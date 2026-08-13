class = var_0_10000

local var_0_0 = "ColoringAchieveCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

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
			getProxy = var_2_10002
			ColoringProxy = var_2_10004

			local var_2_1 = var_2_10002(var_2_10004)
			local var_2_2 = var_2.getColorGroup(var_2_1, var_1_1)

			var_3.setDrops(var_2_2, var_2_0)

			local var_2_3 = var_3

			var_2_10004 = var_3.setState
			ColorGroup = var_7

			var_2_10004(var_2_3, var_7.StateAchieved)
			var_2:checkState()

			local var_2_4 = arg_1_0

			var_2_10004 = var_2_10004.sendNotification
			GAME = var_7

			var_2_10004(var_2_4, var_7.COLORING_ACHIEVE_DONE, {
				drops = var_2_0
			})
		else
			pg = var_2_0

			local var_2_5 = var_2_0.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_6(var_2_5, var_2_10004("coloring_achieve", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
