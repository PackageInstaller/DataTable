class = var_0_10000

local var_0_0 = var_0_10000("EducateCharGroup")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	pg = var_1_10002

	local var_1_0 = var_1_10002.secretary_special_ship.get_id_list_by_group[arg_1_1]

	arg_1_0.charIdList = {}
	ipairs = var_3

	for iter_1_0, iter_1_1 in var_3(var_1_0) do
		pg = var_1_10008

		if var_1_10008.secretary_special_ship[iter_1_1].secrerary_show == 1 then
			table = var_1_10008

			var_1_10008.insert(arg_1_0.charIdList, iter_1_1)
		end
	end

	return
end

function var_0_0.GetSortWeight(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.GetShowId(var_2_0)

	pg = var_2_0

	return var_2_0.secretary_special_ship[var_2_1].type
end

function var_0_0.GetCharIdList(arg_3_0)
	return arg_3_0.charIdList
end

function var_0_0.GetTitle(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.GetShowId(var_4_0)

	pg = var_4_0

	if var_4_0.secretary_special_ship[var_4_1].genghuan_word == 1 then
		i18n = var_2

		return var_2("secretary_special_title_age")
	else
		i18n = var_2

		return var_2("secretary_special_title_physiognomy")
	end

	return
end

function var_0_0.GetUnlockDesc(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.GetShowId(var_5_0)

	pg = var_5_0

	return var_5_0.secretary_special_ship[var_5_1].unlock_desc
end

function var_0_0.GetSpriteName(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.GetShowId(var_6_0)

	pg = var_6_0

	local var_6_2 = var_6_0.secretary_special_ship[var_6_1].type

	return "label_" .. var_6_2
end

function var_0_0.GetShowId(arg_7_0)
	_ = var_1_10001

	return (var_1_10001.detect(arg_7_0.charIdList, function(arg_8_0)
		pg = var_2_10001

		return var_2_10001.secretary_special_ship[arg_8_0].type ~= 0
	end))
end

function var_0_0.IsSp(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.secretary_special_ship[arg_9_0:GetShowId()].type

	EducateConst = var_2

	return var_9_0 == var_2.SECRETARY_TYPE_SP
end

function var_0_0.GetShowPainting(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.GetShowId(var_10_0)

	assert = var_10_0

	var_10_0(var_10_1)

	pg = var_10_0

	return var_10_0.secretary_special_ship[var_10_1].painting
end

function var_0_0.IsSelected(arg_11_0, arg_11_1)
	_ = var_1_10002

	return var_1_10002.any(arg_11_0.charIdList, function(arg_12_0)
		return arg_11_1 == arg_12_0
	end)
end

function var_0_0.IsLock(arg_13_0)
	NewEducateHelper = var_1_10001

	local var_13_0 = var_1_10001.GetAllUnlockSecretaryIds()
	local var_13_1 = {}

	ipairs = var_1_10003

	for iter_13_0, iter_13_1 in var_1_10003(var_13_0) do
		var_13_1[iter_13_1] = true
	end

	_ = var_3

	return var_3.all(arg_13_0.charIdList, function(arg_14_0)
		return not var_13_1[arg_14_0]
	end)
end

function var_0_0.ShouldTip(arg_15_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10002

	local var_15_0 = var_1_10001(var_1_10002)

	_ = var_1_10002

	return var_1_10002.any(arg_15_0.charIdList, function(arg_16_0)
		local var_16_0 = var_15_0

		return var_1._ShouldEducateCharTip(var_16_0, arg_16_0)
	end)
end

return var_0_0
