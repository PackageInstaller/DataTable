-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcampadjustment/BattleCampAdjustmentStartView.lua

module("logic.extensions.battle.viewcampadjustment.BattleCampAdjustmentStartView", package.seeall)

local BattleCampAdjustmentStartView = class("BattleCampAdjustmentStartView", ViewComponent)

function BattleCampAdjustmentStartView:buildUI()
	self._btnStart = self:getBtn("prewarprepareview_1231393320840266047")
	self._goStart = self:getGo("prewarprepareview_1231393320840266047")
	self._selfUserItem = Astral.SimpleLuaComponentContainer.Add(self:getGo("prewar_prepare_view_1860282850"), BattleCampAdjustmentSelfPrepareItem)
	self._otherUserItem = Astral.SimpleLuaComponentContainer.Add(self:getGo("prewar_prepare_view_1175731917"), BattleCampAdjustmentUserItemView)
	self._readyTimeLimit = 0
end

function BattleCampAdjustmentStartView:destroyUI()
	self._selfUserItem:destroy()
	self._otherUserItem:destroy()

	self._selfUserItem = nil
	self._otherUserItem = nil
	self._btnStart = nil
	self._goStart = nil
end

function BattleCampAdjustmentStartView:bindEvents()
	self._btnStart:AddClickListener(self._onClickStart, self)
end

function BattleCampAdjustmentStartView:unbindEvents()
	self._btnStart:RemoveClickListener()
end

function BattleCampAdjustmentStartView:onEnter()
	self._isExiting = false

	self:_setEvent(true)
	self:_judgeStartBtn()
end

function BattleCampAdjustmentStartView:onExit()
	self._isExiting = true

	self:_setEvent(false)
	self._selfUserItem:stopCountDown()
	self._otherUserItem:stopCountDown()
end

function BattleCampAdjustmentStartView:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.ON_RECEIVE_USER_READY, self._onUserReady, self)
		BattleDispatcher:addEventListener(BattleEventType.ON_RECEIVE_USER_CANCEL_READY, self._onUserCancelReady, self)
		BattleDispatcher:addEventListener(BattleEventType.ON_RECEIVE_ALL_USER_ENTER_DONE, self._onAllUserReady, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.ON_RECEIVE_USER_READY, self._onUserReady, self)
		BattleDispatcher:removeEventListener(BattleEventType.ON_RECEIVE_USER_CANCEL_READY, self._onUserCancelReady, self)
		BattleDispatcher:removeEventListener(BattleEventType.ON_RECEIVE_ALL_USER_ENTER_DONE, self._onAllUserReady, self)
	end
end

function BattleCampAdjustmentStartView:_onUserReady(evt, userId)
	if self._otherUserItem:getUserId() == userId then
		self._otherUserItem:setPrepared()
	end
end

function BattleCampAdjustmentStartView:_onUserCancelReady(evt, userId)
	if self._otherUserItem:getUserId() == userId then
		self._otherUserItem:startCountDown()
	end
end

function BattleCampAdjustmentStartView:_onAllUserReady(evt)
	local battleModel = BattleMgr.instance:getModel()

	if battleModel:isMultiPlayerMode() then
		local multiPlayerNetMgr = BattleMgr.instance:getMultiPlayerNetStateMgr()
		local readyStamp = multiPlayerNetMgr:getAllUserReadyTimeStamp()

		self._selfUserItem:setStartTimeStamp(readyStamp)
		self._otherUserItem:setStartTimeStamp(readyStamp)
		self._selfUserItem:startCountDown()
		self._otherUserItem:startCountDown()
	end
end

