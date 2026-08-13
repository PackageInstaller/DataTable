class = var_0_10000

local var_0_0 = var_0_10000("EducateCharCharacter")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	pg = var_1_10002

	local var_1_0 = var_1_10002.secretary_special_ship.get_id_list_by_character_id[arg_1_1]

	arg_1_0.groupList = {}
	pairs = var_3
	pg = var_1_10005

	for iter_1_0, iter_1_1 in var_3(var_1_10005.secretary_special_ship.get_id_list_by_group) do
		table = var_1_10008

		if var_1_10008.contains(var_1_0, iter_1_0) then
			table = var_1_10008
			var_1_10008 = var_1_10008.insert

			local var_1_1 = arg_1_0.groupList

			EducateCharGroup = var_11

			var_1_10008(var_1_1, var_11.New(iter_1_0))
		end
	end

	return
end

function var_0_0.GetGroupList(arg_2_0)
	return arg_2_0.groupList
end

function var_0_0.GetGroupById(arg_3_0, arg_3_1)
	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0.groupList) do
		if iter_3_1.id == arg_3_1 then
			return iter_3_1
		end
	end

	return
end

function var_0_0.IsLock(arg_4_0)
	NewEducateHelper = var_1_10001

	return not var_1_10001.IsUnlockDefaultShip(arg_4_0.id)
end

function var_0_0.IsSelected(arg_5_0, arg_5_1)
	_ = var_1_10002

	return var_1_10002.any(arg_5_0.groupList, function(arg_6_0)
		return arg_6_0:IsSelected(arg_5_1)
	end)
end

function var_0_0.GetDefaultFrame(arg_7_0)
	pg = var_1_10001

	return var_1_10001.secretary_special_ship[arg_7_0.id].head
end

function var_0_0.ShouldTip(arg_8_0)
	_ = var_1_10001

	return var_1_10001.any(arg_8_0.groupList, function(arg_9_0)
		return arg_9_0:ShouldTip()
	end)
end

return var_0_0
