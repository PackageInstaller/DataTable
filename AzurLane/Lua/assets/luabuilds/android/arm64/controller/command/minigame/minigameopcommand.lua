class = var_0_10000

local var_0_0 = "MiniGameOPCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

var_0_1.CMD_COMPLETE = 1
var_0_1.CMD_ULTIMATE = 2
var_0_1.CMD_SPECIAL_GAME = 3
var_0_1.CMD_HIGH_SCORE = 4
var_0_1.CMD_PLAY = 5
var_0_1.CMD_SPECIAL_TRACK = 100
var_0_1.CMD_SUCCESS_DATA = 101

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1:getBody().id then
		var_1_0 = 0
	end

	local var_1_1 = var_2.hubid
	local var_1_2 = var_2.cmd
	local var_1_3 = var_2.args1
	local var_1_4 = 3

	if var_1_2 == var_0_1.CMD_COMPLETE and var_1_4 > #var_1_3 then
		for iter_1_0 = #var_1_3, var_1_4 - 1 do
			table = var_1_10012

			var_1_10012.insert(var_1_3, 0)
		end

		if var_1_0 and var_1_0 > 0 then
			var_1_3[3] = var_1_0
		end
	end

	local var_1_5 = var_2.cbFunc

	pg = var_1_10009

	local var_1_6 = var_1_10009.ConnectionMgr.GetInstance()

	var_9.Send(var_1_6, 26103, {
		hubid = var_1_1,
		cmd = var_1_2,
		args1 = var_1_3
	}, 26104, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2_0
			MiniGameProxy = var_2_10003
			var_2_0 = var_2_0(var_2_10003)

			if arg_2_0.hub.id > 0 then
				var_2_0:UpdataHubData(arg_2_0.hub)
			end

			if arg_2_0.data.id > 0 then
				MiniGameDataCreator = var_2

				var_2.DataCreateFunc(var_1_2, var_1_3, arg_2_0.data.datas, arg_2_0.data.date1_key_value_list)
			end

			PlayerConst = var_2

			local var_2_1 = var_2.addTranDrop(arg_2_0.award_list)

			if var_1_2 == var_0_1.CMD_COMPLETE then
				var_2_10006 = var_2_0:GetHubByHubId(var_1_1)

				if var_3.getConfig(var_2_10006, "reward_target") ~= "" and var_4 ~= 0 then
					local var_2_2 = {
						count = 1
					}

					DROP_TYPE_VITEM = var_2_10006
					var_2_2.type = var_2_10006
					var_2_2.id = var_4
					table = var_2_10006

					var_2_10006.insert(var_2_1, var_2_2)
				end
			end

			local var_2_3 = arg_1_0
			local var_2_4 = var_3.sendNotification

			GAME = var_2_10006

			var_2_4(var_2_3, var_2_10006.SEND_MINI_GAME_OP_DONE, {
				awards = var_2_1,
				hubid = var_1_1,
				cmd = var_1_2,
				argList = var_1_3
			})
		else
			pg = var_2_0

			local var_2_5 = var_2_0.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_5, "mini game Error : " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
