local ExplorationConst = require("app.view.module.exploration.const.ExplorationConst")
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.model.User.explorationData
local ExplorationRoleVirtual = require("app.view.module.exploration.view.map.entity.ExplorationRoleVirtual")
local ExplorationMapKnightComp = class("ExplorationMapKnightComp", require("app.fairyGUI.exploration.UI_ExplorationMapKnightComp"))

function ExplorationMapKnightComp:ctor()
	self._knightVisual = nil
	self._useRoleEffect = false
	self._resId = 0
	self._bossTime = -1
	self._isRole = false
end

function ExplorationMapKnightComp:_createKnightSpine(arg_2_1, arg_2_2)
	if self._knightVisual then
		self._knightVisual:updateRole(arg_2_1, arg_2_2)
	else
		self._knightVisual = ExplorationRoleVirtual.new(arg_2_1, arg_2_2)

		self.m_knightNode:addNode(self._knightVisual)
	end

	self._resId = arg_2_1
end

function ExplorationMapKnightComp:getResId()
	return self._resId
end

function ExplorationMapKnightComp:onLoad()
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_FORMATION_GET, handler(self, self._updateFightValue), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_FORMATION_SAVE, handler(self, self._updateFightValue), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_FORMATION_FIGHTVALUE, handler(self, self._updateFightValue), self)
	self:_updateFightValue()
end

function ExplorationMapKnightComp:_updateFightValue()
	if self._isRole then
		local var_5_0 = {}

		var_5_0.fight = var_0_3:getFormationData():getMaxFormationFightValue()

		self.m_fightText:setText(g.core.lang:get(420655, var_5_0))
	end
end

function ExplorationMapKnightComp:updateKnight(arg_6_1)
	self._isRole = false

	self:_createKnightSpine(arg_6_1.resId)

	local var_6_0 = 0

	if arg_6_1.scale then
		self._knightVisual:setInnerScale(arg_6_1.scale)
		self.m_bigScaleController:setSelectedIndex(1)

		var_6_0 = var_0_3:getBossCanChallengeCount()
	else
		self._knightVisual:setInnerScale(1)
		self.m_bigScaleController:setSelectedIndex(0)
	end

	self.m_isBuffMonsterController:setSelectedIndex(0)

	if arg_6_1.roomId then
		local var_6_1 = g.core.model.User.explorationData:getGuildBuffInfoByRoomId(arg_6_1.roomId)

		if var_6_1 then
			self.m_buffIcon:setURL((g.core.common.Path:getThemeExplorePowerPic(var_6_1.image)))
			self.m_isBuffMonsterController:setSelectedIndex(1)
		end
	end

	self:_updateBossEffect(var_6_0)
	self.m_fightText:setText(g.core.lang:get(420655, {
		fight = arg_6_1.fight
	}))
	self.m_nameText:setText(arg_6_1.name)
	self.m_isMainRoleController:setSelectedIndex(0)

	if arg_6_1.scale then
		self.m_battleLoader:setURL("ui://exploration/pic_slmj_zhandou4_boss")
	elseif arg_6_1.diff == 1 then
		self.m_battleLoader:setURL("ui://exploration/pic_slmj_zhandou3")
	elseif arg_6_1.diff == 2 then
		self.m_battleLoader:setURL("ui://exploration/pic_slmj_zhandou2")
	elseif arg_6_1.diff == 3 then
		self.m_battleLoader:setURL("ui://exploration/pic_slmj_zhandou1")
	end

	if arg_6_1.deBuffInfo then
		self.m_battleLoader:setURL("ui://exploration/pic_slmj_zhandou5_ezhao")
	end

	if arg_6_1.needPlayDied then
		local BattleConst = require("app.view.battle.const.BattleConst")

		self:playInnerAction(BattleConst.SPINE_ACTION_TYPE.DEAD)
		self:newScheduleOnce(handler(self, function(arg_7_0)
			arg_7_0:playInnerAction(BattleConst.SPINE_ACTION_TYPE.IDLE)
			arg_7_0:dispatchCompEvent("knightDiedPlayEnd")
		end), 1)
	end
end

function ExplorationMapKnightComp:_updateBossEffect(arg_8_1)
	if self._bossTime == arg_8_1 then
		return
	end

	self.m_effectUp:removeAllEffect()

	if arg_8_1 < 1 then
		return
	end

	local var_8_0 = "once"

	if arg_8_1 == 2 then
		var_8_0 = "twice"
	elseif arg_8_1 == 3 then
		var_8_0 = "3times"
	end

	self.m_effectUp:addEffectSpine({
		name = "eff_ui_exploration_boss",
		isLoop = true,
		anim = var_8_0
	})

	self._bossTime = arg_8_1
end

function ExplorationMapKnightComp:updateMainRole()
	self._isRole = true

	self:_createKnightSpine(g.core.model.User.roleSkinData:getWearAdvanceIdByPart(g.core.const.ConstMgr.RoleSkinConst.PART.CLOTH), true)
	self:_updateFightValue()
	self.m_nameText:setText(g.core.model.User:getName())
	self.m_isMainRoleController:setSelectedIndex(1)

	if ExplorationConst.MAP.UES_EFFECT and not self._useRoleEffect then
		self:_updateEffect()
	end
end

function ExplorationMapKnightComp:_updateEffect()
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

function ExplorationMapKnightComp:playInnerAction(arg_11_1)
	self._knightVisual:playInnerAction(arg_11_1)
end

function ExplorationMapKnightComp:setHalfOpacity(arg_12_1)
	if not self._knightVisual then
		return
	end

	self._knightVisual:setHalfOpacity(arg_12_1)
end

function ExplorationMapKnightComp:playJumpEffect()
	if not self._knightVisual then
		return
	end

	self._knightVisual:playJumpEffect()
end

function ExplorationMapKnightComp:addEffectSpine()
	if not self._knightVisual then
		return
	end

	self._knightVisual:addEffectSpine()
end

function ExplorationMapKnightComp:showTalkBubble(arg_15_1, arg_15_2)
	if not self._knightVisual then
		return
	end

	self._knightVisual:showTalkBubble(arg_15_1, arg_15_2)
end

function ExplorationMapKnightComp:setInnerDir(arg_16_1)
	self._knightVisual:setInnerDir(arg_16_1)
end

return ExplorationMapKnightComp
