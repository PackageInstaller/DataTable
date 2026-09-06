-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/lmvc/ExtensionMgr.lua

module("frameworkext.lmvc.extension.ExtensionMgr", package.seeall)

local ExtensionMgr = class("ExtensionMgr")

function ExtensionMgr:ctor()
	self._extDispatchers = {}
	self._agents = {}
end

function ExtensionMgr:init(setting)
	self._setting = setting

	NetConnMgr.instance:addMsgHandler(self._handleMsg, self)
end

function ExtensionMgr:_initExtension(id)
	local extObj = self._setting[id]

	if not extObj then
		return
	end

	if self._extDispatchers[id] then
		return
	end

	local extDispatcher = {}

	NotifyDispatcher.extend(extDispatcher)

	self._extDispatchers[id] = extDispatcher

	local len = 0
	local GGG = getglobal("_G")
	local models = extObj.models

	if models then
		len = #models

		for i = 1, #models do
			if GGG[models[i]] then
				local model = GGG[models[i]].instance

				if model then
					model:onInit()
				else
					printError("Cannot find model instance:", models[i])
				end
			else
				printError("Cannot find model class:", models[i])
			end
		end
	end

	local agents = extObj.agents

	if agents then
		local agentArr = {}

		self._agents[id] = agentArr
		len = #agents

		for i = 1, #agents do
			if GGG[agents[i]] then
				local agent = GGG[agents[i]].instance

				if agent then
					agent:setExtId(id)
					agent:onInit()
					table.insert(agentArr, agent)
				else
					printError("Cannot find agent instance:", agents[i])
				end
			else
				printError("Cannot find agent class:", agents[i])
			end
		end
	end

	local controllers = extObj.controllers

	if controllers then
		for i = 1, #controllers do
			if GGG[controllers[i]] then
				local controller = GGG[controllers[i]].instance

				if controller then
					controller:setExtDispatcher(extDispatcher)
					controller:onInit()
				else
					printError("Cannot find controller instance:", controllers[i])
				end
			else
				printError("Cannot find controller class:", controllers[i])
			end
		end
	end
end

function ExtensionMgr:_resetExtension(id)
	local extObj = self._setting[id]

	if not extObj then
		return
	end

	local len = 0
	local GGG = getglobal("_G")
	local models = extObj.models

	if models then
		len = #models

		for i = 1, #models do
			local model = GGG[models[i]].instance

			model:onReset()
		end
	end

	local controllers = extObj.controllers

	if controllers then
		for i = 1, #controllers do
			local controller = GGG[controllers[i]].instance

			controller:onReset()
		end
	end
end

function ExtensionMgr:getExtDispatcher(id)
	return self._extDispatchers[id]
end

function ExtensionMgr:getAgents(id)
	return self._agents[id]
end

function ExtensionMgr:buildExtensions(extIds)
	local len = #extIds

	for i = 1, len do
		self:_initExtension(extIds[i])
	end
end

function ExtensionMgr:buildAllExtensions()
	for k, v in pairs(self._setting) do
		self:_initExtension(k)
	end
end

function ExtensionMgr:buildAllExtensionsWithCallBack(callBack)
	local list = {}

	for k, v in pairs(self._setting) do
		table.insert(list, k)
	end

	coroutine.start(function()
		for i, v in ipairs(list) do
			self:_initExtension(v)

			if i % 10 == 0 then
				coroutine.wait(0)
			end
		end

		if callBack then
			callBack()
		end
	end)
end

function ExtensionMgr:resetAllExtensions()
	for k, v in pairs(self._setting) do
		self:_resetExtension(k)
	end
end

function ExtensionMgr:_handleMsg(extId, cmd, status, structName, msg)
	local agents = self:getAgents(extId)

	if agents then
		local handler
		local count = #agents

		for i = 1, count do
			handler = agents[i]["handle" .. structName]

			if agents[i]["handle" .. structName] then
				trycall(handler, agents[i], status, msg)

				break
			end
		end

		if not handler then
			printWarn("No handler for proto structName=" .. structName)
		end
	end
end

ExtensionMgr.instance = ExtensionMgr.New()

return ExtensionMgr
