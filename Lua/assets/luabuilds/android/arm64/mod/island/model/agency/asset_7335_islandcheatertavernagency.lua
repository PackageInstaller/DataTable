local IslandCheaterTavernAgency = class("IslandCheaterTavernAgency", import(".IslandBaseAgency"))

function IslandCheaterTavernAgency:OnInit(arg_1_1)
	return
end

function IslandCheaterTavernAgency:SetIsConnecting(arg_2_1)
	self.isConnecting = arg_2_1

	return
end

function IslandCheaterTavernAgency:IsConnecting()
	return self.isConnecting
end

function IslandCheaterTavernAgency:SetUILoadOver(arg_4_1)
	self.isUILoadOver = arg_4_1

	if arg_4_1 then
		for iter_4_0, iter_4_1 in ipairs(self.cacheFunc or {}) do
			iter_4_1()
		end
	end

	self.cacheFunc = {}

	return
end

function IslandCheaterTavernAgency:IsUILoadOver()
	return self.isUILoadOver
end

function IslandCheaterTavernAgency:AddCacheFunc(arg_6_1)
	self.cacheFunc = self.cacheFunc or {}

	table.insert(self.cacheFunc, arg_6_1)

	return
end

function IslandCheaterTavernAgency:SetStartGameData(arg_7_1)
	self.player_dic = {}
	self.roomType = arg_7_1.room_type
	self.allPlayerNum = #arg_7_1.player_list
	self.curPlayerSeat = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.player_list) do
		if iter_7_1.user_id == getProxy(PlayerProxy):getRawData().id then
			self.curPlayerSeat = iter_7_1.seat
		end

		self.player_dic[iter_7_1.user_id] = IslandCheaterPlayer.New(iter_7_1)
	end

	self:SetMainPlayerCards(arg_7_1.card_list)
	self:SetRealCard(arg_7_1.real_card)

	return
end

function IslandCheaterTavernAgency:SetResetGameData(arg_8_1)
	self.player_dic = {}
	self.roomType = arg_8_1.room_type
	self.allPlayerNum = #arg_8_1.player_list + #arg_8_1.out_player_list
	self.curPlayerSeat = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_1.player_list) do
		if iter_8_1.user_id == getProxy(PlayerProxy):getRawData().id then
			self.curPlayerSeat = iter_8_1.seat
		end

		self.player_dic[iter_8_1.user_id] = IslandCheaterPlayer.New(iter_8_1)
	end

	for iter_8_2, iter_8_3 in ipairs(arg_8_1.out_player_list) do
		if iter_8_3.user_id == getProxy(PlayerProxy):getRawData().id then
			self.curPlayerSeat = iter_8_3.seat
		end

		iter_8_3.card_num = 0
		self.player_dic[iter_8_3.user_id] = IslandCheaterPlayer.New(iter_8_3)

		self.player_dic[iter_8_3.user_id]:SetOutState()
	end

	self:SetMainPlayerCards(arg_8_1.card_list)
	self:SetRealCard(arg_8_1.real_card)

	return
end

function IslandCheaterTavernAgency:GetRoomType()
	return self.roomType
end

function IslandCheaterTavernAgency:UpdateGameDataEveryRound(arg_10_1)
	self:SetMainPlayerCards(arg_10_1.card_list)
	self:SetRealCard(arg_10_1.real_card)

	for iter_10_0, iter_10_1 in pairs(self.player_dic) do
		if iter_10_1.state == 0 then
			iter_10_1.card_num = IslandCheaterTavernConst.cardNumEveryRound
		end
	end

	return
end

function IslandCheaterTavernAgency:SetMainPlayerCards(arg_11_1)
	self.cardList = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		table.insert(self.cardList, IslandCheaterCard.New(iter_11_1))
	end

	return
end

function IslandCheaterTavernAgency:GetMainPlayerCards()
	table.sort(self.cardList, function(arg_13_0, arg_13_1)
		return arg_13_0.key < arg_13_1.key
	end)

	return self.cardList
end

function IslandCheaterTavernAgency:ClearMainPlayerCards()
	self.cardList = {}

	return
end

