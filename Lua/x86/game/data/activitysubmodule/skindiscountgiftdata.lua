SkinDiscountGiftConst = {
	EXIST_MORE_CHEAP_SKIN_TIPS = 586003,
	EXIST_GIFT_AND_JUMP_TIPS = 586002,
	BUY_SCENE_TIPS = 586004
}

local var_0_0 = singletonClass("SkinDiscountGiftData")

function var_0_0.Init(arg_1_0)
	arg_1_0.selectGoodsIDList_ = {}
	arg_1_0.giftData_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.gift_used_hitory) do
		arg_2_0.giftData_[iter_2_1.gift_id] = iter_2_1.used_times
	end
end

function var_0_0.AddUsedTimes(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.giftData_[arg_3_1] or 0

	arg_3_0.giftData_[arg_3_1] = var_3_0 + 1
end

function var_0_0.GetUsedTimes(arg_4_0, arg_4_1)
	return arg_4_0.giftData_[arg_4_1] or 0
end

function var_0_0.AddGoodsIDList(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	table.insert(arg_5_0.selectGoodsIDList_, {
		skinGoodsID = arg_5_1,
		sceneGoodsID = arg_5_2,
		isSelectSceneID = arg_5_3
	})
end

function var_0_0.RemoveGoodsIDList(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.selectGoodsIDList_) do
		if iter_6_1.skinGoodsID == arg_6_1 then
			table.remove(arg_6_0.selectGoodsIDList_, iter_6_0)

			break
		end
	end
end

function var_0_0.UpdateGoodsIDList(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.selectGoodsIDList_) do
		if iter_7_1.skinGoodsID == arg_7_1 then
			if SkinDiscountGiftTools.HasScene(iter_7_1.sceneGoodsID) then
				iter_7_1.isSelectSceneID = false

				break
			end

			iter_7_1.isSelectSceneID = not iter_7_1.isSelectSceneID

			break
		end
	end
end

function var_0_0.ClearGoodsIDList(arg_8_0)
	arg_8_0.selectGoodsIDList_ = {}
end

function var_0_0.GetGoodsIDList(arg_9_0)
	return arg_9_0.selectGoodsIDList_
end

return var_0_0
