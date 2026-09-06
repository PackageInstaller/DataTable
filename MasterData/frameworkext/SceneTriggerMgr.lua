-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/scene/trigger/SceneTriggerMgr.lua

module("frameworkext.scene.trigger.SceneTriggerMgr", package.seeall)

local SceneTriggerMgr = class("SceneTriggerMgr", SceneComponentBase)

SceneTriggerMgr.TriggerParamType = typeof(Framework.TriggerParam)
SceneTriggerMgr.EmptyStr = ""

function SceneTriggerMgr:ctor(scene)
	SceneTriggerMgr.super.ctor(self, scene)
end

function SceneTriggerMgr:onTriggerEnter(collider, userData)
	local paramObj = collider:GetComponent(SceneTriggerMgr.TriggerParamType)
	local number = 0
	local str = SceneTriggerMgr.EmptyStr

	if paramObj then
		number = paramObj.numberParam

		if paramObj.stringParam then
			str = paramObj.stringParam
		end
	end

	self:dispatch(collider.gameObject.tag, true, collider, number, str, userData)
end

function SceneTriggerMgr:onTriggerExit(collider, userData)
	local paramObj = collider:GetComponent(SceneTriggerMgr.TriggerParamType)
	local number = 0
	local str = SceneTriggerMgr.EmptyStr

	if paramObj then
		number = paramObj.numberParam

		if paramObj.stringParam then
			str = paramObj.stringParam
		end
	end

	self:dispatch(collider.gameObject.tag, false, collider, number, str, userData)
end

return SceneTriggerMgr
