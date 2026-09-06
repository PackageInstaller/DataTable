-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/lmvc/agent/BaseAgent.lua

module("frameworkext.lmvc.agent.BaseAgent", package.seeall)

local BaseAgent = class("BaseAgent")

function BaseAgent:ctor()
	return
end

function BaseAgent:setExtId(extId)
	self._extId = extId
end

function BaseAgent:sendMsg(msg, connType)
	connType = connType or ConnectionType.Logic

	NetConnMgr.instance:sendMsg(msg, connType)
end

function BaseAgent:sendEmptyMsg(cmd, connType)
	connType = connType or ConnectionType.Logic

	NetConnMgr.instance:sendEmptyMsg(self._extId, cmd, connType)
end

function BaseAgent:onInit()
	return
end

return BaseAgent
