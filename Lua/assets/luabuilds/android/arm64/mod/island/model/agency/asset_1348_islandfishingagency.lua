local IslandFishingAgency = class("IslandFishingAgency", import(".IslandBaseAgency"))

IslandFishingAgency.BAIT_UPDATE = "IslandFishingAgency:BAIT_UPDATE"

local var_0_1 = 1501

function IslandFishingAgency:OnInit(arg_1_1)
	self.severBaitId = arg_1_1.fish_sys.old_bait
	self.baitId = self.severBaitId == 0 and var_0_1 or self.severBaitId
	self.fishRodId = arg_1_1.fish_sys.fish_rod
	self.fishList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.fish_sys.fish_weight) do
		table.insert(self.fishList, IslandFish.New(iter_1_1))
	end

	return
end

function IslandFishingAgency:UpdateFishRodId(arg_2_1)
	self.fishRodId = arg_2_1

	return
end

function IslandFishingAgency:NeedUpdateServerBait()
	return self.severBaitId ~= self.baitId
end

function IslandFishingAgency:UpdateBaitId(arg_4_1)
	self.baitId = arg_4_1
	self.severBaitId = arg_4_1

	self:DispatchEvent(IslandFishingAgency.BAIT_UPDATE, arg_4_1)

	return
end

function IslandFishingAgency:GetBaitId()
	return self.baitId
end

function IslandFishingAgency:GetFishRodId()
	return self.fishRodId
end

function IslandFishingAgency:GetFishList()
	return self.fishList
end

function IslandFishingAgency:GetFish(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(self.fishList) do
		if iter_8_1.id == arg_8_1 then
			return iter_8_1
		end
	end

	return nil
end

function IslandFishingAgency:IsNewFish(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(self.fishList) do
		if iter_9_1.id == arg_9_1 then
			return false
		end
	end

	return true
end

function IslandFishingAgency:AddFish(arg_10_1, arg_10_2, arg_10_3)
	if self:IsNewFish(arg_10_1) then
		local var_10_0 = IslandFish.New({
			fish_id = arg_10_1,
			max_weight = arg_10_2,
			min_weight = arg_10_2
		})

		var_10_0:SetCupState(arg_10_3)
		table.insert(self.fishList, var_10_0)
	else
		for iter_10_0, iter_10_1 in ipairs(self.fishList) do
			if iter_10_1.id == arg_10_1 then
				iter_10_1:SetWeight(arg_10_2)
				iter_10_1:SetCupState(arg_10_3)
			end
		end
	end

	return
end

function IslandFishingAgency:IsNewRecord(arg_11_1, arg_11_2)
	if self:IsNewFish(arg_11_1) then
		return false
	end

	for iter_11_0, iter_11_1 in ipairs(self.fishList) do
		if iter_11_1.id == arg_11_1 then
			return arg_11_2 > iter_11_1:GetMaxWeight()
		end
	end

	return false
end

return IslandFishingAgency
