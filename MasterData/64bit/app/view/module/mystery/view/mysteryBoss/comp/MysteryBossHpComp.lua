local BattlePath = require("app.view.battle.BattlePath")
local MysteryBossHpComp = class("MysteryBossHpComp", require("app.fairyGUI.mystery.UI_MysteryBossHpComp"))

function MysteryBossHpComp:ctor()
	self._hp = 0
	self._name = 0
	self._maxHp = 1
	self._monsterId = nil
end

function MysteryBossHpComp:updateBossHpInfo(arg_2_1)
	self._boss = arg_2_1
	self._hp = self._boss:getBossCurHp()
	self._maxHp = self._boss:getBossInitHp()
	self._hpTubeNum = self._boss:getBossConfig().hp_num or 1

	self:updateHp(self._hp)

	local var_2_0 = self._boss:getBossMonsterInfo()

	self.m_nameText:setText(var_2_0.name)
	self.m_bossIcon:setURL((BattlePath.getBossIconPath(var_2_0.res_id)))
end

function MysteryBossHpComp:updateHp(arg_3_1)
	local var_3_5

	if self._hpTubeNum ~= 1 then
		local var_3_0 = self._maxHp / self._hpTubeNum
		local var_3_1 = math.ceil(arg_3_1 / (self._maxHp / self._hpTubeNum))
		local var_3_2 = arg_3_1 % (self._maxHp / self._hpTubeNum)

		if arg_3_1 % (self._maxHp / self._hpTubeNum) == 0 and var_3_1 > 0 then
			var_3_2 = var_3_0
		end

		if var_3_1 > 0 then
			self.m_hpTubeBg:setVisible(true)
		else
			self.m_hpTubeBg:setVisible(false)
		end

		local var_3_3 = math.min(1, var_3_2 / var_3_0)

		self.m_progressImg:setFillAmount(var_3_3)
		self.m_tweenProgress:setPercent({
			tween = true,
			max = 100,
			cur = var_3_3 * 100
		})
		self.m_hpTubeText:setText(g.core.lang:get(109536, {
			num = var_3_1
		}))
	else
		self.m_hpTubeBg:setVisible(false)
		self.m_hpTubeText:setVisible(false)

		local var_3_4 = math.min(1, arg_3_1 / self._maxHp)

		self.m_progressImg:setFillAmount(var_3_4)
		self.m_tweenProgress:setPercent({
			tween = true,
			max = 100,
			cur = var_3_4 * 100
		})

		var_3_5 = {}
	end

	var_3_5.percent = math.max(0, math.ceil(self._hp / self._maxHp * 100))

	self.m_percentText:setText(g.core.lang:get(423502, var_3_5))
end

return MysteryBossHpComp
