local IslandVisitorAgency = class("IslandVisitorAgency", import(".IslandBaseAgency"))

IslandVisitorAgency.PLAYER_ADD = "IslandVisitorAgency:PLAYER_ADD"
IslandVisitorAgency.PLAYER_EXIT = "IslandVisitorAgency:PLAYER_EXIT"
IslandVisitorAgency.CHANGE_PLAYER_DRESS = "IslandVisitorAgency:CHANGE_DRESS"
IslandVisitorAgency.VISITOR_ADD = "IslandVisitorAgency:VISITOR_ADD"
IslandVisitorAgency.VISITOR_EXIT = "IslandVisitorAgency:VISITOR_EXIT"

function IslandVisitorAgency:OnInit(arg_1_1)
	self.playerList = {}

	return
end

function IslandVisitorAgency:SetPlayerList(arg_2_1)
	self.playerList = arg_2_1

	return
end

function IslandVisitorAgency:GetPlayerList()
	return self.playerList
end

function IslandVisitorAgency:DeletePlayer(arg_4_1)
	self.playerList[arg_4_1] = nil

	self:DispatchEvent(IslandVisitorAgency.PLAYER_EXIT, {
		id = arg_4_1
	})

	return
end

function IslandVisitorAgency:AddPlayer(arg_5_1)
	self.playerList[arg_5_1.id] = arg_5_1

	self:DispatchEvent(IslandVisitorAgency.PLAYER_ADD, {
		player = arg_5_1
	})

	return
end

function IslandVisitorAgency:GetPlayer(arg_6_1)
	return self.playerList[arg_6_1]
end

function IslandVisitorAgency:InitMapVisitorList(arg_7_1)
	self.mapVisitorList = {}

	for iter_7_0, iter_7_1 in pairs(self.playerList) do
		if iter_7_1:IsInMap(arg_7_1) or iter_7_1:IsSelf() then
			self.mapVisitorList[iter_7_1.id] = iter_7_1
		end
	end

	return
end

function IslandVisitorAgency:SetMapVisitorList(arg_8_1)
	self.mapVisitorList = arg_8_1

	return
end

function IslandVisitorAgency:GetMapVisitorList()
	return self.mapVisitorList
end

function IslandVisitorAgency:AddMapVisitor(arg_10_1)
	self.mapVisitorList[arg_10_1.id] = arg_10_1

	self:DispatchEvent(IslandVisitorAgency.VISITOR_ADD, {
		player = arg_10_1
	})

	return
end

function IslandVisitorAgency:DeleteMapVisitor(arg_11_1)
	self.mapVisitorList[arg_11_1] = nil

	self:DispatchEvent(IslandVisitorAgency.VISITOR_EXIT, {
		id = arg_11_1
	})

	return
end

function IslandVisitorAgency:ChangeDress(arg_12_1)
	self:ChangePlayerDressData(arg_12_1)
	self:DispatchEvent(IslandVisitorAgency.CHANGE_PLAYER_DRESS, arg_12_1)

	return
end

function IslandVisitorAgency:ChangePlayerDressData(arg_13_1)
	for iter_13_0, iter_13_1 in pairs(self.playerList) do
		if iter_13_1:IsSelf() then
			for iter_13_2, iter_13_3 in pairs(arg_13_1) do
				iter_13_1:ChangeDressUpByType(iter_13_2, iter_13_3.currentItemId)
			end
		end
	end

	return
end

function IslandVisitorAgency:GetPlayerDressData()
	for iter_14_0, iter_14_1 in pairs(self.playerList) do
		if iter_14_1:IsSelf() then
			return iter_14_1:GetDressupData()
		end
	end

	return {}
end

function IslandVisitorAgency:GetVisitorCnt()
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in pairs(self.playerList) do
		if not iter_15_1:IsSelf() then
			var_15_0 = var_15_0 + 1
		end
	end

	return var_15_0
end

return IslandVisitorAgency
