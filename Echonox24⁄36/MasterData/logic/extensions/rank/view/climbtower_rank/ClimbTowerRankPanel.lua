-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/view/climbtower_rank/ClimbTowerRankPanel.lua

module("logic.extensions.rank.view.climbtower_rank.ClimbTowerRankPanel", package.seeall)

local M = class("ClimbTowerRankPanel", RankPanelBase)

function M:buildUI()
	M.super.buildUI(self)

	local go_scrollView = self._registry:getGo("panel_yzam_-2003577202")
	local go_itemMyBank = self._registry:getGo("panel_yzam_391696231")
	local btn_showTeam = self._registry:getBtn("panel_yzam_3512838")
	local lastRankToggle = self._registry:getUIComponent("panel_yzam_-1138766379", UIComponentType.SpaceXToggle)
	local curRankToggle = self._registry:getUIComponent("panel_yzam_34448143", UIComponentType.SpaceXToggle)

	self.go_no_show_team = self._registry:getGo("panel_yzam_895129036")
	self.go_show_team = self._registry:getGo("panel_yzam_-1202372035")

	self:registerScrollView(go_scrollView)
	self:registerMyRank(go_itemMyBank)
	self:registerShowTeamBtn(btn_showTeam)
	self:registerRankToggle(lastRankToggle, curRankToggle)
end

function M:changeShowTeamState(isShow)
	goutil.setActive(self.go_no_show_team, not isShow)
	goutil.setActive(self.go_show_team, isShow)
end

return M
