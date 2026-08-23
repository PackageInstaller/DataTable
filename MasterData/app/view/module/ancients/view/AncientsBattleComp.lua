local AncientsBattleComp = class("AncientsBattleComp", require("app.fairyGUI.ancients.UI_AncientsBattleComp"))
local var_0_2 = g.core.const.ConstMgr.AncientsConst.ENEMY_POS
local var_0_3 = g.core.const.ConstMgr.AncientsConst

function var_0_0:ctor()
	self._compLPoints = {
		self.m_Comp_left1,
		self.m_Comp_left2,
		self.m_Comp_left3,
		self.m_Comp_left4,
		self.m_Comp_left5,
		self.m_Comp_left6,
		self.m_Comp_left7,
		self.m_Comp_left8,
		self.m_Comp_left9
	}
	self._compRPoints = {
		self.m_Comp_right1,
		self.m_Comp_right2,
		self.m_Comp_right3,
		self.m_Comp_right4,
		self.m_Comp_right5,
		self.m_Comp_right6,
		self.m_Comp_right7,
		self.m_Comp_right8,
		self.m_Comp_right9
	}
	self._compLPetPoints = {
		self.m_Comp_left_pet1,
		self.m_Comp_left_pet2,
		self.m_Comp_left_pet3,
		self.m_Comp_left_pet4
	}
	self._compRPetPoints = {
		self.m_Comp_right_pet1,
		self.m_Comp_right_pet2,
		self.m_Comp_right_pet3,
		self.m_Comp_right_pet4
	}
	self._compUsers = {}
	self._isFinalBattle = false
	self._turnDataArray = {}
	self._curTurnId = 0
	self._curTurnData = nil
	self._isBattleEnd = false
	self._battleEndCallback = nil
	self._scheduleExit = nil
	self._scheduleExitTime = 0
	self._isPlayPetFight = false

	self.m_effPetUp:addEffectSpine({
		anim = "up",
		name = "eff_ui_ancients_petglowbattle",
		isLoop = true
	})
	self.m_effPetDown:addEffectSpine({
		anim = "down",
		name = "eff_ui_ancients_petglowbattle",
		isLoop = true
	})
end

function var_0_0:_reset()
	self._isFinalBattle = false
	self._turnDataArray = {}
	self._curTurnId = 0
	self._curTurnData = nil
	self._isBattleEnd = false
	self._battleEndCallback = nil

	self.m_Comp_parent:removeChildren()

	self._compUsers = {}
end

function var_0_0:updateView(arg_3_1)
	self:_reset()

	self._isFinalBattle = arg_3_1.isFinalBattle
	self._atkTeam = arg_3_1.atkTeam
	self._defTeam = arg_3_1.defTeam

	self.m_Comp_pet_left:updateView(false, self._atkTeam)
	self.m_Comp_pet_right:updateView(true, self._defTeam)

	self._turnDataArray = arg_3_1.turns or {}

	if self._isFinalBattle then
		self._battleEndCallback = arg_3_1.battleEndCallback
	end

	local var_3_0 = g.core.model.User.ancientsData

	for iter_3_0, iter_3_1 in ipairs({
		arg_3_1.atkTeam,
		arg_3_1.defTeam
	}) do
		local var_3_1 = iter_3_0 == 2

		for iter_3_2, iter_3_3 in ipairs((var_3_0:getTeamUsers(var_0_3.GET_TEAM_TYPE.CUSTOM_TEAM, iter_3_1))) do
			local var_3_2 = var_3_0:getUserFormationPos(iter_3_3.user_id, var_0_3.GET_TEAM_TYPE.CUSTOM_TEAM, iter_3_1)

			if var_3_2 > 0 then
				if var_3_1 then
					var_3_2 = var_0_2 + var_3_2
				end

				local var_3_3 = require("app.view.module.ancients.view.AncientsBattleUserComp").new({
					team = iter_3_1,
					teamUser = iter_3_3,
					formationPos = var_3_2
				})

				var_3_3:setSize(110, 110)
				var_3_3:setPivot(0.5, 1, true)
				self.m_Comp_parent:addChild(var_3_3)

				local var_3_4, var_3_5 = self:_calCompUserPos(var_3_2)

				var_3_3:setPosAndZOrder(var_3_4, var_3_5)
				table.insert(self._compUsers, var_3_3)
			end
		end
	end

	local var_3_6 = var_3_0:getTeamUserIds(var_0_3.GET_TEAM_TYPE.CUSTOM_TEAM, arg_3_1.atkTeam)

	for iter_3_4, iter_3_5 in ipairs((var_3_0:getTeamUserIds(var_0_3.GET_TEAM_TYPE.CUSTOM_TEAM, arg_3_1.defTeam))) do
		table.insert(var_3_6, iter_3_5)
	end

	if g.core.utils.Tools.ancientsFunc.sendSimpleUserSnapshot(var_3_6) then
		self:updateUsersBaseInfo()
	end

	self:_playPetFightEffect()
