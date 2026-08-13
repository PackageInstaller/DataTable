class = var_0_10000

local var_0_0 = "ModifyGuildInfoCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)
	local var_1_2 = var_3.getData(var_1_1)

	pg = var_1_10005

	local var_1_3 = var_1_10005.gameset.modify_guild_cost.key_value

	type = var_1_1

	if var_1_1 == 1 and var_1_2:getTotalGem() < var_1_3 then
		pg = var_6

		local var_1_4 = var_6.TipsMgr.GetInstance()
		local var_1_5 = var_6.ShowTips

		i18n = var_1_10009

		var_1_5(var_1_4, var_1_10009("common_no_rmb"))

		return
	end

	local function var_1_6()
		pg = var_2_10000

		local var_2_0 = var_2_10000.ConnectionMgr.GetInstance()

		var_0.Send(var_2_0, 60026, {
			type = var_1_0.type,
			int = var_1_0.int,
			str = var_1_0.string
		}, 60027, function(arg_3_0)
			local var_3_3

			if arg_3_0.result == 0 then
				if var_1_0.type == 1 then
					local var_3_0 = var_1_2

					var_3_3.consume(var_3_0, {
						gem = var_1_3
					})

					local var_3_1 = var_0

					var_3_3.updatePlayer(var_3_1, var_1_2)
				end

				local var_3_2 = arg_1_0

				var_3_3 = var_3_3.sendNotification
				GAME = var_3_10004

				var_3_3(var_3_2, var_3_10004.MODIFY_GUILD_INFO_DONE)

				pg = var_3_3

				local var_3_4 = var_3_3.TipsMgr.GetInstance()

				var_3_3 = var_3_3.ShowTips
				i18n = var_3_10004

				var_3_3(var_3_4, var_3_10004("guild_info_update"))
			else
				pg = var_3_3

				local var_3_5 = var_3_3.TipsMgr.GetInstance()
				local var_3_6 = var_1.ShowTips

				errorTip = var_3_10004

				var_3_6(var_3_5, var_3_10004("guild_modify_erro", arg_3_0.result))
			end

			return
		end)

		return
	end

	if var_1_0.type == 1 then
		pg = var_7

		local var_1_7 = var_7.MsgboxMgr.GetInstance()
		local var_1_8 = var_7.ShowMsgBox
		local var_1_9 = {}

		i18n = var_1_10011
		var_1_9.content = var_1_10011("guild_modify_info_tip", var_1_3)

		function var_1_9.onYes()
			var_1_6()

			return
		end

		var_1_8(var_1_7, var_1_9)
	else
		var_1_6()
	end

	return
end

return var_0_1
