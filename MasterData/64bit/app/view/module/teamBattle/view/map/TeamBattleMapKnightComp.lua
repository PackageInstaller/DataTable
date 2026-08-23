local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.model.User.teamBattleData
local TeamBattleRoleVirtual = require("app.view.module.teamBattle.view.map.entity.TeamBattleRoleVirtual")
local TeamBattleMapKnightComp = class("TeamBattleMapKnightComp", require("app.fairyGUI.teamBattle.UI_TeamBattleMapKnightComp"))

function TeamBattleMapKnightComp:ctor()
	self._knightVisual = nil
	self._useRoleEffect = false
	self._resId = 0
	self._bossTime = -1
	self._isRole = false

	self.m_hpBar:setMax(100)
	self.m_knightNode:displayObject():setCascadeColorEnabled(true)
	self:_onInitTimeScale()
end

function TeamBattleMapKnightComp:_onInitTimeScale()
	self.m_showTransition:setTimeScale(2)
	self.m_hideTransition:setTimeScale(2)
	self.m_hpBar:getTransition("show"):setTimeScale(2)
	self.m_hpBar:getTransition("hide"):setTimeScale(2)
	self.m_eventComp:getTransition("show"):setTimeScale(2)
	self.m_eventComp:getTransition("hide"):setTimeScale(2)
end

function TeamBattleMapKnightComp:_createKnightSpine(arg_3_1)
	if self._knightVisual then
		self._knightVisual:updateRole(arg_3_1)
	else
		self._knightVisual = TeamBattleRoleVirtual.new(arg_3_1)

		self.m_knightNode:addNode(self._knightVisual)
	end

	self._knightVisual:setCascadeOpacityEnabled(true)
	self._knightVisual:setCascadeColorEnabled(true)

	self._resId = arg_3_1
end

function TeamBattleMapKnightComp:getResId()
	return self._resId
end

function TeamBattleMapKnightComp:isInitRole()
	return self._roleStruct ~= nil
end

function TeamBattleMapKnightComp:onLoad()
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_FORMATION_GET, handler(self, self._updateFightValue), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_FORMATION_SAVE, handler(self, self._updateFightValue), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_FORMATION_FIGHTVALUE, handler(self, self._updateFightValue), self)
	self:_updateFightValue()
end

function TeamBattleMapKnightComp:_updateFightValue()
	if self._isRole and self._roleStruct:isSelf() then
		local var_7_0 = {}

		var_7_0.fight = var_0_3:getFormationData():getMaxFormationFightValue()

		self.m_fightText:setText(g.core.lang:get(420655, var_7_0))
	end
end

function TeamBattleMapKnightComp:updateKnight(arg_8_1)
	self._knightInfo = arg_8_1
	self._isRole = false

	self:_createKnightSpine(arg_8_1.resId)
	self:_onStopTimer()

	if arg_8_1.scale then
		self._knightVisual:setInnerScale(arg_8_1.scale)
		self.m_bigScaleController:setSelectedIndex(1)
		self:_onStartTimer()
		self:_onBossEventTimeCountDown()
	else
		self._knightVisual:setInnerScale(1)
		self.m_bigScaleController:setSelectedIndex(0)
	end

	if arg_8_1.fight then
		self.m_fightText:setText(g.core.lang:get(420655, {
			fight = arg_8_1.fight
		}))
	else
		self.m_fightText:setText("")
	end

	self.m_nameText:setText(arg_8_1.name)

	local var_8_0 = arg_8_1.tp

	if arg_8_1.lockTime and arg_8_1.lockTime + 600 > g.core.common.ServerTime:getTime() then
		self.m_isLockController:setSelectedIndex(1)
	else
		self.m_isLockController:setSelectedIndex(0)
	end

	if var_8_0 == TeamBattleConst.EVENT_TYPE.GUARD then
		self.m_roleTypeController:setSelectedIndex(1)
		self.m_guardComp:updateGuardHp(arg_8_1.roomId)
		self.m_battleLoader:setIcon("ui://teamBattle/pic_slmj_zhandou4_boss")
	elseif arg_8_1.eventType then
		self.m_roleTypeController:setSelectedIndex(4)

		if arg_8_1.eventType == TeamBattleConst.EVENT_TYPE.REVIVAL then
			self.m_eventComp:setIcon("ui://teamBattle/icon_hjtj_fuhuo")
			self.m_eventComp:setTitle(g.core.lang:get(427126))
		elseif arg_8_1.eventType == TeamBattleConst.EVENT_TYPE.RECOVER then
			self.m_eventComp:setIcon("ui://teamBattle/icon_hjtj_zhiliao")
			self.m_eventComp:setTitle(g.core.lang:get(427127))
		end

		return
	else
		self.m_roleTypeController:setSelectedIndex(0)
	end

	if arg_8_1.diff and var_8_0 ~= TeamBattleConst.EVENT_TYPE.GUARD then
		self.m_battleLoader:updateIcon(arg_8_1.diff)
	end

	if arg_8_1.needPlayDied then
		self:playInnerAction(require("app.view.battle.const.BattleConst").SPINE_ACTION_TYPE.DEAD)
		self:playHurtEffect()
		g.core.common.Scheduler:newScheduleOnce(handler(self, self._onDeadActionEnd), 0.8)
	end

	if not arg_8_1.hpRatioList then
		self.m_hpBar:setVisible(false)

		return
	end

	local var_8_1 = 0
	local var_8_2 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_1.hpRatioList) do
		var_8_2 = var_8_2 + iter_8_1
		var_8_1 = var_8_1 + 1000
	end

	self.m_hpBar:setValue(math.ceil(var_8_2 / var_8_1 * 1000) / 10)
	self.m_hpBar:setVisible(true)
