--[[--

Creating a copy of an table with fully replicated properties.

**Usage:**

    -- Creating a reference of an table:
    local t1 = {a = 1, b = 2}
    local t2 = t1
    t2.b = 3    -- t1 = {a = 1, b = 3} <-- t1.b changed

    -- Createing a copy of an table:
    local t1 = {a = 1, b = 2}
    local t2 = clone(t1)
    t2.b = 3    -- t1 = {a = 1, b = 2} <-- t1.b no change


@param mixed object
@return mixed

]]

table.unpack = table.unpack or unpack
function clone(object, setMetaTable)
    if type(object) ~= "table" then
        return object
    end

    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for key, value in pairs(object) do
            new_table[_copy(key)] = _copy(value)
        end
        if not setMetaTable then
            return new_table
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

function shallowclone(object, setMetaTable)
    if type(object) ~= "table" then
        return object
    end

    local new_table = {}
    for key, value in pairs(object) do
        new_table[key] = value
    end

    if not setMetaTable then
        return new_table
    end
    return setmetatable(new_table, getmetatable(object))
end

function protoclone(object)
    if type(object) ~= "table" then
        return object
    end
    local tmpObj = object

    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for key, value in pairs(object) do
             if type(value) == "function" then
                LuaLogger.es("protoclone value type function", key, tablex.dump(tmpObj))
            end
            if key ~= "_CObj" and key ~= "_CType" then
                new_table[_copy(key)] = _copy(value)
            end
        end
        return new_table
    end
    return _copy(object)
end

function simpleClone(object)
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        end
        local new_table = {}
        for key, value in pairs(object) do
            new_table[_copy(key)] = _copy(value)
        end
        return new_table
    end
    return _copy(object)
end

local objectCount = 0
local function getObjectCount()
    objectCount = objectCount + 1
    return objectCount
end
--[[--

Create an class.

**Usage:**

    local Shape = class("Shape")

    -- base class
    function Shape:ctor(shapeName)
        self.shapeName = shapeName
        printf("Shape:ctor(%s)", self.shapeName)
    end

    function Shape:draw()
        printf("draw %s", self.shapeName)
    end

    --

    local Circle = class("Circle", Shape)

    function Circle:ctor()
        Circle.super.ctor(self, "circle")   -- call super-class method
        self.radius = 100
    end

    function Circle:setRadius(radius)
        self.radius = radius
    end

    function Circle:draw()                  -- overrideing super-class method
        printf("draw %s, raidus = %0.2f", self.shapeName, self.raidus)
    end

    --

    local Rectangle = class("Rectangle", Shape)

    function Rectangle:ctor()
        Rectangle.super.ctor(self, "rectangle")
    end

    --

    local circle = Circle.new()             -- output: Shape:ctor(circle)
    circle:setRaidus(200)
    circle:draw()                           -- output: draw circle, radius = 200.00

    local rectangle = Rectangle.new()       -- output: Shape:ctor(rectangle)
    rectangle:draw()                        -- output: draw rectangle


@param string classname
@param table|function super-class
@return table

]]
-- function class(classname, super)
--     local superType = type(super)
--     local cls

--     if superType ~= "function" and superType ~= "table" then
--         superType = nil
--         super = nil
--     end

--     if superType == "function" or (super and super.__ctype == 1) then
--         -- inherited from native C++ Object
--         cls = {}

--         if superType == "table" then
--             -- copy fields from super
--             for k,v in pairs(super) do cls[k] = v end
--             cls.__create = super.__create
--             cls.super    = super
--         else
--             cls.__create = super
--             cls.ctor = function() end
--         end

--         cls.__cname = classname
--         cls.__ctype = 1

--         function cls:new(o, ...)
--             local instance = cls.__create(o, ...)
--             tolua.setpeer(instance, {})
--             instance.instUUId = getObjectCount()
--             --Debugger.Log(instance)
--             --instance.RefTable = {}
--             -- copy fields from class to native object
--             for k,v in pairs(cls) do instance[k] = v end
--             instance.class = cls
--             if tag then
--                 instance:ctor(...)
--             else
--                 instance:ctor(o, ...)
--             end
--             return instance
--         end

--     else
--         -- inherited from Lua Object
--         if super then
--             cls = clone(super)
--             cls.super = super
--         else
--             cls = {ctor = function() end}
--         end

--         cls.__cname = classname
--         cls.__ctype = 2 -- lua
--         cls.__index = cls

