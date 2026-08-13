class = var_0_10000

local var_0_0 = "MiniGameProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

var_0_1.ON_HUB_DATA_UPDATE = "on hub data update"
var_0_1.ON_MINI_GAME_DATA_UPDATE = "on_mini_game_data_update"

function var_0_1.register(arg_1_0)
	arg_1_0.miniGameHubDataDic = {}
	arg_1_0.miniGameDataDic = {}

	return
end

function var_0_1.timeCall(arg_2_0)
	local var_2_0 = {}

	ProxyRegister = var_1_10002
	var_2_0[var_1_10002.DayCall] = function(arg_3_0)
		local var_3_0 = arg_2_0
		local var_3_1 = var_1.sendNotification

		GAME = var_2_10003

		local var_3_2 = var_2_10003.REQUEST_MINI_GAME
		local var_3_3 = {}

		MiniGameRequestCommand = var_2_10005
		var_3_3.type = var_2_10005.REQUEST_HUB_DATA

		var_3_1(var_3_0, var_3_2, var_3_3)

		local var_3_4 = arg_2_0
		local var_3_5 = var_1.GetMiniGameDataByType

		MiniGameConst = var_3_2

		if var_3_5(var_3_4, var_3_2.MG_TYPE_5) then
			local var_3_6 = var_1.id
			local var_3_7 = arg_2_0
			local var_3_8 = var_3.GetHubByGameId(var_3_7, var_3_6).id
			local var_3_9 = arg_2_0
			local var_3_10 = var_4.sendNotification

			GAME = var_2_10006

			local var_3_11 = var_2_10006.SEND_MINI_GAME_OP
			local var_3_12 = {
				hubid = var_3_8
			}

			MiniGameOPCommand = var_2_10008
			var_3_12.cmd = var_2_10008.CMD_SPECIAL_GAME
			var_3_12.args1 = {
				var_3_6,
				1
			}

			var_3_10(var_3_9, var_3_11, var_3_12)
		end

		return
	end

	return var_2_0
end

function var_0_1.CheckHasHub(arg_4_0, arg_4_1)
	return arg_4_0.miniGameHubDataDic[arg_4_1] ~= nil
end

function var_0_1.GetMiniGameData(arg_5_0, arg_5_1)
	if arg_5_0.miniGameDataDic[arg_5_1] == nil then
		local var_5_0 = {
			id = arg_5_1
		}
		local var_5_1 = arg_5_0.miniGameDataDic

		MiniGameData = var_1_10004
		var_5_1[arg_5_1] = var_1_10004.New(var_5_0)
	end

	return arg_5_0.miniGameDataDic[arg_5_1]
end

function var_0_1.GetMiniGameDataByType(arg_6_0, arg_6_1)
	pairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.miniGameDataDic) do
		if iter_6_1:getConfig("type") == arg_6_1 and iter_6_1:CheckInTime() then
			return iter_6_1
		end
	end

	return
end

function var_0_1.GetHubByHubId(arg_7_0, arg_7_1)
	if arg_7_0.miniGameHubDataDic[arg_7_1] == nil then
		local var_7_0 = {
			id = arg_7_1
		}
		local var_7_1 = arg_7_0.miniGameHubDataDic

		MiniGameHubData = var_1_10004
		var_7_1[arg_7_1] = var_1_10004.New(var_7_0)
	end

	return arg_7_0.miniGameHubDataDic[arg_7_1]
end

function var_0_1.GetHubByGameId(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:GetMiniGameData(arg_8_1)
	local var_8_1 = var_2.getConfig(var_8_0, "hub_id")

	if arg_8_0.miniGameHubDataDic[var_8_1] == nil then
		local var_8_2 = {
			id = var_8_1
		}
		local var_8_3 = arg_8_0.miniGameHubDataDic

		MiniGameHubData = var_1_10006
		var_8_3[var_8_1] = var_1_10006.New(var_8_2)
	end

	return arg_8_0.miniGameHubDataDic[var_8_1]
end

function var_0_1.UpdataHubData(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.id
	local var_9_1 = arg_9_0:GetHubByHubId(var_9_0)

	var_3.UpdateData(var_9_1, arg_9_1)

	local var_9_2 = arg_9_0.facade

	var_4.sendNotification(var_9_2, var_0_1.ON_HUB_DATA_UPDATE, var_3)

	return
end

function var_0_1.GetHighScore(arg_10_0, arg_10_1)
	local var_10_0

	if not arg_10_0:GetHubByGameId(arg_10_1).highScores[arg_10_1] then
		var_10_0 = {}
	end

	return var_10_0
end

function var_0_1.UpdataHighScore(arg_11_0, arg_11_1, arg_11_2)
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

		local var_11_2 = arg_11_0

		arg_11_0.UpdataHubData(var_11_2, var_11_0)

		local var_11_3 = {
			arg_11_1
		}

		ipairs = var_11_2

		for iter_11_0, iter_11_1 in var_11_2(arg_11_2) do
			table = var_1_10011

			var_1_10011.insert(var_11_3, iter_11_1)
		end

		local var_11_4 = arg_11_0
		local var_11_5 = arg_11_0.sendNotification

		GAME = var_8

		local var_11_6 = var_8.SEND_MINI_GAME_OP
		local var_11_7 = {
			hubid = var_11_0.id
		}

		MiniGameOPCommand = var_10
		var_11_7.cmd = var_10.CMD_HIGH_SCORE
		var_11_7.args1 = var_11_3

		var_11_5(var_11_4, var_11_6, var_11_7)
	end

	return
end

function var_0_1.GetRank(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:GetMiniGameData(arg_12_1)

	return var_2.GetRank(var_12_0)
end

function var_0_1.SetRank(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:GetMiniGameData(arg_13_1)

	var_3.SetRank(var_13_0, arg_13_2)

	return
end

function var_0_1.CanFetchRank(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetMiniGameData(arg_14_1)

	return var_2.CanFetchRank(var_14_0)
end

function var_0_1.RequestInitData(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:GetMiniGameData(arg_15_1)
	local var_15_1 = var_3.getConfig(var_15_0, "request_data") == 1

	if arg_15_2 and not var_15_1 then
		return
	end

	if var_3:CheckInTime() then
		local var_15_2 = arg_15_0:GetHubByGameId(arg_15_1)
		local var_15_3 = var_3
		local var_15_4 = var_3.getConfig(var_15_3, "type")

		MiniGameConst = var_15_3

		if var_15_4 ~= var_15_3.MG_TYPE_2 then
			MiniGameConst = var_7

			if var_15_4 ~= var_7.MG_TYPE_3 then
				MiniGameConst = var_7

				if var_15_4 == var_7.MG_TYPE_5 then
					if not var_3:GetRuntimeData("fetchData") then
						local var_15_5 = arg_15_0
						local var_15_6 = arg_15_0.sendNotification

						GAME = var_1_10010

						local var_15_7 = var_1_10010.SEND_MINI_GAME_OP
						local var_15_8 = {
							hubid = var_15_2.id
						}

						MiniGameOPCommand = var_12
						var_15_8.cmd = var_12.CMD_SPECIAL_GAME
						var_15_8.args1 = {
							var_3.id,
							1
						}

						var_15_6(var_15_5, var_15_7, var_15_8)
						var_3:SetRuntimeData("fetchData", true)
					end
				end

				return
			end
		end
	end
end

function var_0_1.remove(arg_16_0)
	return
end

return var_0_1
