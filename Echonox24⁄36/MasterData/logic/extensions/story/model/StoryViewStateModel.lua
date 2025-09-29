-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/model/StoryViewStateModel.lua

module("logic.extensions.story.model.StoryViewStateModel", package.seeall)

local M = class("StoryViewStateModel")

function M:ctor()
	self._uiElementStateTable = {}
end

function M:onReset()
	self._uiElementStateTable = {}
end

function M:setUIElementVisible(elementEnum, visible, key)
	local invisibleSignalAmount = self._uiElementStateTable[elementEnum]

	if not invisibleSignalAmount then
		invisibleSignalAmount = SignalAmount.New()
		self._uiElementStateTable[elementEnum] = invisibleSignalAmount
	end

	if invisibleSignalAmount:hasKey(StoryConst.GuideStateKey) then
		return invisibleSignalAmount:isUnactive()
	end

	if visible then
		invisibleSignalAmount:remove(key)
	else
		invisibleSignalAmount:addUnique(key)
	end

	return self:isUIElementVisible(elementEnum)
end

function M:isUIElementVisible(elementEnum)
	local invisibleSignalAmount = self._uiElementStateTable[elementEnum]
	local visible = not invisibleSignalAmount or invisibleSignalAmount:isUnactive()

	return visible
end

function M:clear()
	for _, invisibleSignalAmount in pairs(self._uiElementStateTable) do
		invisibleSignalAmount:clear()
	end
end

function M:setRightTopDisable()
	self:setUIElementVisible(StoryUIElement.Auto, false, StoryConst.GuideStateKey)
	self:setUIElementVisible(StoryUIElement.Skip, false, StoryConst.GuideStateKey)
	self:setUIElementVisible(StoryUIElement.Record, false, StoryConst.GuideStateKey)
end

M.instance = M.New()

return M
