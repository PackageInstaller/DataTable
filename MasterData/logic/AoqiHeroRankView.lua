-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroRankView.lua

module("logic.extensions.aoqihero.view.AoqiHeroRankView", package.seeall)

local AoqiHeroRankView = class("AoqiHeroRankView", ViewComponent)
local RANK_TYPE_NORMAL = 1
local RANK_TYPE_ENDLESS = 2
local RANK_TYPE_PVP = 3

function AoqiHeroRankView:ctor()
	AoqiHeroRankView.super.ctor(self)
end

function AoqiHeroRankView:unbindEvents()
	AoqiHeroRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AoqiHeroRankView:bindEvents()
	AoqiHeroRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AoqiHeroRankView:buildUI()
	AoqiHeroRankView.super.buildUI(self)

	self._itemTablecell = self:getGo("itemTablecell")
	self._myItemTableview = self:getGo("right/myRank/itemTableview")
	self._myItemTableList = ScrollerList.create(self._myItemTableview, self._itemTablecell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
	self._cell_1 = self:getGo("right/cell_1")
	self._cell_2 = self:getGo("right/cell_2")
	self._subTitle_1 = self:getGo("right/subTitle_1")
	self._subTitle_2 = self:getGo("right/subTitle_2")
	self._subTitle_3 = self:getGo("right/subTitle_3")
	self._rankScrollRect = self:getGo("right/rankScrollRect")
	self._rankList = ScrollerList.create(self._rankScrollRect, {
		self._cell_1,
		self._cell_2
	}, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))

	self._rankList:regGetTagByIdx(GameUtil.handler(self.getCellTag, self))

	self._tabScrollerview = self:getGo("tabScrollerview")
	self._tabScrollercell = self:getGo("tabScrollercell")
	self._tabScrollerList = ScrollerList.create(self._tabScrollerview, self._tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._goEmpty = self:getGo("right/goEmpty")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtMyStepTitle = self:getTxt("right/myRank/txtMyStepTitle")
	self._txtMyStep = self:getTxt("right/myRank/txtMyStep")
	self._txtEmptyTips = self:getGo("right/myRank/txtEmptyTips")
	self._btnClose = self:getGo("btnClose")
	self._txtTip = self:getTxt("right/myRank/txtTip")
end

function AoqiHeroRankView:onExit()
	AoqiHeroRankView.super.onExit(self)

	for k, v in pairs(self._itemTableListDir) do
		v:dispose()

		self._itemTableListDir[k] = nil
	end
end

function AoqiHeroRankView:onEnter()
	AoqiHeroRankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroInfoRes, self._refreshView, self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._rankType = checknumber(params[2])
	self._itemTableListDir = {}
	self._tabList = {
		RANK_TYPE_NORMAL,
		RANK_TYPE_ENDLESS,
		RANK_TYPE_PVP
	}

	if self._rankType == 0 then
		self:_onClickTabId(RANK_TYPE_NORMAL)
	else
		self:_onClickTabId(self._rankType)
	end
end

function AoqiHeroRankView:_refreshView()
	self._tabScrollerList:reloadData(self._tabList)

	local rankInfoList = AoQiHeroModel.instance:getRankInfoList() or {}

	GameUtil.SetActive(self._goEmpty, #rankInfoList <= 0)
	self._rankList:reloadData(rankInfoList)

	local myPrizeArray = {}
	local myRank = AoQiHeroModel.instance:getMyRank()

	self._txtMyRank.text = myRank <= 0 and lang("未上榜") or myRank

	local rankPrizeCfgs = AoQiHeroConfig.instance:getRankPrizeCfgs(self._activityId, self._rankType)
	local tipsDesc

	for k, v in pairs(rankPrizeCfgs) do
		tipsDesc = v.desc

		if myRank >= v.rankRange[1] and myRank <= v.rankRange[2] then
			myPrizeArray = string.split(v.prize, "#")

			break
		end
	end

	self._myItemTableList:reloadData(myPrizeArray)
	GameUtil.SetActive(self._txtEmptyTips, #myPrizeArray <= 0)
	GameUtil.SetActive(self._subTitle_1, self._rankType == RANK_TYPE_NORMAL)
	GameUtil.SetActive(self._subTitle_2, self._rankType == RANK_TYPE_ENDLESS)
	GameUtil.SetActive(self._subTitle_3, self._rankType == RANK_TYPE_PVP)

	if self._rankType == RANK_TYPE_NORMAL then
		self._txtMyStepTitle.text = lang("我的通关时间")

		local time = 0

		for i, v in ipairs(rankInfoList) do
			if v.headInfo.userId == RoleModel.instance:getUserId() then
				time = v.time / 1000
			end
		end

		if checknumber(time) == 0 then
			self._txtMyStep.text = lang("暂无记录")
		else
			local date = GameUtil.time2date(time)

			self._txtMyStep.text = string.format("%d.%d.%02d %02d:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)
		end
	elseif self._rankType == RANK_TYPE_ENDLESS then
		self._txtMyStepTitle.text = lang("我的通关")

		local stageId, roundNum = AoQiHeroModel.instance:getEndlessStageInfo(self._activityId)

		self._txtMyStep.text = langPara("%d关%d回合", stageId, roundNum)
	elseif self._rankType == RANK_TYPE_PVP then
		self._txtMyStepTitle.text = lang("我的积分")
		self._txtMyStep.text = AoQiHeroModel.instance:getPvPScroe(self._activityId)
	end

	self._txtTip.text = tipsDesc
end

function AoqiHeroRankView:_updateRankCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local itemTableView = goutil.findChild(go, "itemTableview")
	local rankInfo = data

	txtRank.text = rankInfo.rank

	GameUtil.SetActive(imgChangeRank, rankInfo.rank <= 3 and rankInfo.rank > 0)

	if rankInfo.rank <= 3 and rankInfo.rank > 0 then
		imgChangeRank:SetState(rankInfo.rank - 1)
		GameUtil.SetActive(imgChangeRank, true)
		GameUtil.SetActive(txtRank, false)
	else
		GameUtil.SetActive(imgChangeRank, false)
		GameUtil.SetActive(txtRank, true)
	end

	local proxy = HeadItemController.instance:setHeadCellByInfo(imgIcon, rankInfo.headInfo)

	if proxy then
		proxy:setCallBack(function()
			if rankInfo.headInfo.userId then
				self:onHeadClick(rankInfo.headInfo.userId, imgIcon)
			end
		end)
	end

	txtName.text = rankInfo.headInfo.userName

	if self._rankType == RANK_TYPE_NORMAL then
		local date = GameUtil.time2date(rankInfo.time / 1000)

		txtScore.text = string.format("%d.%d.%02d\n%02d:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)
	elseif self._rankType == RANK_TYPE_ENDLESS then
		local txtRuond = goutil.findChildTextComponent(go, "txtRound")

		txtScore.text = rankInfo.value
		txtRuond.text = rankInfo.otherValue
	elseif self._rankType == RANK_TYPE_PVP then
		txtScore.text = rankInfo.value
	end

	local prizeArray = {}
	local rankPrizeCfgs = AoQiHeroConfig.instance:getRankPrizeCfgs(self._activityId, self._rankType)

	for k, v in pairs(rankPrizeCfgs) do
		if v.rankRange[1] <= rankInfo.rank and v.rankRange[2] >= rankInfo.rank then
			prizeArray = string.split(v.prize, "#")

			break
		end
	end

	if itemTableView and self._itemTablecell then
		if not self._itemTableListDir[itemTableView] then
			local itemTableList = ScrollerList.create(itemTableView, self._itemTablecell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemTableListDir[itemTableView] = self._itemTableListDir[itemTableView]

			self._itemTableListDir[itemTableView]:reloadData(prizeArray)
		end
	end
end

function AoqiHeroRankView:_clearRankCell(cell)
	local go = cell.gameObject
	local itemTableView = goutil.findChild(go, "itemTableview")

	if self._itemTableListDir[itemTableView] then
		self._itemTableListDir[itemTableView]:dispose()

		self._itemTableListDir[itemTableView] = nil
	end
end

function AoqiHeroRankView:_updateTabCell(view, cell, data, tag)
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

	if data == self._rankType then
		uiChangeGroup:SetState(1)
	else
		uiChangeGroup:SetState(0)
	end

	GameUtil.addClickHandler(go, function()
		self:_onClickTabId(data)
	end)
end

function AoqiHeroRankView:_clearTabCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function AoqiHeroRankView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCellByCfg(data, go)
end

function AoqiHeroRankView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function AoqiHeroRankView:getCellTag(data, idx)
	if self._rankType == RANK_TYPE_NORMAL or self._rankType == RANK_TYPE_PVP then
		return 1
	else
		return 2
	end
end

function AoqiHeroRankView:_onClickTabId(tabId)
	self._rankType = tabId

	AoQiHeroAgent.instance:sendPM_AoQiHeroRankInfoReq(self._activityId, self._rankType)
end

function AoqiHeroRankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return AoqiHeroRankView
