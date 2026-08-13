class = var_0_10000

local var_0_0 = "ModifyGuildInfoCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	PlayerProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)
	local var_1_3 = var_3.getData(var_1_2)

	pg = var_1_2

	local var_1_4 = var_1_2.gameset.modify_guild_cost.key_value

	type = var_1_10006

	if var_1_10006 == 1 and var_1_3:getTotalGem() < var_1_4 then
		pg = var_6

		local var_1_5 = var_6.TipsMgr.GetInstance()
		local var_1_6 = var_6.ShowTips

		i18n = var_1_10008

		var_1_6(var_1_5, var_1_10008("common_no_rmb"))

		return
	end

	local function var_1_7()
		pg = var_2_10000

		local var_2_0 = var_2_10000.ConnectionMgr.GetInstance()

		var_0.Send(var_2_0, 60026, {
			type = var_1_1.type,
			int = var_1_1.int,
			str = var_1_1.string
		}, 60027, function(arg_3_0)
			local var_3_3

			if arg_3_0.result == 0 then
				if var_1_1.type == 1 then
					local var_3_0 = var_1_3

					var_3_3.consume(var_3_0, {
						gem = var_1_4
					})

					local var_3_1 = var_0

					var_3_3.updatePlayer(var_3_1, var_1_3)
				end

				local var_3_2 = arg_1_0

				var_3_3 = var_3_3.sendNotification
				GAME = var_3_10003

				var_3_3(var_3_2, var_3_10003.MODIFY_GUILD_INFO_DONE)

				pg = var_3_3

				local var_3_4 = var_3_3.TipsMgr.GetInstance()

				var_3_3 = var_3_3.ShowTips
				i18n = var_3_10003

				var_3_3(var_3_4, var_3_10003("guild_info_update"))
			else
				pg = var_3_3

				local var_3_5 = var_3_3.TipsMgr.GetInstance()
				local var_3_6 = var_1.ShowTips

				errorTip = var_3_10003

				var_3_6(var_3_5, var_3_10003("guild_modify_erro", arg_3_0.result))
			end

			return
		end)

		return
	end

	if var_1_1.type == 1 then
		pg = var_7

		local var_1_8 = var_7.MsgboxMgr.GetInstance()
		local var_1_9 = var_7.ShowMsgBox
		local var_1_10 = {}

		i18n = var_1_10010
		var_1_10.content = var_1_10010("guild_modify_info_tip", var_1_4)

		function var_1_10.onYes()
			var_1_7()

			return
		end

		var_1_9(var_1_8, var_1_10)
	else
		var_1_7()
	end

	return
end

return var_0_1
