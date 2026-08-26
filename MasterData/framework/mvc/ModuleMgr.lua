-- chunkname: @framework/mvc/ModuleMgr.lua

module("framework.mvc.ModuleMgr", package.seeall)

local ModuleMgr = class("ModuleMgr")
local _xpcall = xpcall
local _TRACKBACK = __G__TRACKBACK__

function ModuleMgr:ctor()
	self._moduleSetting = nil
	self._models = {}
	self._rpcs = {}
	self._controllers = {}
end

function ModuleMgr:init(moduleSetting, callback, callbackObj)
	self._moduleSetting = moduleSetting
	self._onInitCallback = callback
	self._onInitCallbackObj = callbackObj

	self:_initModules()
end

function ModuleMgr:reInit()
	for _, one in ipairs(self._models) do
		_xpcall(one.instance.reInitInternal, _TRACKBACK, one.instance)
	end

	for _, one in ipairs(self._rpcs) do
		_xpcall(one.instance.reInitInternal, _TRACKBACK, one.instance)
	end

	for _, one in ipairs(self._controllers) do
		_xpcall(one.instance.reInit, _TRACKBACK, one.instance)
	end
end

function ModuleMgr:getSetting(moduleName)
	return self._moduleSetting[moduleName]
end

function ModuleMgr:_initModules()
	self._frameHandleNum = 5
	self._nowHandNum = 0
	self._allHandNum = tabletool.len(self._moduleSetting)
	self._moduleSettingList = {}

	for _, setting in pairs(self._moduleSetting) do
		table.insert(self._moduleSettingList, setting)
	end

	TaskDispatcher.runRepeat(self._initModulesRepeat, self, 0.01)
end

function ModuleMgr:_initModulesRepeat()
	for i = 1, self._frameHandleNum do
		self._nowHandNum = self._nowHandNum + 1

		local setting = self._moduleSettingList[self._nowHandNum]

		self:_initConfigs(setting.config)
		self:_initModels(setting.model)
		self:_initRpcs(setting.rpc)
		self:_initControllers(setting.controller)

		if self._nowHandNum == self._allHandNum then
			TaskDispatcher.cancelTask(self._initModulesRepeat, self)
			self:_initFinish()

			break
		end
	end
end

function ModuleMgr:_initConfigs(configs)
	if not configs then
		return
	end

	for _, name in ipairs(configs) do
		local config = _G[name]

		if config then
			config.instance:onInit()
			ConfigMgr.instance:addRequestor(config.instance)
		else
			logError("config not found: " .. name)
		end
	end
end

function ModuleMgr:_initModels(models)
	if not models then
		return
	end

	for _, name in ipairs(models) do
		local model = _G[name]

		if model then
			model.instance:onInit()
			table.insert(self._models, model)
		else
			logError("model not found: " .. name)
		end
	end
end

function ModuleMgr:_initRpcs(rpcs)
	if not rpcs then
		return
	end

	for _, name in ipairs(rpcs) do
		local rpc = _G[name]

		if rpc then
			rpc.instance:onInitInternal()
			table.insert(self._rpcs, rpc)
		else
			logError("rpc not found: " .. name)
		end
	end
end

function ModuleMgr:_initControllers(controllers)
	if not controllers then
		return
	end

	for _, name in ipairs(controllers) do
		local controller = _G[name]

		if controller then
			LuaEventSystem.addEventMechanism(controller.instance)
			controller.instance:__onInit()
			controller.instance:onInit()
			table.insert(self._controllers, controller)
		else
			logError("controller not found: " .. name)
		end
	end
end

function ModuleMgr:_initFinish()
	for _, controller in ipairs(self._controllers) do
		controller.instance:onInitFinish()
		controller.instance:addConstEvents()
	end

	self._onInitCallback(self._onInitCallbackObj)
end

ModuleMgr.instance = ModuleMgr.New()

return ModuleMgr
