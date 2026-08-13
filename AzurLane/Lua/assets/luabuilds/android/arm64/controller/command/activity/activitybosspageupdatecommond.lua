class = var_0_10000

local var_0_0 = "ActivityBossPageUpdateCommond"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_10003
	ActivityProxy = var_1_10005

	local var_1_2 = var_1_10003(var_1_10005)
	local var_1_3 = var_3.getActivityByType

	ActivityConst = var_1_10006

	if not var_1_3(var_1_2, var_1_10006.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2) or var_3:isEnd() then
		return
	end

	pg = var_1_0

	local var_1_4 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_4, 26031, {
		act_id = var_3.id
	}, 26032, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_2_1
			ActivityProxy = var_2_10003

			local var_2_0 = var_2_1(var_2_10003)
			local var_2_1 = var_2_1.getActivityByType

			ActivityConst = var_2_10004
			var_0 = var_2_1(var_2_0, var_2_10004.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)

			if var_0 then
				local var_2_2 = var_0

				if var_2_1.isEnd(var_2_2) then
					return
				end

				local var_2_3 = var_0

				var_2_1.UpdatePublicData(var_2_3, arg_2_0)

				getProxy = var_2_1
				ActivityProxy = var_2_3

				local var_2_4 = var_2_1(var_2_3)

				var_2_1.updateActivity(var_2_4, var_0)

				if false then
					pg = var_2_1

					local var_2_5 = var_2_1.TipsMgr.GetInstance()
					local var_2_6 = var_1.ShowTips

					errorTip = var_2_10004

					var_2_6(var_2_5, var_2_10004("", arg_2_0.result))
				end

				return
			end
		end
	end)

	return
end

return var_0_1
