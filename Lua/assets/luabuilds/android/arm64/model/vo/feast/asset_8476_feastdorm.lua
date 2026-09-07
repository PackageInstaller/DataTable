local FeastDorm = class("FeastDorm", import("model.vo.Dorm.Dorm"))

FeastDorm.OP_RANDOM_SHIPS = 0
FeastDorm.OP_ENTER = 1
FeastDorm.OP_MAKE_TICKET = 2
FeastDorm.OP_GIVE_TICKET = 3
FeastDorm.OP_GIVE_GIFT = 4
FeastDorm.OP_INTERACTION = 5

function FeastDorm:Ctor(arg_1_1, arg_1_2)
	FeastDorm.super.Ctor(self, arg_1_1)

	self.refreshTime = arg_1_2.refresh_time
	self.invitedFeastShips = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_2.special_roles) do
		local var_1_0 = InvitedFeastShip.New(iter_1_1)

		var_1_0:SetInvitationState(iter_1_1.state)
		var_1_0:SetGiftState(iter_1_1.gift)

		self.invitedFeastShips[iter_1_1.tid] = var_1_0
	end

	self.feastShips = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_2.party_roles) do
		local var_1_1 = FeastShip.New(iter_1_3)

		if self.invitedFeastShips[iter_1_3.tid] then
			var_1_1:SetSkinId(self.invitedFeastShips[iter_1_3.tid]:GetSkinId())
		end

		self.feastShips[iter_1_3.tid] = var_1_1
	end

	return
end

function FeastDorm:GetInvitedFeastShips()
	return self.invitedFeastShips
end

function FeastDorm:GetInvitedFeastShipList()
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs((self:GetInvitedFeastShips())) do
		table.insert(var_3_0, iter_3_1)
	end

	table.sort(var_3_0, function(arg_4_0, arg_4_1)
		return arg_4_0.configId < arg_4_1.configId
	end)

	return var_3_0
end

function FeastDorm:GetInvitedFeastShip(arg_5_1)
	return self.invitedFeastShips[arg_5_1]
end

function FeastDorm:GetFeastShipList()
	return self.feastShips
end

function FeastDorm:GetFeastShip(arg_7_1)
	return self.feastShips[arg_7_1]
end

function FeastDorm:RemoveShip(arg_8_1)
	self.feastShips[arg_8_1] = nil

	return
end

function FeastDorm:AddShip(arg_9_1)
	self.feastShips[arg_9_1.tid] = arg_9_1

	return
end

function FeastDorm:SetRefreshTime(arg_10_1)
	self.refreshTime = arg_10_1

	return
end

function FeastDorm:ShouldRandomShips()
	local var_11_0 = pg.TimeMgr.GetInstance():GetServerTime()
	local var_11_1

	if var_11_0 > self.refreshTime then
		if pg.TimeMgr.GetInstance():DiffDay(self.refreshTime, var_11_0) <= 0 then
			var_11_1 = false

			goto label_11_0
		end
	end

	::label_11_0::

	return true
end

function FeastDorm:GetMapSize()
	return Vector4(0, 0, BackYardConst.MAX_FEAST_MAP_SIZE.x, BackYardConst.MAX_FEAST_MAP_SIZE.y)
end

function FeastDorm:GetPutFurnitureList(arg_13_1)
	local var_13_0 = {}
	local var_13_1 = {
		id = -1
	}

	var_13_1.furniture_put_list = require("GameCfg.backyardTheme.theme_feast").furnitures or {}

	local var_13_2 = FeastThemeTemplate.New(var_13_1, 1, self:GetMapSize())

	for iter_13_0, iter_13_1 in pairs(var_13_2 and var_13_2:GetAllFurniture() or {}) do
		table.insert(var_13_0, iter_13_1)
	end

	table.sort(var_13_0, BackyardThemeFurniture._LoadWeight)

	return var_13_0
end

function FeastDorm:GetBayShipOnFloor(arg_14_1)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(self.feastShips) do
		table.insert(var_14_0, iter_14_1)
	end

	return var_14_0
end

return FeastDorm
