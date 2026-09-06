-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anchorsimulator/view/AnchorSimulatorRankView.lua

module("logic.extensions.anchorsimulator.view.AnchorSimulatorRankView", package.seeall)

local AnchorSimulatorRankView = class("AnchorSimulatorRankView", ViewComponent)

function AnchorSimulatorRankView:ctor()
	AnchorSimulatorRankView.super.ctor(self)
end

function AnchorSimulatorRankView:buildUI()
	AnchorSimulatorRankView.super.buildUI(self)

	self._closeBtn = self:getGo("closeBtn")
	self._txtMyRank = self:getTxt("tipsCol/txtMyRank")
	self._emptyGo = self:getGo("rankCol/emptyGo")
	self._rankScrollerview = self:getGo("rankCol/rankScrollerview")
	self._rankScrollercell = self:getGo("rankCol/rankScrollercell")
	self._itemScrollercell = self:getGo("rankCol/itemScrollercell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._myPrizeCol = self:getGo("tipsCol/myPrizeCol")
	self._myPrizeCol_itemScrollerview = self:getGo("tipsCol/myPrizeCol/itemScrollerview")
	self._myPrizeCol_itemScrollercell = self:getGo("tipsCol/myPrizeCol/itemScrollercell")
	self._myPrizeScrollList = ScrollerList.create(self._myPrizeCol_itemScrollerview, self._myPrizeCol_itemScrollercell, GameUtil.handler(self._updateMyPrizeItemCell, self), GameUtil.handler(self._clearMyPrizeItemCell, self))
	self._txtMyValue = self:getTxt("tipsCol/txtMyValue")
end

function AnchorSimulatorRankView:bindEvents()
	AnchorSimulatorRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeBtn, self.close, self)
end

function AnchorSimulatorRankView:unbindEvents()
	AnchorSimulatorRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeBtn)
end

function AnchorSimulatorRankView:destroyUI()
	AnchorSimulatorRankView.super.destroyUI(self)
end

function AnchorSimulatorRankView:onEnter()
	AnchorSimulatorRankView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = AnchorSimulatorController.instance:getActivityId()
	end

	local isInTime = AnchorSimulatorController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._myValue = 0
	self._myRank = 0
	self._infoList = {}

	self.addGEvent(self, GlobalNotify.HandlePM_AnchorSimulatorRankViewRes, self._handleMsg, self)
	AnchorSimulatorController.instance:sendPM_AnchorSimulatorRankViewReq(self._activityId)
	self:_onUpdate()
end

function AnchorSimulatorRankView:onExit()
	AnchorSimulatorRankView.super.onExit(self)
	self:_onClear()
	self._myPrizeScrollList:dispose()
end

function AnchorSimulatorRankView:_handleMsg(msg)
	self._myValue = msg.myHeatValue
	self._myRank = msg.myRank
	self._infoList = msg.rankInfoList

	self:_onUpdate()
end

function AnchorSimulatorRankView:_onUpdate()
	local myRank = self._myRank

	self._txtMyRank.text = myRank > 0 and myRank or "未上榜"

	local prizes = self:_getPrizesByRank(myRank)

	if not string.nilorempty(prizes) then
		local prizeStrArr = string.split(prizes, "#")

		self._myPrizeScrollList:reloadData(prizeStrArr)
		self._myPrizeScrollList:dragNotifyParent()
		GameUtil.SetActive(self._myPrizeCol, true)
	else
		GameUtil.SetActive(self._myPrizeCol, false)
		self._myPrizeScrollList:dispose()
	end

	self._txtMyValue.text = self._myValue

	self._rankScrollList:reloadData(self._infoList)
	self._rankScrollList:MoveCellInView(0, true)
	GameUtil.SetActive(self._emptyGo, #self._infoList <= 0)
end

function AnchorSimulatorRankView:_onClear()
	self._rankScrollList:dispose()
end

function AnchorSimulatorRankView:_getPrizesByRank(rank)
	local prizeData = AnchorSimulatorConfig.instance:getRankPrizeDataByRank(self._activityId, rank)

	return prizeData and prizeData.prize
end

function AnchorSimulatorRankView:_updateRankCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local txtArea = goutil.findChildTextComponent(mainGo, "txtArea")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")

	txtRank.text = info.rank

	local isTop3 = checknumber(info.rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(info.rank - 1)
	end

	txtName.text = info.headInfo.userName
	txtArea.text = info.headInfo.areaName
	txtScore.text = info.value

	local date = GameUtil.time2date(info.time / 1000)

	txtTime.text = string.format("%02d.%02d %02d:%02d", date.month, date.day, date.hour, date.min)

	HeadItemController.instance:setHeadCellByInfo(head, info.headInfo, true)

	local prizes = self:_getPrizesByRank(info.rank)

	if itemScrollerview and self._itemScrollercell and not string.nilorempty(prizes) then
		local prizeStrArr = string.split(prizes, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = self._itemScrollListDic[mainGo]

			self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
			self._itemScrollListDic[mainGo]:dragNotifyParent()
			self._itemScrollListDic[mainGo]:setCenterMode(true)
		end
	end
end

function AnchorSimulatorRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")

	HeadItemController.instance:resetHeadCell(head)

	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function AnchorSimulatorRankView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function AnchorSimulatorRankView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function AnchorSimulatorRankView:_updateMyPrizeItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function AnchorSimulatorRankView:_clearMyPrizeItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return AnchorSimulatorRankView
