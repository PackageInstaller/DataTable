local ObtDebugConst = require("app.view.module.debug.OnlineBattleTest.ObtDebugConst")
local ObtAllBattleCell = class("ObtAllBattleCell", require("app.fairyGUI.debug.UI_ObtAllBattleCell"))

function ObtAllBattleCell:ctor()
	self._battleIndex = 0
end

function ObtAllBattleCell:updateBattleCell(arg_2_1)
	self._battleIndex = arg_2_1

	local var_2_0 = g.core.model.User.obtData:getBattle(arg_2_1)

	self.m_hasDataController:setSelectedIndex(0)

	if var_2_0 then
		self.m_desc:setText(string.format("%s(%d) 攻击 %s(%d)", ((g.core.model.User.obtData:getUserBattleTeamIndex(var_2_0.attack) or {}).user or {}).name or "", var_2_0.attack, ((g.core.model.User.obtData:getUserBattleTeamIndex(var_2_0.victim) or {}).user or {}).name or "", var_2_0.victim))
		self:updateProgress()
	end
end

function ObtAllBattleCell:updateProgress()
	local var_3_0 = g.core.model.User.obtData:getBattle(self._battleIndex)

	if not var_3_0 then
		return
	end

	local var_3_1 = var_3_0.attack
	local var_3_2 = g.core.model.User.obtData:getShowProgressIndex()

	if ObtDebugConst.progressList[var_3_2] == ObtDebugConst.progressEnum.fightValue then
		local var_3_3 = g.core.model.User.obtData:getUserBattleTeamIndex(var_3_1)

		if not var_3_3 then
			return
		end

		local var_3_4 = var_3_3.user or {}
		local var_3_5 = g.core.model.User.obtData:getUserBattleTeamIndex(var_3_0.victim)

		if not var_3_5 then
			return
		end

		self.m_hasDataController:setSelectedIndex(1)

		local var_3_7 = ((var_3_5.user or {}).fight_value or 0) / (var_3_4.fight_value or 0) * 100

		self.m_progressComp:setMax(100)
		self.m_progressComp:setValue(var_3_7)
	elseif ObtDebugConst.progressList[var_3_2] == ObtDebugConst.progressEnum.winCount then
		local var_3_8 = g.core.model.User.obtData:getBattleResult(var_3_1, var_3_0.victim)

		if var_3_8 then
			self.m_hasDataController:setSelectedIndex(1)

			local var_3_9 = var_3_8.winCount or 0
			local var_3_10 = g.core.model.User.obtData:getOnceBattleCount()

			self.m_progressComp:setMax(var_3_10)
			self.m_progressComp:setValue(var_3_10 - var_3_9)
		end
	elseif ObtDebugConst.progressList[var_3_2] == ObtDebugConst.progressEnum.round then
		local var_3_11 = g.core.model.User.obtData:getBattleResult(var_3_1, var_3_0.victim)

		if var_3_11 then
			self.m_hasDataController:setSelectedIndex(1)
			self.m_progressComp:setMax(20)
			self.m_progressComp:setValue(math.round(var_3_11.averageRound) or 0)
		end
	end
end

return ObtAllBattleCell
