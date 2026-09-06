-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/rank/AoqiGodHelperRankView.lua

module("logic.extensions.aoqigod.view.rank.AoqiGodHelperRankView", package.seeall)

local AoqiGodHelperRankView = class("AoqiGodHelperRankView", ViewComponent)

function AoqiGodHelperRankView:buildUI()
	AoqiGodHelperRankView.super.buildUI(self)

	self._filedView = goutil.findChild(self.mainGO, "rankCol/titleCol/filedView")
	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemScrollercell = goutil.findChild(self.mainGO, "rankCol/itemScrollercell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._txtMyHelp = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyHelp")
	self._myPrizeCol = goutil.findChild(self.mainGO, "tipsCol/myPrizeCol")
	self._myPrizeCol_itemScrollerview = goutil.findChild(self.mainGO, "tipsCol/myPrizeCol/itemScrollerview")
	self._myPrizeCol_itemScrollercell = goutil.findChild(self.mainGO, "tipsCol/myPrizeCol/itemScrollercell")
	self._myPrizeScrollList = ScrollerList.create(self._myPrizeCol_itemScrollerview, self._myPrizeCol_itemScrollercell, GameUtil.handler(self._updateMyPrizeItemCell, self), GameUtil.handler(self._clearMyPrizeItemCell, self))
end

function AoqiGodHelperRankView:bindEvents()
	AoqiGodHelperRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AoqiGodHelperRankView:unbindEvents()
	AoqiGodHelperRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AoqiGodHelperRankView:onEnter()
	AoqiGodHelperRankView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._rankType = checknumber(params[2])

	local isInTime = AoqiGodController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("不在活动时间内")
		self:close()

		return
	end

	self._aoqiGodMo = AoqiGodController.instance:getAoqiGodMo(self._activityId)
	self._myRank = 0
	self._rankInfoList = {}

	self.addGEvent(self, GlobalNotify.HandlePM_AoqiGodRankRes, self._handlePM_AoqiGodRankRes, self)
	AoqiGodController.instance:sendPM_AoqiGodRankReq(self._activityId)
end

function AoqiGodHelperRankView:onExit()
	AoqiGodHelperRankView.super.onExit(self)
	self._rankScrollList:dispose()
	self._myPrizeScrollList:dispose()
end

function AoqiGodHelperRankView:_handlePM_AoqiGodRankRes()
	self._rankMsg = self._aoqiGodMo:getRankResMsg()
	self._myRank = self._rankMsg.myRank
	self._rankInfoList = self._rankMsg.rankInfos
	self._score = self._rankMsg.score

	self:_onUpdate()
end

function AoqiGodHelperRankView:_getPrizesByRank(rank)
	local prize
	local prizeData = AoqiGodConfig.instance:getRankPrizeData(self._activityId, rank)

	return (prizeData or nil) and prizeData.prize
end

function AoqiGodHelperRankView:_onUpdate()
	self._txtMyRank.text = self._myRank > 0 and self._myRank or "未上榜"
	self._txtMyHelp.text = checknumber(self._score)

	local prizes = self:_getPrizesByRank(self._myRank)

	if not string.nilorempty(prizes) then
		local prizeStrArr = string.split(prizes, "#")

		self._myPrizeScrollList:reloadData(prizeStrArr)
		self._myPrizeScrollList:dragNotifyParent()
		GameUtil.SetActive(self._myPrizeCol, true)
	else
		GameUtil.SetActive(self._myPrizeCol, false)
		self._myPrizeScrollList:dispose()
	end

	GameUtil.SetActive(self._emptyGo, #self._rankInfoList <= 0)
	self._rankScrollList:reloadData(self._rankInfoList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)
end

function AoqiGodHelperRankView:_updateRankCell(view, cell, info, tag)
	local rank = info.rank
	local headInfo = info.headInfo
	local socre = info.value
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")

	txtRank.text = rank

	local isTop3 = checknumber(rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	if txtName then
		txtName.text = headInfo.userName
	end

	if txtScore then
		txtScore.text = socre
	end

	HeadItemController.instance:setHeadCellByInfo(head, headInfo, true)

	local prizes = self:_getPrizesByRank(rank)

	if itemScrollerview and self._itemScrollercell and not string.nilorempty(prizes) then
		local prizeStrArr = string.split(prizes, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = self._itemScrollListDic[mainGo]

			self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
			self._itemScrollListDic[mainGo]:dragNotifyParent()
		end
	end
end

function AoqiGodHelperRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")

	HeadItemController.instance:resetHeadCell(head)

	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function AoqiGodHelperRankView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function AoqiGodHelperRankView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function AoqiGodHelperRankView:_updateMyPrizeItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function AoqiGodHelperRankView:_clearMyPrizeItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return AoqiGodHelperRankView