--         function cls:new(o, ...)
--             local instance = {}
--             instance.instUUId = getObjectCount()
--             instance.class = cls
--             setmetatable(instance, cls)
--             if instance.super and instance.super.__ctype == 2 and instance.super.new ~= nil then
--                 instance.super = instance.super:new(o, ...)
--             end
--             if iskindof(instance, "LuaMonoBehavior") then
--                 instance:InitGameObject(o)
--                 instance:ctor(...)
--             else
--                 instance:ctor(o, ...)
--             end
--             return instance
--         end
--     end

--     -- function cls:create(...)
--     --     return cls:new(...)
--     -- end

--     return cls
-- end

if not df then
    df = {}
end

---@generic T:BaseClass
---@class BaseClass
---@field private __cname string
---@field super BaseClass
---@field new fun(o:string?):BaseClass
---@field getClassName fun():string

local tag = nil -- todo:global 下面用到的，后面再看
---@generic T:BaseClass
---@param classname string
---@return T
function class(classname, ...)
    if df then
        if not df.class_reg then
            df.class_reg = {}
        end

        local cls = df.class_reg[classname]
        if cls then
            return cls
        end
    end

    local supers = {...}
    local super = supers[1]

    local superType = type(super)
    local cls = {}
    cls.__cname = classname

    if superType ~= "function" and superType ~= "table" then
        superType = nil
        super = nil
    end

    local create
    create = function(c, obj, ...)
        if c.supers then
            for k,v in pairs(c.supers) do
                create(v, obj, ...)
            end
        elseif c.super then
            create(c.super, obj, ...)
        end

        if c.ctor then
            c.ctor(obj, ...)
        end
    end

    if superType == "function" or (super and super.__ctype == 1) then
        -- inherited from native C++ Object

        cls.__ctype = 1

        if superType == "table" then
            -- copy fields from super
            -- setmetatable(cls, super)
            for k,v in pairs(super) do cls[k] = v end
            cls.__create = super.__create
            cls.super    = super
        else
            cls.__create = super
        end

        function cls:new(o, ...)
            local instance = cls.__create(o, ...)
            tolua.setpeer(instance, {})
            -- instance.instUUId = getObjectCount()
            -- copy fields from class to native object
            for k,v in pairs(cls) do instance[k] = v end
            if tag then
                create(cls, instance, ...)
            else
                create(cls, instance, o, ...)
            end
            return instance
        end

    else
        -- inherited from Lua Object
        cls.super = super
        cls.supers = supers
        cls.__index = cls
        cls.__ctype = 2 -- lua

        if #supers == 1 then
            setmetatable(cls, super)
        elseif #supers > 1 then
            LuaExtend(cls, table.unpack(supers))
        end

        function cls:new(o, ...)
            local instance = setmetatable({}, cls)
            -- instance.instUUId = getObjectCount()
            if iskindof(instance, "LuaMonoBehavior") then
                instance:InitGameObject(o)
                create(cls, instance, ...)
            else
                create(cls, instance, o, ...)
            end
            return instance
        end
    end

    function cls:getClassName()
        return self.__cname
    end

    if df then
        df.class_reg[classname] = cls
    end

    return cls
end

function instanceOf(cls)
    if cls and type(cls) == 'table' and cls.__cname then
        return cls.__cname
    end
    return nil
end

function iskindof(obj, className)
    local t = type(obj)

    if t == "table" then
        -- local mt = getmetatable(obj)
        -- while mt and mt.__index do
        local mt = obj
        if mt.__cname == className then
            return true
        elseif mt.supers then
            for k,v in pairs(mt.supers) do
                if iskindof(v, className) then
                    return true
                end
            end
        else
            return iskindof(obj.super, className)
        end
        return false

    elseif t == "userdata" then

    else
        return false
    end
end

function LuaExtend(src, ...)
    local meta = getmetatable(src)
    local parents = {meta, ...}

    setmetatable(src, {
        __index = function (tb, key)
            local v = rawget(tb, key)
            if v then
                return v
            end

            local find
            for k,v2 in pairs(parents) do
                find = v2[key]
                if find then
                    return find
                end
            end
        end,

         __newindex = function(t, k, v)
             for i,v2 in ipairs(parents) do
                 if v2[k] then
                     v2[k] = v
                     return
                 end
             end

             rawset(t, k, v)
         end,
    })
end

function ClassExtend(class, filename)
    local extendFunc = require(filename)
    extendFunc(class)
end

