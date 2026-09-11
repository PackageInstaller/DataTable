local ChallengeRogueTeamEffectItemData = class("ChallengeRogueTeamEffectItemData")

function ChallengeRogueTeamEffectItemData:Ctor()
	self.itemList_ = {}
end

function ChallengeRogueTeamEffectItemData:GetItemList()
	return self.itemList_
end

function ChallengeRogueTeamEffectItemData:UpdateItemList(arg_3_1, arg_3_2)
	if arg_3_1 == ChallengeRogueTeamConst.ITEM_OPERATE.ADD then
		self:UpdateItem(arg_3_2)
	elseif arg_3_1 == ChallengeRogueTeamConst.ITEM_OPERATE.DELETE then
		self:RemoveItem(arg_3_2)
	end
end

function ChallengeRogueTeamEffectItemData:UpdateItem(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(self.itemList_) do
		if iter_4_1.id == arg_4_1 then
			return
		end
	end

	table.insert(self.itemList_, {
		id = arg_4_1,
		effectList = {}
	})
end

function ChallengeRogueTeamEffectItemData:RemoveItem(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(self.itemList_) do
		if iter_5_1.id == arg_5_1 then
			table.remove(self.itemList_, iter_5_0)

			break
		end
	end
end

function ChallengeRogueTeamEffectItemData:UpdateEffect(arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs(self.itemList_) do
		if iter_6_1.id == arg_6_1 then
			local var_6_0 = table.indexof(iter_6_1.effectList, arg_6_2)

			if not var_6_0 then
				table.insert(iter_6_1.effectList, arg_6_2)

				break
			else
				iter_6_1.effectList[var_6_0] = arg_6_2
			end
		end
	end
end

function ChallengeRogueTeamEffectItemData:RemoveEffect(arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in ipairs(self.itemList_) do
		if iter_7_1.id == arg_7_1 and table.indexof(iter_7_1.effectList, arg_7_2) then
			table.remove(iter_7_1.effectList, arg_7_2)

			break
		end
	end
end

function ChallengeRogueTeamEffectItemData:ClearEffectItem()
	for iter_8_0 = #self.itemList_, 1, -1 do
		self.itemList_[iter_8_0] = nil
	end
end

return ChallengeRogueTeamEffectItemData
