local IslandFollowerAgency = class("IslandFollowerAgency", import(".IslandBaseAgency"))

IslandFollowerAgency.ADD_FOLLOWER = "IslandFollowerAgency:ADD_FOLLOWER"
IslandFollowerAgency.DEL_FOLLOWER = "IslandFollowerAgency:DEL_FOLLOWER"

function IslandFollowerAgency:OnInit(arg_1_1)
	self.followers = {}

	return
end

function IslandFollowerAgency:InitPrivateData(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.follow_ships) do
		table.insert(self.followers, iter_2_1)
	end

	self.maxCnt = pg.island_set.max_follower_cnt.key_value_int

	return
end

function IslandFollowerAgency:GetFollowers()
	return self.followers
end

function IslandFollowerAgency:AddFollower(arg_4_1)
	if not self:Following(arg_4_1) then
		table.insert(self.followers, arg_4_1)
		self:DispatchEvent(IslandFollowerAgency.ADD_FOLLOWER, arg_4_1)
	end

	return
end

function IslandFollowerAgency:DelFollower(arg_5_1)
	if self:Following(arg_5_1) then
		table.removebyvalue(self.followers, arg_5_1)
		self:DispatchEvent(IslandFollowerAgency.DEL_FOLLOWER, arg_5_1)
	end

	return
end

function IslandFollowerAgency:Following(arg_6_1)
	return table.contains(self.followers, arg_6_1)
end

function IslandFollowerAgency:ReachMaxCnt()
	return #self.followers >= self.maxCnt
end

return IslandFollowerAgency
