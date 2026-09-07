local Island = class("Island", import(".BaseIsland"))

Island.EXP_ADD = "Island:EXP_ADD"

function Island:Ctor(arg_1_1)
	Island.super.Ctor(self, arg_1_1.public_data)

	self.inventoryAgency = IslandInventoryAgency.New(self, arg_1_1.private_data)
	self.orderAgency = IslandOrderAgency.New(self, arg_1_1.private_data)
	self.shopAgency = IslandShopAgency.New(self, arg_1_1.private_data)
	self.seasonAgency = IslandSeasonAgency.New(self, arg_1_1.private_data)
	self.dressUpAgency = IslandDressUpAgency.New(self, arg_1_1.private_data)
	self.achievementAgency = IslandAchievementAgency.New(self, arg_1_1.private_data)
	self.globalBuffAgency = IslandGlobalBuffAgency.New(self, arg_1_1.private_data)
	self.actionAgency = IslandActionAgency.New(self, arg_1_1.private_data)
	self.npcFeedbackAgency = IslandNpcFeedbackAgency.New(self, arg_1_1.private_data)
	self.fishingAgency = IslandFishingAgency.New(self, arg_1_1.private_data)
	self.settingsAgency = IslandSettingsAgency.New(self, arg_1_1.private_data)
	self.bookAgency = IslandBookAgency.New(self, arg_1_1.private_data)
	self.cardDiyAgency = IslandCardDiyAgency.New(self, arg_1_1.private_data)
	self.ticketAgency = IslandTicketAgency.New(self, arg_1_1.private_data)

	self:GetAgoraAgency():InitPrivateData(arg_1_1.private_data)
	self:AddDefaultAgoraData()
	self:GetFollowerAgency():InitPrivateData(arg_1_1.private_data)
	self:GetInventoryAgency():InitPrivateData(arg_1_1.public_data)
	self:GetSignInAgency():InitPrivateData(arg_1_1.private_data)
	self:GetAccessAgency():InitPrivateData(arg_1_1.private_data)
	self:GetBuildingAgency():InitPrivateData(arg_1_1.private_data)
	self:GetWildCollectAgency():InitPrivateData(arg_1_1.private_data)

	return
end

function Island:IsPrivate()
	return true
end

function Island:AddExp(arg_3_1)
	Island.super.AddExp(self, arg_3_1)
	self:DispatchEvent(Island.EXP_ADD)

	return
end

function Island:AddDefaultAgoraData()
	local var_4_0 = self:GetAgoraAgency()

	for iter_4_0, iter_4_1 in ipairs(pg.island_set.initial_furniture.key_value_varchar) do
		var_4_0:RawAddFurniture(IslandFurniture.New({
			id = iter_4_1[1],
			count = iter_4_1[2]
		}))
	end

	return
end

function Island:GetInventoryAgency()
	return self.inventoryAgency
end

function Island:GetFishingAgency()
	return self.fishingAgency
end

function Island:GetOrderAgency()
	return self.orderAgency
end

function Island:GetActionAgency()
	return self.actionAgency
end

function Island:GetNpcFeedbackAgency()
	return self.npcFeedbackAgency
end

function Island:GetShopAgency()
	return self.shopAgency
end

function Island:GetSeasonAgency()
	return self.seasonAgency
end

function Island:GetDressUpAgency()
	return self.dressUpAgency
end

function Island:GetAchievementAgency()
	return self.achievementAgency
end

function Island:GetGlobalBuffAgency()
	return self.globalBuffAgency
end

function Island:GetSettingsAgency()
	return self.settingsAgency
end

function Island:GetBookAgency()
	return self.bookAgency
end

function Island:GetCardDiyAgency()
	return self.cardDiyAgency
end

function Island:GetTicketAgency()
	return self.ticketAgency
end

function Island:GetSystemTipInfos()
	if not self:GetAblityAgency():IsUnlockPostManage() then
		return {
			awardCnt = 0,
			emptyCnt = 0,
			postFlag = 0,
			timestamps = {}
		}
	else
		local var_19_0 = self:GetBuildingAgency():GetTipInfos()
		local var_19_1 = self:GetManageAgency():GetTipInfos()

		return {
			postFlag = 1,
			awardCnt = var_19_0.awardCnt + var_19_1.awardCnt,
			emptyCnt = var_19_0.emptyCnt + var_19_1.emptyCnt,
			timestamps = table.mergeArray(var_19_0.timestamps, var_19_1.timestamps)
		}
	end

	return
end

function Island:UpdatePerDay()
	Island.super.UpdatePerDay(self)
	self:GetOrderAgency():UpdatePerDay()
	self:GetTaskAgency():UpdatePerDay()
	self:GetNpcFeedbackAgency():UpdatePerDay()
	self:GetSignInAgency():UpdatePerDay()

	return
end

function Island:UpdatePerSecond()
	Island.super.UpdatePerSecond(self)
	self:GetTaskAgency():UpdatePerSecond()

	return
end

return Island
