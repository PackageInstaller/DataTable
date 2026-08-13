class = var_0_10000

local var_0_0 = "ColoringAchieveCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().activityId
	local var_1_1 = var_2.id

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 26002, {
		act_id = var_1_0,
		id = var_1_1
	}, 26003, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			PlayerConst = var_2_0
			var_2_0 = var_2_0.addTranDrop(arg_2_0.drop_list)
			getProxy = var_2
			ColoringProxy = var_2_10003

			local var_2_1 = var_2(var_2_10003)
			local var_2_2 = var_2.getColorGroup(var_2_1, var_1_1)

			var_2_10003.setDrops(var_2_2, var_2_0)

			local var_2_3 = var_2_10003
			local var_2_4 = var_2_10003.setState

			ColorGroup = var_6

			var_2_4(var_2_3, var_6.StateAchieved)
			var_2:checkState()

			local var_2_5 = arg_1_0
			local var_2_6 = var_4.sendNotification

			GAME = var_6

			var_2_6(var_2_5, var_6.COLORING_ACHIEVE_DONE, {
				drops = var_2_0
			})
		else
			pg = var_2_0

			local var_2_7 = var_2_0.TipsMgr.GetInstance()
			local var_2_8 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_8(var_2_7, var_2_10003("coloring_achieve", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
