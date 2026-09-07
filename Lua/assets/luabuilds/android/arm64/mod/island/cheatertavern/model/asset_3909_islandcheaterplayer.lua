local IslandCheaterPlayer = class("IslandCheaterPlayer")

function IslandCheaterPlayer:Ctor(arg_1_1)
	self.user_id = arg_1_1.user_id
	self.seat = arg_1_1.seat
	self.card_num = arg_1_1.card_num
	self.bomb_dic = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.bomb_list) do
		self.bomb_dic[iter_1_1.bomb_id] = iter_1_1.state == 1
	end

	self.state = 0
	self.player_info = arg_1_1.player_info
	self.rank = 0
	self.addScore = 0

	return
end

function IslandCheaterPlayer:SetGameData(arg_2_1, arg_2_2)
	self.rank = arg_2_1
	self.addScore = arg_2_2

	return
end

function IslandCheaterPlayer:GetRank()
	return self.rank
end

function IslandCheaterPlayer:GetAddScore()
	return self.addScore
end

function IslandCheaterPlayer:GetName()
	return self.player_info.name
end

function IslandCheaterPlayer:ReduceCardNum(arg_6_1)
	self.card_num = self.card_num - arg_6_1

	return
end

function IslandCheaterPlayer:GetCardNum()
	return self.card_num
end

function IslandCheaterPlayer:UpdateBombState(arg_8_1)
	self.bomb_dic[arg_8_1] = true

	return
end

function IslandCheaterPlayer:UpdateDelegateState(arg_9_1)
	self.delegateState = arg_9_1

	return
end

function IslandCheaterPlayer:IsDelegate()
	return self.delegateState == 1
end

function IslandCheaterPlayer:SetOutState()
	self.state = 1

	return
end

function IslandCheaterPlayer:IsOut()
	return self.state == 1
end

function IslandCheaterPlayer:GetBombState(arg_13_1)
	return self.bomb_dic[arg_13_1] or false
end

function IslandCheaterPlayer:GetCurrentAndAllHp()
	local var_14_0 = 0
	local var_14_1 = 0

	for iter_14_0, iter_14_1 in pairs(self.bomb_dic) do
		if iter_14_1 then
			var_14_0 = var_14_0 + 1
		end

		var_14_1 = var_14_1 + 1
	end

	return var_14_1 - var_14_0, var_14_1
end

function IslandCheaterPlayer:GetCurrentBombId()
	local var_15_0
	local var_15_1 = 0

	for iter_15_0 = 1, pg.gameset.bar_punishment_limit.key_value do
		if self.bomb_dic[iter_15_0] == false and not var_15_0 then
			var_15_0 = iter_15_0 - 1
		elseif self.bomb_dic[iter_15_0] == true then
			var_15_1 = var_15_1 + 1
		end
	end

	if var_15_0 == 0 then
		var_15_0 = pg.gameset.bar_punishment_limit.key_value
	end

	return var_15_0 or 1, var_15_1
end

return IslandCheaterPlayer
