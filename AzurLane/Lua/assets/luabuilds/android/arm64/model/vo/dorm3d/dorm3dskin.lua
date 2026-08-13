class = var_0_10000

local var_0_0 = "Dorm3dSkin"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.dorm3d_resource
end

function var_0_1.GetName(arg_2_0)
	return arg_2_0:getConfig("name")
end

function var_0_1.GetType(arg_3_0)
	return arg_3_0:getConfig("type")
end

function var_0_1.GetUnlock(arg_4_0)
	return arg_4_0:getConfig("unlock")
end

function var_0_1.GetShopId(arg_5_0)
	return arg_5_0:getConfig("shop_id")
end

function var_0_1.GetPublicRoomId(arg_6_0)
	return arg_6_0:GetUnlock()[2]
end

function var_0_1.GetIcon(arg_7_0)
	return arg_7_0:getConfig("head_Icon")
end

function var_0_1.GetUnlockText(arg_8_0)
	return arg_8_0:getConfig("unlock_text")
end

function var_0_1.GetSwitchAnim(arg_9_0)
	return arg_9_0:getConfig("switch_anim")
end

function var_0_1.GetWearAnim(arg_10_0)
	return arg_10_0:getConfig("wear_anim")
end

function var_0_1.GetRemarks(arg_11_0)
	return arg_11_0:getConfig("remarks")
end

function var_0_1.GetGroupId(arg_12_0)
	return arg_12_0:getConfig("ship_group")
end

function var_0_1.ShouldApplyHiddenPartInTimeline(arg_13_0)
	return arg_13_0:getConfig("hidden_part_apply_in_timeline") == 1
end

function var_0_1.GetHiddenPartIcons(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.getConfig(var_14_0, "hidden_part")
	local var_14_2 = {}

	ipairs = var_14_0

	for iter_14_0, iter_14_1 in var_14_0(arg_14_1) do
		if iter_14_0.find(var_14_1, function(arg_15_0)
			return arg_15_0[1] == iter_14_1
		end) then
			table = var_1_10010

			var_1_10010.insert(var_14_2, var_9[2])
		end
	end

	return var_14_2
end

function var_0_1.GetActiveAndHiddenPartNames(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getConfig("hidden_part")
	local var_16_1 = {}
	local var_16_2 = {}

	ipairs = var_5

	for iter_16_0, iter_16_1 in var_5(var_16_0) do
		table = var_1_10010

		if var_1_10010.contains(arg_16_1, iter_16_1[1]) then
			table = var_1_10010

			var_1_10010.insert(var_16_2, iter_16_1[3])
		else
			table = var_1_10010

			var_1_10010.insert(var_16_1, iter_16_1[3])
		end
	end

	return var_16_1, var_16_2
end

function var_0_1.GetRarity(arg_17_0)
	return 5
end

function var_0_1.GetModelName(arg_18_0)
	return arg_18_0:getConfig("model_id")
end

function var_0_1.IsShow(arg_19_0)
	return arg_19_0:getConfig("is_show_change_skin") == 1
end

return var_0_1
