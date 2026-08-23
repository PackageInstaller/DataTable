local var_0_0 = g.core.model.User.wushTowerData
local BattleResultWushTowerUserHpComp = class("BattleResultWushTowerUserHpComp", require("app.fairyGUI.battleResult.UI_BattleResultWushTowerUserHpComp"))

function BattleResultWushTowerUserHpComp:ctor()
	self._knightData = {}

	self.m_knightHpList:setVirtual()
	self.m_knightHpList:setItemRenderer(handler(self, self._onKnightHpListRenderer))
end

function BattleResultWushTowerUserHpComp:update(arg_2_1)
	local var_2_0 = arg_2_1.knightList or {}
	local var_2_1 = var_0_0:getSumUserHp()

	self._formationHp = var_0_0:getWushTowerFormationHpMap()

	self.m_hpProgBar:setPercent({
		cur = var_2_1,
		max = #self._formationHp * 1000
	})
	self.m_userHpTxt:setText(math.floor(var_2_1 / (#self._formationHp * 1000) * 100) .. "%")
	self.m_stepCountTxt:setText((var_0_0:getCanChallengeCount()))

	self._knightData = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if iter_2_1.id > 0 then
			table.insert(self._knightData, {
				knightId = iter_2_1.id,
				hp = self._formationHp[iter_2_1.index]
			})
		end
	end

	self.m_knightHpList:setNumItems(#self._knightData)
end

function BattleResultWushTowerUserHpComp:_onKnightHpListRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateKnightHpIcon(self._knightData[arg_3_1 + 1])
end

return BattleResultWushTowerUserHpComp
