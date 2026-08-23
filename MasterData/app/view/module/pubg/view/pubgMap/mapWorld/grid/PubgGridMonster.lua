local var_0_0 = g.core.model.User.pubgData
local PubgGridMonster = class("PubgGridMonster", require("app.fairyGUI.pubg.UI_PubgGridMonster"))

function PubgGridMonster:ctor()
	self._monster = nil
end

function PubgGridMonster:resetComp()
	self.m_eff:setVisible(false)
	self:setCanAttack(false)
end

function PubgGridMonster:setMonster(arg_3_1)
	if not self._monster or self._monster:getUid() ~= arg_3_1:getUid() then
		self._monster = arg_3_1
	end

	self:refreshMonster()
end

function PubgGridMonster:refreshMonster()
	self.m_userName:setText(self._monster:getName())
	self.m_fightValue:setText(g.core.lang:get(304534, {
		fightValue = self._monster:getMonsterCfg().power
	}))
	self:_setShowKnight({
		isLoop = true,
		resId = self._monster:getMonsterCfg().knight_base
	})
end

function PubgGridMonster:_setShowKnight(arg_5_1)
	if self._knight then
		if self._knight:getResId() ~= arg_5_1.resId then
			var_0_0:getMapData():recycleKnightSpine(self._knight)

			self._knight = var_0_0:getMapData():getKnightSpine(arg_5_1)

			self.m_showKnight:addNode(self._knight)
			self._knight:release()
		end
	else
		self._knight = var_0_0:getMapData():getKnightSpine(arg_5_1)

		self.m_showKnight:addNode(self._knight)
		self._knight:release()
	end
end

function PubgGridMonster:playKnightAnimation(arg_6_1, arg_6_2)
	if self._knight then
		self._knight:setAnimation(0, arg_6_1, arg_6_2)
	end
end

function PubgGridMonster:playDeadEffect()
	self.m_effAttack:addEffectSpine({
		remove = true,
		name = "eff_ui_pubg_attack",
		scale = 1,
		isLoop = false
	})
end

function PubgGridMonster:setCanAttack(arg_8_1)
	self.m_canAttackController:setSelectedIndex(arg_8_1 and 1 or 0)
end

function PubgGridMonster:playRefreshEventEff()
	self.m_eff:addEffectSpine({
		anim = "play",
		name = "eff_ui_pubg_monster",
		remove = true,
		isLoop = false
	})
end

return PubgGridMonster