function BattleCampAdjustmentStartView:_judgeStartBtn()
	local battleModel = BattleMgr.instance:getModel()

	if battleModel:isMultiPlayerMode() then
		goutil.setActive(self._goStart, false)

		local settingModel = BattleMgr.instance:getSettingModel()
		local readyTimeLimit = settingModel:getReadyTimeLimit()

		self._selfUserItem:setTimelimit(readyTimeLimit)
		self._selfUserItem:setVisible(true)

		local otherUserInfoMO = self:_getOtherUserInfoMO()

		self._otherUserItem:setUserInfoMO(otherUserInfoMO)
		self._otherUserItem:setTimelimit(readyTimeLimit)
		self._otherUserItem:setVisible(true)

		local multiPlayerNetMgr = BattleMgr.instance:getMultiPlayerNetStateMgr()
		local readyStamp = multiPlayerNetMgr:getAllUserReadyTimeStamp()

		if readyStamp > 0 then
			self:_onAllUserReady()
		end
	else
		goutil.setActive(self._goStart, true)
		self._selfUserItem:setVisible(false)
		self._otherUserItem:setVisible(false)
	end
end

function BattleCampAdjustmentStartView:_getOtherUserInfoMO()
	local settingModel = BattleMgr.instance:getSettingModel()
	local battleModel = BattleMgr.instance:getModel()
	local operateTeamId = battleModel:getOperateGameTeamId()
	local teamInfoMOList = settingModel:getTeamInfoMOList()

	for _, teamInfoMO in ipairs(teamInfoMOList) do
		if teamInfoMO.teamId ~= operateTeamId then
			return teamInfoMO:getLeaderUserInfoMO()
		end
	end

	return false
end

function BattleCampAdjustmentStartView:_onClickStart()
	BattleAudioUtil.playSEByName("ui_battle_querenzhandou")

	if BattleCampAdjustmentModel.instance:isDebug() then
		self:_onConfirmStart()

		return
	end

	local currentTeamCharacterCount = #BattleCampAdjustmentModel.instance:getCurrentTeamCharacterCodeList()

	if currentTeamCharacterCount <= 0 then
		if BattleCampAdjustmentModel.instance:containsAvailableCharacter() then
			FloatWordMgr.instance:show(lang("tip_battle_one_role"))

			return
		end

		Dialog.showWarnMessage(lang("tip_no_battle_role"), lang("tip_no_role_exit_battle")):setConfirmListener(self._forceExitBattle, self):setCancelListener(self._forceExitBattle, self)

		return
	end

	CriwareAudioFacade.instance:setState("battle_music", "loop")

	local count = BattleCampAdjustmentModel.instance:getEntityCountLimit() - currentTeamCharacterCount

	if count > 0 then
		Dialog.showWarnMessage(lang("tip_role_not_enough"), string.format(lang("tip_can_assign_role"), count)):setConfirmListener(self._onConfirmStart, self):setCancelListener(self._onCancelStart, self)
	else
		self:_onConfirmStart()
	end
end

function BattleCampAdjustmentStartView:_onConfirmStart()
	BattleAudioUtil.playSEByName("ui_generic_click")

	if not self._isExiting then
		BattleAgent.instance:sendEndReadyRequest()
	end
end

function BattleCampAdjustmentStartView:_onCancelStart()
	BattleAudioUtil.playSEByName("ui_generic_click_cancel")

	local unitMgr = BattleMgr.instance:getUnitMgr()
	local boardMgr = BattleMgr.instance:getBoardMgr()
	local bornUnionIndexList = BattleCampAdjustmentModel.instance:getBornUnionIndexList()

	for _, unionIndex in pairs(bornUnionIndexList) do
		if not unitMgr:getUnitOnUnionIndex(unionIndex) then
			local position = boardMgr:getCellPosition(unionIndex)

			BattleCameraUtil.doFollowPosition(position.x, position.y, position.z, 0.5)

			return
		end
	end
end

function BattleCampAdjustmentStartView:_forceExitBattle()
	local netAgent = BattleMgr.instance:getNetAgent()

	netAgent:sendSurrenderRequest()
end

return BattleCampAdjustmentStartView
