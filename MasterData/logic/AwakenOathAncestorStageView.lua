-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/awakenoathancestor/view/AwakenOathAncestorStageView.lua

module("logic.extensions.awakenoathancestor.view.AwakenOathAncestorStageView", package.seeall)

local AwakenOathAncestorStageView = class("AwakenOathAncestorStageView", ViewComponent)

function AwakenOathAncestorStageView:buildUI()
	AwakenOathAncestorStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._con = self:getGo("con")

	local stageScrView = self:getGo("stageCol/scrView")
	local stageScrCell = self:getGo("stageCol/scrCell")

	self._stageScrollerList = ScrollerList.create(stageScrView, stageScrCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
end

function AwakenOathAncestorStageView:bindEvents()
	AwakenOathAncestorStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function AwakenOathAncestorStageView:unbindEvents()
	AwakenOathAncestorStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function AwakenOathAncestorStageView:onEnter()
	AwakenOathAncestorStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = AwakenOathAncestorController.instance:getSubMo(self._activityId)
	self._actData = AwakenOathAncestorConfig.instance:getActData(self._activityId)

	local skinId = 12035
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[3] then
		local x, y, scale = checknumber(modelCfg[1]), checknumber(modelCfg[2]), 1

		self._loader = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, modelCfg[3], nil, true, x, y)

		self.addGEvent(self, GlobalNotify.HandlePM_AwakenOathAncestorInfoRes, self._onUpdate, self)
		self.addGEvent(self, GlobalNotify.handlePM_AwakenOathAncestorNotifyChallengeRes, self._onUpdate, self)
		self:_onUpdate()
	end
end

function AwakenOathAncestorStageView:onExit()
	AwakenOathAncestorStageView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	self:_onClearStageCol()
end

function AwakenOathAncestorStageView:_onUpdate()
	self:_onUpdateStageColUI()
end

function AwakenOathAncestorStageView:_onUpdateStageColUI()
	local cfg = AwakenOathAncestorConfig.instance:getStageCfg(self._activityId) or {}

	self._stageScrollerList:reloadData(cfg)

	local index = 0
	local maxNum = 99999

	for stageId, data in ipairs(cfg) do
		local num = self._subMo:getBloodNumInStage(stageId)

		if num < maxNum then
			maxNum = num
			index = stageId - 1
		else
			break
		end
	end

	self._stageScrollerList:MoveCellToCenter(index)
end

function AwakenOathAncestorStageView:_onClearStageCol()
	self._stageScrollerList:dispose()
end

function AwakenOathAncestorStageView:_updateStageCell(view, cell, data, tag)
	local stageId = data.stageId
	local isUnlockStage = self._subMo:isUnlockStage(stageId)
	local bloodNum = self._subMo:getBloodNumInStage(stageId)
	local mainGo = cell.gameObject
	local btnChallenge = goutil.findChild(mainGo, "btnChallenge")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtGain = goutil.findChildTextComponent(mainGo, "txtGain")

	txtName.text = string.format("第 <size=60>%s</size> 关", stageId)
	txtGain.text = string.format("已获得%s血液", bloodNum)

	GameUtil.SetActive(btnChallenge, isUnlockStage)
	GameUtil.SetActive(txtGain.gameObject, isUnlockStage)
	GameUtil.addClickHandler(btnChallenge, function()
		if not isUnlockStage then
			FloatWordMgr.instance:show("未解锁")

			return
		end

		AwakenOathAncestorController.instance:enterBattle(self._activityId, stageId)
	end)
end

function AwakenOathAncestorStageView:_clearStageCell(cell)
	local mainGo = cell.gameObject
	local btnChallenge = goutil.findChild(mainGo, "btnChallenge")

	GameUtil.rmClickHandler(btnChallenge)
end

function AwakenOathAncestorStageView:_onClickBtnTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

return AwakenOathAncestorStageView
