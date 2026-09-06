-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroAllReportView.lua

module("logic.extensions.aoqihero.view.AoqiHeroAllReportView", package.seeall)

local AoqiHeroAllReportView = class("AoqiHeroAllReportView", ViewComponent)

function AoqiHeroAllReportView:ctor()
	AoqiHeroAllReportView.super.ctor(self)
end

function AoqiHeroAllReportView:unbindEvents()
	AoqiHeroAllReportView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AoqiHeroAllReportView:bindEvents()
	AoqiHeroAllReportView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AoqiHeroAllReportView:buildUI()
	AoqiHeroAllReportView.super.buildUI(self)

	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getGo("btnClose")
	self._goEmpty = self:getGo("goEmpty")
end

function AoqiHeroAllReportView:onExit()
	AoqiHeroAllReportView.super.onExit(self)
end

function AoqiHeroAllReportView:onEnter()
	AoqiHeroAllReportView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroPvPRecordRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())

	AoQiHeroController.instance:setNewReport(false)
	AoQiHeroAgent.instance:sendPM_AoQiHeroPvPRecordReq(self._activityId)
end

function AoqiHeroAllReportView:_refreshView()
	local recordList = AoQiHeroModel.instance:getRecordInfo(self._activityId) or {}
	local reverseList = {}

	for i, v in ipairs(recordList) do
		table.insert(reverseList, 1, v)
	end

	self._tableList:reloadData(reverseList)
	GameUtil.SetActive(self._goEmpty, #reverseList <= 0)
end

function AoqiHeroAllReportView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local leftHeadInfoGo = goutil.findChild(go, "leftHeadInfo")
	local rightHeadInfoGo = goutil.findChild(go, "rightHeadInfo")
	local btnDetail = goutil.findChild(go, "btnDetail")
	local imgResultChange = goutil.findChildComponent(go, "imgResult", ComponentType.UIImageSpriteChange)
	local imgWait = goutil.findChild(go, "imgWait")
	local txtLeftInfo = goutil.findChildTextComponent(go, "txtLeftInfo")
	local txtRightInfo = goutil.findChildTextComponent(go, "txtRightInfo")
	local txtLeftScore = goutil.findChildTextComponent(go, "txtLeftScore")
	local txtRightScore = goutil.findChildTextComponent(go, "txtRightScore")
	local txtTime = goutil.findChildTextComponent(go, "txtTime")
	local headInfo = RoleModel.instance:getHeadInfo()

	HeadItemController.instance:setHeadCellByInfo(leftHeadInfoGo, headInfo, false)

	txtLeftInfo.text = langPara("%s\n%s", RoleModel.instance:getAreaName(), RoleModel.instance:getUserName())

	HeadItemController.instance:setHeadCellByInfo(rightHeadInfoGo, data.enemyHeadInfo, false)

	txtRightInfo.text = langPara("%s\n%s", data.enemyHeadInfo.areaName, data.enemyHeadInfo.userName)

	local hasResult = data.completed ~= nil and data.myBattleResult ~= nil and data.opBattleResult ~= nil

	if data.completed == true then
		txtLeftScore.text = string.format("%.2f%%", data.myLeftHp * 100)
		txtRightScore.text = string.format("%.2f%%", data.enemyLeftHp * 100)

		GameUtil.SetActive(txtTime, true)
		GameUtil.SetActive(imgResultChange, true)

		if data.result == 0 then
			imgResultChange:SetState(2)
			GameUtil.setAnchoredPos(imgResultChange, -363, 0)
		elseif data.result == 1 then
			imgResultChange:SetState(0)
			GameUtil.setAnchoredPos(imgResultChange, -356, 0)
		elseif data.result == -1 then
			imgResultChange:SetState(1)
			GameUtil.setAnchoredPos(imgResultChange, -356, 0)
		end

		local date = GameUtil.time2date(data.time / 1000)

		txtTime.text = string.format("%d-%d %d:%02d", date.month, date.day, date.hour, date.min)

		GameUtil.SetActive(imgWait, false)
	else
		txtRightScore.text = "100%"
		txtLeftScore.text = "100%"

		GameUtil.SetActive(imgWait, true)
		GameUtil.SetActive(imgResultChange, false)
		GameUtil.SetActive(txtTime, false)
	end

	GameUtil.SetGray(btnDetail, not hasResult)
	GameUtil.addClickHandler(btnDetail, function()
		self:_onClickDetail(data)
	end)
end

function AoqiHeroAllReportView:_clearCell(cell)
	local go = cell.gameObject
	local leftHeadInfoGo = goutil.findChild(go, "leftHeadInfo")
	local rightHeadInfoGo = goutil.findChild(go, "rightHeadInfo")

	HeadItemController.instance:resetHeadCell(leftHeadInfoGo)
	HeadItemController.instance:resetHeadCell(rightHeadInfoGo)
	GameUtil.rmClickHandler(go)
end

function AoqiHeroAllReportView:_onClickDetail(data)
	local hasResult = data.completed ~= nil and data.myBattleResult ~= nil and data.opBattleResult ~= nil

	if data.completed == true then
		if hasResult then
			self:close()
			UIStateManager.instance:push(ViewName.AoqiHeroReportView, self._activityId, data)
		else
			FloatWordMgr.instance:show(lang("无完整战斗数据"))
		end
	else
		FloatWordMgr.instance:show(lang("正在结算"))
	end
end

return AoqiHeroAllReportView
