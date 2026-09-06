-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchrankView.lua

module("logic.extensions.annimatch.view.AnnimatchrankView", package.seeall)

local AnnimatchrankView = class("AnnimatchrankView", ViewComponent)

function AnnimatchrankView:ctor()
	AnnimatchrankView.super.ctor(self)
end

function AnnimatchrankView:unbindEvents()
	AnnimatchrankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose, self)
end

function AnnimatchrankView:bindEvents()
	AnnimatchrankView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function AnnimatchrankView:buildUI()
	AnnimatchrankView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.goEmpty = self:getGo("content/goEmpty")
	self.rankcell = self:getGo("content/rankcell")
	self.rankview = self:getGo("content/rankview")
	self.txtmyRank = self:getTxt("content/myRank/txtMyRank")
	self.txtTip = self:getTxt("content/myRank/txtTip")
	self.scrollList = ScrollerList.create(self.rankview, self.rankcell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function AnnimatchrankView:onExit()
	AnnimatchrankView.super.onExit(self)
	self.scrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.OnAnnimatchGetRankInfo, self.refreshUI, self)
end

function AnnimatchrankView:onEnter()
	AnnimatchrankView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.OnAnnimatchGetRankInfo, self.refreshUI, self)

	local activityId = AnnimatchController.instance:getCurrActId()

	AnnimatchController.instance:sendGetRankInfo(activityId)
	self:refreshUI()
end

function AnnimatchrankView:refreshUI()
	local activityId = AnnimatchController.instance:getCurrActId()
	local info = AnnimatchModel.instance:getRankInfo(activityId)

	self.txtmyRank.text = checknumber(info.myRank) > 0 and info.myRank or lang("text_rank_notrank")
	self.txtTip.text = AnnimatchConfig.instance:getCommonByKey("RANK_VIEW_DESC")

	if not info.rankInfos then
		local list = {}

		self.scrollList:reloadData(list)
		GameUtil.SetActive(self.goEmpty, #list == 0)
	end
end

function AnnimatchrankView:_updateCell(view, cell, data, tag)
	local imgRank = goutil.findChild(cell, "imgRank")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local imgHeadIcon = goutil.findChild(cell, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtArea = goutil.findChildTextComponent(cell, "txtArea")
	local txtWin = goutil.findChildTextComponent(cell, "txtWin")
	local txtRate = goutil.findChildTextComponent(cell, "txtRate")

	GameUtil.SetActive(imgRank, data.rank <= 3)

	if data.rank <= 3 then
		GameUtil.setUIImageSpriteIdx(imgRank, data.rank - 1)

		txtRank.text = ""
	else
		txtRank.text = data.rank
	end

	HeadItemController.instance:setHeadCellByInfo(imgHeadIcon, data.headInfo, true)

	txtName.text = data.headInfo.userName
	txtArea.text = data.areaName
	txtWin.text = data.totalWinTimes
	txtRate.text = string.format("%.2f", data.totalWinRate * 100) .. "%"

	local prizeCom = goutil.findChild(cell, "prizeCom")
	local itemGo = goutil.findChild(cell, "item")
	local tableview = ScrollerList.create(prizeCom, itemGo, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
	local prizeStr = AnnimatchConfig.instance:getRankPrizeCfg(AnnimatchController.instance:getCurrActId(), data.rank)

	tableview:reloadData(MaterialMgr.changeItemStrArr(prizeStr))
end

function AnnimatchrankView:clearCell(cell)
	local imgHeadIcon = goutil.findChild(cell, "imgHeadIcon")

	HeadItemController.instance:resetHeadCell(imgHeadIcon)

	local prizeCom = goutil.findChild(cell, "prizeCom")
	local itemGo = goutil.findChild(cell, "item")
	local tableview = ScrollerList.create(prizeCom, itemGo, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	tableview:dispose()
end

function AnnimatchrankView:_updateItemCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell)
end

function AnnimatchrankView:_clearItemCell(cell)
	MaterialMgr.resetAll(cell)
end

return AnnimatchrankView
