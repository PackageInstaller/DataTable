class = var_0_10000

local var_0_0 = "IslandVisitorAgency"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseAgency"))

var_0_1.PLAYER_ADD = "IslandVisitorAgency:PLAYER_ADD"
var_0_1.PLAYER_EXIT = "IslandVisitorAgency:PLAYER_EXIT"
var_0_1.CHANGE_PLAYER_DRESS = "IslandVisitorAgency:CHANGE_DRESS"
var_0_1.VISITOR_ADD = "IslandVisitorAgency:VISITOR_ADD"
var_0_1.VISITOR_EXIT = "IslandVisitorAgency:VISITOR_EXIT"

function var_0_1.OnInit(arg_1_0, arg_1_1)
	arg_1_0.playerList = {}

	return
end

function var_0_1.SetPlayerList(arg_2_0, arg_2_1)
	arg_2_0.playerList = arg_2_1

	return
end

function var_0_1.GetPlayerList(arg_3_0)
	return arg_3_0.playerList
end

function var_0_1.DeletePlayer(arg_4_0, arg_4_1)
	arg_4_0.playerList[arg_4_1] = nil

	arg_4_0:DispatchEvent(var_0_1.PLAYER_EXIT, {
		id = arg_4_1
	})

	return
end

function var_0_1.AddPlayer(arg_5_0, arg_5_1)
	arg_5_0.playerList[arg_5_1.id] = arg_5_1

	arg_5_0:DispatchEvent(var_0_1.PLAYER_ADD, {
		player = arg_5_1
	})

	return
end

function var_0_1.GetPlayer(arg_6_0, arg_6_1)
	return arg_6_0.playerList[arg_6_1]
end

function var_0_1.InitMapVisitorList(arg_7_0, arg_7_1)
	arg_7_0.mapVisitorList = {}
	pairs = var_2

	for iter_7_0, iter_7_1 in var_2(arg_7_0.playerList) do
		if iter_7_1:IsInMap(arg_7_1) or iter_7_1:IsSelf() then
			arg_7_0.mapVisitorList[iter_7_1.id] = iter_7_1
		end
	end

	return
end

function var_0_1.SetMapVisitorList(arg_8_0, arg_8_1)
	arg_8_0.mapVisitorList = arg_8_1

	return
end

function var_0_1.GetMapVisitorList(arg_9_0)
	return arg_9_0.mapVisitorList
end

function var_0_1.AddMapVisitor(arg_10_0, arg_10_1)
	arg_10_0.mapVisitorList[arg_10_1.id] = arg_10_1

	arg_10_0:DispatchEvent(var_0_1.VISITOR_ADD, {
		player = arg_10_1
	})

	return
end

function var_0_1.DeleteMapVisitor(arg_11_0, arg_11_1)
	arg_11_0.mapVisitorList[arg_11_1] = nil

	arg_11_0:DispatchEvent(var_0_1.VISITOR_EXIT, {
		id = arg_11_1
	})

	return
end

function var_0_1.ChangeDress(arg_12_0, arg_12_1)
	arg_12_0:ChangePlayerDressData(arg_12_1)
	arg_12_0:DispatchEvent(var_0_1.CHANGE_PLAYER_DRESS, arg_12_1)

	return
end

function var_0_1.ChangePlayerDressData(arg_13_0, arg_13_1)
	pairs = var_1_10002

	for iter_13_0, iter_13_1 in var_1_10002(arg_13_0.playerList) do
		if iter_13_1:IsSelf() then
			pairs = var_7

			for iter_13_2, iter_13_3 in var_7(arg_13_1) do
				iter_13_1:ChangeDressUpByType(iter_13_2, iter_13_3.currentItemId)
			end
		end
	end

	return
end

function var_0_1.GetPlayerDressData(arg_14_0)
	pairs = var_1_10001

	for iter_14_0, iter_14_1 in var_1_10001(arg_14_0.playerList) do
		if iter_14_1:IsSelf() then
			return iter_14_1:GetDressupData()
		end
	end

	return {}
end

function var_0_1.GetVisitorCnt(arg_15_0)
	local var_15_0 = 0

	pairs = var_1_10002

	for iter_15_0, iter_15_1 in var_1_10002(arg_15_0.playerList) do
		if not iter_15_1:IsSelf() then
			var_15_0 = var_15_0 + 1
		end
	end

	return var_15_0
end

return var_0_1
