local var_0_0 = class("ChallengeRogueTeamEffectItemData")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.itemList_ = {}
end

function var_0_0.GetItemList(arg_2_0)
	return arg_2_0.itemList_
end

function var_0_0.UpdateItemList(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == ChallengeRogueTeamConst.ITEM_OPERATE.ADD then
		arg_3_0:UpdateItem(arg_3_2)
	elseif arg_3_1 == ChallengeRogueTeamConst.ITEM_OPERATE.DELETE then
		arg_3_0:RemoveItem(arg_3_2)
	end
end

function var_0_0.UpdateItem(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.itemList_) do
		if iter_4_1.id == arg_4_1 then
			return
		end
	end

	table.insert(arg_4_0.itemList_, {
		id = arg_4_1,
		effectList = {}
	})
end

function var_0_0.RemoveItem(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.itemList_) do
		if iter_5_1.id == arg_5_1 then
			table.remove(arg_5_0.itemList_, iter_5_0)

			break
		end
	end
end

function var_0_0.UpdateEffect(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.itemList_) do
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

function var_0_0.RemoveEffect(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.itemList_) do
		if iter_7_1.id == arg_7_1 and table.indexof(iter_7_1.effectList, arg_7_2) then
			table.remove(iter_7_1.effectList, arg_7_2)

			break
		end
	end
end

function var_0_0.ClearEffectItem(arg_8_0)
	for iter_8_0 = #arg_8_0.itemList_, 1, -1 do
		arg_8_0.itemList_[iter_8_0] = nil
	end
end

return var_0_0
