local BlazingArenaFormationLineComp = class("BlazingArenaFormationLineComp", require("app.fairyGUI.blazingArena.UI_BlazingArenaFormationLineComp"))

function BlazingArenaFormationLineComp:updateComp()
	local var_1_0 = 0

	for iter_1_0 = 1, 3 do
		local var_1_1 = g.core.model.User.mulFormationData:getFormationStruct(g.core.const.ConstMgr.LineUpConst.MulTeamType.BLAZING_ARENA, iter_1_0)
		local var_1_2 = var_1_1:getValidKnightSidList()

		for iter_1_1 = 1, var_1_1:getLimitKnightNum() do
			var_1_0 = var_1_0 + 1

			local var_1_3 = self[table.concat({
				"m_icon",
				var_1_0
			})]
			local var_1_4
			local var_1_5

			if var_1_2[iter_1_1] then
				var_1_4 = {
					scaleIndex = 3,
					sid = var_1_2[iter_1_1]
				}

				local var_1_6 = var_1_1:getBindKnight((var_1_1:getKnightStationPos(var_1_2[iter_1_1])))

				if var_1_6 then
					var_1_5 = var_1_6:getLevel()
				end
			end

			var_1_3:updateComp(var_1_0, var_1_4, nil, nil, false, var_1_5)
		end
	end
end

return BlazingArenaFormationLineComp
