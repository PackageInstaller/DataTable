-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/new/CharacterHeartAnchorImpressionUpgradeResultTipsPresentor.lua

module("logic.extensions.characterinformation.view.new.CharacterHeartAnchorImpressionUpgradeResultTipsPresentor", package.seeall)

local M = class("CharacterHeartAnchorImpressionUpgradeResultTipsPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.CharacterSystem_heart_anchor_upgrade_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterHeartAnchorImpressionUpgradeResultTips.New())

	self._timelineGadget = GuiTimelineGadgetView.New()

	table.insert(views, self._timelineGadget)

	return views
end

function M:onClickOutside()
	if self._timelineGadget:getOpenAniFinish() then
		ViewMgr.instance:close(self:getViewName())
	end
end

return M