end

function var_0_0:updateUsersBaseInfo()
	for iter_4_0, iter_4_1 in ipairs(self._compUsers) do
		iter_4_1:updateUserBaseInfo()
	end
end

function var_0_0:onTurnNotify(arg_5_1)
	self._turnDataArray = arg_5_1 or {}

	if self._curTurnId == 0 then
		self:_playNextTurnBattle()
	end
end

function var_0_0:onBattleEndNotify(arg_6_1)
	self._isBattleEnd = true
	self._battleEndCallback = arg_6_1

	self:_cancelScheduleExit()

	if self._curTurnId == 0 then
		self:_playBattleEndAnim()
	end
end

function var_0_0:_updateScheduleExit()
	if g.core.common.ServerTime:getTime() - self._scheduleExitTime >= 60 then
		self:_cancelScheduleExit()
		g.core.module.ModuleManager:tip(g.core.lang:get(433316))
		g.core.utils.Tools.ancientsFunc.openAncientsMainLayer(true)
	end
end

function var_0_0:_doScheduleExit()
	self:_cancelScheduleExit()

	self._scheduleExitTime = g.core.common.ServerTime:getTime()
	self._scheduleExit = self:newSchedule(handler(self, self._updateScheduleExit), 1)
end

function var_0_0:_cancelScheduleExit()
	if self._scheduleExit ~= nil then
		self:cancelSchedule(self._scheduleExit)

		self._scheduleExit = nil
	end

	self._scheduleExitTime = 0
end

function var_0_0:_calCompUserPos(arg_10_1)
	local var_10_0 = false

	if arg_10_1 > var_0_2 then
		var_10_0 = true
		arg_10_1 = arg_10_1 - var_0_2
	end

	local var_10_1 = ((var_10_0 or nil) and (self._compRPoints or self._compLPoints))[arg_10_1]:getPosition()

	return var_10_1.x, var_10_1.y
end

