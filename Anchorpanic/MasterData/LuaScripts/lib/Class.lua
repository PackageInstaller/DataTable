module("lib.Class", package.seeall)

-- 给userdata绑定peer
local bind_peer
bind_peer = function(ud, cls)
    if type(ud) == "userdata" then
        local peer = xlua.getpeer(ud)
        if not peer then
            peer = {}
            xlua.setpeer(ud, peer)
        end
        setmetatable(peer, cls)
    end
end

-- lua类的继承关系说明：
-- 1. 纯lua继承：
-- 假设在一个2层继承体系下，当前类叫cls，父类叫parent_cls，当前类的实例叫instance，它们的关系如下：
-- instance.mt = cls
-- cls.mt = parent_cls
-- parent_cls.mt = _G -- 父类的mt要设置成_G是为了在lua文件中能访问到全局环境，因为类定义文件都是用module写
--
-- 2.继承c#的类
-- 假设在一个2层继承体系下，当前的lua类叫cls，继承的c#父类叫parent_cs_cls，当前的cs实例叫instance，它们的关系如下：
-- instance.mt = parent_cs_cls + instance.peer
-- cls.mt = core.LuaObject
-- instance.peer.mt = cls

--- class定义函数，在module定义时把module定义为class，并确定父类
-- @param parent_cls 父类名字或c#导出的类定义
function impl(parent_cls)
    return function(cls)
        package.seeall(cls)
    
        -- cls.ctor = false
    
        if parent_cls ~= nil then
            if type(parent_cls) == "string" then
                local filePath = string.gsub(parent_cls, "%.", "%/")
                parent_cls = require(filePath)
                setmetatable(cls, {__index = parent_cls})
            -- elseif parent_cls[".is_cs_class"] then
            --     local base_lua_cls = require("lib/LuaObject")
            --     setmetatable(cls, {__index = base_lua_cls})
    
            --     cls.__base_cs_type = parent_cls.UnderlyingSystemType
            else
                setmetatable(cls, {__index = parent_cls})
            end
    
            cls.super = parent_cls
        end
    
        cls.__cname = cls._NAME
        cls.__index = cls
        cls.__is_class = true
    
        -- lua下构建纯lua类实例的方法
        -- 本方法不可以构建继承cs类的lua类实例！
        cls.new = function(...)
            local obj
    
            -- 递归调用构造函数
            do
                local create
                create = function(c, ...)
                    if c.super then
                        create(c.super, ...)
                    end
    
                    if not obj then
                        -- if c[".is_cs_class"] then
                        --     error(cls._NAME .. "不能使用new方法，因为它是继承cs类的。应该要从cs层调用new_with_cs_instance。")
                        -- else
                            obj = {}
                            setmetatable(obj, cls)
                        -- end
    
                        obj.class = cls
                    end
                    -- if c.ctor then
                    --     c.ctor(obj, ...)
                    -- end
                end
    
                create(cls, ...)
                if cls.ctor then
                    cls.ctor(obj, ...)
                else
                    local tmpSuper = cls.super
                    while tmpSuper do
                        if tmpSuper.ctor then
                            tmpSuper.ctor(obj,...)
                            break
                        end
                        tmpSuper = tmpSuper.super
                    end
                end
            end
    
            return obj
        end
    
        -- cs下构建继承cs类的lua类实例的方法
        -- lua下请不要调用本方法
        cls.new_with_cs_instance = function(cs_instance)
            local obj
    
            -- 递归调用构造函数
            do
                local create
                create = function(c, cs_instance)
                    if c.super then
                        create(c.super, cs_instance)
                    end
    
                    if not obj then
                        -- if c[".is_cs_class"] then
                        --     obj = cs_instance
                        --     bind_peer(obj, cls)
    
                        --     obj[".is_cs_instance"] = true
                        -- else
                        --     error(cls._NAME .. "不能使用new_with_cs_instance，因为它的最上层父类不是cs类。应该在lua下调用new。")
                        -- end
                        obj.class = cls
                    end
    
                    if c.ctor then
                        c.ctor(obj)
                    end
                end
    
                create(cls, cs_instance)
                
            end
    
            return obj
        end
    end
