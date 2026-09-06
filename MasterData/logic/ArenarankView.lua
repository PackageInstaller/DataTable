-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showoff/view/ArenarankView.lua

module("logic.extensions.showoff.view.ArenarankView", package.seeall)

local ArenarankView = class("ArenarankView", ViewComponent)

function ArenarankView:ctor()
	ArenarankView.super.ctor(self)
end

function ArenarankView:unbindEvents()
	ArenarankView.super.unbindEvents(self)
end

function ArenarankView:bindEvents()
	ArenarankView.super.bindEvents(self)
end

function ArenarankView:buildUI()
	ArenarankView.super.buildUI(self)

	self._goEmpty = self:getGo("goEmpty")
	self._myRank = self:getGo("myRank")
	self._txtMyRank = self:getTxt("myRank/txtMyRank")
	self._txtZone = self:getTxt("zoneTip/txtZone")
	self._tableview = self:getGo("tableview")
	self._rankcell = self:getGo("rankcell")
	self._scrollList = ScrollerList.create(self._tableview, self._rankcell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ArenarankView:onExit()
	ArenarankView.super.onExit(self)
	self._scrollList:dispose()
end

function ArenarankView:onEnter()
	ArenarankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.RankDataGet, self._refreshUI, self)

	local zoneId = ArenaModel.instance:getZoneId()

	if zoneId == -1 then
		zoneId = 2
	end

	ArenaAgent.instance:sendGetTopDetailReq(zoneId, 1, 100)
end

function ArenarankView:_refreshUI()
	local info = RankModel.instance:getRankMo(GameEnum.RankType.Arena, 0) or {}

	if not info.rankList then
		local infoList = {}

		GameUtil.SetActive(self._goEmpty, #infoList == 0)
		self._scrollList:reloadData(infoList)

		local rank = checknumber(info.myRank)

		self._txtMyRank.text = rank <= 0 and lang("未上榜") or rank

		local zoneId = ArenaModel.instance:getZoneId()

		self._txtZone.text = ArenaModel.instance:getZoneName(zoneId)
	end
end

function ArenarankView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local head = goutil.findChild(go, "imgIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtFamily = goutil.findChildTextComponent(go, "txtFamily")
	local txtFightPower = goutil.findChildTextComponent(go, "txtFightPower")
	local btnDef = goutil.findChild(go, "btnDef")
	local rankInfo = data

	txtRank.text = rankInfo.rank
	txtFamily.text = rankInfo.familyName
	txtFamily.text = string.nilorempty(rankInfo.familyName) and lang("无") or rankInfo.familyName

	GameUtil.SetActive(imgChangeRank, rankInfo.rank <= 3 and rankInfo.rank > 0)

	if rankInfo.rank <= 3 and rankInfo.rank > 0 then
		imgChangeRank:SetState(rankInfo.rank - 1)
		GameUtil.SetActive(imgChangeRank, true)
		GameUtil.SetActive(txtRank, false)
	else
		GameUtil.SetActive(imgChangeRank, false)
		GameUtil.SetActive(txtRank, true)
	end

	local proxy = HeadItemController.instance:setHeadCellByInfo(head, rankInfo.headInfo, true)

	txtName.text = rankInfo.headInfo.userName
	txtFightPower.text = rankInfo.everMaxZdl

	GameUtil.addClickHandler(btnDef, GameUtil.handler(self._onClickDef, self, data))
end

function ArenarankView:_clearCell(cell)
	local head = goutil.findChild(cell, "imgIcon")

	HeadItemController.instance:resetHeadCell(head)
end

function ArenarankView:_onClickDef(mo)
	if not mo or not mo.headInfo then
		return
	end

	UIStateManager.instance:open(ViewName.ArenaDefFmtView, mo.headInfo.userId, mo.headInfo.userName, mo.everMaxZdl)
end

return ArenarankView
