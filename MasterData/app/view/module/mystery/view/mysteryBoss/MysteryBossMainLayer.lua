local var_0_0 = g.core.const.ConstMgr.MysteryBossConst
local var_0_1 = g.core.model.User.mysteryBossData
local var_0_2 = g.core.const.ConstMgr.SpineConst
local MysteryBossMainLayer = class("MysteryBossMainLayer", require("app.fairyGUI.mystery.UI_MysteryBossMainLayer"), function()
	return fgui.GComponent:create({
		resName = "MysteryBossMainLayer",
		pkgPath = "ui/mystery/mystery",
		isFullScreen = true,
		pkgName = "mystery"
	}, ...)
end)

function MysteryBossMainLayer:ctor(arg_2_1)
	self._boss = arg_2_1 and arg_2_1.boss
	self._isRealBattle = true
	self._cdSchedule = nil
	self._battleSchedule = nil
	self._closeSchedule = nil
	self._atkName = nil

	self:_initRegisterUI()
end

function MysteryBossMainLayer:_initRegisterUI()
	if not self._boss then
		return
	end

	if self._boss:getBossType() == var_0_0.BOSS_TYPE.LIMIT then
		self:addBg("bg/mystery/bg_symj_boss_xianding.jpg", nil, nil, 1)
	else
		self:addBg("bg/mystery/bg_symj_boss_changzhu.jpg", nil, nil, 1)
	end

	self.m_returnBtn:addClickListener(handler(self, self._onClickBossMainLayerReturnBtn))
	self.m_lookAwardBtn:addClickListener(handler(self, self._onClickPreviewBossAward))
	g.core.network.GameNetProxy:send_C2S_MysteryBoss_EnterRoom({
		id = self._boss:getBossId()
	})
	g.core.network.GameNetProxy:send_C2S_MysteryBoss_GetRankList({
		id = self._boss:getBossId()
	})
	var_0_1:setLastAttackBossTime()
	var_0_1:cleanRenturnRoomTag()
	self.m_enterTransition:play()
end

function MysteryBossMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_ENTERROOM, handler(self, self._onS2CMysteryBossEnterRoom), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_GETRANKLIST, handler(self, self._onS2CMysteryBossGetRankList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._updateBossMainInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_POSCHALLENGEBEGIN, handler(self, self._onS2CMysteryBossPosChallengeBegin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_POSCHALLENGEFINISH, handler(self, self._onS2CMysteryBossPosChallengeFinish), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_NOTIFYPOSCHALLENGE, handler(self, self._onS2CMysteryBossNotifyPosChallenge), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_NOTIFYLEAVE, handler(self, self._onS2CMysteryBossNotifyLeave), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_NOTIFYBOSSCHALLENGE, handler(self, self.onS2CMysteryBossNotifyBossChallenge), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_BOSSCHALLENGEFINISH, handler(self, self.onS2CMysteryBossChallengeFinish), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_NOTIFYDISBAND, handler(self, self._exitBossLayer), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MYSTERY_BOSS_ENTERROOM_ERROR, handler(self, self._exitBossLayer), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_NOTIFYBOSSDEAD, handler(self, self._checkBossIsDead), self)
	self:_sendIntervalChallengeBoss()
	self:_sendMysteryBossRankList()
	self:_updateBossMainInfo()
end

function MysteryBossMainLayer:_updateBossMainInfo()
	self.m_challengePosComp:updateChallengePosInfo(self._boss)
	self.m_bossMapComp:updateMapInfo(self._boss)
	self.m_bossHpComp:updateBossHpInfo(self._boss)
end

function MysteryBossMainLayer:_onS2CMysteryBossEnterRoom()
	self:_updateBossMainInfo()
end

function MysteryBossMainLayer:onS2CMysteryBossNotifyBossChallenge(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_4.user_id then
		local var_7_0 = self._boss:getMysteryBossPosByUserId(arg_7_4.user_id)

		if var_7_0 then
			self.m_bossMapComp:playUserAction(var_7_0.pos, var_0_2.ACTION.ATTACK)
		end
	end

	self:_updateBossHpAndHit(arg_7_4.real_damage)
end

function MysteryBossMainLayer:onS2CMysteryBossChallengeFinish(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self.m_bossMapComp:playUserAction(self._boss:getMySelfPos(), var_0_2.ACTION.ATTACK)
	self:_updateBossHpAndHit(arg_8_4.real_damage)
end

function MysteryBossMainLayer:_updateBossHpAndHit(arg_9_1)
	self:newScheduleOnce(handler(self, function()
		self.m_bossHpComp:updateBossHpInfo(self._boss)
		self.m_bossMapComp:playBossHitAction(arg_9_1)
	end), 0.8)
end

function MysteryBossMainLayer:_checkBossIsDead()
	if not self._boss:getBossAlive() then
		self.m_bossHpComp:updateBossHpInfo(self._boss)
		self.m_bossMapComp:playBossDeadAction()
	end
end

function MysteryBossMainLayer:_onS2CMysteryBossNotifyPosChallenge(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	self:_updateBossMainInfo()

	if arg_12_4.target_pos then
		self.m_bossMapComp:playUserAction(arg_12_4.target_pos, var_0_2.ACTION.IN)
	end
end

function MysteryBossMainLayer:_onS2CMysteryBossNotifyLeave()
	self.m_challengePosComp:updateChallengePosInfo(self._boss)
	self.m_bossMapComp:updateMapInfo(self._boss)
end

function MysteryBossMainLayer:_onS2CMysteryBossPosChallengeBegin(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if arg_14_4.battle_id then
		local var_14_0 = g.core.battle.BattleProxy:getGuildFightReport(arg_14_4.battle_id)

		if var_14_0 and var_14_0.enemy_teams and var_14_0.enemy_teams[1] then
			if var_14_0.enemy_teams[1].user then
				self._atkName = var_14_0.enemy_teams[1].user.name or nil
			end
		else
			self._atkName = nil
		end
	else
		self._atkName = nil
	end
end

function MysteryBossMainLayer:_onS2CMysteryBossPosChallengeFinish(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	if arg_15_4.is_win then
		if var_0_1:getOldPosUserId() > 0 and self._atkName then
			g.core.module.ModuleManager:tip(g.core.lang:get(423528, {
				name = self._atkName
			}))
		end
	elseif self._atkName then
		g.core.module.ModuleManager:tip(g.core.lang:get(423529, {
			name = self._atkName
		}))
	end

	self._atkName = nil

	self:_updateBossMainInfo()
end

function MysteryBossMainLayer:_showBossResultPop()
	if var_0_1:getMysteryBossNotifyAwards() then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.mystery.view.mysteryBoss.MysteryBossResultPop").new(), {
			touchDisappear = false,
			ignoreTouch = true
		})
	end

	self:_exitBossLayer()
end

function MysteryBossMainLayer:receiveCompEvent(arg_17_1)
	if arg_17_1 == "MYSTERYBOSS_CHALLENGE_POS" then
		g.core.network.GameNetProxy:send_C2S_MysteryBoss_PosChallengeBegin({
			pos = ({
				...
			})[1]
		})
	elseif arg_17_1 == "SHOW_MYSTERYBOSS_RESULT" then
		self:_showBossResultPop()
	end
end

function MysteryBossMainLayer:_sendMysteryBossRankList()
	self._cdSchedule = self._cdSchedule or self:newSchedule(handler(self, self._reqGetBossHurtRank), 5)
end

function MysteryBossMainLayer:_sendIntervalChallengeBoss()
	self._battleSchedule = self._battleSchedule or self:newSchedule(handler(self, self._reqIntervalChallengeBoss), 1)
end

function MysteryBossMainLayer:_reqGetBossHurtRank()
	g.core.network.GameNetProxy:send_C2S_MysteryBoss_GetRankList({
		id = self._boss:getBossId()
	})
end

function MysteryBossMainLayer:_reqIntervalChallengeBoss()
	if self._boss:getBossAlive() then
		if not var_0_1:isSelfAttackBossCD() then
			var_0_1:setLastAttackBossTime()
			g.core.network.GameNetProxy:send_C2S_MysteryBoss_BossChallengeBegin({
				real_battle = self._isRealBattle
			})

			self._isRealBattle = false
		end
	elseif self._battleSchedule then
		self:cancelSchedule(self._battleSchedule)

		self._battleSchedule = nil
	end
end

function MysteryBossMainLayer:_onS2CMysteryBossGetRankList(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	self._rankData = arg_22_4.units or {}

	self.m_hurtRankComp:updateRankInfo(self._rankData)
end

function MysteryBossMainLayer:_exitBossLayer()
	self._closeSchedule = self._closeSchedule or self:newSchedule(handler(self, self._checkCurModuleClose), 1)
end

function MysteryBossMainLayer:_checkCurModuleClose()
	local var_24_0 = g.core.module.ModuleManager:getCurModule()

	if var_24_0 and var_24_0.module == g.view.entrance.MYSTERY_BOSS_MAIN_LAYER then
		if self._closeSchedule then
			self:cancelSchedule(self._closeSchedule)

			self._closeSchedule = nil
		end

		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function MysteryBossMainLayer:_onClickBossMainLayerReturnBtn()
	local var_25_0

	if self._boss:isLimitLowHpSpecialPosProtect() then
		g.core.module.ModuleManager:tip(g.core.lang:get(423521))

		do return end

		var_25_0 = require("app.view.base.pop.BaseConfirmPop").new
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(1257),
		desc = g.core.lang:get(423522),
		onConfirm = handler(self, function()
			g.core.network.GameNetProxy:send_C2S_MysteryBoss_LeaveRoom({})
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		end)
	}))
end

function MysteryBossMainLayer:_onClickPreviewBossAward()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.mystery.view.mysteryBoss.MysteryBossAwardPop").new(self._boss)))
end

function MysteryBossMainLayer:onUnload()
	if self._cdSchedule then
		self:cancelSchedule(self._cdSchedule)

		self._cdSchedule = nil
	end

	if self._closeSchedule then
		self:cancelSchedule(self._closeSchedule)

		self._closeSchedule = nil
	end

	if self._battleSchedule then
		self:cancelSchedule(self._battleSchedule)

		self._battleSchedule = nil
	end
end

return MysteryBossMainLayer
