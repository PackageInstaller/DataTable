local BattleResultThemeExploreAwardComp = class("BattleResultThemeExploreAwardComp", require("app.fairyGUI.battleResult.UI_BattleResultThemeExploreAwardComp"))

function BattleResultThemeExploreAwardComp:ctor()
	self._knightData = {}

	self.m_knightList:setVirtual()
	self.m_knightList:setItemRenderer(handler(self, self._onKnightRenderer))
end

function BattleResultThemeExploreAwardComp:update(arg_2_1)
	self._knightData = {}

	local var_2_0 = g.core.model.User.knightsData:getFormation()

	for iter_2_0 = 1, 6 do
		if var_2_0[iter_2_0] and var_2_0[iter_2_0] > 0 then
			local var_2_1 = self._knightData
			local var_2_2 = {
				knightData = g.core.model.User.knightsData:getKnight({
					id = var_2_0[iter_2_0]
				})
			}

			if arg_2_1.hpList then
				var_2_2.hpTh = arg_2_1.hpList[iter_2_0] or 0
			end

			table.insert(var_2_1, var_2_2)
		end
	end

	self.m_knightList:setNumItems(#self._knightData)
end

function BattleResultThemeExploreAwardComp:_onKnightRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateHpIcon(self._knightData[arg_3_1 + 1])
end

return BattleResultThemeExploreAwardComp
