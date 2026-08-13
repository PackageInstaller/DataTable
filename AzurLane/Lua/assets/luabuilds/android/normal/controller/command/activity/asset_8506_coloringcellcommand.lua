class = var_0_10000

local var_0_0 = "ColoringCellCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().activityId
	local var_1_1 = var_2.id
	local var_1_2 = var_2.cells

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 26004, {
		act_id = var_1_0,
		id = var_1_1,
		cell_list = var_1_2
	}, 26005, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			ColoringProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)

			local var_2_0 = var_1.getColorItems(var_2_10003)
			local var_2_1 = var_1:getColorGroup(var_1_1)
			local var_2_2 = var_2_10003.getConfig(var_2_1, "color_id_list")

			_ = var_2_1

			var_2_1.each(var_1_2, function(arg_3_0)
				local var_3_0 = var_2_10003

				var_1.setFill(var_3_0, arg_3_0.row, arg_3_0.column, arg_3_0.color)

				local var_3_1 = var_2_10003

				if not var_1.canBeCustomised(var_3_1) and arg_3_0.color > 0 then
					local var_3_2 = var_2_2[arg_3_0.color]
					local var_3_3 = var_2_0

					math = var_3
					var_3_3[var_3_2] = var_3.max(var_2_0[var_3_2] - 1, 0)
				end

				return
			end)

			local var_2_3 = var_1:checkState()
			local var_2_4 = arg_1_0
			local var_2_5 = var_6.sendNotification

			GAME = var_2_10008

			var_2_5(var_2_4, var_2_10008.COLORING_CELL_DONE, {
				cells = var_1_2,
				stateChange = var_2_3
			})
		else
			pg = var_1

			local var_2_6 = var_1.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_7(var_2_6, var_2_10003("coloring_cell", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
