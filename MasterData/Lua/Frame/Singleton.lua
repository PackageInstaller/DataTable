--[[
-- lua单例类别
--]]
---@class Singleton
---@field __init fun():void
---@field __delete fun():void
---@field __cname string
---@generic SubClass
---@field New fun():SubClass
---@field Delete fun(self:SubClass):void
---@field GetInstance fun(self:SubClass):SubClass
---@field Startup fun():void
---@field Destroy fun():void
local Singleton = Class("Singleton")

Singleton.GLOBAL_CACHE_KEY = '__manager_instance_caches__'
local GLOBAL_CACHE_KEY = Singleton.GLOBAL_CACHE_KEY

local isHoldGlobalCache = true--(Config.DEBUG and CS.UnityEngine.Application.isEditor)
if isHoldGlobalCache then
    _G[GLOBAL_CACHE_KEY] = _G[GLOBAL_CACHE_KEY] or {}
end


---@param self Singleton
local function __init(self)
    assert(rawget(self.class, "Instance") == nil, self.class.__cname.." to create singleton twice!")
    rawset(self.class, "Instance", self)
end


---@param self Singleton
local function __delete(self)
    rawset(self.class, "Instance", nil)
    if _G[GLOBAL_CACHE_KEY] then
        _G[GLOBAL_CACHE_KEY][self.__cname] = nil
    end
end


-- 只是用于启动模块
---@param self Singleton
local function Startup(self)
end


-- 不要重写
---@param self Singleton
local function GetInstance(self)
    if rawget(self, "Instance") == nil then
        if _G[GLOBAL_CACHE_KEY] then
            if _G[GLOBAL_CACHE_KEY][self.__cname] == nil then
                _G[GLOBAL_CACHE_KEY][self.__cname] = self.New()
            end
            rawset(self, "Instance", _G[GLOBAL_CACHE_KEY][self.__cname])
        else
            rawset(self, "Instance", self.New())
        end
    end
    assert(self.Instance ~= nil)
    return self.Instance
end


-- 不要重写
---@param self Singleton
local function Destroy(self)
    self.Instance = nil
end


Singleton.__init = __init
Singleton.__delete = __delete
Singleton.Startup = Startup
Singleton.GetInstance = GetInstance
Singleton.Destroy = Destroy

return Singleton
