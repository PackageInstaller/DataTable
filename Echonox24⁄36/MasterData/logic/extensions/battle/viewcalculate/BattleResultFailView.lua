-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcalculate/BattleResultFailView.lua

module("logic.extensions.battle.viewcalculate.BattleResultFailView", package.seeall)

local M = class("BattleResultFailView", ViewComponent)

function M:buildUI()
	self._failGo = goutil.findChild(self.mainGO, "fail")
	self._failPanel = goutil.findChild(self.mainGO, "failPanel")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._btn2PanelGo = goutil.findChild(self.mainGO, "failPanel/objTwo")
	self._btn3PanelGo = goutil.findChild(self.mainGO, "failPanel/objThree")
	self._btn2Exit = Astral.ButtonAdapter.GetFrom(self.mainGO, "failPanel/objTwo/btnExit")
	self._btn2Restart = Astral.ButtonAdapter.GetFrom(self.mainGO, "failPanel/objTwo/btnRestart")
	self._btn3Exit = Astral.ButtonAdapter.GetFrom(self.mainGO, "failPanel/objThree/btnExit")
	self._btn3Restart = Astral.ButtonAdapter.GetFrom(self.mainGO, "failPanel/objThree/btnRestart")
	self._btn3Repentance = Astral.ButtonAdapter.GetFrom(self.mainGO, "failPanel/objThree/btnRepentance")
	self._txtFailTips = goutil.findChildTextComponent(self.mainGO, "failPanel/content/scrollViewTips/viewPort/content/txtContent")
	self._txtRemainUndoCount = goutil.findChildTextComponent(self.mainGO, "failPanel/objThree/btnRepentance/Image1/txtNum")

	local successPanel = goutil.findChild(self.mainGO, "success")

	goutil.setActive(successPanel, false)

	local rtGo = goutil.findChild(self.mainGO, "rt")

	goutil.setActive(rtGo, false)
end

function M:destroyUI()
	self._failGo = false
	self._failPanel = false
	self._guiAnimation = false
end

function M:bindEvents()
	self._btn2Exit:AddClickListener(self._onClickExit, self)
	self._btn2Restart:AddClickListener(self._onClickRestart, self)
	self._btn3Exit:AddClickListener(self._onClickExit, self)
	self._btn3Restart:AddClickListener(self._onClickRestart, self)
	self._btn3Repentance:AddClickListener(self._onClickRepentance, self)
end

function M:unbindEvents()
	self._btn2Exit:RemoveClickListener()
	self._btn2Restart:RemoveClickListener()
	self._btn3Exit:RemoveClickListener()
	self._btn3Restart:RemoveClickListener()
	self._btn3Repentance:RemoveClickListener()
end

function M:_setEvents(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.ON_BLUR_BG_CAPTURE_FINISH, self._handleBlurBgCaptureFinish, self)
		GlobalDispatcher:addEventListener(EventType.ON_MULTI_FIGHT_TIPS_CONFIRM, self._multiFightConfirm, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_BLUR_BG_CAPTURE_FINISH, self._handleBlurBgCaptureFinish, self)
		GlobalDispatcher:removeEventListener(EventType.ON_MULTI_FIGHT_TIPS_CONFIRM, self._multiFightConfirm, self)
	end
end

function M:onEnter()
	self:_setEvents(true)

	local params = self:getOpenParam()

	self._canRepentance = params[1]

	goutil.setActive(self._failGo, false)
	goutil.setActive(self._failPanel, false)

	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()

	if dungeonCode then
		self._dungeonId = dungeonCode
		self._dungeonMo = DungeonModel.instance:getDungeonMoById(dungeonCode)
	else
		self._dungeonId = nil
		self._dungeonMo = nil
	end

	self:_tryShowConsecutiveNotify()
end

function M:_handleBlurBgCaptureFinish()
	self:_startPlayAnimation()
	self:_updateView()
end

function M:_startPlayAnimation()
	goutil.setActive(self._failGo, true)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("fail_open")
	BattleAudioUtil.playSEByName("ui_battle_diaochashibai")
end

function M:onExit()
	self:_setEvents(false)
end

