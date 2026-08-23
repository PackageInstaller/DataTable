local var_0_0 = g.core.config.chibi_parameter_info
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.module.ModuleManager
local var_0_4 = g.core.common.ServerTime
local var_0_5 = g.core.battle.BattleProxy
local var_0_6 = g.core.network.GameNetProxy
local var_0_7 = g.core.model.User.redCliffData
local var_0_8 = g.core.const.ConstMgr.RedCliffConst
local RedCliffGameStage = class("RedCliffGameStage", require("app.fairyGUI.redCliff.UI_RedCliffGameStage"), function()
	return fgui.GComponent:create({
		resName = "RedCliffGameStage",
		pkgPath = "ui/redCliff/redCliff",
		isFullScreen = true,
		pkgName = "redCliff"
	})
end)

function RedCliffGameStage:ctor(arg_2_1)
	self._mapWorld = nil
	self._endTime = 0
	self._poolId = var_0_7:getMyPoolId()
	self._isQuit = false
	self._robotMaxNum = math.min(var_0_7:getRobotMaxNum(), var_0_8.COMPONENT_NUM)
	self._cdHandler = nil
	self._battleId = 0
	self._matchLength = 0
	self._isShowFertile = false
	self._isAttack = false
	self._robotInterval = var_0_0.get(8).value

	self.m_quitBtn:addClickListener(handler(self, self._onClickQuitBtn))
	self.m_battleCheckBtn:addClickListener(handler(self, self._onClickBattleCheckBtn))
	self.m_battleCheckBtn:setSelected(var_0_7:isSkipBattle())
	self.m_matchUserBtn:addClickListener(handler(self, self._onClickMatchUserBtn))
	self:_initGameTime()
	self:_initView()
end

function RedCliffGameStage:_initGameTime()
	local var_3_0 = var_0_7:getCurrentPoolFightTime(self._poolId)

	if var_3_0 then
		self._endTime = var_3_0.endTime or 0
	end
end

function RedCliffGameStage:_initView()
	self:addBg("bg/redCliff/bg_hdzb_ditu.jpg")

	local var_4_0 = var_0_7:getMyMapInfo()

	self.m_damageTxt:setText(g.core.lang:get(421105, {
		num = var_4_0.debuff_num
	}))

	self._matchLength = var_4_0.length
end

function RedCliffGameStage:_updateAllCdTime()
	local var_5_0 = math.max(0, self._endTime - var_0_4:getTime())

	self.m_leftTime:setText(string.format("%02d:%02d", (var_5_0 - var_5_0 % 60) / 60, var_5_0 % 60))
	self.m_cdController:setSelectedIndex(var_5_0 >= var_0_8.CD_COLOR and 0 or 1)
	self:_updateEditorCd()
	self.m_mapComp:updateMapRoleCd()

	if self._matchLength > 0 then
		self.m_clockComp:updateClock(var_5_0 / self._matchLength)
	end

	if var_5_0 % var_0_8.RANK_REQUEST_INTERVAL == 0 then
		var_0_6:send_C2S_ChiBi_GetRankInfo({})
	end

	if var_5_0 % self._robotInterval == 0 then
		self:_genRobot()
	end
end

function RedCliffGameStage:_updateEditorCd()
	self.m_mapComp:updateEditorCd()
end

function RedCliffGameStage:_isSkipBattle()
	return self.m_battleCheckBtn:isSelected()
end

function RedCliffGameStage:_quitGame()
	if self._isQuit then
		return
	end

	self._isQuit = true

	var_0_3:popAllPopup()
	var_0_3:onlyPopSelfByDisplay(self)
end

function RedCliffGameStage:onLoad()
	self.m_enterTransition:play()

	if var_0_4:getTime() >= self._endTime then
		var_0_3:tip(g.core.lang:get(421120))
		self:newScheduleOnce(handler(self, self._quitGame))

		return
	end

	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_CHI_BI_LEVELROOM, self._onRcvLeaveRoom, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_CHI_BI_NOTIFYUSERREVIVE, self._onRcvUserRevive, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_CHI_BI_GETRANKINFO, self._onRcvRankInfo, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_CHI_BI_NOTIFYOCCUPYCHANGE, self._onRcvOccupyChange, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_CHI_BI_NOTIFYMATCHEND, self._onRcvMatchEnd, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_CHI_BI_BATTLE, self._onRcvBattle, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_CHI_BI_CHECKBATTLE, self._onRcvCheckBattle, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_CHI_BI_CHECKBATTLEFINISH, self._onRcvCheckBattleFinish, self)
	var_0_1:addEventListener(var_0_2.RED_CLIFF_S2C_CHI_BI_BATTLE_RET, self._onRcvCheckBattleRet, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_CHI_BI_LEVELCOMPONENT, self._onRcvLeaveComponent, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_CHI_BI_NOTIFYFERTILITY, self._onRcvNotifyFertility, self)
	var_0_1:addEventListener(var_0_2.EVENT_GAME_RESUME_FINISH, self._onRcvResumeFinish, self)
	var_0_6:send_C2S_ChiBi_GetRankInfo({})
	self:_updateAllCdTime()

	self._cdHandler = self._cdHandler or self:newSchedule(handler(self, self._updateAllCdTime), 1)
