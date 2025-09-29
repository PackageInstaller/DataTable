-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/PlayerUpgradeShowView2Presentor.lua

module("logic.extensions.common.view.PlayerUpgradeShowView2Presentor", package.seeall)

local M = class("PlayerUpgradeShowView2Presentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Common_player_upgrade_show_view_2
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, PlayerUpgradeShow2View.New())

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
