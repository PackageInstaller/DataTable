local var_0_0 = class("MiniGameProxy", import(".NetProxy"))

var_0_0.ON_HUB_DATA_UPDATE = "on hub data update"
var_0_0.ON_MINI_GAME_DATA_UPDATE = "on_mini_game_data_update"

function var_0_0.register(arg_1_0)
	arg_1_0.miniGameHubDataDic = {}
	arg_1_0.miniGameDataDic = {}

	return
end

function var_0_0.timeCall(arg_2_0)
	return {
		[ProxyRegister.DayCall] = function(arg_3_0)
			arg_2_0:sendNotification(GAME.REQUEST_MINI_GAME, {
				type = MiniGameRequestCommand.REQUEST_HUB_DATA
			})

			local var_3_0 = arg_2_0:GetMiniGameDataByType(MiniGameConst.MG_TYPE_5)

			if var_3_0 then
				arg_2_0:sendNotification(GAME.SEND_MINI_GAME_OP, {
					hubid = arg_2_0:GetHubByGameId(var_3_0.id).id,
					cmd = MiniGameOPCommand.CMD_SPECIAL_GAME,
					args1 = {
						var_3_0.id,
						1
					}
				})
			end

			return
		end
	}
end

function var_0_0.CheckHasHub(arg_4_0, arg_4_1)
	return arg_4_0.miniGameHubDataDic[arg_4_1] ~= nil
end

function var_0_0.GetMiniGameData(arg_5_0, arg_5_1)
	if arg_5_0.miniGameDataDic[arg_5_1] == nil then
		arg_5_0.miniGameDataDic[arg_5_1] = MiniGameData.New({
			id = arg_5_1
		})
	end

	return arg_5_0.miniGameDataDic[arg_5_1]
end

function var_0_0.GetMiniGameDataByType(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.miniGameDataDic) do
		if iter_6_1:getConfig("type") == arg_6_1 and iter_6_1:CheckInTime() then
			return iter_6_1
		end
	end

	return
end

function var_0_0.GetHubByHubId(arg_7_0, arg_7_1)
	if arg_7_0.miniGameHubDataDic[arg_7_1] == nil then
		arg_7_0.miniGameHubDataDic[arg_7_1] = MiniGameHubData.New({
			id = arg_7_1
		})
	end

	return arg_7_0.miniGameHubDataDic[arg_7_1]
end

function var_0_0.GetHubByGameId(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:GetMiniGameData(arg_8_1):getConfig("hub_id")

	if arg_8_0.miniGameHubDataDic[var_8_0] == nil then
		arg_8_0.miniGameHubDataDic[var_8_0] = MiniGameHubData.New({
			id = var_8_0
		})
	end

	return arg_8_0.miniGameHubDataDic[var_8_0]
end

function var_0_0.UpdataHubData(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:GetHubByHubId(arg_9_1.id)

	var_9_0:UpdateData(arg_9_1)
	arg_9_0.facade:sendNotification(var_0_0.ON_HUB_DATA_UPDATE, var_9_0)

	return
end

function var_0_0.GetHighScore(arg_10_0, arg_10_1)
	return arg_10_0:GetHubByGameId(arg_10_1).highScores[arg_10_1] or {}
end

function var_0_0.UpdataHighScore(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:GetHubByGameId(arg_11_1)
	local var_11_1 = 0

	if var_11_0.highScores[arg_11_1] and var_11_0.highScores[arg_11_1][1] then
		var_11_1 = var_11_0.highScores[arg_11_1][1]
	end

	if var_11_1 > arg_11_2[1] then
		arg_11_2[1] = var_11_1
	end

	if var_11_1 <= arg_11_2[1] then
		var_11_0.highScores[arg_11_1] = arg_11_2

		arg_11_0:UpdataHubData(var_11_0)

		for iter_11_0, iter_11_1 in ipairs(arg_11_2) do
			table.insert({
				arg_11_1
			}, iter_11_1)
		end

		arg_11_0:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = var_11_0.id,
			cmd = MiniGameOPCommand.CMD_HIGH_SCORE,
			args1 = {
				arg_11_1
			}
		})
	end

	return
end

function var_0_0.GetRank(arg_12_0, arg_12_1)
	return arg_12_0:GetMiniGameData(arg_12_1):GetRank()
end

function var_0_0.SetRank(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:GetMiniGameData(arg_13_1):SetRank(arg_13_2)

	return
end

function var_0_0.CanFetchRank(arg_14_0, arg_14_1)
	return arg_14_0:GetMiniGameData(arg_14_1):CanFetchRank()
end

function var_0_0.RequestInitData(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:GetMiniGameData(arg_15_1)
	local var_15_1 = var_15_0:getConfig("request_data") == 1

	if arg_15_2 and not var_15_1 then
		return
	end

	if var_15_0:CheckInTime() then
		local var_15_2 = var_15_0:getConfig("type")

		if (var_15_2 == MiniGameConst.MG_TYPE_2 or var_15_2 == MiniGameConst.MG_TYPE_3 or var_15_2 == MiniGameConst.MG_TYPE_5) and not var_15_0:GetRuntimeData("fetchData") then
			arg_15_0:sendNotification(GAME.SEND_MINI_GAME_OP, {
				hubid = arg_15_0:GetHubByGameId(arg_15_1).id,
				cmd = MiniGameOPCommand.CMD_SPECIAL_GAME,
				args1 = {
					var_15_0.id,
					1
				}
			})
			var_15_0:SetRuntimeData("fetchData", true)
		end
	end

	return
end

function var_0_0.remove(arg_16_0)
	return
end

return var_0_0
