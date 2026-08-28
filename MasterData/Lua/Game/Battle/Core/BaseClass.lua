--
-- Author:luqucheng
-- Date: 2019-10-18 10:15:59
--
local BaseClass = Class("BaseClass")
-- function BaseClass:ctor()
    
-- end

-- BaseClass.Get = {}
-- BaseClass.Set = {}
BaseClass.aaa = 1

-- local Get = BaseClass.Get
-- local Set = BaseClass.Set

-- function index(self, key)
--     printInfo("get %s", key)
--     -- local func = BaseClass[key]
--     -- if func then
--     --    return func
--     -- end
--     local getter = Get[key]
--     if getter then
--         return getter(self)
--     end

--     return nil
-- end

-- function newindex(self, key, value)
--     printInfo("set %s", key)
--     local setter = Set[key]
--     if setter then
--         setter(self, value or false)
--         return
--     end

--     if Get[key] then
--         assert(false, "readonly property")
--     end
    
--     rawset(self, key, value)
-- end

-- setmetatable(BaseClass, { __index = index, __newindex = newindex })

return BaseClass