local var_0_0 = class("Dorm3dSkin", import("model.vo.BaseVO"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.dorm3d_resource
end

function var_0_0.GetName(arg_2_0)
	return arg_2_0:getConfig("name")
end

function var_0_0.GetType(arg_3_0)
	return arg_3_0:getConfig("type")
end

function var_0_0.GetUnlock(arg_4_0)
	return arg_4_0:getConfig("unlock")
end

function var_0_0.GetShopId(arg_5_0)
	return arg_5_0:getConfig("shop_id")
end

function var_0_0.GetPublicRoomId(arg_6_0)
	return arg_6_0:GetUnlock()[2]
end

function var_0_0.GetIcon(arg_7_0)
	return arg_7_0:getConfig("head_Icon")
end

function var_0_0.GetUnlockText(arg_8_0)
	return arg_8_0:getConfig("unlock_text")
end

function var_0_0.GetSwitchAnim(arg_9_0)
	return arg_9_0:getConfig("switch_anim")
end

function var_0_0.GetWearAnim(arg_10_0)
	return arg_10_0:getConfig("wear_anim")
end

function var_0_0.GetRemarks(arg_11_0)
	return arg_11_0:getConfig("remarks")
end

function var_0_0.GetGroupId(arg_12_0)
	return arg_12_0:getConfig("ship_group")
end

function var_0_0.ShouldApplyHiddenPartInTimeline(arg_13_0)
	return arg_13_0:getConfig("hidden_part_apply_in_timeline") == 1
end

function var_0_0.GetHiddenPartIcons(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getConfig("hidden_part")

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		local var_14_1 = iter_14_0.find(var_14_0, function(arg_15_0)
			return arg_15_0[1] == iter_14_1
		end)

		if var_14_1 then
			table.insert({}, var_14_1[2])
		end
	end

	return {}
end

function var_0_0.GetActiveAndHiddenPartNames(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs((arg_16_0:getConfig("hidden_part"))) do
		if table.contains(arg_16_1, iter_16_1[1]) then
			table.insert({}, iter_16_1[3])
		else
			table.insert({}, iter_16_1[3])
		end
	end

	return {}, {}
end

function var_0_0.GetRarity(arg_17_0)
	return 5
end

function var_0_0.GetModelName(arg_18_0)
	return arg_18_0:getConfig("model_id")
end

function var_0_0.IsShow(arg_19_0)
	return arg_19_0:getConfig("is_show_change_skin") == 1
end

return var_0_0
