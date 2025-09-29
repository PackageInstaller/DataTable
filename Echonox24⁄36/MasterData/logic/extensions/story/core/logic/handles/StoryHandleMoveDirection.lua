-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleMoveDirection.lua

module("logic.extensions.story.core.logic.handles.StoryHandleMoveDirection", package.seeall)

local M = class("StoryHandleMoveDirection")

function M:ctor()
	self.m_getter = StoryFixDirectionGetter.New()
	self.m_disPos = Vector3.zero
	self.m_lastPos = Vector3.zero
	self.m_curPos = Vector3.zero
	self.m_easingType = 0
	self.m_speed = 0
end

function M:HandleSectionEnter(config, duration)
	if not config or not config:HasAnyArg() then
		return
	end

	self.m_lastPos = Vector3.zero
	self.m_speed = config:GetArgValueNumber(StoryArgKeyConst.MoveDirectionSpeed)
	self.m_easingType = Easings.Functions.IntToEnum(config:GetArgValueEnum(StoryArgKeyConst.EasingType))

	local getter = self.m_getter

	getter:UpdateAsset(config)

	local dir

	if getter.isFixDir then
		dir = getter.fixDirectionVect
	else
		dir = getter.customDirection
	end

	self.m_disPos = dir.normalized * self.m_speed * duration
end

function M:Handle(config, targetGo, percent)
	if goutil.isNil(targetGo) then
		return
	end

	if not config or not config:HasAnyArg() then
		return
	end

	local targetTf = targetGo.transform

	self.m_curPos = self.m_disPos * self.m_speed * Easings.Interpolate(percent, self.m_easingType)

	targetTf:Translate(self.m_curPos - self.m_lastPos)

	self.m_lastPos = self.m_curPos
end

return M
