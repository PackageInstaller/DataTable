local IslandFish = class("IslandFish", import("model.vo.BaseVO"))

IslandFish.CUP_STATE_NONE = 0
IslandFish.CUP_STATE_MIN = 1
IslandFish.CUP_STATE_MAX = 2
IslandFish.CUP_STATE_NIN_AND_MAX = 3

function IslandFish:Ctor(arg_1_1)
	self.id = arg_1_1.fish_id
	self.configId = self.id
	self.minWeight = arg_1_1.min_weight
	self.maxWeight = arg_1_1.max_weight
	self.cupState = arg_1_1.gold_state or IslandFish.CUP_STATE_NONE

	return
end

function IslandFish:bindConfigTable()
	return pg.island_fish
end

function IslandFish:GetMinWeight()
	return self.minWeight
end

function IslandFish:GetMaxWeight()
	return self.maxWeight
end

function IslandFish:SetWeight(arg_5_1)
	if arg_5_1 > self.maxWeight then
		self.maxWeight = arg_5_1
	elseif arg_5_1 < self.minWeight then
		self.minWeight = arg_5_1
	end

	return
end

function IslandFish:ReachMinCup()
	return self.cupState == IslandFish.CUP_STATE_NIN_AND_MAX or self.cupState == IslandFish.CUP_STATE_MIN
end

function IslandFish:ReachMaxCup()
	return self.cupState == IslandFish.CUP_STATE_NIN_AND_MAX or self.cupState == IslandFish.CUP_STATE_MAX
end

function IslandFish:SetCupState(arg_8_1)
	if self.cupState == IslandFish.CUP_STATE_NIN_AND_MAX then
		return
	end

	if arg_8_1 == 1 then
		if self.cupState == IslandFish.CUP_STATE_MAX then
			self.cupState = IslandFish.CUP_STATE_NIN_AND_MAX or IslandFish.CUP_STATE_MIN
		end
	elseif arg_8_1 == 2 then
		if self.cupState == IslandFish.CUP_STATE_MIN then
			self.cupState = IslandFish.CUP_STATE_NIN_AND_MAX or IslandFish.CUP_STATE_MAX
		end
	end

	return
end

return IslandFish
