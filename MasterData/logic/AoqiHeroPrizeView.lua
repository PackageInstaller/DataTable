-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroPrizeView.lua

module("logic.extensions.aoqihero.view.AoqiHeroPrizeView", package.seeall)

local AoqiHeroPrizeView = class("AoqiHeroPrizeView", ViewComponent)
local RANK_TYPE_NORMAL = 1
local RANK_TYPE_ENDLESS = 2
local RANK_TYPE_PVP = 3

function AoqiHeroPrizeView:ctor()
	AoqiHeroPrizeView.super.ctor(self)
end

function AoqiHeroPrizeView:unbindEvents()
	AoqiHeroPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AoqiHeroPrizeView:bindEvents()
	AoqiHeroPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AoqiHeroPrizeView:buildUI()
	AoqiHeroPrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tabScrollerCell = self:getGo("tabScrollercell")
	self._tabScrollerView = self:getGo("tabScrollerview")
	self._tabScrollerList = ScrollerList.create(self._tabScrollerView, self._tabScrollerCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._rankTableView = self:getGo("ranktableview")
	self._rankTableCell = self:getGo("ranktablecell")
	self._rankTableList = ScrollerList.create(self._rankTableView, self._rankTableCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemTableCell = self:getGo("itemTablecell")
end

function AoqiHeroPrizeView:onExit()
	AoqiHeroPrizeView.super.onExit(self)

	for k, v in pairs(self._itemTableListDir) do
		v:dispose()

		self._itemTableListDir[k] = nil
	end
end

function AoqiHeroPrizeView:onEnter()
	AoqiHeroPrizeView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())
	self._itemTableListDir = {}
	self._tabList = {
		RANK_TYPE_NORMAL,
		RANK_TYPE_ENDLESS,
		RANK_TYPE_PVP
	}

	self:_onClickTab(RANK_TYPE_NORMAL)
end

function AoqiHeroPrizeView:_refreshView()
	self._tabScrollerList:reloadData(self._tabList)

	local list = {}
	local rankPrizeCfgs = AoQiHeroConfig.instance:getRankPrizeCfgs(self._activityId, self._tabId)

	for k, v in pairs(rankPrizeCfgs) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a.rankRange[1] < b.rankRange[1]
	end)
	self._rankTableList:reloadData(list)
end

function AoqiHeroPrizeView:_updateTabCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local uiChangeGroup = go:GetComponent(ComponentType.UIChangeGroup)

	if data == RANK_TYPE_NORMAL then
		txtName.text = lang("普通模式")
	elseif data == RANK_TYPE_ENDLESS then
		txtName.text = lang("无尽模式")
	elseif data == RANK_TYPE_PVP then
		txtName.text = lang("比拼模式")
	end

	if data == self._tabId then
		uiChangeGroup:SetState(1)
	else
		uiChangeGroup:SetState(0)
	end

	GameUtil.addClickHandler(go, function()
		self:_onClickTab(data)
	end)
end

function AoqiHeroPrizeView:_clearTabCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function AoqiHeroPrizeView:_updateRankCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local itemTableView = goutil.findChild(go, "itemTableview")
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")

	txtRank.text = data.title

	if data.rankRange[1] == data.rankRange[2] then
		if not data.rankRange[2] then
			local singleRank = 0

			singleRank = checknumber(singleRank)

			if singleRank <= 3 and singleRank > 0 then
				imgChangeRank:SetState(singleRank - 1)
				GameUtil.SetActive(imgChangeRank, true)
				GameUtil.SetActive(txtRank, false)
			else
				GameUtil.SetActive(imgChangeRank, false)
				GameUtil.SetActive(txtRank, true)
			end

			local prizeArray = string.split(data.prize, "#")

			if itemTableView and self._itemTableCell then
				if not self._itemTableListDir[itemTableView] then
					local itemTableList = ScrollerList.create(itemTableView, self._itemTableCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

					self._itemTableListDir[itemTableView]:dragNotifyParent()

					self._itemTableListDir[itemTableView] = self._itemTableListDir[itemTableView]

					self._itemTableListDir[itemTableView]:reloadData(prizeArray)
				end
			end
		end
	end
end

function AoqiHeroPrizeView:_clearRankCell(cell)
	local go = cell.gameObject
	local itemTableView = goutil.findChild(go, "itemTableview")

	if self._itemTableListDir[itemTableView] then
		self._itemTableListDir[itemTableView]:dispose()

		self._itemTableListDir[itemTableView] = nil
	end
end

function AoqiHeroPrizeView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCellByCfg(data, go)
end

function AoqiHeroPrizeView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function AoqiHeroPrizeView:_onClickTab(tabId)
	self._tabId = tabId

	self:_refreshView()
end

return AoqiHeroPrizeView
