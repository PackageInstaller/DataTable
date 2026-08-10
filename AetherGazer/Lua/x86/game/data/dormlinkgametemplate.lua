local var_0_0 = class("DormLinkGameCustomerTemplate")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.ID = arg_1_1.customerID
	arg_1_0.eid = arg_1_1.customerEID
	arg_1_0.posIndex = arg_1_1.posIndex
	var_0_1 = 0
	arg_1_0.satietyNum, arg_1_0.curPreference = ActivityLinkGameCustomerCfg[arg_1_0.ID].satiety_limit[1]
	arg_1_0.satietyAddition = 0
	arg_1_0.priority = ActivityLinkGameCustomerCfg[arg_1_0.ID].seat_priority

	arg_1_0:CalSatietyExtendAddition()
	arg_1_0:RefreshNextPreferenceFood()
end

function var_0_0.FoodComplate(arg_2_0)
	if arg_2_0.curPreference then
		local var_2_0 = ActivityLinkGameComposeCfg[arg_2_0.curPreference].satiety_up

		arg_2_0:ReviseSatiety(var_2_0)
		arg_2_0:RefreshNextPreferenceFood()
		manager.notify:Invoke(LIANLIANKAN_CUSTOMER_EAT, arg_2_0.posIndex)
	end
end

function var_0_0.RefreshNextPreferenceFood(arg_3_0)
	local var_3_0 = ActivityLinkGameCustomerCfg[arg_3_0.ID].compose_list

	if var_3_0 then
		local var_3_1 = var_3_0[math.random(#var_3_0)]

		while var_3_1 == arg_3_0.curPreference and #var_3_0 > 1 do
			var_3_1 = var_3_0[math.random(#var_3_0)]
		end

		arg_3_0.curPreference = var_3_1

		DormLinkGameData:UpdataCustomerNeed()
	end
end

function var_0_0.ReviseSatiety(arg_4_0, arg_4_1)
	local var_4_0 = ActivityLinkGameCustomerCfg[arg_4_0.ID].satiety_limit[2]
	local var_4_1 = ActivityLinkGameCustomerCfg[arg_4_0.ID].satiety_limit[1]

	arg_4_0.satietyNum = arg_4_0.satietyNum + var_4_0 * arg_4_1 / 100

	if var_4_1 > arg_4_0.satietyNum then
		arg_4_0.satietyNum = var_4_1
	end

	if var_4_0 < arg_4_0.satietyNum then
		arg_4_0.satietyNum = var_4_0
	end

	arg_4_0:CalSatietyExtendAddition()
	manager.notify:Invoke(DORM_LINK_REFRESH_CUSTOMER_SATIETY, arg_4_0.ID)
end

function var_0_0.CalSatietyExtendAddition(arg_5_0)
	local var_5_0 = ActivityLinkGameCustomerCfg[arg_5_0.ID].satiety_score_up
	local var_5_1 = arg_5_0.satietyAddition

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_2 = iter_5_1[2][1]
		local var_5_3 = iter_5_1[2][2]

		if var_5_2 <= arg_5_0.satietyNum and var_5_3 > arg_5_0.satietyNum then
			arg_5_0.satietyAddition = iter_5_1[1]

			break
		end

		if iter_5_0 == #var_5_0 and var_5_3 <= arg_5_0.satietyAddition then
			arg_5_0.satietyAddition = iter_5_1[1]
		end
	end

	if var_5_1 ~= arg_5_0.satietyAddition then
		DormLinkGameData:RefreshCustomerExtendAddition()
	end
end

function var_0_0.GetSatiety(arg_6_0)
	if var_0_1 then
		return var_0_1
	else
		print(arg_6_0.ID .. "号客人不存在饱食度数据")
	end
end

function var_0_0.RefreshCustomerBubble(arg_7_0, arg_7_1)
	DormLuaBridge.SetUIFollow(arg_7_1, arg_7_0.eid, "root")
end

return var_0_0
