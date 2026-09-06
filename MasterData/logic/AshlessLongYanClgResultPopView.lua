-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashlesslongyan/view/AshlessLongYanClgResultPopView.lua

module("logic.extensions.ashlesslongyan.view.AshlessLongYanClgResultPopView", package.seeall)

local AshlessLongYanClgResultPopView = class("AshlessLongYanClgResultPopView", ViewComponent)

function AshlessLongYanClgResultPopView:ctor()
	AshlessLongYanClgResultPopView.super.ctor(self)
end

function AshlessLongYanClgResultPopView:buildUI()
	AshlessLongYanClgResultPopView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtName = self:getTxt("txtName")
	self._txtTitle = self:getTxt("txtTitle")
	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")

	local descScrView = self:getGo("descCol/scrView")
	local descScrCell = self:getGo("descCol/scrCell")

	self._descScrollerList = ScrollerList.create(descScrView, descScrCell, GameUtil.handler(self._updateDescCell, self), GameUtil.handler(self._clearDescCell, self))
end

function AshlessLongYanClgResultPopView:bindEvents()
	AshlessLongYanClgResultPopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnCancel, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
end

function AshlessLongYanClgResultPopView:unbindEvents()
	AshlessLongYanClgResultPopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function AshlessLongYanClgResultPopView:onEnter()
	AshlessLongYanClgResultPopView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._phaseId = checknumber(params[2])
	self._stageId = checknumber(params[3])
	self._longYanMo = AshlessLongYanController.instance:getLongYanMo(self._activityId)
	self._stageData = AshlessLongYanConfig.instance:getStageData(self._activityId, self._phaseId, self._stageId)

	self.addGEvent(self, GlobalNotify.HandlePM_AshlessLongYanConfirmScoreRes, self._handlePM_AshlessLongYanConfirmScoreRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_Notify_AshlessLongYanChallengeEndRes, self._onUpdate, self)
	self:_onUpdate()
end

function AshlessLongYanClgResultPopView:onExit()
	AshlessLongYanClgResultPopView.super.onExit(self)
	self._descScrollerList:dispose()
end

function AshlessLongYanClgResultPopView:_handlePM_AshlessLongYanConfirmScoreRes()
	BattleController.instance:endBattle()
end

function AshlessLongYanClgResultPopView:_onUpdate()
	local msg = self._longYanMo:getEndResMsg() or {}

	if msg then
		self._originalScore = msg.originalScore or 0
	end

	if msg then
		self._isWin = msg.win or false
	end

	local arryCond = string.split(self._stageData.woodScoreCalc, "$")
	local condKey = arryCond[1]
	local params = arryCond[2]
	local paramsArry = string.split(params, "#")

	self._targets = {}

	for _, str in ipairs(paramsArry) do
		local arr = string.split(str, "=")
		local target = arr[1]

		self._targets[target] = arr[2]
	end

	self._condData = AshlessLongYanConfig.instance:getPassCondData(condKey)
	self._txtTitle.text = self._condData and string.format(self._condData.resultTitle, self._originalScore) or ""
	self._txtName.text = self._isWin and "胜利" or "失败"

	local matStr = AshlessLongYanConfig.instance:getGoldMat(self._activityId)

	self._matName = MaterialMgr.getMaterialsNameByCfg(matStr)

	local ruleId = checknumber(self._targets.ruleId)
	local cfg = AshlessLongYanConfig.instance:getScoreRuleCfg(ruleId) or {}

	self._descScrollerList:reloadData(cfg)

	local index = 0

	for idx, data in ipairs(cfg) do
		if self:_isFit(data) then
			index = idx

			break
		end
	end

	self._descScrollerList:MoveCellToCenter(index)
end

function AshlessLongYanClgResultPopView:_updateDescCell(view, cell, data, tag)
	local left, right = data.range[1], data.range[2]
	local isFit = self:_isFit(data)

	if self._condData then
		local mainGo = cell.gameObject
		local imgSuccess = goutil.findChild(mainGo, "imgSuccess")
		local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
		local txtPrize = goutil.findChildTextComponent(mainGo, "txtPrize")

		txtDesc.text = not string.nilorempty(self._condData) and (left == right and string.format(self._condData, left) or string.format(self._condData, left .. "~" .. right)) or ""
		txtPrize.text = string.format("获得%s x %s", self._matName, data.score)

		if isFit then
			txtDesc.text = string.format("<color=#20b376>%s</color>", txtDesc.text)
			txtPrize.text = string.format("<color=#20b376>%s</color>", txtPrize.text)
		end

		GameUtil.SetActive(imgSuccess, isFit)
	end
end

function AshlessLongYanClgResultPopView:_clearDescCell(cell)
	return
end

function AshlessLongYanClgResultPopView:_isFit(data)
	local left, right = data.range[1], data.range[2]

	return left <= self._originalScore and right >= self._originalScore
end

function AshlessLongYanClgResultPopView:_onClickBtnSure()
	if self._isWin then
		AshlessLongYanController.instance:sendPM_AshlessLongYanConfirmScoreReq(self._activityId, self._phaseId, self._stageId, true)
	else
		BattleController.instance:endBattle()
	end
end

function AshlessLongYanClgResultPopView:_onClickBtnCancel()
	local fmtMo = AshlessLongYanModel.instance:getLongYanFmtMo()

	fmtMo:updateCfg(self._activityId, self._phaseId, self._stageId)
	UIJumper.instance:pushOneStack(ViewName.CustomMissionView, false, fmtMo)

	if self._isWin then
		AshlessLongYanController.instance:sendPM_AshlessLongYanConfirmScoreReq(self._activityId, self._phaseId, self._stageId, false)
	else
		BattleController.instance:endBattle()
	end
end

return AshlessLongYanClgResultPopView