end

function RedCliffGameStage:onUnload()
	if self._cdHandler then
		self:cancelSchedule(self._cdHandler)

		self._cdHandler = nil
	end

	self.m_fertileTip:setVisible(false)
	self.m_topTip:setVisible(false)
end

function RedCliffGameStage:receiveCompEvent(arg_11_1)
	if arg_11_1 == "open_final_match_user_list" then
		local var_11_0 = require("app.view.module.redCliff.stage.RedCliffStageMatchDataPop").new()

		self:addListen(var_11_0)
		var_0_3:pushPopup(var_11_0, {
			touchDisappear = false,
			ignoreTouch = true
		})
	elseif arg_11_1 == "open_upgrade_list" then
		local var_11_1 = require("app.view.module.redCliff.stage.RedCliffStageUpgradePop").new({
			poolId = self._poolId
		})

		self:addListen(var_11_1)
		var_0_3:pushPopup(var_11_1, {
			touchDisappear = false,
			ignoreTouch = true
		})
	elseif arg_11_1 == "leave_game" then
		self:_quitGame()
	end
end

function RedCliffGameStage:_onClickQuitBtn()
	var_0_3:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(1257),
		onConfirm = handler(self, function(arg_13_0)
			if var_0_4:getTime() < arg_13_0._endTime then
				var_0_6:send_C2S_ChiBi_LevelRoom({})
			else
				arg_13_0:_quitGame()
			end
		end),
		confirmText = g.core.lang:get(1160),
		cancelText = g.core.lang:get(1037),
		desc = g.core.lang:get(421098)
	})))
end

function RedCliffGameStage:_onClickBattleCheckBtn()
	var_0_7:saveSkipBattleState((self.m_battleCheckBtn:isSelected()))
end

function RedCliffGameStage:_onClickMatchUserBtn()
	var_0_3:pushPopup(require("app.view.module.redCliff.stage.RedCliffStageMatchUserPop").new(), {
		touchDisappear = false,
		ignoreTouch = true
	})
end

function RedCliffGameStage:_updateOccupyView(arg_16_1)
	self.m_mapComp:updateOccupyView(arg_16_1)
end

function RedCliffGameStage:_isPlayerMySelf(arg_17_1)
	return arg_17_1 and arg_17_1.user_id == g.core.model.User:getId()
end

function RedCliffGameStage:_genRobot()
	local var_18_0 = math.random(var_0_8.MIN_ROBOT_GEN_NUM, self._robotMaxNum)

	if var_18_0 > 0 then
		self.m_mapComp:generateRandomPlayer(var_18_0)
	end
end

function RedCliffGameStage:_onRcvLeaveRoom()
	self:_quitGame()
end

function RedCliffGameStage:_onRcvUserRevive()
	if self._isAttack then
		-- block empty
	else
		self.m_mapComp:updateMapRoleStateAndMoveWorld()
		self.m_mapComp:setIsPlaying(false)
		self.m_failTransition:play()

		if not self._failEffect then
			self._failEffect = self.m_failEffectLoader:addEffectSpine({
				anim = "play",
				name = "eff_ui_redCliff_fail",
				isLoop = false
			})
		else
			self._failEffect:setAnimation(0, "play", false)
		end
	end

	self._isAttack = false
end

function RedCliffGameStage:_onRcvRankInfo(arg_21_1, arg_21_2, arg_21_3)
	if arg_21_3.ret ~= g.core.network.proto.RET_OK then
		var_0_3:tip(g.core.lang:get(421122))
		self:_quitGame()

		return
	end

	self.m_rankComp:updateRankComp()
end

function RedCliffGameStage:_onRcvOccupyChange(arg_22_1, arg_22_2, arg_22_3)
	if arg_22_3 then
		local var_22_0 = arg_22_3.user
		local var_22_1 = arg_22_3.before_user
		local var_22_2 = var_0_7:getEditorStructByComponentId(arg_22_3.component_id)
		local var_22_3 = self:_isPlayerMySelf(arg_22_3.user)
		local var_22_4 = self:_isPlayerMySelf(arg_22_3.before_user)

		if arg_22_3.user and not var_22_3 then
			self:_updateOccupyView(arg_22_3.component_id)
		elseif var_22_1 then
			self:_updateOccupyView(arg_22_3.component_id)
		end

		if var_22_2:getEditorType() == var_0_8.EDITOR_TYPE.BIG and var_22_0 then
			local var_22_5 = ""

			if var_22_1 and var_22_0 then
				var_22_5 = g.core.lang:get(421004, {
					name1 = var_22_0.user.name,
					name2 = var_22_1.user.name,
					editor = var_22_2:getEditorName()
				})
			elseif var_22_0 then
				var_22_5 = g.core.lang:get(421036, {
					name = var_22_0.user.name,
					editor = var_22_2:getEditorName()
				})
			end

			if not self._isShowFertile then
				self.m_topTip:setTitle(var_22_5)
				self.m_topTip:setVisible(true)
				self:newScheduleOnce(handler(self, function(arg_23_0)
					arg_23_0.m_topTip:setVisible(false)
				end), var_0_8.TOP_TIP_DELAY)
			end
		end

		if var_22_3 or var_22_4 then
			self.m_recordBoard:updateRecordBoard()
		end

		if var_22_4 and var_22_0 then
			self.m_mapComp:closePopView()
			var_0_7:saveTargetCoordAndEditor(nil, nil)
		end
	end