end

function TeamBattleMapKnightComp:updateKnightSpine(arg_9_1)
	local var_9_0 = g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot(arg_9_1)

	self:_createKnightSpine(var_9_0.resId)
	self._knightVisual:updateSkinSkeletonAndBackSpine(var_9_0)
end

function TeamBattleMapKnightComp:_onDeadActionEnd()
	if not self._knightInfo then
		return
	end

	self:playInnerAction(require("app.view.battle.const.BattleConst").SPINE_ACTION_TYPE.IDLE)

	self._knightInfo.needPlayDied = false

	self:dispatchCompEvent("knightDiedPlayEnd")
end

function TeamBattleMapKnightComp:onRemoved()
	self._knightInfo = nil
end

function TeamBattleMapKnightComp:_updateBossEffect(arg_12_1)
	if self._bossTime == arg_12_1 then
		return
	end

	self.m_effectUp:removeAllEffect()

	if arg_12_1 < 1 then
		return
	end

	local var_12_0 = "once"

	if arg_12_1 == 2 then
		var_12_0 = "twice"
	elseif arg_12_1 == 3 then
		var_12_0 = "3times"
	end

	self.m_effectUp:addEffectSpine({
		name = "eff_ui_exploration_boss",
		isLoop = true,
		anim = var_12_0
	})

	self._bossTime = arg_12_1
end

function TeamBattleMapKnightComp:updateRole(arg_13_1)
	self._isRole = true
	self._roleStruct = arg_13_1

	local var_13_0 = arg_13_1:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER)

	if var_13_0 then
		self:updateKnightSpine(var_13_0)
		self.m_nameText:setText(var_13_0.name)
	end

	self.m_fightText:setText(arg_13_1:getFightValue())

	if TeamBattleConst.MAP.UES_EFFECT and arg_13_1:isSelf() and not self._useRoleEffect then
		self:_updateEffect()

		self._useRoleEffect = true
	end

	if arg_13_1:isSelf() then
		self.m_roleTypeController:setSelectedIndex(2)

		if var_0_3:getFormationData():getMaxFormationFightValue() > arg_13_1:getFightValue() then
			local var_13_1 = {}

			var_13_1.fight = var_0_3:getFormationData():getMaxFormationFightValue()

			self.m_fightText:setText(g.core.lang:get(420655, var_13_1))
		end
	else
		self.m_roleTypeController:setSelectedIndex(3)
	end

	self.m_isOnlineController:setSelectedIndex(arg_13_1:getOnLineState())

	if arg_13_1:getDeBuffId() > 0 then
		self:updateBuff(arg_13_1:getDeBuffId())
	else
		self.m_isDebuffController:setSelectedIndex(0)
	end
end

function TeamBattleMapKnightComp:getKnightResId(arg_14_1)
	if arg_14_1.skin and arg_14_1.skin > 0 then
		local var_14_0 = g.core.config.skin_info.fetch(arg_14_1.skin)

		if var_14_0 then
			local var_14_1 = g.core.config.knight_base_info.fetch(var_14_0.res)

			if var_14_1 then
				return var_14_1.fight_id
			end
		end
	end

	return g.core.config.knight_info.get(arg_14_1.base_id).res_id
end

function TeamBattleMapKnightComp:updateBuff(arg_15_1)
	self.m_buffGroup2:setVisible(false)

	self._skillInfo = g.core.config.skill_info.get(g.core.config.passive_skill_info.get(g.core.config.team_battle_debuff_info.get(arg_15_1).buff_id).passive_skill_value)

	self.m_buffIcon1:setURL("battle/buff_icon/buff_youhun1.png")
	self.m_isDebuffController:setSelectedIndex(1)
end

function TeamBattleMapKnightComp:checkRoleSpine()
	if not self._roleStruct then
		return
	end

	local var_16_0 = self._roleStruct:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER)

	if self._resId == 0 and var_16_0 then
		self:updateKnightSpine(var_16_0)
		self.m_nameText:setText(var_16_0.name)
	end
end

function TeamBattleMapKnightComp:updateSelf()
	if self._roleStruct then
		self:updateRole(self._roleStruct)
	end
