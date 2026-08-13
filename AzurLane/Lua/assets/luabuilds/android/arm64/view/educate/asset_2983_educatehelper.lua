class = var_0_10000

local var_0_0 = var_0_10000("EducateHelper")

function var_0_0.GetItemAddDrops(arg_1_0)
	pg = var_1_10001

	local var_1_0 = var_1_10001.child_item[arg_1_0.id].display
	local var_1_1 = {}

	underscore = var_1_10003

	var_1_10003.each(var_1_0, function(arg_2_0)
		assert = var_2_10001

		local var_2_0 = arg_2_0[1]

		EducateConst = var_2_10004

		local var_2_2

		if var_2_0 ~= var_2_10004.DROP_TYPE_ATTR then
			local var_2_1 = arg_2_0[1]

			EducateConst = var_4

			if var_2_1 ~= var_4.DROP_TYPE_RES then
				var_2_2 = false

				goto label_2_0
			end
		end

		var_2_2 = true

		::label_2_0::

		var_2_10001(var_2_2, "非法道具增益, item id:" .. arg_1_0.id)

		table = var_2_10001

		var_2_10001.insert(var_1_1, {
			type = arg_2_0[1],
			id = arg_2_0[2],
			number = arg_2_0[3] * arg_1_0.number
		})

		return
	end)

	return var_1_1
end

function var_0_0.UpdateDropsData(arg_3_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)

	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0) do
		switch = var_1_10007

		local var_3_1 = iter_3_1.type
		local var_3_2 = {}

		EducateConst = var_1_10011
		var_3_2[var_1_10011.DROP_TYPE_ATTR] = function()
			local var_4_0 = var_3_0

			var_0.UpdateAttr(var_4_0, iter_3_1.id, iter_3_1.number)

			return
		end
		EducateConst = var_1_10011
		var_3_2[var_1_10011.DROP_TYPE_RES] = function()
			local var_5_0 = var_3_0

			var_0.UpdateRes(var_5_0, iter_3_1.id, iter_3_1.number)

			return
		end
		EducateConst = var_1_10011
		var_3_2[var_1_10011.DROP_TYPE_ITEM] = function()
			local var_6_0 = var_3_0

			var_0.AddItem(var_6_0, iter_3_1.id, iter_3_1.number)

			local var_6_1 = var_0_0.GetItemAddDrops(iter_3_1)

			var_0_0.UpdateDropsData(var_6_1)

			return
		end
		EducateConst = var_1_10011
		var_3_2[var_1_10011.DROP_TYPE_MEMORY] = function()
			local var_7_0 = var_3_0

			var_0.AddMemory(var_7_0, iter_3_1.id, iter_3_1.number)

			return
		end
		EducateConst = var_1_10011
		var_3_2[var_1_10011.DROP_TYPE_POLAROID] = function()
			local var_8_0 = var_3_0

			var_0.AddPolaroid(var_8_0, iter_3_1.id)

			return
		end
		EducateConst = var_1_10011
		var_3_2[var_1_10011.DROP_TYPE_BUFF] = function()
			local var_9_0 = var_3_0

			var_0.AddBuff(var_9_0, iter_3_1.id)

			return
		end

		var_1_10007(var_3_1, var_3_2)
	end

	return
end