function IslandCheaterTavernAgency:MainPlayerPutCard(arg_15_1)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_1 or {}) do
		for iter_15_2, iter_15_3 in ipairs(self.cardList) do
			if iter_15_3.key == iter_15_1 then
				table.insert(var_15_0, iter_15_2)
			end
		end
	end

	table.sort(var_15_0, function(arg_16_0, arg_16_1)
		return arg_16_1 < arg_16_0
	end)

	for iter_15_4, iter_15_5 in ipairs(var_15_0) do
		table.remove(self.cardList, iter_15_5)
	end

	return
end

function IslandCheaterTavernAgency:GetMainPlayerAutoPutCard(arg_17_1)
	local var_17_0 = {}
	local var_17_1 = self:GetMainPlayerCards()

	for iter_17_0 = 1, arg_17_1 do
		table.insert(var_17_0, var_17_1[iter_17_0].key)
	end

	return var_17_0
end

function IslandCheaterTavernAgency:SetRealCard(arg_18_1)
	self.real_card = arg_18_1

	return
end

function IslandCheaterTavernAgency:GetRealCard()
	return self.real_card
end

function IslandCheaterTavernAgency:ReducePlayerCardNum(arg_20_1, arg_20_2)
	if self.player_dic[arg_20_1] then
		self.player_dic[arg_20_1]:ReduceCardNum(arg_20_2)
	end

	return
end

function IslandCheaterTavernAgency:GetPlayerCardNum(arg_21_1)
	return self.player_dic[arg_21_1] and self.player_dic[arg_21_1]:GetCardNum() or 0
end

function IslandCheaterTavernAgency:UpdatePlayerBombState(arg_22_1, arg_22_2, arg_22_3)
	if self.player_dic[arg_22_1] then
		self.player_dic[arg_22_1]:UpdateBombState(arg_22_2)

		if arg_22_3 == 1 then
			self.player_dic[arg_22_1]:SetOutState()

			if arg_22_1 == getProxy(PlayerProxy):getRawData().id then
				self:ClearMainPlayerCards()
			end
		end
	end

	return
end

function IslandCheaterTavernAgency:UpdatePlayerDelegateState(arg_23_1, arg_23_2)
	if self.player_dic[arg_23_1] then
		self.player_dic[arg_23_1]:UpdateDelegateState(arg_23_2)
	end

	return
end

function IslandCheaterTavernAgency:GetPlayerCurrentAndAllHp(arg_24_1)
	if self.player_dic[arg_24_1] then
		return self.player_dic[arg_24_1]:GetCurrentAndAllHp()
	end

	return 0, 0
end

function IslandCheaterTavernAgency:GetMainPlayer()
	return self.player_dic[getProxy(PlayerProxy):getRawData().id]
end

function IslandCheaterTavernAgency:GetPlayerData(arg_26_1)
	return self.player_dic[arg_26_1]
end

function IslandCheaterTavernAgency:GetPlayerList()
	local var_27_0 = {}
	local var_27_1 = {}

	for iter_27_0, iter_27_1 in pairs(self.player_dic) do
		if iter_27_1.user_id ~= getProxy(PlayerProxy):getRawData().id then
			var_27_0[(iter_27_1.seat - self.curPlayerSeat + self.allPlayerNum) % self.allPlayerNum] = iter_27_1
			var_27_1[iter_27_1.user_id] = (iter_27_1.seat - self.curPlayerSeat + self.allPlayerNum) % self.allPlayerNum
		end
	end

	return var_27_0, var_27_1
end

function IslandCheaterTavernAgency:CheckCanOnlyQurey()
	for iter_28_0, iter_28_1 in pairs(self.player_dic) do
		if iter_28_1.user_id ~= getProxy(PlayerProxy):getRawData().id and not iter_28_1:IsOut() and iter_28_1:GetCardNum() ~= 0 then
			return false
		end
	end

	return true
end

function IslandCheaterTavernAgency:GetCurrentPtNum()
	return 0
end

function IslandCheaterTavernAgency:CheckWinerUserId()
	local var_30_0
	local var_30_1 = 0

	for iter_30_0, iter_30_1 in pairs(self.player_dic) do
		if not iter_30_1:IsOut() then
			var_30_0 = iter_30_1.user_id
			var_30_1 = var_30_1 + 1
		end
	end

	if var_30_1 == 1 then
		return var_30_0
	end

	return
end

return IslandCheaterTavernAgency
