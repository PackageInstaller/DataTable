local var_0_0 = class("FeastDorm", import("model.vo.Dorm.Dorm"))

var_0_0.OP_RANDOM_SHIPS = 0
var_0_0.OP_ENTER = 1
var_0_0.OP_MAKE_TICKET = 2
var_0_0.OP_GIVE_TICKET = 3
var_0_0.OP_GIVE_GIFT = 4
var_0_0.OP_INTERACTION = 5

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.refreshTime = arg_1_2.refresh_time
	arg_1_0.invitedFeastShips = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_2.special_roles) do
		local var_1_0 = InvitedFeastShip.New(iter_1_1)

		var_1_0:SetInvitationState(iter_1_1.state)
		var_1_0:SetGiftState(iter_1_1.gift)

		arg_1_0.invitedFeastShips[iter_1_1.tid] = var_1_0
	end

	arg_1_0.feastShips = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_2.party_roles) do
		local var_1_1 = FeastShip.New(iter_1_3)

		if arg_1_0.invitedFeastShips[iter_1_3.tid] then
			var_1_1:SetSkinId(arg_1_0.invitedFeastShips[iter_1_3.tid]:GetSkinId())
		end

		arg_1_0.feastShips[iter_1_3.tid] = var_1_1
	end

	return
end

function var_0_0.GetInvitedFeastShips(arg_2_0)
	return arg_2_0.invitedFeastShips
end

function var_0_0.GetInvitedFeastShipList(arg_3_0)
	for iter_3_0, iter_3_1 in pairs((arg_3_0:GetInvitedFeastShips())) do
		table.insert({}, iter_3_1)
	end

	table.sort({}, function(arg_4_0, arg_4_1)
		return arg_4_0.configId < arg_4_1.configId
	end)

	return {}
end

function var_0_0.GetInvitedFeastShip(arg_5_0, arg_5_1)
	return arg_5_0.invitedFeastShips[arg_5_1]
end

function var_0_0.GetFeastShipList(arg_6_0)
	return arg_6_0.feastShips
end

function var_0_0.GetFeastShip(arg_7_0, arg_7_1)
	return arg_7_0.feastShips[arg_7_1]
end

function var_0_0.RemoveShip(arg_8_0, arg_8_1)
	arg_8_0.feastShips[arg_8_1] = nil

	return
end

function var_0_0.AddShip(arg_9_0, arg_9_1)
	arg_9_0.feastShips[arg_9_1.tid] = arg_9_1

	return
end

function var_0_0.SetRefreshTime(arg_10_0, arg_10_1)
	arg_10_0.refreshTime = arg_10_1

	return
end

function var_0_0.ShouldRandomShips(arg_11_0)
	local var_11_0 = pg.TimeMgr.GetInstance():GetServerTime()

	if var_11_0 > arg_11_0.refreshTime then
		local var_11_1 = pg.TimeMgr.GetInstance():DiffDay(arg_11_0.refreshTime, var_11_0) > 0

		return var_11_1
	end
end

function var_0_0.GetMapSize(arg_12_0)
	return Vector4(0, 0, BackYardConst.MAX_FEAST_MAP_SIZE.x, BackYardConst.MAX_FEAST_MAP_SIZE.y)
end

function var_0_0.GetPutFurnitureList(arg_13_0, arg_13_1)
	({
		id = -1
	}).furniture_put_list = require("GameCfg.backyardTheme.theme_feast").furnitures or {}

	local var_13_0 = FeastThemeTemplate.New({
		id = -1
	}, 1, arg_13_0:GetMapSize())
	local var_13_1 = var_13_0 and var_13_0:GetAllFurniture() or {}

	for iter_13_0, iter_13_1 in pairs(var_13_1) do
		table.insert({}, iter_13_1)
	end

	table.sort({}, BackyardThemeFurniture._LoadWeight)

	return {}
end

function var_0_0.GetBayShipOnFloor(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.feastShips) do
		table.insert({}, iter_14_1)
	end

	return {}
end

return var_0_0
