local GuildAssaultFleet = class("GuildAssaultFleet", import("..BaseVO"))

function GuildAssaultFleet:GetRealId()
	return tonumber(string.split(tostring(self), "_")[1])
end

function GuildAssaultFleet:GetUserId()
	return tonumber(string.split(tostring(self), "_")[2])
end

function GuildAssaultFleet:GetVirtualId(arg_3_1)
	return arg_3_1 .. "_" .. self
end

function GuildAssaultFleet:IsSameUserId(arg_4_1)
	return GuildAssaultFleet.GetUserId(self) == GuildAssaultFleet.GetUserId(arg_4_1)
end

function GuildAssaultFleet:Ctor(arg_5_1)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.ships or {}) do
		var_5_0[iter_5_0] = GuildAssaultShip.New(iter_5_1)
	end

	self:InitShips(arg_5_1.user_id, var_5_0)

	return
end

function GuildAssaultFleet:InitShips(arg_6_1, arg_6_2)
	self.ships = {}
	self.userId = arg_6_1

	for iter_6_0, iter_6_1 in pairs(arg_6_2) do
		iter_6_1.id = GuildAssaultFleet.GetVirtualId(self.userId, iter_6_1.id)
		self.ships[iter_6_0] = iter_6_1
	end

	return
end

function GuildAssaultFleet:ClearAllRecommandShip()
	for iter_7_0, iter_7_1 in ipairs(self.ships) do
		self:MarkShipBeRecommanded(iter_7_1, false)
	end

	return
end

function GuildAssaultFleet:SetRecommendList(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(self.ships) do
		local var_8_0 = GuildAssaultFleet.GetRealId(iter_8_1.id)

		if _.any(arg_8_1, function(arg_9_0)
			return arg_9_0 == var_8_0
		end) then
			self:MarkShipBeRecommanded(iter_8_1, true)
		end
	end

	return
end

function GuildAssaultFleet:MarkShipBeRecommanded(arg_10_1, arg_10_2)
	arg_10_1.guildRecommand = arg_10_2

	return
end

function GuildAssaultFleet:SetShipBeRecommanded(arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in ipairs(self.ships) do
		if arg_11_1 == GuildAssaultFleet.GetRealId(iter_11_1.id) then
			self:MarkShipBeRecommanded(iter_11_1, arg_11_2)

			break
		end
	end

	return
end

function GuildAssaultFleet:GetStrongestShip(arg_12_1)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(self.ships) do
		if iter_12_1:getTeamType() == arg_12_1 then
			table.insert(var_12_0, iter_12_1)
		end
	end

	table.sort(var_12_0, function(arg_13_0, arg_13_1)
		return arg_13_0.level > arg_13_1.level
	end)

	return var_12_0[1]
end

function GuildAssaultFleet:GetShipList()
	return self.ships
end

function GuildAssaultFleet:IsEmpty()
	return table.getCount(self.ships) == 0
end

function GuildAssaultFleet:ExistShip(arg_16_1)
	for iter_16_0, iter_16_1 in pairs(self.ships) do
		if arg_16_1 == iter_16_1.id then
			return true
		end
	end

	return false
end

function GuildAssaultFleet:GetShipIds()
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs(self.ships) do
		table.insert(var_17_0, iter_17_1.id)
	end

	return var_17_0
end

function GuildAssaultFleet:GetShipById(arg_18_1)
	for iter_18_0, iter_18_1 in pairs(self.ships) do
		if iter_18_1.id == arg_18_1 then
			return iter_18_1
		end
	end

	return
end

function GuildAssaultFleet:GetShipByRealId(arg_19_1, arg_19_2)
	local var_19_0 = GuildAssaultFleet.GetVirtualId(arg_19_1, arg_19_2)

	for iter_19_0, iter_19_1 in pairs(self.ships) do
		if iter_19_1.id == var_19_0 then
			return iter_19_1
		end
	end

	return
end

function GuildAssaultFleet:GetShipByPos(arg_20_1)
	return self.ships[arg_20_1]
end

function GuildAssaultFleet:InsertBayShip(arg_21_1, arg_21_2)
	arg_21_2.id = GuildAssaultFleet.GetVirtualId(self.userId, arg_21_2.id)
	self.ships[arg_21_1] = arg_21_2

	return
end

function GuildAssaultFleet:AnyShipChanged(arg_22_1)
	for iter_22_0 = 1, 2 do
		if self:PositionIsChanged(arg_22_1, iter_22_0) then
			return true
		end
	end

	return false
end

function GuildAssaultFleet:PositionIsChanged(arg_23_1, arg_23_2)
	local var_23_0 = arg_23_1:GetShipByPos(arg_23_2)
	local var_23_1 = self:GetShipByPos(arg_23_2)

	if var_23_0 then
		if var_23_1 then
			if (var_23_0.id or 0) ~= (var_23_1.id or 0) or (function(arg_24_0, arg_24_1)
				if arg_24_0 and arg_24_1 and arg_24_0.id == arg_24_1.id then
					for iter_24_0, iter_24_1 in ipairs(arg_24_0.equipments) do
						local var_24_0 = iter_24_1 and 1 or 0

						if (iter_24_1 and 1 or 0) ~= (arg_24_1.equipments[iter_24_0] and 1 or 0) or var_24_0 == (arg_24_1.equipments[iter_24_0] and 1 or 0) and var_24_0 == 1 and iter_24_1.id ~= arg_24_1.equipments[iter_24_0].id then
							return true
						end
					end
				end

				return false
			end)(var_23_0, var_23_1) then
				return true
			end
		end
	end

	return false
end

return GuildAssaultFleet
