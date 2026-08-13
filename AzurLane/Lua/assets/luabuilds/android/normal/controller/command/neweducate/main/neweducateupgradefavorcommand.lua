class = var_0_10000

local var_0_0 = "NewEducateUpgradeFavorCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2 and var_2.callback

	getProxy = var_1_10005
	NewEducateProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.GetCurChar(var_1_2)
	local var_1_4 = var_5.GetFSM(var_1_3)
	local var_1_6

	if var_5.CheckPriorityStystem(var_1_4) then
		pg = var_1_6

		local var_1_5 = var_1_6.TipsMgr.GetInstance()

		var_1_6 = var_1_6.ShowTips
		i18n = var_1_10007

		var_1_6(var_1_5, var_1_10007("child2_priority_tip"))

		return
	end

	pg = var_1_6

	local var_1_7 = var_1_6.ConnectionMgr.GetInstance()

	var_5.Send(var_1_7, 29027, {
		id = var_1_0
	}, 29028, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			getProxy = var_2_2
			NewEducateProxy = var_2_10002

			local var_2_0 = var_2_2(var_2_10002)
			local var_2_1 = var_2_2.GetCurChar(var_2_0)

			var_2_2.UpgradeFavor(var_2_1)

			NewEducateDropHelper = var_2_2
			var_2_2 = var_2_2.HandleDrops(arg_2_0.drop)

			local var_2_3 = arg_1_0
			local var_2_4 = var_2.sendNotification

			GAME = var_2_10004

			var_2_4(var_2_3, var_2_10004.NEW_EDUCATE_UPGRADE_FAVOR_DONE, {
				drops = var_2_2,
				callback = var_1_1
			})
		else
			pg = var_2_2

			local var_2_5 = var_2_2.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_5, "NewEducate_UpgradeFavor: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
