-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoqiAttackForceRankView.lua

module("logic.extensions.aoqiattackforce.view.AoqiAttackForceRankView", package.seeall)

local AoqiAttackForceRankView = class("AoqiAttackForceRankView", ViewComponent)

function AoqiAttackForceRankView:ctor()
	AoqiAttackForceRankView.super.ctor(self)
end

function AoqiAttackForceRankView:unbindEvents()
	AoqiAttackForceRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AoqiAttackForceRankView:bindEvents()
	AoqiAttackForceRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AoqiAttackForceRankView:buildUI()
	AoqiAttackForceRankView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local tableviewGo = self:getGo("rankCol/rankScrollerview")
	local cellGo = self:getGo("rankCol/rankScrollercell")

	self._tableviewRank = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._prizeItem = self:getGo("rankCol/prizeItem")
	self._emptyGo = self:getGo("rankCol/emptyGo")
	self._txtMyRank = self:getTxt("tipsCol/txtMyRank")
end

function AoqiAttackForceRankView:onExit()
	AoqiAttackForceRankView.super.onExit(self)
	self._tableviewRank:dispose()

	self._subTabs = {}
end

function AoqiAttackForceRankView:onEnter()
	AoqiAttackForceRankView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	self.addGEvent(self, GlobalNotify.AQAFGetRankInfoRes, self._updateByInfo, self)
	AoQiAttackForceController.instance:getRankInfo(self._activityId)

	self._subTabs = {}
end

function AoqiAttackForceRankView:_updateByInfo()
	local rankInfo = AoQiAttackForceModel.instance:getRankInfoByActId(self._activityId)

	if rankInfo then
		if not rankInfo.rankInfos then
			local rankList = {}

			self._tableviewRank:reloadData(rankList)
			goutil.setActive(self._emptyGo, #rankList <= 0)

			self._txtMyRank.text = rankInfo.myRank <= 0 and "未上榜" or rankInfo.myRank
		end
	else
		self._tableviewRank:reloadData({})

		self._txtMyRank.text = "未上榜"

		goutil.setActive(self._emptyGo, true)
	end
end

function AoqiAttackForceRankView:_updateRankCell(view, cell, data)
	local goHeadIcon = goutil.findChild(cell.gameObject, "head")
	local imgChangeImgRank = goutil.findChild(cell.gameObject, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRank")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtScore = goutil.findChildTextComponent(cell.gameObject, "txtScore")

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

	local score = checknumber(data.value)

	txtScore.text = score > 100000 and 100000 or score

	local subTab = self._subTabs[cell.gameObject]

	if not subTab then
		local prizeCom = goutil.findChild(cell.gameObject, "itemScrollerview")

		subTab = ScrollerList.create(prizeCom, self._prizeItem, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
		self._subTabs[cell.gameObject] = subTab
	end

	local prizeCfg = AoQiAttackForceConfig.instance:getRankCfgByRank(self._activityId, data.rank)

	if prizeCfg then
		if not prizeCfg.prize then
			local prize = ""
			local itemList = string.split(prize, "#")

			subTab:reloadData(itemList)
			subTab:MoveCellToBegin(0)
		end
	end
end

function AoqiAttackForceRankView:_clearRankCell(cell)
	local goHeadIcon = goutil.findChild(cell.gameObject, "head")

	HeadItemController.instance:resetHeadCell(goHeadIcon)

	local subTab = self._subTabs[cell.gameObject]

	if subTab then
		subTab:dispose()
	end
end

function AoqiAttackForceRankView:_updateItemCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function AoqiAttackForceRankView:_clearItemCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

return AoqiAttackForceRankView
