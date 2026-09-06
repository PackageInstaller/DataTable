-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapter4RankView.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapter4RankView", package.seeall)

local BoccaccioChapter4RankView = class("BoccaccioChapter4RankView", ViewComponent)

function BoccaccioChapter4RankView:ctor()
	BoccaccioChapter4RankView.super.ctor(self)
end

function BoccaccioChapter4RankView:unbindEvents()
	BoccaccioChapter4RankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function BoccaccioChapter4RankView:bindEvents()
	BoccaccioChapter4RankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function BoccaccioChapter4RankView:buildUI()
	BoccaccioChapter4RankView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local goCellRank = self:getGo("content/rankcell")
	local goTableViewRank = self:getGo("content/rankview")

	self._tableViewRank = ScrollerList.create(goTableViewRank, goCellRank, GameUtil.handler(self._updateCellRank, self), GameUtil.handler(self._clearCellRank, self))
	self._goEmpty = self:getGo("content/goEmpty")
	self._txtMyRank = self:getTxt("content/myRank/txtMyRank")
	self._item = self:getGo("item")

	goutil.setActive(self._item, false)

	self._myPrizeCon = self:getGo("content/myRank/myPrizeCon")
	self._tableview = self:getGo("content/myRank/myPrizeCon/tableview")
	self._tablecell = self:getGo("content/myRank/myPrizeCon/tablecell")
	self._myPrizeScrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	GameUtil.SetActive(self._myPrizeCon, false)
end

function BoccaccioChapter4RankView:onExit()
	BoccaccioChapter4RankView.super.onExit(self)
	self._tableViewRank:dispose()
	self._myPrizeScrollList:dispose()
end

function BoccaccioChapter4RankView:onEnter()
	BoccaccioChapter4RankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandlePM_BoccaccioChapter4RankViewRes, self._updateUIByInfo, self)

	self._itemScrollListDic = {}
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 580001
	end

	self:_updateUIByInfo()
	BoccaccioChapterController.instance:sendPM_BoccaccioChapter4RankViewReq(self._activityId)
end

function BoccaccioChapter4RankView:_updateUIByInfo()
	local myRank = -1
	local rankInfos = {}
	local subMo = BoccaccioChapterController.instance:getSubMo(self._activityId)

	if subMo then
		local rankInfo = subMo:getChapter4RankInfo()

		if rankInfo then
			rankInfos = rankInfo.rankInfoList or {}
			myRank = rankInfo.myRank or -1
		end
	end

	self._tableViewRank:reloadData(rankInfos)

	if #rankInfos > 0 then
		GameUtil.SetActive(self._goEmpty, false)
	else
		GameUtil.SetActive(self._goEmpty, true)
	end

	self._txtMyRank.text = checknumber(myRank) > 0 and myRank or lang("未上榜")

	local myPrizes = self:_getPrizesByRank(myRank)

	if myPrizes and myPrizes ~= "" then
		GameUtil.SetActive(self._myPrizeCon, true)

		local prizeStrArr = string.split(myPrizes, "#")

		self._myPrizeScrollList:reloadData(prizeStrArr)
	else
		GameUtil.SetActive(self._myPrizeCon, false)
	end
end

function BoccaccioChapter4RankView:_updateCellRank(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local itemListGo = goutil.findChild(go, "prizeCom")
	local txtDate = goutil.findChildTextComponent(cell, "txtDate")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
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

	HeadItemController.instance:setHeadCellByInfo(imgIcon, rankInfo.headInfo, true)

	local date = GameUtil.time2date(checknumber(data.time / 1000))

	txtDate.text = string.format("%s-%s-%s\n%02d:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)
	txtName.text = rankInfo.headInfo.userName
	txtScore.text = self:numberToString(checknumber(rankInfo.value))

	local prizes = self:_getPrizesByRank(rankInfo.rank)

	if itemListGo and self._item then
		if not self._itemScrollListDic[go] then
			local prizeScrollList = ScrollerList.create(itemListGo, self._item, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[go] = self._itemScrollListDic[go]

			local prizeStrArr = string.split(prizes, "#")

			self._itemScrollListDic[go]:reloadData(prizeStrArr)
			self._itemScrollListDic[go]:dragNotifyParent()
		end
	end
end

function BoccaccioChapter4RankView:_clearCellRank(cell)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "imgHeadIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)

	local prizeScrollList = self._itemScrollListDic[go]

	if prizeScrollList then
		prizeScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function BoccaccioChapter4RankView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function BoccaccioChapter4RankView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function BoccaccioChapter4RankView:_getPrizesByRank(rank)
	local data = BoccaccioChapterConfig.instance:getChapter4RankPrizeDataByRank(self._activityId, rank)

	return (data or nil) and (data.prize or "")
end

function BoccaccioChapter4RankView:numberToString(num)
	return num >= 100000000 and string.format("%.2f亿", num / 100000000) or num >= 10000 and string.format("%.2f万", num / 10000) or tostring(num)
end

return BoccaccioChapter4RankView