function var_0_0.UpdateDropShow(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.type

	EducateConst = var_1_10003

	if var_10_0 ~= var_1_10003.DROP_TYPE_MEMORY then
		var_10_0 = arg_10_1.type
		EducateConst = var_3

		if var_10_0 == var_3.DROP_TYPE_POLAROID then
			pg = var_10_0

			local var_10_1 = var_10_0.TipsMgr.GetInstance()
			local var_10_2 = var_2.ShowTips

			string = var_1_10005

			var_10_2(var_10_1, var_1_10005.format("不支持的掉落展示for Item,请检查配置！type:%d, id:%d", arg_10_1.type, arg_10_1.id))

			return
		end

		local var_10_3 = var_0_0.GetDropConfig(arg_10_1)

		LoadImageSpriteAsync = var_3

		local var_10_4 = "educateprops/" .. var_10_3.icon

		findTF = var_6

		var_3(var_10_4, var_6(arg_10_0, "frame/icon"))

		setText = var_3
		findTF = var_10_4

		var_3(var_10_4(arg_10_0, "frame/count_bg/count"), "x" .. arg_10_1.number)

		setText = var_3
		findTF = var_5

		local var_10_5 = var_5(arg_10_0, "name_bg/name")

		shortenString = var_6

		var_3(var_10_5, var_6(var_10_3.name, 5))

		local var_10_6 = arg_10_1.type

		EducateConst = var_4

		if var_10_6 == var_4.DROP_TYPE_ITEM then
			EducateItem = var_10_6

			local var_10_7 = var_10_6.RARITY2FRAME[var_10_3.rarity]

			GetImageSpriteFromAtlasAsync = var_4

			local var_10_8 = "ui/educatecommonui_atlas"
			local var_10_9 = var_10_7

			findTF = var_8

			var_4(var_10_8, var_10_9, var_8(arg_10_0, "frame"))
		end

		return
	end
end

function var_0_0.GetDropConfig(arg_11_0)
	switch = var_1_10001

	local var_11_0 = arg_11_0.type
	local var_11_1 = {}

	EducateConst = var_1_10005
	var_11_1[var_1_10005.DROP_TYPE_ATTR] = function()
		pg = var_2_10000

		local var_12_0 = var_2_10000.child_attr[arg_11_0.id]

		assert = var_1

		var_1(var_12_0, "找不到child_attr配置, id: " .. arg_11_0.id)

		return var_12_0
	end
	EducateConst = var_5
	var_11_1[var_5.DROP_TYPE_RES] = function()
		pg = var_2_10000

		local var_13_0 = var_2_10000.child_resource[arg_11_0.id]

		assert = var_1

		var_1(var_13_0, "找不到child_resource配置, id: " .. arg_11_0.id)

		return var_13_0
	end
	EducateConst = var_5
	var_11_1[var_5.DROP_TYPE_ITEM] = function()
		pg = var_2_10000

		local var_14_0 = var_2_10000.child_item[arg_11_0.id]

		assert = var_1

		var_1(var_14_0, "找不到child_item配置, id: " .. arg_11_0.id)

		return var_14_0
	end
	EducateConst = var_5
	var_11_1[var_5.DROP_TYPE_MEMORY] = function()
		pg = var_2_10000

		local var_15_0 = var_2_10000.child_memory[arg_11_0.id]

		assert = var_1

		var_1(var_15_0, "找不到child_memory配置, id: " .. arg_11_0.id)

		return var_15_0
	end
	EducateConst = var_5
	var_11_1[var_5.DROP_TYPE_POLAROID] = function()
		pg = var_2_10000

		local var_16_0 = var_2_10000.child_polaroid[arg_11_0.id]

		assert = var_1

		var_1(var_16_0, "找不到child_polaroid配置, id: " .. arg_11_0.id)

		return var_16_0
	end
	EducateConst = var_5
	var_11_1[var_5.DROP_TYPE_BUFF] = function()
		pg = var_2_10000

		local var_17_0 = var_2_10000.child_buff[arg_11_0.id]

		assert = var_1

		var_1(var_17_0, "找不到child_buff配置, id: " .. arg_11_0.id)

		return var_17_0
	end

	return var_1_10001(var_11_0, var_11_1)
end

function var_0_0.GetColorForAttrDrop(arg_18_0)
	local var_18_0 = arg_18_0.type

	EducateConst = var_1_10002

	if var_18_0 == var_1_10002.DROP_TYPE_RES then
		Color = var_18_0

		return var_18_0.NewHex("6FD9C4")
	else
		var_18_0 = arg_18_0.type
		EducateConst = var_2

		if var_18_0 == var_2.DROP_TYPE_ATTR then
			getProxy = var_18_0
			EducateProxy = var_1_10003

			local var_18_1 = var_18_0(var_1_10003)
			local var_18_2 = var_18_0.GetCharData(var_18_1)

			var_18_0 = var_18_0.GetAttrTypeById(var_18_2, arg_18_0.id)
			EducateChar = var_2

			if var_18_0 == var_2.ATTR_TYPE_MAJOR then
				Color = var_2

				return var_2.NewHex("5DC9FD")
			else
				EducateChar = var_2

				if var_18_0 == var_2.ATTR_TYPE_PERSONALITY then
					Color = var_2

					return var_2.NewHex("6FD9C4")
				else
					EducateChar = var_2

					if var_18_0 == var_2.ATTR_TYPE_MINOR then
						Color = var_2

						return var_2.NewHex("8CA1EE")
					end
				end
			end
		end
	end

	Color = var_18_0

	return var_18_0.NewHex("39BFFF")
end

function var_0_0.UpdateDropShowForAttr(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1.type

	EducateConst = var_1_10003

	if var_19_0 ~= var_1_10003.DROP_TYPE_ATTR then
		var_19_0 = arg_19_1.type
		EducateConst = var_3

		if var_19_0 ~= var_3.DROP_TYPE_RES then
			pg = var_19_0

			local var_19_1 = var_19_0.TipsMgr.GetInstance()

			var_19_0 = var_19_0.ShowTips
			string = var_1_10005

			var_19_0(var_19_1, var_1_10005.format("不支持的掉落展示for Attr,请检查配置！type:%d, id:%d", arg_19_1.type, arg_19_1.id))

			return
		end
	end

	setImageColor = var_19_0

	var_19_0(arg_19_0, var_0_0.GetColorForAttrDrop(arg_19_1))

	local var_19_2 = arg_19_1.type

	EducateConst = var_3

	local var_19_3 = var_19_2 == var_3.DROP_TYPE_ATTR and "attr_" or "res_"
	local var_19_4 = arg_19_1.number > 0 and "+" or ""
	local var_19_5 = var_0_0.GetDropConfig(arg_19_1)

	setActive = var_5
	findTF = var_7

	var_5(var_7(arg_19_0, "icon"), true)

	GetImageSpriteFromAtlasAsync = var_5

	local var_19_6 = "ui/educatecommonui_atlas"
	local var_19_7 = var_19_3 .. arg_19_1.id

	findTF = var_9

	var_5(var_19_6, var_19_7, var_9(arg_19_0, "icon"))

	setText = var_5
	findTF = var_19_6

	var_5(var_19_6(arg_19_0, "name"), var_19_5.name)

	setText = var_5
	findTF = var_7

	var_5(var_7(arg_19_0, "value"), var_19_4 .. arg_19_1.number)

	return
end

function var_0_0.FilterDropByTypes(arg_20_0, arg_20_1)
	underscore = var_1_10002

	return var_1_10002.select(arg_20_0, function(arg_21_0)
		table = var_2_10001

		return var_2_10001.contains(arg_20_1, arg_21_0.type)
	end)
end

function var_0_0.GetDialogueShowDrops(arg_22_0)
	local var_22_0 = var_0_0.FilterDropByTypes
	local var_22_1 = arg_22_0
	local var_22_2 = {}

	EducateConst = var_1_10005
	var_22_2[1] = var_1_10005.DROP_TYPE_ATTR
	EducateConst = var_5
	var_22_2[2] = var_5.DROP_TYPE_RES
	EducateConst = var_5
	var_22_2[3] = var_5.DROP_TYPE_BUFF

	return var_22_0(var_22_1, var_22_2)
end

function var_0_0.GetCommonShowDrops(arg_23_0)
	local var_23_0 = var_0_0.FilterDropByTypes
	local var_23_1 = arg_23_0
	local var_23_2 = {}

	EducateConst = var_1_10005
	var_23_2[1] = var_1_10005.DROP_TYPE_ITEM
	EducateConst = var_5
	var_23_2[2] = var_5.DROP_TYPE_POLAROID

	return var_23_0(var_23_1, var_23_2)
end

function var_0_0.UpdateAvatarShow(arg_24_0, arg_24_1, arg_24_2)
	setImageSprite = var_1_10003
	findTF = var_1_10005

	local var_24_0 = var_1_10005(arg_24_0, "mask/Image")

	LoadSprite = var_1_10006

	var_1_10003(var_24_0, var_1_10006("squareicon/" .. arg_24_2), true)

	local var_24_1 = 0

	ipairs = var_1_10004

	for iter_24_0, iter_24_1 in var_1_10004(arg_24_1) do
		findTF = var_24_2

		local var_24_2 = var_24_2(arg_24_0, "progress/" .. iter_24_1[1])
		local var_24_3 = iter_24_1[2] - 0.005

		setFillAmount = var_11

		var_11(var_24_2, var_24_3)

		setLocalEulerAngles = var_11

		local var_24_4 = var_24_2

		Vector3 = var_14

		var_11(var_24_4, var_14(0, 0, 24 * var_24_1))

		var_24_1 = var_24_1 + var_24_3 + 0.005
	end

	return
end

function var_0_0.GetTimeFromCfg(arg_25_0)
	return {
		month = arg_25_0[1],
		week = arg_25_0[2],
		day = arg_25_0[3]
	}
end

function var_0_0.IsSameDay(arg_26_0, arg_26_1)
	return arg_26_0.month == arg_26_1.month and arg_26_0.week == arg_26_1.week and arg_26_0.day == arg_26_1.day
end

function var_0_0.CfgTime2Time(arg_27_0)
	local var_27_0 = {
		month = arg_27_0[1][1]
	}
	local var_27_1

	if not arg_27_0[1][2] then
		var_27_1 = 1
	end

	var_27_0.week = var_27_1

	local var_27_2

	if not arg_27_0[1][3] then
		var_27_2 = 1
	end

	var_27_0.day = var_27_2

	local var_27_3 = {
		month = arg_27_0[2][1]
	}
	local var_27_4

	if not arg_27_0[2][2] then
		var_27_4 = 4
	end

	var_27_3.week = var_27_4

	local var_27_5

	if not arg_27_0[2][3] then
		var_27_5 = 7
	end

	var_27_3.day = var_27_5

	return var_27_0, var_27_3
end

function var_0_0.IsBeforeTime(arg_28_0, arg_28_1)
	if arg_28_0.month < arg_28_1.month then
		return true
	end

	if arg_28_0.month == arg_28_1.month and arg_28_0.week < arg_28_1.week then
		return true
	end

	if arg_28_0.month == arg_28_1.month and arg_28_0.week == arg_28_1.week and arg_28_0.day < arg_28_1.day then
		return true
	end

	return false
end

function var_0_0.IsAfterTime(arg_29_0, arg_29_1)
	if arg_29_0.month > arg_29_1.month then
		return true
	end

	if arg_29_0.month == arg_29_1.month and arg_29_0.week > arg_29_1.week then
		return true
	end

	if arg_29_0.month == arg_29_1.month and arg_29_0.week == arg_29_1.week and arg_29_0.day > arg_29_1.day then
		return true
	end

	return false
end

function var_0_0.InTime(arg_30_0, arg_30_1, arg_30_2)
	return not var_0_0.IsBeforeTime(arg_30_0, arg_30_1) and not var_0_0.IsAfterTime(arg_30_0, arg_30_2)
end

function var_0_0.GetTimeAfterDays(arg_31_0, arg_31_1)
	local var_31_0 = {
		month = arg_31_0.month,
		week = arg_31_0.week,
		day = arg_31_0.day,
		day = arg_31_0.day + arg_31_1
	}

	while var_31_0.day > 7 or var_31_0.week > 4 do
		if var_31_0.day > 7 then
			var_31_0.day = var_31_0.day - 7
			var_31_0.week = var_31_0.week + 1
		end

		if var_31_0.week > 4 then
			var_31_0.week = var_31_0.week - 4
			var_31_0.month = var_31_0.month + 1
		end
	end

	return var_31_0
end

function var_0_0.GetTimeAfterWeeks(arg_32_0, arg_32_1)
	var_2.week = ({
		month = arg_32_0.month,
		week = arg_32_0.week,
		day = arg_32_0.day
	}).week + arg_32_1

	while var_2.week > 4 do
		var_2.week = var_2.week - 4
		var_2.month = var_2.month + 1
	end

	return var_2
end

function var_0_0.GetDaysBetweenTimes(arg_33_0, arg_33_1)
	return (arg_33_1.month - arg_33_0.month) * 28 + (arg_33_1.week - arg_33_0.week) * 7 + (arg_33_1.day - arg_33_0.day)
end

function var_0_0.GetWeekIdxWithTime(arg_34_0)
	return (arg_34_0.month - 1) * 4 + arg_34_0.week
end

function var_0_0.GetShowMonthNumber(arg_35_0)
	local var_35_0

	if not (arg_35_0 > 12) or not (arg_35_0 - 12) then
		var_35_0 = arg_35_0
	end

	return var_35_0
end

function var_0_0.GetWeekByNumber(arg_36_0)
	if arg_36_0 == 7 then
		i18n = var_1_10001

		return var_1_10001("word_day")
	else
		i18n = var_1_10001

		return var_1_10001("number_" .. arg_36_0)
	end

	return
end

function var_0_0.GetWeekStrByNumber(arg_37_0)
	i18n = var_1_10001

	return var_1_10001("word_week_day" .. arg_37_0)
end

function var_0_0.InUnlockTime(arg_38_0, arg_38_1)
	if arg_38_0.month > arg_38_1[1] then
		return true
	end

	if arg_38_0.month == arg_38_1[1] and arg_38_0.week > arg_38_1[2] then
		return true
	end

	if arg_38_0.month == arg_38_1[1] and arg_38_0.week == arg_38_1[2] and arg_38_0.day >= arg_38_1[3] then
		return true
	end

	return false
end

function var_0_0.IsSystemUnlock(arg_39_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_39_0 = var_1_10001(var_1_10003)
	local var_39_1 = var_1.IsFirstGame(var_39_0)

	EducateConst = var_1_10002

	local var_39_2 = var_1_10002.SYSTEM_UNLOCK_CONFIG[arg_39_0]

	if not var_39_1 and var_39_2[2] then
		return true
	end

	getProxy = var_39_0
	EducateProxy = var_1_10005

	local var_39_3 = var_39_0(var_1_10005)
	local var_39_4 = var_3.GetCurTime(var_39_3)

	pg = var_1_10004

	local var_39_5 = var_1_10004.gameset[var_39_2[1]].description

	return var_0_0.InUnlockTime(var_39_4, var_39_5)
end

function var_0_0.IsShowNature()
	local var_40_0 = var_0_0.CfgTime2Time

	pg = var_1_10002

	local var_40_1, var_40_2 = var_40_0(var_1_10002.gameset.child_charactor_time.description)
	local var_40_3 = var_0_0.InTime

	getProxy = var_1_10004
	EducateProxy = var_1_10006

	local var_40_4 = var_1_10004(var_1_10006)

	return var_40_3(var_4.GetCurTime(var_40_4), var_40_1, var_40_2)
end

function var_0_0.IsSiteUnlock(arg_41_0, arg_41_1)
	pg = var_1_10002

	local var_41_0 = var_1_10002.child_site[arg_41_0]

	getProxy = var_1_10003
	EducateProxy = var_1_10005

	local var_41_1 = var_1_10003(var_1_10005)
	local var_41_2 = var_3.GetCurTime(var_41_1)
	local var_41_3

	if not arg_41_1 or not var_41_0.unlock_time_1 then
		var_41_3 = var_41_0.unlock_time_2
	end

	return var_0_0.InUnlockTime(var_41_2, var_41_3)
end

function var_0_0.IsMatchSubType(arg_42_0, arg_42_1)
	if arg_42_0 == "" then
		return false
	end

	type = var_1_10002

	if var_1_10002(arg_42_0) == "table" then
		table = var_2

		return var_2.contains(arg_42_0, arg_42_1)
	else
		type = var_2

		if var_2(arg_42_0) == "string" then
			tonumber = var_2

			return arg_42_1 == var_2(arg_42_0)
		end
	end

	return false
end

function var_0_0.ReqEducateDataCheck(arg_43_0)
	LOCK_EDUCATE_SYSTEM = var_1_10001

	if var_1_10001 then
		arg_43_0()

		return
	end

	local var_43_0 = {}

	getProxy = var_1_10002
	EducateProxy = var_1_10004

	local var_43_1 = var_1_10002(var_1_10004)

	if not var_2.CheckDataRequestEnd(var_43_1) then
		table = var_2

		var_2.insert(var_43_0, function(arg_44_0)
			pg = var_2_10001

			local var_44_0 = var_2_10001.m02
			local var_44_1 = var_1.sendNotification

			GAME = var_2_10004

			var_44_1(var_44_0, var_2_10004.EDUCATE_REQUEST, {
				callback = arg_44_0
			})

			return
		end)
	end

	seriesAsync = var_2

	var_2(var_43_0, arg_43_0)

	return
end

return var_0_0
