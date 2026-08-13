class = var_0_10000

local var_0_0 = "IslandFollowerOpCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId
	local var_1_1 = var_2.op

	getProxy = var_1_10005
	IslandProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.GetIsland(var_1_2)
	local var_1_4 = var_5.GetFollowerAgency(var_1_3)
	local var_1_5 = var_5:GetCharacterAgency()

	if not var_7.GetShipById(var_1_5, var_1_0) then
		return
	end

	IslandConst = var_1_5

	local var_1_7

	if var_1_1 == var_1_5.FOLLOWER_OP_ADD and not var_7:CanFollowPlayer(var_1_0) then
		pg = var_1_7

		local var_1_6 = var_1_7.TipsMgr.GetInstance()

		var_1_7 = var_1_7.ShowTips
		i18n = var_1_10011

		var_1_7(var_1_6, var_1_10011("island_follower_state_no_normal"))

		return
	end

	IslandConst = var_1_7

	local var_1_9

	if var_1_1 == var_1_7.FOLLOWER_OP_ADD and var_1_4:ReachMaxCnt() then
		pg = var_1_9

		local var_1_8 = var_1_9.TipsMgr.GetInstance()

		var_1_9 = var_1_9.ShowTips
		i18n = var_1_10011

		var_1_9(var_1_8, var_1_10011("island_follower_cnt_max"))

		return
	end

	pg = var_1_9

	local var_1_10 = var_1_9.ConnectionMgr.GetInstance()

	var_9.Send(var_1_10, 21630, {
		ship_id = var_1_0,
		type = var_1_1
	}, 21631, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = var_1_1
			IslandConst = var_2_10002

			local var_2_1

			if var_2_0 == var_2_10002.FOLLOWER_OP_ADD then
				var_2_1 = var_1_4

				var_2_0.AddFollower(var_2_1, var_1_0)

				pg = var_2_0
				var_2_1 = var_2_0.TipsMgr.GetInstance()
				var_2_0 = var_2_0.ShowTips
				i18n = var_2_10003

				var_2_0(var_2_1, var_2_10003("island_follow_success"))
			else
				var_2_0 = var_1_1
				IslandConst = var_2_1

				if var_2_0 == var_2_1.FOLLOWER_OP_DEL then
					local var_2_2 = var_1_4

					var_2_0.DelFollower(var_2_2, var_1_0)

					pg = var_2_0

					local var_2_3 = var_2_0.TipsMgr.GetInstance()

					var_2_0 = var_2_0.ShowTips
					i18n = var_2_10003

					var_2_0(var_2_3, var_2_10003("island_cancel_follow_success"))
				end
			end

			local var_2_4 = arg_1_0

			var_2_0 = var_2_0.sendNotification
			GAME = var_2_10003

			var_2_0(var_2_4, var_2_10003.ISLAND_FOLLOWER_OP_DONE, var_1_0)

			if var_0.callback then
				var_0.callback()
			end
		else
			pg = var_2_0

			local var_2_5 = var_2_0.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_6(var_2_5, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
