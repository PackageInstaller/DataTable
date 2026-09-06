-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/scene/trigger/SceneTriggerDetector.lua

module("frameworkext.scene.trigger.SceneTriggerDetector", package.seeall)

local SceneTriggerDetector = class("SceneTriggerDetector")

function SceneTriggerDetector.Get(go)
	Framework.LuaComponentContainer.Add(go, SceneTriggerDetector)
end

function SceneTriggerDetector:ctor(componetContainer)
	self.go = componetContainer.gameObject
	self._userData = nil
end

function SceneTriggerDetector:setUserData(userData)
	self._userData = userData
end

function SceneTriggerDetector:OnTriggerEnter(collider)
	SceneTriggerMgr.instance:onTriggerEnter(collider, self._userData)
end

function SceneTriggerDetector:OnTriggerExit(collider)
	SceneTriggerMgr.instance:onTriggerExit(collider, self._userData)
end

function SceneTriggerDetector:OnDestroy()
	self._userData = nil
end

return SceneTriggerDetector