end

function class(clsname, parent_cls)
    local cls = {_NAME=clsname}
    package.seeall(cls)

    -- cls.ctor = false

    if parent_cls ~= nil then
        if type(parent_cls) == "string" then
            local filePath = string.gsub(parent_cls, "%.", "%/")
            parent_cls = require(filePath)
            setmetatable(cls, {__index = parent_cls})
        -- elseif parent_cls[".is_cs_class"] then
        --     local base_lua_cls = require("lib/LuaObject")
        --     setmetatable(cls, {__index = base_lua_cls})

        --     cls.__base_cs_type = parent_cls.UnderlyingSystemType
        else
            setmetatable(cls, {__index = parent_cls})
        end

        cls.super = parent_cls
    end

    cls.__cname = cls._NAME
    cls.__index = cls
    cls.__is_class = true

    -- lua下构建纯lua类实例的方法
    -- 本方法不可以构建继承cs类的lua类实例！
    cls.new = function(...)
        local obj

        -- 递归调用构造函数
        do
            local create
            create = function(c, ...)
                if c.super then
                    create(c.super, ...)
                end

                if not obj then
                    -- if c[".is_cs_class"] then
                    --     error(cls._NAME .. "不能使用new方法，因为它是继承cs类的。应该要从cs层调用new_with_cs_instance。")
                    -- else
                        obj = {}
                        setmetatable(obj, cls)
                    -- end

                    obj.class = cls
                end

                -- if c.ctor then
                --     c.ctor(obj, ...)
                -- end
            end

            create(cls, ...)
            if cls.ctor then
                cls.ctor(obj, ...)
            else
                local tmpSuper = cls.super
                while tmpSuper do
                    if tmpSuper.ctor then
                        tmpSuper.ctor(obj,...)
                        break
                    end
                    tmpSuper = tmpSuper.super
                end
            end
        end

        return obj
    end

    -- cs下构建继承cs类的lua类实例的方法
    -- lua下请不要调用本方法
    cls.new_with_cs_instance = function(cs_instance)
        local obj

        -- 递归调用构造函数
        do
            local create
            create = function(c, cs_instance)
                if c.super then
                    create(c.super, cs_instance)
                end

                if not obj then
                    -- if c[".is_cs_class"] then
                    --     obj = cs_instance
                    --     bind_peer(obj, cls)

                    --     obj[".is_cs_instance"] = true
                    -- else
                    --     error(cls._NAME .. "不能使用new_with_cs_instance，因为它的最上层父类不是cs类。应该在lua下调用new。")
                    -- end

                    obj.class = cls
                end

                if c.ctor then
                    c.ctor(obj)
                end
            end

            create(cls, cs_instance)
        end

        return obj
    end

    return cls
end

-- 析构lua类实例的方法
function delete(obj)
    -- 递归调用析构函数
    local destroy
    destroy = function(c)
        local dtor = rawget(c, "dtor")
        if dtor then
            dtor(obj)
        end

        if c.super then
            destroy(c.super)
        end
    end

    destroy(obj.class)
    obj.__delete__ = true
end

local function iskindof_helper(obj, cls, cls_name)
    -- if cls[".is_cs_class"] then
    --     -- TODO 在cs中添加判断函数
    --     -- return tolua.iskindof(obj, cls_name)
    --     return false
    if cls.__cname == cls_name then
        return true
    elseif cls.super then
        return iskindof_helper(obj, cls.super, cls_name)
    else
        return false
    end
end

function iskindof(obj, cls_name)
    if obj == nil then
        return false
    end
    return iskindof_helper(obj, obj.class, cls_name)
end

function new(cls_name, ...)
    local filePath = string.gsub(cls_name, "%.", "%/")
    local cls = require(filePath)
    if cls then
        return cls.new(...)
    end
end

return _M