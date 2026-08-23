local CommonKnight = require("app.view.common.CommonKnight")
local var_0_1 = g.core.const.ConstMgr.SpineConst
local var_0_2 = g.core.const.ConstMgr.ElderBossConst
local var_0_3 = g.core.model.User.elderBossData
local ElderBossMapComp = class("ElderBossMapComp", require("app.fairyGUI.elderBoss.UI_ElderBossMapComp"))

function ElderBossMapComp:updateMapInfo()
	local var_1_0 = var_0_3:getBossId()

	if var_1_0 > 0 then
		local var_1_1 = var_0_3:getMonsterInfoByTeamId(g.core.config.elder_boss_info.get(var_1_0).monster_team_id)

		if var_1_1 or not self._bossSpine then
			self._bossSpine = CommonKnight.new({
				resId = var_1_1.res_id
			})

			self.m_bossPlaceComp:removeChildren()
			self.m_bossPlaceComp:addChild(self._bossSpine)

			self._attackSchedule = self._attackSchedule or self:newSchedule(handler(self, self.playBossAttackAction), g.core.config.parameter_info.get(24043).parameter)
		end
	end

	self.m_mainRole:updateRoleComp(g.core.model.User:getId())

	local var_1_2 = var_0_3:getShowUserArray()

	for iter_1_0 = 1, var_0_2.MAX_SHOW_USER_COUNT do
		if var_1_2[iter_1_0] then
			self["m_player" .. iter_1_0]:updateRoleComp(var_1_2[iter_1_0])
		else
			self["m_player" .. iter_1_0]:setEmpty()
		end
	end
end

function ElderBossMapComp:playMainRoleAttackAction()
	self.m_mainRole:playAttack()
end

function ElderBossMapComp:playBossAttackAction()
	if self._bossSpine then
		self._bossSpine:playAction(var_0_1.ACTION.ATTACK)
	end
end

function ElderBossMapComp:playBossDeadAction()
	if self._bossSpine then
		self:cancelAttackSchedule()
	end
end

function ElderBossMapComp:onUnload()
	self:cancelAttackSchedule()
end

function ElderBossMapComp:cancelAttackSchedule()
	if self._attackSchedule then
		self:cancelSchedule(self._attackSchedule)

		self._attackSchedule = nil
	end
end

return ElderBossMapComp
