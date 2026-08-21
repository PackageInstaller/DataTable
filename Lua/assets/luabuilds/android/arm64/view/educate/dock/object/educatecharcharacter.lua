local var_0_0 = class("EducateCharCharacter")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.groupList = {}

	for iter_1_0, iter_1_1 in pairs(pg.secretary_special_ship.get_id_list_by_group) do
		if table.contains(pg.secretary_special_ship.get_id_list_by_character_id[arg_1_1], iter_1_0) then
			table.insert(arg_1_0.groupList, EducateCharGroup.New(iter_1_0))
		end
	end

	return
end

function var_0_0.GetGroupList(arg_2_0)
	return arg_2_0.groupList
end

function var_0_0.GetGroupById(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.groupList) do
		if iter_3_1.id == arg_3_1 then
			return iter_3_1
		end
	end

	return
end

function var_0_0.IsLock(arg_4_0)
	return not NewEducateHelper.IsUnlockDefaultShip(arg_4_0.id)
end

function var_0_0.IsSelected(arg_5_0, arg_5_1)
	return _.any(arg_5_0.groupList, function(arg_6_0)
		return arg_6_0:IsSelected(arg_5_1)
	end)
end

function var_0_0.GetDefaultFrame(arg_7_0)
	return pg.secretary_special_ship[arg_7_0.id].head
end

function var_0_0.ShouldTip(arg_8_0)
	return _.any(arg_8_0.groupList, function(arg_9_0)
		return arg_9_0:ShouldTip()
	end)
end

return var_0_0
