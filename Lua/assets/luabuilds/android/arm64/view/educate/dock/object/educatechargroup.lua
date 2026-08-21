local var_0_0 = class("EducateCharGroup")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.charIdList = {}

	for iter_1_0, iter_1_1 in ipairs(pg.secretary_special_ship.get_id_list_by_group[arg_1_1]) do
		if pg.secretary_special_ship[iter_1_1].secrerary_show == 1 then
			table.insert(arg_1_0.charIdList, iter_1_1)
		end
	end

	return
end

function var_0_0.GetSortWeight(arg_2_0)
	return pg.secretary_special_ship[arg_2_0:GetShowId()].type
end

function var_0_0.GetCharIdList(arg_3_0)
	return arg_3_0.charIdList
end

function var_0_0.GetTitle(arg_4_0)
	if pg.secretary_special_ship[arg_4_0:GetShowId()].genghuan_word == 1 then
		return i18n("secretary_special_title_age")
	else
		return i18n("secretary_special_title_physiognomy")
	end

	return
end

function var_0_0.GetUnlockDesc(arg_5_0)
	return pg.secretary_special_ship[arg_5_0:GetShowId()].unlock_desc
end

function var_0_0.GetSpriteName(arg_6_0)
	return "label_" .. pg.secretary_special_ship[arg_6_0:GetShowId()].type
end

function var_0_0.GetShowId(arg_7_0)
	return (_.detect(arg_7_0.charIdList, function(arg_8_0)
		return pg.secretary_special_ship[arg_8_0].type ~= 0
	end))
end

function var_0_0.IsSp(arg_9_0)
	return pg.secretary_special_ship[arg_9_0:GetShowId()].type == EducateConst.SECRETARY_TYPE_SP
end

function var_0_0.GetShowPainting(arg_10_0)
	local var_10_0 = arg_10_0:GetShowId()

	assert(var_10_0)

	return pg.secretary_special_ship[var_10_0].painting
end

function var_0_0.IsSelected(arg_11_0, arg_11_1)
	return _.any(arg_11_0.charIdList, function(arg_12_0)
		return arg_11_1 == arg_12_0
	end)
end

function var_0_0.IsLock(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs((NewEducateHelper.GetAllUnlockSecretaryIds())) do
		({})[iter_13_1] = true
	end

	return _.all(arg_13_0.charIdList, function(arg_14_0)
		return not var_13_0[arg_14_0]
	end)
end

function var_0_0.ShouldTip(arg_15_0)
	local var_15_0 = getProxy(SettingsProxy)

	return _.any(arg_15_0.charIdList, function(arg_16_0)
		return var_15_0:_ShouldEducateCharTip(arg_16_0)
	end)
end

return var_0_0
