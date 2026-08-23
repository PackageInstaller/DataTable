local var_0_0 = g.core.const.ConstMgr.ElderBossConst
local var_0_1 = g.core.model.User.elderBossData
local ElderBossHpComp = class("ElderBossHpComp", require("app.fairyGUI.elderBoss.UI_ElderBossHpComp"))

function ElderBossHpComp:ctor()
	self._hp = 0
	self._name = 0
	self._maxHp = 1
	self._monsterId = nil

	self:addClickListener(handler(self, self._onClick))
end

function ElderBossHpComp:updateBossHpInfo(arg_2_1)
	self._bossId = var_0_1:getBossId()
	self._bossInfo = g.core.config.elder_boss_info.get(self._bossId)
	self._bossData = var_0_1:getBossSvrData()
	self._hp = self._bossData.curHp
	self._maxHp = self._bossData.maxHp
	self._level = math.min(self._bossData.grade, var_0_0.ELDER_BOSS_LEVEL_LIMIT)
	self._hpTubeNum = 1

	self:updateHp(self._hp)
	self.m_nameText:setText(self._bossInfo.name)
	self.m_levelText:setText(g.core.lang:get(120) .. self._level)
	self.m_bossIcon:setURL((require("app.view.battle.BattlePath").getBossIconPath(var_0_1:getMonsterInfoByTeamId(self._bossInfo.monster_team_id).res_id)))
end

function ElderBossHpComp:updateHp(arg_3_1)
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

	self.m_percentText:setText(g.core.lang:get(432526, var_3_5))
end

function ElderBossHpComp:_onClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.elderBoss.view.ElderBossPreviewPop").new()))
end

return ElderBossHpComp
