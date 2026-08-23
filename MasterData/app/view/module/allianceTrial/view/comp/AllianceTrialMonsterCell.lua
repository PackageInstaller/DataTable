local var_0_0 = g.core.model.User.allianceTrialData
local var_0_1 = g.core.config.knight_info
local var_0_2 = g.core.config.knight_base_info
local AllianceTrialMonsterCell = class("AllianceTrialMonsterCell", require("app.fairyGUI.allianceTrial.UI_AllianceTrialMonsterCell"))

function AllianceTrialMonsterCell:ctor()
	self._monsterInfo = nil

	self:addClickListener(handler(self, self._onClickMonster))
end

function AllianceTrialMonsterCell:_onClickMonster()
	if not self._monsterInfo then
		return
	end

	if not var_0_0:canChallengeMonster(self._monsterInfo.id) then
		g.core.module.ModuleManager:tip(g.core.lang:get(430403))

		return
	end

	self:dispatchCompEvent("allianceTrial_click_monster", {
		id = self._monsterInfo.id,
		bid = self._bid
	})
end

function AllianceTrialMonsterCell:updateMonsterInfo(arg_3_1, arg_3_2)
	self._monsterInfo = arg_3_1
	self._bid = arg_3_2

	local var_3_0 = var_0_1.get(self._monsterInfo.knight_id)
	local var_3_1 = var_0_2.get(var_3_0.res_id)

	self.m_monsterName:setText(var_3_0.name)
	self.m_isDeadController:setSelectedIndex(not var_0_0:canChallengeMonster(self._monsterInfo.id) and 1 or 0)
	self.m_monsterIcon:setIcon(g.core.common.Path:getKnightIconById(var_3_1.icon_id))
	self.m_hpProgress:setMax(self._monsterInfo.monster_group_hp)
	self.m_hpProgress:setValue(var_0_0:isLevelFinish() and self._monsterInfo.monster_group_hp or var_0_0:getMonsterHp(self._monsterInfo.id))
end

return AllianceTrialMonsterCell
