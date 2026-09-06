-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoQiAttackForceHeroRankView.lua

module("logic.extensions.aoqiattackforce.view.AoQiAttackForceHeroRankView", package.seeall)

local AoQiAttackForceHeroRankView = class("AoQiAttackForceHeroRankView", ViewComponent)

function AoQiAttackForceHeroRankView:ctor()
	AoQiAttackForceHeroRankView.super.ctor(self)
end

function AoQiAttackForceHeroRankView:unbindEvents()
	AoQiAttackForceHeroRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AoQiAttackForceHeroRankView:bindEvents()
	AoQiAttackForceHeroRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AoQiAttackForceHeroRankView:buildUI()
	AoQiAttackForceHeroRankView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local tableviewGo = self:getGo("rankCol/rankScrollerview")
	local cellGo = self:getGo("rankCol/rankScrollercell")

	self._tableviewRank = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._prizeItem = self:getGo("rankCol/prizeItem")
	self._emptyGo = self:getGo("rankCol/emptyGo")
	self._txtMyRank = self:getTxt("tipsCol/txtMyRank")
end

function AoQiAttackForceHeroRankView:onExit()
	AoQiAttackForceHeroRankView.super.onExit(self)
	self._tableviewRank:dispose()

	self._subTabs = {}
end

function AoQiAttackForceHeroRankView:onEnter()
	AoQiAttackForceHeroRankView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	self.addGEvent(self, GlobalNotify.AQAFGetRankInfoRes, self._updateByInfo, self)
	AoQiAttackForceAgent.instance:sendPM_AoQiAttackForceHeroRankInfoReq(self._activityId)

	self._subTabs = {}
end

function AoQiAttackForceHeroRankView:_updateByInfo()
	local rankInfo = AoQiAttackForceModel.instance:getHeroRankInfoByActId(self._activityId)

	if rankInfo then
		if not rankInfo.rankInfos then
			local rankList = {}

			self._tableviewRank:reloadData(rankList)
			goutil.setActive(self._emptyGo, #rankList <= 0)

			self._txtMyRank.text = rankInfo.myRank <= 0 and lang("未上榜") or rankInfo.myRank
		end
	else
		self._tableviewRank:reloadData({})

		self._txtMyRank.text = lang("未上榜")

		goutil.setActive(self._emptyGo, true)
	end
end

function AoQiAttackForceHeroRankView:_updateRankCell(view, cell, data)
	local goHeadIcon = goutil.findChild(cell.gameObject, "head")
	local imgChangeImgRank = goutil.findChild(cell.gameObject, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRank")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtTime = goutil.findChildTextComponent(cell.gameObject, "txtScore")

	HeadItemController.instance:resetHeadCell(goHeadIcon)
	HeadItemController.instance:setHeadCellByInfo(goHeadIcon, data.headInfo, true)

	local isTop3 = data.rank <= 3

	if isTop3 then
		imgChangeImgRank:SetState(data.rank - 1)
		goutil.setActive(imgChangeImgRank.gameObject, true)
		goutil.setActive(txtRank.gameObject, false)
	else
		goutil.setActive(txtRank.gameObject, true)
		goutil.setActive(imgChangeImgRank.gameObject, false)

		txtRank.text = data.rank
	end

	txtName.text = data.headInfo.userName

	local date = GameUtil.time2date(checknumber(data.time) / 1000)

	txtTime.text = langPara("%d月%d日\n%02d:%02d:%02d", date.month, date.day, date.hour, date.min, date.sec)

	local subTab = self._subTabs[cell.gameObject]

	if not subTab then
		local prizeCom = goutil.findChild(cell.gameObject, "itemScrollerview")

		subTab = ScrollerList.create(prizeCom, self._prizeItem, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
		self._subTabs[cell.gameObject] = subTab
	end

	local prizeCfg = AoQiAttackForceConfig.instance:getHeroRankCfgByRank(self._activityId, data.rank)

	if prizeCfg then
		if not prizeCfg.prize then
			local prize = ""
			local itemList = string.split(prize, "#")

			subTab:reloadData(itemList)
			subTab:MoveCellToBegin(0)
		end
	end
end

function AoQiAttackForceHeroRankView:_clearRankCell(cell)
	local goHeadIcon = goutil.findChild(cell.gameObject, "head")

	HeadItemController.instance:resetHeadCell(goHeadIcon)

	local subTab = self._subTabs[cell.gameObject]

	if subTab then
		subTab:dispose()
	end
end

function AoQiAttackForceHeroRankView:_updateItemCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function AoQiAttackForceHeroRankView:_clearItemCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

return AoQiAttackForceHeroRankView