end

function TeamBattleMapKnightComp:_updateEffect()
	self.m_effectUp:addEffectSpine({
		anim = "playUp",
		name = "eff_ui_exploration_knightCircle",
		isLoop = true
	})
	self.m_effectDown:addEffectSpine({
		anim = "playDown",
		name = "eff_ui_exploration_knightCircle",
		isLoop = true
	})
end

function TeamBattleMapKnightComp:playInnerAction(arg_19_1)
	self._knightVisual:playInnerAction(arg_19_1)
end

function TeamBattleMapKnightComp:setHalfOpacity(arg_20_1)
	if not self._knightVisual then
		return
	end

	self._knightVisual:setHalfOpacity(arg_20_1)
end

function TeamBattleMapKnightComp:playJumpEffect()
	if not self._knightVisual then
		return
	end

	self._knightVisual:playJumpEffect()
end

function TeamBattleMapKnightComp:addEffectSpine()
	if not self._knightVisual then
		return
	end

	self._knightVisual:addEffectSpine()
end

function TeamBattleMapKnightComp:showTalkBubble(arg_23_1, arg_23_2)
	if not self._knightVisual then
		return
	end

	self._knightVisual:showTalkBubble(arg_23_1, arg_23_2)
end

function TeamBattleMapKnightComp:setInnerDir(arg_24_1)
	self._knightVisual:setInnerDir(arg_24_1)
end

function TeamBattleMapKnightComp:setKnightCompColor(arg_25_1)
	return
end

function TeamBattleMapKnightComp:_onBossEventTimeCountDown()
	if self._knightInfo.endTime - g.core.common.ServerTime:getTime() > 0 then
		self.m_limitTimeText:setText(g.core.common.ServerTime:getLeftSecondsString(self._knightInfo.endTime))
	else
		self.m_limitTimeText:setText(g.core.lang:get(427129))
		self:_onStopTimer()
		self:setVisible(false)
	end
end

function TeamBattleMapKnightComp:_onStartTimer()
	self._timer = self._timer or self:newSchedule(handler(self, self._onBossEventTimeCountDown), 1)
end

function TeamBattleMapKnightComp:_onStopTimer()
	if self._timer then
		self:cancelSchedule(self._timer)
	end

	self._timer = nil
end

function TeamBattleMapKnightComp:playBuffEffect(arg_29_1)
	self.m_effRoleUp:removeAllEffect()
	self.m_effRoleUp:addEffectSpine({
		name = "eff_ui_teamBattle_trigger",
		anim = "play",
		isLoop = false,
		remove = true,
		eventHandler = function(self, arg_30_1)
			if require("app.view.battle.const.BattleConst").SPINE_EVENT.COMPLETE == self.type and arg_29_1 then
				arg_29_1()
			end
		end
	})
end

function TeamBattleMapKnightComp:playRoleTelportEffect(arg_31_1)
	self.m_effRoleUp:removeAllEffect()
	g.core.module.ModuleManager:tip(g.core.lang:get(427110))
	self.m_effRoleUp:addEffectSpine({
		name = "eff_ui_teamBattle_move",
		anim = "play",
		isLoop = false,
		remove = true,
		eventHandler = function(self, arg_32_1)
			if require("app.view.battle.const.BattleConst").SPINE_EVENT.COMPLETE == self.type and arg_31_1 then
				arg_31_1()
			end
		end
	})
end

function TeamBattleMapKnightComp:playTrapEffect(arg_33_1)
	self.m_effRoleUp:removeAllEffect()
	self.m_effRoleUp:addEffectSpine({
		name = "eff_ui_teamBattle_trap",
		anim = "play",
		isLoop = false,
		remove = true,
		eventHandler = function(self, arg_34_1)
			if require("app.view.battle.const.BattleConst").SPINE_EVENT.COMPLETE == self.type and arg_33_1 then
				arg_33_1()
			end
		end
	})
end

function TeamBattleMapKnightComp:playHurtEffect()
	self.m_effRoleUp:removeAllEffect()
	self.m_effRoleUp:addEffectSpine({
		anim = "play",
		name = "eff_ui_teamBattle_attack",
		remove = true,
		isLoop = false
	})
end

function TeamBattleMapKnightComp:setKnightBlack(arg_36_1)
	if arg_36_1 then
		self._knightVisual:setColor(cc.c3b(127, 127, 127))
	else
		self._knightVisual:setColor(cc.c3b(255, 255, 255))
	end
end

function TeamBattleMapKnightComp:setKnightBlackAnim(arg_37_1)
	self:setKnightBlack(not arg_37_1)

	if arg_37_1 then
		self._knightVisual:runAction((cc.TintTo:create(0.2, 127, 127, 127)))
	else
		self._knightVisual:runAction((cc.TintTo:create(0.2, 255, 255, 255)))
	end
end

return TeamBattleMapKnightComp
