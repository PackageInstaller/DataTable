local var_0_0 = class("MiniGameOPCommand", pm.SimpleCommand)

var_0_0.CMD_COMPLETE = 1
var_0_0.CMD_ULTIMATE = 2
var_0_0.CMD_SPECIAL_GAME = 3
var_0_0.CMD_HIGH_SCORE = 4
var_0_0.CMD_PLAY = 5
var_0_0.CMD_SPECIAL_TRACK = 100
var_0_0.CMD_SUCCESS_DATA = 101

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id or 0
	local var_1_2 = var_1_0.hubid
	local var_1_3 = var_1_0.cmd
	local var_1_4 = var_1_0.args1

	if var_1_0.cmd == var_0_0.CMD_COMPLETE and 3 > #var_1_0.args1 then
		for iter_1_0 = #var_1_0.args1, 3 - 1 do
			table.insert(var_1_0.args1, 0)
		end

		if var_1_1 and var_1_1 > 0 then
			var_1_0.args1[3] = var_1_1
		end
	end

	pg.ConnectionMgr.GetInstance():Send(26103, {
		hubid = var_1_2,
		cmd = var_1_0.cmd,
		args1 = var_1_0.args1
	}, 26104, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(MiniGameProxy)

			if arg_2_0.hub.id > 0 then
				var_2_0:UpdataHubData(arg_2_0.hub)
			end

			if arg_2_0.data.id > 0 then
				MiniGameDataCreator.DataCreateFunc(var_1_3, var_1_4, arg_2_0.data.datas, arg_2_0.data.date1_key_value_list)
			end

			local var_2_1 = PlayerConst.addTranDrop(arg_2_0.award_list)

			if var_1_3 == var_0_0.CMD_COMPLETE then
				local var_2_2 = var_2_0:GetHubByHubId(var_1_2):getConfig("reward_target")

				if var_2_2 ~= "" and var_2_2 ~= 0 then
					table.insert(var_2_1, {
						count = 1,
						type = DROP_TYPE_VITEM,
						id = var_2_2
					})
				end
			end

			arg_1_0:sendNotification(GAME.SEND_MINI_GAME_OP_DONE, {
				awards = var_2_1,
				hubid = var_1_2,
				cmd = var_1_3,
				argList = var_1_4
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("mini game Error : " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
