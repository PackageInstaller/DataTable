-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/view/collection_rank/CollectionRankPanel.lua

module("logic.extensions.rank.view.collection_rank.CollectionRankPanel", package.seeall)

local M = class("CollectionRankPanel", RankPanelBase)

function M:buildUI()
	M.super.buildUI(self)

	local toggle_tabItemList = {
		self._registry:getUIComponent("panel_sjl_-348516057", UIComponentType.SpaceXToggle),
		self._registry:getUIComponent("panel_sjl_-992452587", UIComponentType.SpaceXToggle)
	}
	local txt_tabNormalNameList = {
		self._registry:getText("panel_sjl_-1010685004"),
		self._registry:getText("panel_sjl_-2141419031")
	}
	local txt_tabSelectNameList = {
		self._registry:getText("panel_sjl_1336672186"),
		self._registry:getText("panel_sjl_-1448356749")
	}
	local go_scrollView = self._registry:getGo("panel_sjl_-376719702")
	local go_itemMyBank = self._registry:getGo("panel_sjl_1983950659")

	self:registerSubRankToggle(toggle_tabItemList, txt_tabNormalNameList, txt_tabSelectNameList)
	self:registerScrollView(go_scrollView)
	self:registerMyRank(go_itemMyBank)
end

return M