function var_0_0:_getCompUser(arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in ipairs(self._compUsers) do
		if iter_11_1:getUserId() == arg_11_1 and iter_11_1:isEnemy() == arg_11_2 then
			return iter_11_1
		end
	end

	return nil
end

function var_0_0:_getTurnData(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(self._turnDataArray) do
		if iter_12_1.id == arg_12_1 then
			return iter_12_1
		end
	end

	return nil
end

function var_0_0:_playNextTurnBattle()
	self:_doScheduleExit()

	if self._isPlayPetFight then
		return
	end

	self:dispatchCompEvent("ANCIENTS_BATTLE_NEXT_TURN", {
		curTurnId = self._curTurnId
	})

	self._curTurnData = self:_getTurnData(self._curTurnId + 1)

	if self._curTurnData then
		self._curTurnId = self._curTurnId + 1

		self:_playMoveAnim()
	elseif self._isBattleEnd or self._isFinalBattle then
		self:_cancelScheduleExit()
		self:_playBattleEndAnim()
	end
end

function var_0_0:_playMoveAnim()
	local var_14_0 = self:_getCompUser(self._curTurnData.atk_uid, false)
	local var_14_1 = self:_getCompUser(self._curTurnData.def_uid, true)
	local var_14_2 = self:_getTurnData(self._curTurnId - 1)

	if not var_14_2 or var_14_2.is_win then
		self:_doUserMoveAction(var_14_0, var_14_1:getCurFrontFormationPos(), handler(self, self._playAttackAnim))
	else
		self:_doUserMoveAction(var_14_1, var_14_0:getCurFrontFormationPos(), handler(self, self._playAttackAnim))
	end
end

function var_0_0:_playAttackAnim()
	local var_15_0 = self:_getCompUser(self._curTurnData.atk_uid, false)
	local var_15_1 = self:_getCompUser(self._curTurnData.def_uid, true)

	var_15_0:stopAllFGActions()
	var_15_0:showBattleFlag(true)
	var_15_0:runFGAction(fgui.FSequence:create({
		fgui.FDelayTime:create(1),
		fgui.FCallFunc:create(handler(self, function()
			var_15_0:showBattleFlag(false)
		end))
	}))
	self:_doUserAttackAction(var_15_0, handler(self, self._playDeadAnim))
	var_15_1:stopAllFGActions()
	var_15_1:showBattleFlag(true)
	var_15_1:runFGAction(fgui.FSequence:create({
		fgui.FDelayTime:create(1),
		fgui.FCallFunc:create(handler(self, function()
			var_15_1:showBattleFlag(false)
		end))
	}))
	self:_doUserAttackAction(var_15_1)
end

function var_0_0:_playDeadAnim()
	local var_18_0 = self:_getCompUser(self._curTurnData.atk_uid, false)
	local var_18_1 = self:_getCompUser(self._curTurnData.def_uid, true)

	if self._curTurnData.is_win then
		var_18_0:setHpProg(self._curTurnData.hp_percent)
		var_18_1:setHpProg(0)
		self:_doUserDeadAction(var_18_1, handler(self, self._playNextTurnBattle))
	else
		var_18_0:setHpProg(0)
		var_18_1:setHpProg(self._curTurnData.hp_percent)
		self:_doUserDeadAction(var_18_0, handler(self, self._playNextTurnBattle))
	end
end

function var_0_0:_doUserMoveAction(arg_19_1, arg_19_2, arg_19_3)
	if arg_19_2 == arg_19_1:getCurFormationPos() then
		if arg_19_3 then
			arg_19_3()
		end

		return
	end

	arg_19_1:playAction("run")

	local var_19_0, var_19_1 = self:_calCompUserPos(arg_19_2)

	arg_19_1:stopAllFGActions()
	arg_19_1:runFGAction(fgui.FSequence:create({
		fgui.FMoveTo:create(1, {
			x = var_19_0,
			y = var_19_1
		}),
		fgui.FCallFunc:create(handler(self, function()
			arg_19_1:setPosAndZOrder(var_19_0, var_19_1)
			arg_19_1:setCurFormationPos(arg_19_2)

			if arg_19_3 then
				arg_19_3()
			end
		end))
	}))
end

function var_0_0._doUserAttackAction(arg_21_0, arg_21_1, arg_21_2)
	arg_21_1:playAction("attack", handler(arg_21_0, function()
		if not arg_21_0._isBattleEnd and not arg_21_0:_getTurnData(arg_21_0._curTurnId + 1) and not arg_21_0._isFinalBattle then
			arg_21_0:_doUserAttackAction(arg_21_1, arg_21_2)
		elseif arg_21_2 then
			arg_21_2()
		end
	end))
end

function var_0_0._doUserDeadAction(arg_23_0, arg_23_1, arg_23_2)
	arg_23_1:playAction("dead", handler(arg_23_0, function()
		arg_23_1:setDead(true)

		if arg_23_2 then
			arg_23_2()
		end
	end))
end

function var_0_0:_playBattleEndAnim()
	if self._isPlayPetFight then
		return
	end

	local var_25_0 = 1

	for iter_25_0, iter_25_1 in ipairs(self._compUsers) do
		local var_25_2

		if not iter_25_1:isDead() then
			local var_25_1

			if iter_25_1:isEnemy() then
				var_25_1 = self._compLPetPoints[1]
				var_25_2 = 1 + 1
			else
				var_25_1 = self._compRPetPoints[var_25_0]
				var_25_0 = var_25_0 + 1
			end

			if var_25_1 then
				self:_doUserEndMoveAction(iter_25_1, (var_25_1:getPosition()))
			end
		end
	end
end

function var_0_0._doUserEndMoveAction(arg_26_0, arg_26_1, arg_26_2)
	arg_26_1:playAction("run")
	arg_26_1:stopAllFGActions()
	arg_26_1:runFGAction(fgui.FSequence:create({
		fgui.FMoveTo:create(1, {
			x = arg_26_2.x,
			y = arg_26_2.y
		}),
		fgui.FCallFunc:create(handler(arg_26_0, function()
			arg_26_0:_doUserEndAttackAction(arg_26_1)
		end))
	}))
end

function var_0_0._doUserEndAttackAction(arg_28_0, arg_28_1)
	arg_28_1:playAction("attack", handler(arg_28_0, function()
		if arg_28_0._battleEndCallback then
			arg_28_0._battleEndCallback()

			arg_28_0._battleEndCallback = nil
		end
	end))
end

function var_0_0:_playPetFightEffect()
	local var_30_1 = self._atkTeam.pet_fight_value or 0
	local var_30_2 = self._defTeam.pet_fight_value or 0

	self.m_Comp_petCurtain:updateView(var_30_1, var_30_2, self._atkTeam, self._defTeam)

	local var_30_3 = var_30_2 < var_30_1 and "win" or var_30_1 == var_30_2 and "ping" or "lose"

	self.m_Comp_petCurtain:getTransition(var_30_2 < var_30_1 and "win" or var_30_1 == var_30_2 and "ping" or "lose"):setHook("showVS", handler(self, self.playCurtainVsEff))
	self.m_Comp_petCurtain:getTransition(var_30_3):setHook("showWin", handler(self, self.playCurtainWinEff))
	self.m_Comp_petCurtain:getTransition(var_30_3):setHook("showLose", handler(self, self.playCurtainLoseEff))
	self.m_Comp_petCurtain:getTransition(var_30_3):setHook("showPing", handler(self, self.playCurtainPingEff))
	self.m_Comp_petCurtain:playStartEff()
	self.m_Comp_petCurtain:getTransition(var_30_3):play(handler(self, self.onAnimEnd))

	self._isPlayPetFight = true
end

function var_0_0:onAnimEnd()
	self._isPlayPetFight = false

	self.m_Comp_petCurtain:setVisible(false)
	self:_playNextTurnBattle()
end

function var_0_0:playCurtainVsEff()
	self.m_Comp_petCurtain:playVsEff()
end

function var_0_0:playCurtainWinEff()
	self.m_Comp_petCurtain:playResultEff("eff_ui_ancientsBattle_petWin")
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_JuXiang_Battle_03)
end

function var_0_0:playCurtainLoseEff()
	self.m_Comp_petCurtain:playResultEff("eff_ui_ancientsBattle_petLose")
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_JuXiang_Battle_04)
end

function var_0_0:playCurtainPingEff()
	self.m_Comp_petCurtain:playResultEff("eff_ui_ancientsBattle_petPing")
end

return var_0_0
