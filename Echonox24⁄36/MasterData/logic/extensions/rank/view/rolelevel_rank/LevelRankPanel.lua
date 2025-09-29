-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/view/rolelevel_rank/LevelRankPanel.lua

module("logic.extensions.rank.view.rolelevel_rank.LevelRankPanel", package.seeall)

local M = class("LevelRankPanel", RankPanelBase)

function M:buildUI()
	M.super.buildUI(self)

	local go_scrollView = self._registry:getGo("panel_zj_-609020268")
	local go_itemMyBank = self._registry:getGo("panel_zj_1148718973")

	self:registerScrollView(go_scrollView)
	self:registerMyRank(go_itemMyBank)
end

return M
