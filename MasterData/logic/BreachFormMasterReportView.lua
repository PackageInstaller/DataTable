-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/view/BreachFormMasterReportView.lua

module("logic.extensions.breachformmaster.view.BreachFormMasterReportView", package.seeall)

local BreachFormMasterReportView = class("BreachFormMasterReportView", ViewComponent)

function BreachFormMasterReportView:ctor()
	BreachFormMasterReportView.super.ctor(self)
end

function BreachFormMasterReportView:unbindEvents()
	BreachFormMasterReportView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function BreachFormMasterReportView:bindEvents()
	BreachFormMasterReportView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function BreachFormMasterReportView:buildUI()
	BreachFormMasterReportView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local cellGo = self:getGo("cell")
	local tableviewGo = self:getGo("tableview")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._empty = self:getGo("goEmpty")
end

function BreachFormMasterReportView:onExit()
	BreachFormMasterReportView.super.onExit(self)
	self._tableview:dispose()
end

function BreachFormMasterReportView:onEnter()
	BreachFormMasterReportView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_BreachFormMasterBattleReportRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_BreachFormMasterBattleVideoRes, self._handleGetBattleVideo, self)
	self.addGEvent(self, GlobalNotify.PM_BreachFormMasterBattleVideoErrorRes, self._handleGetBattleVideoError, self)

	self._activityId = checknumber(self:getFirstParam())

	BreachFormMasterAgent.instance:sendPM_BreachFormMasterBattleReportReq(self._activityId)
end

function BreachFormMasterReportView:_refreshView()
	local reportInfo = BreachFormMasterModel.instance:getReportInfo()

	if not reportInfo.reportList then
		local recordNos = {}

		self._tableview:reloadData(recordNos)
		goutil.setActive(self._empty, #recordNos <= 0)
	end
end

function BreachFormMasterReportView:_updateCell(view, cellGo, data)
	local cell = self:_clearCell(cellGo)

	GameUtil.addClickHandler(cell.btnVideo, GameUtil.handler(self._onClickPlayVideo, self, data.battleId))
	GameUtil.addClickHandler(cell.btnScore, GameUtil.handler(self._onClickDetail, self, data))
	cell.imgResult:SetState(0)
	HeadItemController.instance:setMyHeadCell(cell.leftPart.head)

	cell.leftPart.txtName.text = RoleModel.instance:getUserName()

	HeadItemController.instance:setHeadCellByInfo(cell.rightPart.head, data.attackPlayerHead, true)

	cell.rightPart.txtName.text = data.attackPlayerHead.userName

	local totalScore = data.defenseScore + data.zdlDiffScore + data.activePetCount + data.circleCount

	cell.txtScore.text = langPara("防守积分：<color=#20B376FF>%s</color>", totalScore)
end

function BreachFormMasterReportView:_clearCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.btnVideo = goutil.findChild(cell.go, "btnVideo")
	cell.btnScore = goutil.findChild(cell.go, "btnScore")

	GameUtil.rmClickHandler(cell.btnVideo)

	cell.imgResult = goutil.findChildComponent(cell.go, "imgResult", "UIImageSpriteChange")
	cell.leftPart = self:_getPlayerPart(goutil.findChild(cell.go, "left"))
	cell.txtScore = goutil.findChildTextComponent(cell.leftPart.go, "txtScore")

	HeadItemController.instance:resetHeadCell(cell.leftPart.head)

	cell.rightPart = self:_getPlayerPart(goutil.findChild(cell.go, "right"))

	HeadItemController.instance:resetHeadCell(cell.rightPart.head)

	return cell
end

function BreachFormMasterReportView:_getPlayerPart(partGo)
	local partCell = {}

	partCell.go = partGo
	partCell.head = goutil.findChild(partCell.go, "head")
	partCell.txtName = goutil.findChildTextComponent(partCell.go, "txtName")

	return partCell
end

function BreachFormMasterReportView:_onClickPlayVideo(battleId)
	if checknumber(battleId) <= 0 then
		TipsFacade.instance:openCommonTips("战斗记录已过期")

		return
	end

	BreachFormMasterAgent.instance:sendPM_BreachFormMasterBattleVideoReq(battleId)
end

function BreachFormMasterReportView:_onClickDetail(data)
	UIStateManager.instance:push(ViewName.BreachFormMasterDetailView, self._activityId, data)
end

function BreachFormMasterReportView:_handleGetBattleVideo(handle)
	UIJumper.instance:clear()
	UIJumper.instance:saveCurStack()

	if handle then
		handle()
	end
end

function BreachFormMasterReportView:_handleGetBattleVideoError(status)
	if status == -526 or status == -47 then
		TipsFacade.instance:openCommonTips("战斗记录已过期")
	end
end

return BreachFormMasterReportView
