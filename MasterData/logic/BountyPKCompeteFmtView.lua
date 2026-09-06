-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/view/BountyPKCompeteFmtView.lua

module("logic.extensions.bountypkcompete.view.BountyPKCompeteFmtView", package.seeall)

local BountyPKCompeteFmtView = class("BountyPKCompeteFmtView", ViewComponent)
local BtnEffectPath = "20220902/wzsltiaozhan/fx_ui_wzsl_anniu.prefab"

function BountyPKCompeteFmtView:ctor()
	BountyPKCompeteFmtView.super.ctor(self)
end

function BountyPKCompeteFmtView:unbindEvents()
	BountyPKCompeteFmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnMyBuff)
	GameUtil.rmClickHandler(self._btnOpBuff)
	GameUtil.rmClickHandler(self._btnFollow)
	GameUtil.rmClickHandler(self._btnAbandon)
	GameUtil.rmClickHandler(self._btnSure)
	self._myBuffCustomInputComp:RemoveListener()
	self._opBuffCustomInputComp:RemoveListener()
end

function BountyPKCompeteFmtView:bindEvents()
	BountyPKCompeteFmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnMyBuff, self._onClickMyBuff, self)
	GameUtil.addClickHandler(self._btnOpBuff, self._onClickOpBuff, self)
	GameUtil.addClickHandler(self._btnFollow, self._onClickFollow, self)
	GameUtil.addClickHandler(self._btnAbandon, self._onClickAbandon, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	self._myBuffCustomInputComp:AddListener(self._myBuffCustomInputChanged, self)
	self._opBuffCustomInputComp:AddListener(self._opBuffCustomInputChanged, self)
end

function BountyPKCompeteFmtView:buildUI()
	BountyPKCompeteFmtView.super.buildUI(self)

	self._btnMyBuff = self:getGo("btnMyBuff")
	self._txtBtnMyBuff = self:getTxt("btnMyBuff/txt")
	self._myBuffTips = self:getGo("btnMyBuff/tips")
	self._txtMyBuffTips = self:getTxt("btnMyBuff/tips/txt")
	self._btnOpBuff = self:getGo("btnOpBuff")
	self._txtBtnOpyBuff = self:getTxt("btnOpBuff/txt")
	self._txtOpBuffTips = self:getTxt("btnOpBuff/tips/txt")
	self._btnFollow = self:getGo("btnFollow")
	self._btnAbandon = self:getGo("btnAbandon")
	self._btnSure = self:getGo("btnSure")
	self._lockFormation = self:getGo("lockFormation")
	self._lockAll = self:getGo("lockAll")
	self._tip = self:getGo("tip")
	self._txtTimes = self:getTxt("txtTimes")
	self._txtNeedPet = self:getTxt("txtNeedPet")
	self._txtMyBounty = self:getTxt("txtMyBounty")
	self._txtTotalBounty = self:getTxt("txtTotalBounty")
	self._txtRoundBounty = self:getTxt("btnFollow/txtRoundBounty")
	self._bountyIcon = self:getGo("btnFollow/txtRoundBounty/icon")
	self._myBuffCustomInputComp = UICustomInput.Get(self._btnMyBuff.gameObject)
	self._opBuffCustomInputComp = UICustomInput.Get(self._btnOpBuff.gameObject)

	goutil.setActive(self._myBuffTips, false)
	goutil.setActive(self._opBuffTips, false)
	goutil.setActive(self._locker, false)
	goutil.setActive(self._tip, false)

	self._popupTips = WBB_UIPopupTips.New(self._tip)
	self._uiEffects = {}
end

function BountyPKCompeteFmtView:onExit()
	BountyPKCompeteFmtView.super.onExit(self)

	local controller = BountyPKCompeteController.instance

	controller:unregisterLocalNotify(BountyPKCompeteController.E_BountyPKSetFormRes, self._afterSetForm, self)
	controller:unregisterLocalNotify(BountyPKCompeteController.E_BountyPKSetBetRes, self._afterSetBet, self)
	controller:unregisterLocalNotify(BountyPKCompeteController.E_BountyPKNotifyGameEndRes, self._endAllPhase, self)
	controller:unregisterLocalNotify(BountyPKCompeteController.E_BountyPKNotifyRoundStartRes, self._nextPhase, self)
	controller:unregisterLocalNotify(BountyPKCompeteController.E_BountyPKNotifyShowFormRes, self._nextPhase, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationPosChanged, self._resetMyBuff, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationEndDragSeatBlockByFixPos, self._blockByFixPos, self)
	self._popupTips:dispose()
	MaterialMgr.resetAll(self._bountyIcon)
	removetimer(self._tick, self)

	for i, v in pairs(self._uiEffects) do
		self:_clearEffect(v)
	end

	self._uiEffects = {}
end

function BountyPKCompeteFmtView:onEnter()
	BountyPKCompeteFmtView.super.onEnter(self)

	local controller = BountyPKCompeteController.instance

	controller:registerLocalNotify(BountyPKCompeteController.E_BountyPKSetFormRes, self._afterSetForm, self)
	controller:registerLocalNotify(BountyPKCompeteController.E_BountyPKSetBetRes, self._afterSetBet, self)
	controller:registerLocalNotify(BountyPKCompeteController.E_BountyPKNotifyGameEndRes, self._endAllPhase, self)
	controller:registerLocalNotify(BountyPKCompeteController.E_BountyPKNotifyRoundStartRes, self._nextPhase, self)
	controller:registerLocalNotify(BountyPKCompeteController.E_BountyPKNotifyShowFormRes, self._nextPhase, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationPosChanged, self._resetMyBuff, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationEndDragSeatBlockByFixPos, self._blockByFixPos, self)
	settimer(0.2, self._tick, self)
	self:_tick()

	local prizeItemId = BountyPKCompeteConfig.instance:getCommonValue("BOUNTY_ITEM_ID", true)
	local proxy = MaterialMgr.setCellByCfg(MaterialMgr.createSerName(MatType.Item_Fake, prizeItemId, 1), self._bountyIcon)

	proxy.binder:setAutoTips(false)
	proxy.binder:setBgActive(false)
	proxy:setNumStr("")
	proxy:setCallBack(function()
		return
	end)
	self:_nextPhase()
	self:_resetMyBuff()
	self:_resetOpBuff()
end

function BountyPKCompeteFmtView:_resetTimestamp()
	local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()

	self._endTimeStamp = phaseModel.endTimeStamp
	self._isEndAll = phaseModel.isEndAll
end

function BountyPKCompeteFmtView:_tick()
	if self._endTimeStamp ~= nil then
		local delta = math.ceil(self._endTimeStamp - UnityEngine.Time.realtimeSinceStartup, 0)

		self._txtTimes.text = langPara("倒计时：%s", math.max(delta, 0))

		if delta <= 0 then
			local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()

			if self._isEndAll then
				removetimer(self._tick, self)
				BountyPKCompeteController.instance:enterFight()
			elseif phaseModel.phase == BountyPkCompetePhaseHandler.PhaseSettingForm then
				-- block empty
			end
		end
	end
end

function BountyPKCompeteFmtView:_afterSetForm()
	self:_nextPhase()
end

function BountyPKCompeteFmtView:_afterSetBet()
	self:_nextPhase()
end

function BountyPKCompeteFmtView:_endAllPhase()
	self:_nextPhase()
end

function BountyPKCompeteFmtView:_nextPhase()
	local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()

	self:_resetTimestamp()
	GameUtil.SetActive(self._lockAll, self._isEndAll)

	if self._isEndAll then
		GameUtil.SetActive(self._txtNeedPet, false)
	elseif phaseModel.phase == BountyPkCompetePhaseHandler.PhaseBetting or phaseModel.phase == BountyPkCompetePhaseHandler.PhaseAfterBet then
		GameUtil.SetActive(self._txtNeedPet, true)

		self._txtNeedPet.text = lang("bountypk__20")
	else
		GameUtil.SetActive(self._txtNeedPet, true)

		if phaseModel.roundConfig.formNum > 0 then
			self._txtNeedPet.text = langPara("bountypk__5", phaseModel.roundConfig.formNum)
		elseif phaseModel.roundConfig.changeNum > 0 then
			self._txtNeedPet.text = langPara("bountypk__6", phaseModel.roundConfig.changeNum)
		end
	end

	if self._isEndAll then
		GameUtil.SetActive(self._btnAbandon, false)
		GameUtil.SetActive(self._btnFollow, false)
		GameUtil.SetActive(self._btnSure, false)
		self._popupTips:hide()
	elseif phaseModel.phase == BountyPkCompetePhaseHandler.PhaseSettingForm or phaseModel.phase == BountyPkCompetePhaseHandler.PhaseAfterSetForm then
		GameUtil.SetActive(self._btnAbandon, false)
		GameUtil.SetActive(self._btnFollow, false)
		self:_clearEffect(self._btnFollow)
		GameUtil.SetActive(self._btnSure, true)

		if phaseModel.phase == BountyPkCompetePhaseHandler.PhaseSettingForm then
			self._popupTips:hide()
			GameUtil.SetGray(self._btnSure, false)
			self:_playEffect(self._btnSure)
		else
			self._popupTips:show(nil, lang("bountypk__7"))
			GameUtil.SetGray(self._btnSure, true)
			self:_clearEffect(self._btnSure)
		end
	elseif phaseModel.phase == BountyPkCompetePhaseHandler.PhaseBetting then
		GameUtil.SetActive(self._btnAbandon, true)
		GameUtil.SetActive(self._btnFollow, true)
		self:_playEffect(self._btnFollow)
		GameUtil.SetActive(self._btnSure, false)
		self:_clearEffect(self._btnSure)
		GameUtil.SetGray(self._btnAbandon, false)
		GameUtil.SetGray(self._btnFollow, false)
		self._popupTips:hide()
		self:_resetOpBuff()
	elseif phaseModel.phase == BountyPkCompetePhaseHandler.PhaseAfterBet then
		GameUtil.SetActive(self._btnAbandon, true)
		GameUtil.SetActive(self._btnFollow, true)
		GameUtil.SetActive(self._btnSure, false)
		self:_clearEffect(self._btnSure)
		GameUtil.SetGray(self._btnAbandon, true)
		GameUtil.SetGray(self._btnFollow, true)
		self:_clearEffect(self._btnFollow)
		self._popupTips:show(nil, lang("bountypk__7"))
	end

	self._txtMyBounty.text = langPara("bountypk__8", phaseModel.myBetScore)
	self._txtTotalBounty.text = langPara("bountypk__9", phaseModel.scorePool)
	self._txtRoundBounty.text = langPara("%s", phaseModel.cost)
end

function BountyPKCompeteFmtView:_buildBuffTips(curLv)
	local configInstance = BountyPKCompeteConfig.instance
	local seasonConfig = configInstance:getSeasonConfig(BountyPKCompeteModel.instance:getActivityId())
	local buffs = configInstance:getBuffConfigs(seasonConfig.buffPlan)
	local array = {}

	for lv, config in ipairs(buffs) do
		table.insert(array, string.format("<color=%s>%s</color>", lv <= curLv and "#00ff00" or "#f8f8ff", config.decs))
	end

	return table.concat(array, "\n")
end

function BountyPKCompeteFmtView:_resetOpBuff()
	local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()
	local count, config = phaseModel:checkOpBuff()
	local level = 0

	if config then
		level = config.id
		self._txtBtnOpyBuff.text = langPara("bountypk__10", config.id)
	else
		self._txtBtnOpyBuff.text = lang("bountypk__11")
	end

	self._txtOpBuffTips.text = self:_buildBuffTips(level)
end

function BountyPKCompeteFmtView:_resetMyBuff()
	local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()
	local count, config = phaseModel:checkMyBuff()

	self._txtBtnMyBuff.text = config and langPara("bountypk__10", config.id) or lang("bountypk__11")
end

function BountyPKCompeteFmtView:_blockByFixPos(petId, pos)
	if petId > 0 then
		local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()

		phaseModel:tryModifyByAdjust(petId, pos)
	end
end

function BountyPKCompeteFmtView:_myBuffCustomInputChanged(isHover)
	if isHover == false then
		GameUtil.SetActive(self._myBuffTips, false)
	end
end

function BountyPKCompeteFmtView:_playEffect(container)
	self:_clearEffect(container)

	local uiEffect = UIEffectManager.instance:playEffect(self, BtnEffectPath, container.transform, 0, 0, true)

	uiEffect:setParent(container.transform)
	uiEffect:setLocalPos(-284, 258, 0)
	uiEffect:setScale(1)

	self._uiEffects[container] = uiEffect
end

function BountyPKCompeteFmtView:_clearEffect(container)
	if self._uiEffects[container] then
		UIEffectManager.instance:stopEffect(self._uiEffects[container])

		self._uiEffects[container] = nil
	end
end

function BountyPKCompeteFmtView:_onClickMyBuff()
	local isActive = not GameUtil.GetActive(self._myBuffTips)

	GameUtil.SetActive(self._myBuffTips, isActive)

	if isActive then
		local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()
		local count, config = phaseModel:checkMyBuff()

		self._txtMyBuffTips.text = self:_buildBuffTips((config or nil) and config.id)
	end
end

function BountyPKCompeteFmtView:_opBuffCustomInputChanged(isHover)
	if isHover == false then
		GameUtil.SetActive(self._opBuffTips, false)
	end
end

function BountyPKCompeteFmtView:_onClickOpBuff()
	GameUtil.SetActive(self._opBuffTips, not GameUtil.GetActive(self._opBuffTips))
end

function BountyPKCompeteFmtView:_onClickFollow()
	local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()

	phaseModel:reqFollow()
end

function BountyPKCompeteFmtView:_onClickAbandon()
	local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()

	phaseModel:reqAbandon()
end

function BountyPKCompeteFmtView:_onClickSure()
	local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()

	if phaseModel:isMyFormationFull() then
		phaseModel:reqSetFormation()
	else
		FloatWordMgr.instance:show(lang("未上阵足够精灵"))
	end
end

return BountyPKCompeteFmtView