function M:_updateView()
	self:_playAudioRoleFail()
	goutil.setActive(self._btn2PanelGo, not self._canRepentance)
	goutil.setActive(self._btn3PanelGo, self._canRepentance)

	local model = BattleMgr.instance:getModel()
	local remainUndoCount = model:getRemainUndoCount()
	local flow = BattleMgr.instance:getActiveBattleFlow()

	if OOPUtil.isInstanceOf(flow, DungeonBattleFlowBase) then
		local dungeonId = flow:getPassId()
		local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonId)

		self._txtFailTips.text = StringUtil.replaceAllRed(dungeonMO:getFailTips())
	else
		self._txtFailTips.text = ""
	end

	self._txtRemainUndoCount.text = remainUndoCount
end

function M:_playAudioRoleFail()
	if not BattleMgr.instance:getActiveBattleFlow() then
		return
	end

	local entityIds = BattleMgr.instance:getUnitMgr():getMyUnits(false)
	local entityId = entityIds[1]

	if entityId then
		local audioName = "speech_" .. entityId .. "_shibai"

		CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum[audioName], nil, nil, nil)
	end
end

function M:_onClickExit()
	local model = BattleMgr.instance:getModel()
	local gamePlay = model:getGamePlay()
	local resultMO = model:getResultMO()

	resultMO:setSkip(true)

	if self._canRepentance then
		BattleAgent.instance:sendSurrenderRequest()
	elseif gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_consecutive_cancel_hint"))

		dialog:setConfirmListener(self._onGamePlayConsecutiveConfirmGiveUp, self)

		return
	else
		BattleDispatcher:dispatchEvent(BattleEventType.OnFailTimesUpdate)
		BattleMgr.instance:exit()
	end

	self:close()
end

function M:_onGamePlayConsecutiveConfirmGiveUp()
	local rewards = BattleMgr.instance:getModel():getConsecutiveRewardsItemDataList(nil)

	if #rewards > 0 then
		local titleStr = lang("tip_gain_item_title_total")

		GainItemController.instance:openView(rewards, false, nil, titleStr, false, function()
			BattleDispatcher:dispatchEvent(BattleEventType.OnFailTimesUpdate)
			BattleMgr.instance:exit()
			self:close()
		end, self)

		return
	else
		BattleDispatcher:dispatchEvent(BattleEventType.OnFailTimesUpdate)
		BattleMgr.instance:exit()
		self:close()
	end
end

function M:_onClickRestart()
	local model = BattleMgr.instance:getModel()
	local gamePlay = model:getGamePlay()

	if self._canRepentance then
		BattleMgr.instance:userRequestRestart(BattleEnum.RestartType.NORMAL)
	elseif gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		if DungeonUtil.isControlAction(self._dungeonMo:getType()) then
			ToolTipsMgr.showControlMultiFightView(self._dungeonId, gamePlay)
		else
			local maxMultiCount = self._dungeonMo:getConsecutiveLimit()

			ToolTipsMgr.showMultiFightTipsView(self._dungeonId, maxMultiCount, true, true, gamePlay)
		end

		return
	else
		BattleMgr.instance:userRequestRestart(BattleEnum.RestartType.CALCULATE)
	end

	self:close()
end

function M:_onClickRepentance()
	if self._canRepentance then
		BattleDispatcher:dispatchEvent(BattleEventType.OnRequestOpenUndoView)
		self:close()
	else
		FloatWordMgr.instance:show(lang("tip_no_undo_count"))
	end
end

function M:_multiFightConfirm(_, info)
	self:close()

	local flow = BattleMgr.instance:getActiveBattleFlow()

	if flow then
		flow.model:setMultiCount(info.multiCount)
		flow.model:setGamePlay(info.gamePlay)
		flow.model:setConsecutiveRound(1)
		flow.model:setConsecutiveRewards(nil)
	end

	BattleMgr.instance:userRequestRestart(BattleEnum.RestartType.CALCULATE)
end

function M:_tryShowConsecutiveNotify()
	local model = BattleMgr.instance:getModel()

	if model and model:isGamePlayConsecutive() then
		local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang("tip_consecutive_fail_hint"))

		dialog:setConfirmButtonText(lang("tip_common_sure"))
	end
end

return M
