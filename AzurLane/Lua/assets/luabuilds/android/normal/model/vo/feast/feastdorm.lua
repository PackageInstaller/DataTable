class = var_0_10000

local var_0_0 = "FeastDorm"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.Dorm.Dorm"))

var_0_1.OP_RANDOM_SHIPS = 0
var_0_1.OP_ENTER = 1
var_0_1.OP_MAKE_TICKET = 2
var_0_1.OP_GIVE_TICKET = 3
var_0_1.OP_GIVE_GIFT = 4
var_0_1.OP_INTERACTION = 5

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.refreshTime = arg_1_2.refresh_time
	arg_1_0.invitedFeastShips = {}
	ipairs = var_3

	for iter_1_0, iter_1_1 in var_3(arg_1_2.special_roles) do
		InvitedFeastShip = var_1_10008

		local var_1_0 = var_1_10008.New(iter_1_1)

		var_1_10008.SetInvitationState(var_1_0, iter_1_1.state)
		var_1_10008:SetGiftState(iter_1_1.gift)

		arg_1_0.invitedFeastShips[iter_1_1.tid] = var_1_10008
	end

	arg_1_0.feastShips = {}
	ipairs = var_3

	for iter_1_2, iter_1_3 in var_3(arg_1_2.party_roles) do
		FeastShip = var_1_10008
		var_1_10008 = var_1_10008.New(iter_1_3)

		if arg_1_0.invitedFeastShips[iter_1_3.tid] then
			var_1_10008:SetSkinId(var_9:GetSkinId())
		end

		arg_1_0.feastShips[iter_1_3.tid] = var_1_10008
	end

	return
end

function var_0_1.GetInvitedFeastShips(arg_2_0)
	return arg_2_0.invitedFeastShips
end

function var_0_1.GetInvitedFeastShipList(arg_3_0)
	local var_3_0 = arg_3_0:GetInvitedFeastShips()
	local var_3_1 = {}

	pairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(var_3_0) do
		table = var_1_10008

		var_1_10008.insert(var_3_1, iter_3_1)
	end

	table = var_3

	var_3.sort(var_3_1, function(arg_4_0, arg_4_1)
		return arg_4_0.configId < arg_4_1.configId
	end)

	return var_3_1
end

function var_0_1.GetInvitedFeastShip(arg_5_0, arg_5_1)
	return arg_5_0.invitedFeastShips[arg_5_1]
end

function var_0_1.GetFeastShipList(arg_6_0)
	return arg_6_0.feastShips
end

function var_0_1.GetFeastShip(arg_7_0, arg_7_1)
	return arg_7_0.feastShips[arg_7_1]
end

function var_0_1.RemoveShip(arg_8_0, arg_8_1)
	arg_8_0.feastShips[arg_8_1] = nil

	return
end

function var_0_1.AddShip(arg_9_0, arg_9_1)
	arg_9_0.feastShips[arg_9_1.tid] = arg_9_1

	return
end

function var_0_1.SetRefreshTime(arg_10_0, arg_10_1)
	arg_10_0.refreshTime = arg_10_1

	return
end

function var_0_1.ShouldRandomShips(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.TimeMgr.GetInstance()
	local var_11_1 = var_1.GetServerTime(var_11_0)

	if arg_11_0.refreshTime < var_11_1 then
		pg = var_2

		local var_11_2 = var_2.TimeMgr.GetInstance()
		local var_11_3

		if not (var_2.DiffDay(var_11_2, arg_11_0.refreshTime, var_11_1) > 0) then
			var_11_3 = false
		else
			var_11_3 = true
		end

		return var_11_3
	end
end

function var_0_1.GetMapSize(arg_12_0)
	local var_12_0 = 0
	local var_12_1 = 0

	BackYardConst = var_1_10003

	local var_12_2 = var_1_10003.MAX_FEAST_MAP_SIZE.x
	local var_12_3 = var_3.y

	Vector4 = var_1_10006

	return var_1_10006(var_12_0, var_12_1, var_12_2, var_12_3)
end

function var_0_1.GetPutFurnitureList(arg_13_0, arg_13_1)
	local var_13_0 = {}

	require = var_1_10003

	local var_13_1 = var_1_10003("GameCfg.backyardTheme.theme_feast")

	FeastThemeTemplate = var_4

	local var_13_2 = var_4.New
	local var_13_3 = {
		id = -1
	}
	local var_13_4

	if not var_13_1.furnitures then
		var_13_4 = {}
	end

	var_13_3.furniture_put_list = var_13_4

	if var_13_2(var_13_3, 1, arg_13_0:GetMapSize()) then
		local var_13_5 = var_4
		local var_13_6

		if not var_4.GetAllFurniture(var_13_5) then
			var_13_6 = {}
		end

		pairs = var_13_5

		for iter_13_0, iter_13_1 in var_13_5(var_13_6) do
			table = var_1_10011

			var_1_10011.insert(var_13_0, iter_13_1)
		end

		table = var_6

		local var_13_7 = var_6.sort
		local var_13_8 = var_13_0

		BackyardThemeFurniture = var_8

		var_13_7(var_13_8, var_8._LoadWeight)

		return var_13_0
	end
end

function var_0_1.GetBayShipOnFloor(arg_14_0, arg_14_1)
	local var_14_0 = {}

	pairs = var_1_10003

	for iter_14_0, iter_14_1 in var_1_10003(arg_14_0.feastShips) do
		table = var_1_10008

		var_1_10008.insert(var_14_0, iter_14_1)
	end

	return var_14_0
end

return var_0_1
