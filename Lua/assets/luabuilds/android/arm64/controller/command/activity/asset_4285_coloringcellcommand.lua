local ColoringCellCommand = class("ColoringCellCommand", pm.SimpleCommand)

function ColoringCellCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.cells

	pg.ConnectionMgr.GetInstance():Send(26004, {
		act_id = var_1_0.activityId,
		id = var_1_0.id,
		cell_list = var_1_0.cells
	}, 26005, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(ColoringProxy)
			local var_2_1 = var_2_0:getColorItems()
			local var_2_2 = var_2_0:getColorGroup(var_1_1)
			local var_2_3 = var_2_2:getConfig("color_id_list")

			_.each(var_1_2, function(arg_3_0)
				var_2_2:setFill(arg_3_0.row, arg_3_0.column, arg_3_0.color)

				if not var_2_2:canBeCustomised() and arg_3_0.color > 0 then
					var_2_1[var_2_3[arg_3_0.color]] = math.max(var_2_1[var_2_3[arg_3_0.color]] - 1, 0)
				end

				return
			end)
			self:sendNotification(GAME.COLORING_CELL_DONE, {
				cells = var_1_2,
				stateChange = var_2_0:checkState()
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("coloring_cell", arg_2_0.result))
		end

		return
	end)

	return
end

return ColoringCellCommand