end

function RedCliffGameStage:_onRcvMatchEnd(arg_24_1, arg_24_2, arg_24_3)
	if self._cdHandler then
		self:cancelSchedule(self._cdHandler)

		self._cdHandler = nil
	end

	var_0_3:popAllPopup()

	local var_24_0 = require("app.view.module.redCliff.stage.RedCliffBattleFinishPop").new()

	self:addListen(var_24_0)
	var_0_3:pushPopup(var_24_0, {
		touchDisappear = false,
		ignoreTouch = false
	})
end

function RedCliffGameStage:_onRcvBattle(arg_25_1, arg_25_2, arg_25_3)
	self._isAttack = true

	local var_25_0 = {
		user_id = arg_25_3.enemy_id,
		component_id = arg_25_3.component_id
	}

	if var_0_5:fastBattleWithoutCheck(arg_25_3.battle_id) then
		var_25_0.battle_result = var_0_8.BATTLE_RESULT.WIN or var_0_8.BATTLE_RESULT.LOSE
	end

	g.core.network.GameNetProxy:send_C2S_ChiBi_CheckBattle(var_25_0)

	if not self.m_battleCheckBtn:isSelected() then
		local BattleConst = require("app.view.battle.const.BattleConst")

		var_0_5:enterBattle({
			cloudLoading = true,
			canSkip = true,
			skip = BattleConst.SKIP_TYPE.ACTIVE,
			type = BattleConst.TYPE_RED_CLIFF,
			battle_id = arg_25_3.battle_id,
			battleType = BattleConst.BATTLE_TYPE.PVP
		})
	end
end

function RedCliffGameStage:_onRcvCheckBattle(arg_26_1, arg_26_2, arg_26_3)
	if arg_26_3.check_status ~= var_0_8.CHECK_STATUS.SERVER then
		local var_26_0 = arg_26_3.battle_result == var_0_8.BATTLE_RESULT.WIN

		self.m_mapComp:playAttackAnimation(arg_26_3.battle_result == var_0_8.BATTLE_RESULT.WIN, handler(self, function(arg_27_0)
			if arg_27_0:_isSkipBattle() then
				var_0_1:dispatchEvent(var_0_2.EVENT_FAKE_PVP_BATTLE_RESULT, false)
			end

			if var_26_0 then
				arg_27_0:_updateOccupyView((var_0_7:getMyPlayerStruct():getComponentId()))
			else
				arg_27_0.m_mapComp:updateMapRoleStateAndMoveWorld()
			end

			arg_27_0._isAttack = false

			arg_27_0.m_mapComp:setIsPlaying(false)
		end))

		if not var_26_0 then
			self.m_recordBoard:updateRecordBoard()
		end
	end
end

function RedCliffGameStage:_onRcvCheckBattleFinish(arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = arg_28_3.is_win

	self.m_mapComp:playAttackAnimation(arg_28_3.is_win, handler(self, function(arg_29_0)
		if arg_29_0:_isSkipBattle() then
			var_0_1:dispatchEvent(var_0_2.EVENT_FAKE_PVP_BATTLE_RESULT, false)
		end

		if var_28_0 then
			arg_29_0:_updateOccupyView((var_0_7:getMyPlayerStruct():getComponentId()))
		else
			arg_29_0.m_mapComp:updateMapRoleStateAndMoveWorld()
		end

		arg_29_0._isAttack = false

		arg_29_0.m_mapComp:setIsPlaying(false)
	end))
end

function RedCliffGameStage:_onRcvCheckBattleRet(arg_30_1, arg_30_2, arg_30_3)
	self._isAttack = false

	self.m_mapComp:setIsPlaying(false)
end

function RedCliffGameStage:_onRcvLeaveComponent(arg_31_1, arg_31_2, arg_31_3)
	self.m_mapComp:updateOccupyView(arg_31_3.component_id)
	self.m_mapComp:leaveCompAndMove()
end

function RedCliffGameStage:_onRcvNotifyFertility(arg_32_1, arg_32_2, arg_32_3)
	self.m_mapComp:updateFertile()
	self.m_topTip:setVisible(false)

	self._isShowFertile = true

	self.m_fertileTip:setTitle(g.core.lang:get(421104))
	self.m_fertileTip:setVisible(true)
	self:newScheduleOnce(handler(self, function(arg_33_0)
		arg_33_0.m_fertileTip:setVisible(false)

		arg_33_0._isShowFertile = false
	end), var_0_8.TOP_TIP_DELAY)
end

function RedCliffGameStage:_onRcvResumeFinish()
	var_0_3:tip(g.core.lang:get(421123))
	self:_quitGame()
end

return RedCliffGameStage
