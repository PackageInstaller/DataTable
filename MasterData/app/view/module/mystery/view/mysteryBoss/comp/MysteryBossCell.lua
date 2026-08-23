local var_0_0 = g.core.const.ConstMgr.MysteryBossConst
local MysteryBossCell = class("MysteryBossCell", require("app.fairyGUI.mystery.UI_MysteryBossCell"))

function MysteryBossCell:ctor()
	self._cdSchedule = nil
end

function MysteryBossCell:updateCell(arg_2_1)
	self.m_canBattleTxt:setVisible(true)

	self._boss = arg_2_1

	self.m_bossNameTxt:setText(arg_2_1:getBossName())
	self.m_iconLoader:setIcon(g.core.common.Path:getRoleHeadIcon(arg_2_1:getBossMonsterInfo().res_id))

	local var_2_0 = arg_2_1:getBossState()

	self.m_stateController:setSelectedIndex(var_2_0)
	self.m_timeShowController:setSelectedIndex(0)

	if var_2_0 == var_0_0.BOSS_STATE.FIGHTING then
		self.m_battleTxt:setText((g.core.lang:get(423502, {
			percent = math.max(0, math.ceil(arg_2_1:getBossCurHp() / arg_2_1:getBossInitHp() * 100))
		})))
	elseif var_2_0 == var_0_0.BOSS_STATE.WAIT then
		self:newRebornSchedule()
	elseif var_2_0 == var_0_0.BOSS_STATE.UNOPEN_LIMIT then
		if g.core.model.User.mysteryBossData:getOpenLimitTime() > 0 then
			self:newRebornSchedule()
			self.m_canBattleTxt:setVisible(false)
		else
			self.m_timeShowController:setSelectedIndex(1)
		end
	end
end

function MysteryBossCell:newRebornSchedule()
	self:_updateCDTime()

	self._cdSchedule = self._cdSchedule or self:newSchedule(handler(self, self._updateCDTime), 1)
end

function MysteryBossCell:_updateCDTime()
	local var_4_0 = 0
	local var_4_1 = self.m_stateController:getSelectedIndex()

	if var_4_1 == var_0_0.BOSS_STATE.WAIT then
		var_4_0 = self._boss:getRebornCD()
	elseif var_4_1 == var_0_0.BOSS_STATE.UNOPEN_LIMIT then
		var_4_0 = g.core.model.User.mysteryBossData:getOpenLimitTime()
	end

	if var_4_0 > 0 then
		self.m_rebornTxt:setText(g.core.lang:get(423503, {
			time = g.core.common.ServerTime:secondToHMSString(var_4_0)
		}))
	elseif self._cdSchedule then
		self:cancelSchedule(self._cdSchedule)

		self._cdSchedule = nil

		g.core.network.GameNetProxy:send_C2S_MysteryBoss_GetInfo({})
	end
end

return MysteryBossCell
