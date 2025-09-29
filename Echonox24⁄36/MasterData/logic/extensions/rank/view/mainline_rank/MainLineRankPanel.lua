-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/view/mainline_rank/MainLineRankPanel.lua

module("logic.extensions.rank.view.mainline_rank.MainLineRankPanel", package.seeall)

local M = class("MainLineRankPanel", RankPanelBase)

function M:buildUI()
	M.super.buildUI(self)

	local toggle_tabItemList = {
		self._registry:getUIComponent("panel_zx_-397360250", UIComponentType.SpaceXToggle),
		self._registry:getUIComponent("panel_zx_-944590156", UIComponentType.SpaceXToggle)
	}
	local txt_tabNormalNameList = {
		self._registry:getText("panel_zx_-1062668011"),
		self._registry:getText("panel_zx_-2093589688")
	}
	local txt_tabSelectNameList = {
		self._registry:getText("panel_zx_1287728411"),
		self._registry:getText("panel_zx_-1430190382")
	}
	local go_scrollView = self._registry:getGo("panel_zx_-354327541")
	local go_itemMyBank = self._registry:getGo("panel_zx_1965719010")
	local btn_showTeam = self._registry:getBtn("panel_zx_342984390")

	self.go_no_show_team = self._registry:getGo("panel_zx_2002877058")
	self.go_show_team = self._registry:getGo("panel_zx_1373814476")

	self:registerSubRankToggle(toggle_tabItemList, txt_tabNormalNameList, txt_tabSelectNameList)
	self:registerScrollView(go_scrollView)
	self:registerMyRank(go_itemMyBank)
	self:registerShowTeamBtn(btn_showTeam)
end

function M:changeShowTeamState(isShow)
	goutil.setActive(self.go_no_show_team, not isShow)
	goutil.setActive(self.go_show_team, isShow)
end

return M
