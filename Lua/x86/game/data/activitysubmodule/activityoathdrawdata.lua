local var_0_0 = singletonClass("ActivityOathDrawData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}
	var_0_4 = {}
	arg_1_0.nowStoryActivityId_ = nil
	arg_1_0.sceneList_ = {}
	arg_1_0.sceneListDropList_ = {}
end

function var_0_0.InitDrawData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id

	var_0_1[var_2_0] = {}
	var_0_2[var_2_0] = {}
	arg_2_0.mainActivityId_ = ActivityCfg.get_id_list_by_sub_activity_list[var_2_0][1]
	arg_2_0.sceneList_, arg_2_0.sceneListDropList_, arg_2_0.giftID_, arg_2_0.giftDropID_ = OathDrawTools.GetAllReward(arg_2_0.mainActivityId_)
	arg_2_0.skinID_ = OathDrawTools.GetGiftReward(arg_2_0.giftID_)

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.info) do
		local var_2_1 = iter_2_1.drop_id

		var_0_1[var_2_0][var_2_1] = {
			id = var_2_1,
			num = iter_2_1.num
		}
	end

	local var_2_2 = ActivityLimitedDrawPoolListCfg.get_id_list_by_activity_id[var_2_0][1]

	var_0_2[var_2_0].last_drop = arg_2_1.draw_info2.last_drop
	var_0_2[var_2_0].drawing_list = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.draw_info2.already_drop) do
		local var_2_3 = {
			index = iter_2_2,
			dropID = iter_2_3,
			isOpen = iter_2_3 ~= 0,
			poolID = var_2_2
		}

		table.insert(var_0_2[var_2_0].drawing_list, var_2_3)
	end

	arg_2_0:RefreshSkinDrawEntrace()
	manager.notify:Invoke(ACTIVITY_OATH_SKIN_DRAW_UPDATE)
end

function var_0_0.RefreshData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0:GetRemainCanDrawCnt(arg_3_1)

	if var_0_1[arg_3_1] then
		local var_3_0 = var_0_1[arg_3_1][arg_3_2].num
		local var_3_1

		var_3_1 = var_3_0 - 1 >= 0 and var_3_0 - 1 or 0
		var_0_1[arg_3_1][arg_3_2].num = var_3_1
	end

	if var_0_2[arg_3_1] then
		var_0_2[arg_3_1].drawing_list[arg_3_3].isOpen = true
		var_0_2[arg_3_1].drawing_list[arg_3_3].dropID = arg_3_2
	end

	arg_3_0:GetRemainCanDrawCnt(arg_3_1)
end

function var_0_0.GetRemainCanDrawCnt(arg_4_0, arg_4_1)
	local var_4_0 = 0

	for iter_4_0, iter_4_1 in pairs(var_0_1[arg_4_1]) do
		var_4_0 = var_4_0 + iter_4_1.num
	end

	return var_4_0
end

function var_0_0.RefreshSkinDrawEntrace(arg_5_0)
	manager.notify:Invoke(ACTIVITY_SKIN_DRAW_UPDATE, arg_5_0.mainActivityId_)
end

function var_0_0.GetLastFile(arg_6_0, arg_6_1)
	return var_0_4[arg_6_1]
end

function var_0_0.SetLastFile(arg_7_0, arg_7_1, arg_7_2)
	var_0_4[arg_7_1] = arg_7_2
end

function var_0_0.GetDrawData(arg_8_0, arg_8_1)
	return var_0_2[arg_8_1].drawing_list
end

function var_0_0.GetLastDrop(arg_9_0, arg_9_1)
	return var_0_2[arg_9_1].last_drop
end

function var_0_0.GetCurDrawPool(arg_10_0, arg_10_1)
	return var_0_3[arg_10_1]
end

function var_0_0.SetCurDrawPool(arg_11_0, arg_11_1, arg_11_2)
	var_0_3[arg_11_1] = arg_11_2
end

function var_0_0.GetDrawInfo(arg_12_0, arg_12_1, arg_12_2)
	return var_0_1[arg_12_1] and var_0_1[arg_12_1][arg_12_2] or nil
end

function var_0_0.IsGetSkinLastDrop(arg_13_0, arg_13_1)
	local var_13_0 = WeddingSkinDrawCfg[arg_13_1].poolList
	local var_13_1

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		if ActivityLimitedDrawPoolListCfg[iter_13_1].pool_type == 1 then
			var_13_1 = ActivityLimitedDrawPoolListCfg[iter_13_1].activity_id[1]

			break
		end
	end

	local var_13_2 = arg_13_0:GetDrawInfo(var_13_1, arg_13_0.giftDropID_)

	if var_13_2 and var_13_2.num <= 0 then
		return true
	end

	return false
end

function var_0_0.GetActivityList(arg_14_0)
	local var_14_0 = {}

	if arg_14_0.mainActivityId_ then
		local var_14_1 = ActivityData:GetActivityData(arg_14_0.mainActivityId_)
		local var_14_2 = WeddingSkinDrawCfg[arg_14_0.mainActivityId_]

		if var_14_1:IsActivitying() then
			table.insert(var_14_0, arg_14_0.mainActivityId_)
		end
	end

	return var_14_0
end

function var_0_0.GetMainActivityID(arg_15_0)
	return arg_15_0.mainActivityId_
end

function var_0_0.GetGiftID(arg_16_0)
	return arg_16_0.giftID_, arg_16_0.giftDropID_
end

function var_0_0.GetSceneID(arg_17_0, arg_17_1)
	return arg_17_0.sceneList_[arg_17_1]
end

function var_0_0.GetSceneDropID(arg_18_0, arg_18_1)
	return arg_18_0.sceneListDropList_[arg_18_1]
end

function var_0_0.GetSkinID(arg_19_0)
	return arg_19_0.skinID_
end

return var_0_0
