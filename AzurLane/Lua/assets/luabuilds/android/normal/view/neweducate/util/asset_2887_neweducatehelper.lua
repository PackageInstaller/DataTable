class = var_0_10000

local var_0_0 = var_0_10000("NewEducateHelper")

function var_0_0.Config2Drop(arg_1_0)
	return {
		type = arg_1_0[1],
		id = arg_1_0[2],
		number = arg_1_0[3]
	}
end

function var_0_0.Config2Drops(arg_2_0)
	local var_2_0 = {}

	underscore = var_1_10002

	var_1_10002.each(arg_2_0, function(arg_3_0)
		table = var_2_10001

		var_2_10001.insert(var_2_0, var_0_0.Config2Drop(arg_3_0))

		return
	end)

	return var_2_0
end

function var_0_0.Config2Condition(arg_4_0)
	return {
		type = arg_4_0[1],
		id = arg_4_0[2],
		operator = arg_4_0[3],
		number = arg_4_0[4]
	}
end

function var_0_0.Config2Conditions(arg_5_0)
	local var_5_0 = {}

	underscore = var_1_10002

	var_1_10002.each(arg_5_0, function(arg_6_0)
		table = var_2_10001

		var_2_10001.insert(var_5_0, var_0_0.Config2Condition(arg_6_0))

		return
	end)

	return var_5_0
end

function var_0_0.GetDropConfig(arg_7_0)
	switch = var_1_10001

	local var_7_0 = arg_7_0.type
	local var_7_1 = {}

	NewEducateConst = var_1_10004
	var_7_1[var_1_10004.DROP_TYPE.ATTR] = function()
		pg = var_2_10000

		local var_8_0 = var_2_10000.child2_attr[arg_7_0.id]

		assert = var_1

		var_1(var_8_0, "找不到child2_attr配置, id: " .. arg_7_0.id)

		return var_8_0
	end
	NewEducateConst = var_4
	var_7_1[var_4.DROP_TYPE.RES] = function()
		pg = var_2_10000

		local var_9_0 = var_2_10000.child2_resource[arg_7_0.id]

		assert = var_1

		var_1(var_9_0, "找不到child2_resource配置, id: " .. arg_7_0.id)

		return var_9_0
	end
	NewEducateConst = var_4
	var_7_1[var_4.DROP_TYPE.POLAROID] = function()
		pg = var_2_10000

		local var_10_0 = var_2_10000.child2_polaroid[arg_7_0.id]

		assert = var_1

		var_1(var_10_0, "child2_polaroid, id: " .. arg_7_0.id)

		return var_10_0
	end
	NewEducateConst = var_4
	var_7_1[var_4.DROP_TYPE.BUFF] = function()
		pg = var_2_10000

		local var_11_0 = var_2_10000.child2_benefit_list[arg_7_0.id]

		assert = var_1

		var_1(var_11_0, "找不到child2_benefit_list配置, id: " .. arg_7_0.id)

		return var_11_0
	end
	NewEducateConst = var_4
	var_7_1[var_4.DROP_TYPE.TAROT] = function()
		pg = var_2_10000

		local var_12_0 = var_2_10000.child2_benefit_list[arg_7_0.id]

		assert = var_1

		var_1(var_12_0, "找不到child2_benefit_list配置, id: " .. arg_7_0.id)

		return var_12_0
	end

	return var_1_10001(var_7_0, var_7_1, function()
		assert = var_2_10000

		var_2_10000(false, "养成二期非法掉落类型:" .. arg_7_0.type)

		return
	end)
end

function var_0_0.GetDropIcon(arg_14_0)
	local var_14_0 = var_0_0.GetDropConfig(arg_14_0)

	switch = var_2

	local var_14_1 = arg_14_0.type
	local var_14_2 = {}

	NewEducateConst = var_1_10005
	var_14_2[var_1_10005.DROP_TYPE.TAROT] = function()
		return var_14_0.item_icon_little
	end

	return var_2(var_14_1, var_14_2, function()
		return var_14_0.item_icon
	end)
end

function var_0_0.UpdateVectorItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1.type

	NewEducateConst = var_1_10004

	if var_17_0 ~= var_1_10004.DROP_TYPE.ATTR then
		local var_17_1 = arg_17_1.type

		NewEducateConst = var_4

		if var_17_1 ~= var_4.DROP_TYPE.RES then
			pg = var_17_1

			local var_17_2 = var_17_1.TipsMgr.GetInstance()

			var_3.ShowTips(var_17_2, "不支持的掉落展示for Vector,请检查配置！" .. arg_17_1.type)

			return
		end
	end

	local var_17_3 = arg_17_2 or ""
	local var_17_4 = var_0_0.GetDropConfig(arg_17_1)

	LoadImageSpriteAsync = var_5

	var_5("neweducateicon/" .. var_17_4.icon, arg_17_0:Find("icon"))

	setText = var_5

	var_5(arg_17_0:Find("name"), var_17_4.name)

	setText = var_5

	var_5(arg_17_0:Find("value"), var_17_3 .. arg_17_1.number)

	if arg_17_0:Find("benefit") then
		setActive = var_5

		var_5(arg_17_0:Find("benefit"), arg_17_1.isBenefit)

		setActive = var_5

		var_5(arg_17_0:Find("benefit/add"), arg_17_1.number > 0)

		setActive = var_5

		var_5(arg_17_0:Find("benefit/reduce"), arg_17_1.number < 0)
	end

	return
end

function var_0_0.UpdateItem(arg_18_0, arg_18_1)
	local var_18_0 = var_0_0.GetDropConfig(arg_18_1)

	LoadImageSpriteAsync = var_3

	var_3("neweducateicon/" .. var_0_0.GetDropIcon(arg_18_1), arg_18_0:Find("frame/icon"))

	setText = var_3

	var_3(arg_18_0:Find("frame/count_bg/count"), arg_18_1.number)

	setText = var_3

	local var_18_1 = arg_18_0
	local var_18_2 = arg_18_0.Find(var_18_1, "name_bg/name")

	shortenString = var_18_1

	var_3(var_18_2, var_18_1(var_18_0.name, 5))

	if arg_18_0:Find("frame/benefit") then
		setActive = var_3

		var_3(arg_18_0:Find("frame/benefit"), arg_18_1.isBenefit)
	end

	return
end

function var_0_0.NormalType2SiteType(arg_19_0)
	switch = var_1_10001

	local var_19_0 = arg_19_0
	local var_19_1 = {}

	NewEducateConst = var_1_10004
	var_19_1[var_1_10004.SITE_NORMAL_TYPE.WORK] = function()
		NewEducateConst = var_2_10000

		return var_2_10000.SITE_TYPE.WORK
	end
	NewEducateConst = var_4
	var_19_1[var_4.SITE_NORMAL_TYPE.TRAVEL] = function()
		NewEducateConst = var_2_10000

		return var_2_10000.SITE_TYPE.TRAVEL
	end

	return var_1_10001(var_19_0, var_19_1)
end

function var_0_0.FilterBenefit(arg_22_0)
	underscore = var_1_10001

	return var_1_10001.select(arg_22_0, function(arg_23_0)
		local var_23_0 = arg_23_0.type

		NewEducateConst = var_2_10002

		if var_23_0 == var_2_10002.DROP_TYPE.BUFF then
			local var_23_1 = arg_23_0.type

			NewEducateConst = var_2

			if var_23_1 == var_2.DROP_TYPE.BUFF then
				pg = var_23_1

				local var_23_2

				if var_23_1.child2_benefit_list[arg_23_0.id].is_show ~= 1 or not (arg_23_0.number > 0) then
					var_23_2 = false

					goto label_23_0
				end

				var_23_2 = true

				::label_23_0::

				return var_23_2
			end
		end
	end)
end

function var_0_0.MergeDrops(arg_24_0)
	local var_24_0 = {}

	ipairs = var_1_10002

	for iter_24_0, iter_24_1 in var_1_10002(arg_24_0) do
		if not var_24_0[iter_24_1.type] then
			var_24_0[iter_24_1.type] = {}
		end

		local var_24_1 = var_24_0[iter_24_1.type]

		var_1_10008 = iter_24_1.id

		local var_24_2

		if not var_24_0[iter_24_1.type][iter_24_1.id] then
			var_24_2 = 0
		end

		var_24_1[var_1_10008] = var_24_2 + iter_24_1.number
	end

	local var_24_3 = {}

	pairs = var_3

	for iter_24_2, iter_24_3 in var_3(var_24_0) do
		pairs = var_1_10008

		for iter_24_4, iter_24_5 in var_1_10008(iter_24_3) do
			table = var_1_10013

			var_1_10013.insert(var_24_3, {
				type = iter_24_2,
				id = iter_24_4,
				number = iter_24_5
			})
		end
	end

	return var_24_3
end

function var_0_0.GetSiteColors(arg_25_0)
	pg = var_1_10001

	local var_25_0 = var_1_10001.child2_site_display[arg_25_0]

	switch = var_1_10002

	local var_25_1 = var_25_0.type
	local var_25_2 = {}

	NewEducateConst = var_1_10005
	var_25_2[var_1_10005.SITE_TYPE.WORK] = function()
		Color = var_2_10000

		local var_26_0 = var_2_10000.NewHex("f6bb56")

		Color = var_1

		local var_26_1 = var_1.NewHex("eea221")
	end
	NewEducateConst = var_5
	var_25_2[var_5.SITE_TYPE.TRAVEL] = function()
		Color = var_2_10000

		local var_27_0 = var_2_10000.NewHex("f6bb56")

		Color = var_1

		local var_27_1 = var_1.NewHex("eea221")
	end
	NewEducateConst = var_5
	var_25_2[var_5.SITE_TYPE.EVENT] = function()
		Color = var_2_10000

		local var_28_0 = var_2_10000.NewHex("887af2")

		Color = var_1

		local var_28_1 = var_1.NewHex("7668e2")
	end
	NewEducateConst = var_5
	var_25_2[var_5.SITE_TYPE.SHIP] = function()
		if var_25_0.bg == "red" then
			Color = var_0

			local var_29_0 = var_0.NewHex("d96964")

			Color = var_1

			local var_29_1 = var_1.NewHex("d96964")

			return
		elseif var_25_0.bg == "blue" then
			Color = var_0

			local var_29_2 = var_0.NewHex("39bfff")

			Color = var_1

			local var_29_3 = var_1.NewHex("26b1f3")

			return
		end

		return
	end

	return var_1_10002(var_25_1, var_25_2)
end

function var_0_0.PlaySpecialStory(arg_30_0, arg_30_1)
	getProxy = var_1_10002
	NewEducateProxy = var_1_10003

	local var_30_0 = var_1_10002(var_1_10003)
	local var_30_1 = var_2.GetCurChar(var_30_0).id .. "_" .. var_2:GetPersonalityTag()

	pg = var_4

	local var_30_2 = var_4.NewStoryMgr.GetInstance()
	local var_30_3 = not var_4.IsPlayed(var_30_2, arg_30_0)

	pg = var_30_2

	local var_30_4 = var_30_2.NewStoryMgr.GetInstance()

	var_5.PlayForTb(var_30_4, arg_30_0, var_30_1, function(arg_31_0, arg_31_1)
		existCall = var_2_10002

		var_2_10002(arg_30_1(arg_31_0, arg_31_1))

		return
	end, true)

	if var_30_3 then
		getProxy = var_5
		NewEducateProxy = var_30_4

		local var_30_5 = var_5(var_30_4)

		var_5.UpdateUnlock(var_30_5)

		local var_30_6 = var_2:GetPermanentData()

		if var_5.GetMemoryIdByName(var_30_6, arg_30_0) then
			pg = var_30_6

			local var_30_7 = var_30_6.m02
			local var_30_8 = var_6.sendNotification

			GAME = var_8

			local var_30_9 = var_8.NEW_EDUCATE_TRACK

			NewEducateTrackCommand = var_9

			var_30_8(var_30_7, var_30_9, var_9.BuildDataMemory(var_2:GetGameCnt(), var_2:GetRoundData().round, var_5))
		end
	end

	return
end

function var_0_0.PlaySpecialStoryList(arg_32_0, arg_32_1)
	local var_32_0 = {}

	ipairs = var_1_10003

	for iter_32_0, iter_32_1 in var_1_10003(arg_32_0) do
		table = var_1_10008

		var_1_10008.insert(var_32_0, function(arg_33_0)
			var_0_0.PlaySpecialStory(iter_32_1, arg_33_0)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_32_0, function()
		existCall = var_2_10000

		var_2_10000(arg_32_1)

		return
	end)

	return
end

function var_0_0.IsPersonalDrop(arg_35_0)
	local var_35_0 = arg_35_0.type

	NewEducateConst = var_1_10002

	if var_35_0 == var_1_10002.DROP_TYPE.ATTR then
		pg = var_35_0

		local var_35_1 = var_35_0.child2_attr[arg_35_0.id].type

		NewEducateChar = var_2

		local var_35_2

		if var_35_1 ~= var_2.ATTR_TYPE.PERSONALITY then
			var_35_2 = false
		else
			var_35_2 = true
		end

		return var_35_2
	end
end

function var_0_0.GetBenefitValue(arg_36_0, arg_36_1)
	math = var_1_10002

	local var_36_0 = var_1_10002.max
	local var_36_1 = 0

	math = var_1_10004

	return var_36_0(var_36_1, var_1_10004.floor(arg_36_0 * (1 + arg_36_1.ratio / 16) + arg_36_1.value))
end

function var_0_0.GetTarotDetailDescKey()
	getProxy = var_1_10000
	PlayerProxy = var_1_10001

	local var_37_0 = var_1_10000(var_1_10001)
	local var_37_1 = var_0.getRawData(var_37_0).id

	getProxy = var_37_0
	NewEducateProxy = var_1_10002

	local var_37_2 = var_37_0(var_1_10002)
	local var_37_3 = var_1.GetCurChar(var_37_2).id

	NewEducateConst = var_37_2

	return var_37_2.NEW_EDUCATE_TAROT_DETAIL_DESC .. "_" .. var_37_1 .. "_" .. var_37_3
end

function var_0_0.IsShowTarotDeatilDesc()
	PlayerPrefs = var_1_10000

	return var_1_10000.GetInt(var_0_0.GetTarotDetailDescKey()) == 1
end

function var_0_0.SetTarotDeatilDescData(arg_39_0)
	PlayerPrefs = var_1_10001

	local var_39_0 = var_1_10001.SetInt
	local var_39_1 = var_0_0

	var_39_0(var_2.GetTarotDetailDescKey(var_39_1), arg_39_0 and 1 or 0)

	return
end

function var_0_0.GetNewTipKey()
	getProxy = var_1_10000
	PlayerProxy = var_1_10001

	local var_40_0 = var_1_10000(var_1_10001)
	local var_40_1 = var_0.getRawData(var_40_0).id

	pg = var_40_0

	local var_40_2 = var_40_0.child2_data.all

	pg = var_1_10002

	local var_40_3 = var_40_2[#var_1_10002.child2_data.all]

	NewEducateConst = var_2

	return var_2.NEW_EDUCATE_NEW_CHILD_TIP .. "_" .. var_40_1 .. "_" .. var_40_3
end

function var_0_0.IsShowNewChildTip()
	LOCK_EDUCATE_SYSTEM = var_1_10000

	if not var_1_10000 then
		LOCK_NEW_EDUCATE_SYSTEM = var_1_10000

		if var_1_10000 then
			return false
		end

		getProxy = var_1_10000
		PlayerProxy = var_1_10001

		local var_41_0 = var_1_10000(var_1_10001)
		local var_41_1 = var_0.getRawData(var_41_0)

		LOCK_NEW_EDUCATE_SYSTEM = var_41_0

		local var_41_2 = var_41_0 and "EducateMediator" or "NewEducateSelectMediator"

		pg = var_1_10002

		local var_41_3 = var_1_10002.SystemOpenMgr.GetInstance()

		if not var_2.isOpenSystem(var_41_3, var_41_1.level, var_41_2) then
			return false
		end

		PlayerPrefs = var_41_3

		return var_41_3.GetInt(var_0_0.GetNewTipKey()) ~= 1
	end
end

function var_0_0.ClearShowNewChildTip()
	PlayerPrefs = var_1_10000

	var_1_10000.SetInt(var_0_0.GetNewTipKey(), 1)

	return
end

function var_0_0.ClearEventPerformance(arg_43_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_43_0 = var_1_10001(var_1_10002)
	local var_43_1 = var_1.getRawData(var_43_0).id

	NewEducateConst = var_43_0

	local var_43_2 = var_43_0.NEW_EDUCATE_EVENT_TIP .. "_" .. var_43_1 .. "_" .. arg_43_0.id .. "_" .. arg_43_0:GetGameCnt() .. "_"

	underscore = var_3

	local var_43_3 = var_3.select

	pg = var_4

	local var_43_4 = var_43_3(var_4.child2_site_event_group.all, function(arg_44_0)
		pg = var_2_10001

		return #var_2_10001.child2_site_event_group[arg_44_0].performance > 0
	end)

	underscore = var_4

	var_4.each(var_43_4, function(arg_45_0)
		PlayerPrefs = var_2_10001

		var_2_10001.SetInt(var_43_2 .. arg_45_0, 0)

		return
	end)

	return
end

function var_0_0.TrackRoundEnd()
	getProxy = var_1_10000
	NewEducateProxy = var_1_10001

	local var_46_0 = var_1_10000(var_1_10001)
	local var_46_1 = var_0.GetCurChar(var_46_0)

	underscore = var_46_0

	local var_46_2

	if not var_46_0.map(var_46_1:GetAttrIds(), function(arg_47_0)
		local var_47_0 = var_46_1

		return var_1.GetAttr(var_47_0, arg_47_0)
	end) then
		var_46_2 = {}
	end

	local var_46_3 = var_46_1:GetBenefitData()
	local var_46_4, var_46_5 = var_2.GetAllIds(var_46_3)

	pg = var_1_10004

	local var_46_6 = var_1_10004.m02
	local var_46_7 = var_4.sendNotification

	GAME = var_1_10006

	local var_46_8 = var_1_10006.NEW_EDUCATE_TRACK

	NewEducateTrackCommand = var_1_10007

	local var_46_9 = var_1_10007.BuildDataRoundEnd
	local var_46_10 = var_46_1.id
	local var_46_11 = var_46_1:GetGameCnt()
	local var_46_12 = var_46_1:GetRoundData().round
	local var_46_13 = var_46_1
	local var_46_14 = var_46_1.GetResByType

	NewEducateChar = var_1_10013

	local var_46_15 = var_46_14(var_46_13, var_1_10013.RES_TYPE.MOOD)
	local var_46_16 = var_46_1
	local var_46_17 = var_46_1.GetResByType

	NewEducateChar = var_1_10014

	local var_46_18 = var_46_17(var_46_16, var_1_10014.RES_TYPE.MONEY)
	local var_46_19 = var_46_1
	local var_46_20 = var_46_1.GetResByType

	NewEducateChar = var_1_10015

	local var_46_21 = var_46_20(var_46_19, var_1_10015.RES_TYPE.FAVOR)
	local var_46_22 = var_46_1
	local var_46_23 = var_46_1.GetPersonality(var_46_22)

	table = var_46_22

	local var_46_24 = var_46_22.concat(var_46_2, ",")

	table = var_16

	local var_46_25 = var_16.concat(var_46_4, ",")
	local var_46_26 = ";"

	table = var_18

	var_46_7(var_46_6, var_46_8, var_46_9(var_46_10, var_46_11, var_46_12, var_46_15, var_46_18, var_46_21, var_46_23, var_46_24, var_46_25 .. var_46_26 .. var_18.concat(var_46_5, ",")))

	return
end

function var_0_0.TrackEnterTime()
	getProxy = var_1_10000
	NewEducateProxy = var_1_10001

	local var_48_0 = var_1_10000(var_1_10001)

	if var_0.GetEnterTime(var_48_0) == 0 then
		getProxy = var_48_0
		NewEducateProxy = var_1_10002

		local var_48_1 = var_48_0(var_1_10002)

		var_1.RecordEnterTime(var_48_1)

		getProxy = var_1
		NewEducateProxy = var_48_1

		local var_48_2 = var_1(var_48_1)
		local var_48_3 = var_1.GetCurChar(var_48_2).id

		pg = var_48_2

		local var_48_4 = var_48_2.m02
		local var_48_5 = var_2.sendNotification

		GAME = var_1_10004

		local var_48_6 = var_1_10004.NEW_EDUCATE_TRACK

		NewEducateTrackCommand = var_1_10005

		var_48_5(var_48_4, var_48_6, var_1_10005.BuildDataEnter(var_48_3, 0))
	end

	return
end

function var_0_0.TrackExitTime()
	getProxy = var_1_10000
	NewEducateProxy = var_1_10001

	local var_49_0 = var_1_10000(var_1_10001)

	if var_0.GetEnterTime(var_49_0) ~= 0 then
		pg = var_49_0

		local var_49_1 = var_49_0.TimeMgr.GetInstance()
		local var_49_2 = var_1.GetServerTime(var_49_1) - var_0

		getProxy = var_49_1
		NewEducateProxy = var_1_10003

		local var_49_3 = var_49_1(var_1_10003)
		local var_49_4 = var_2.GetCurChar(var_49_3).id

		pg = var_49_3

		local var_49_5 = var_49_3.m02
		local var_49_6 = var_3.sendNotification

		GAME = var_1_10005

		local var_49_7 = var_1_10005.NEW_EDUCATE_TRACK

		NewEducateTrackCommand = var_1_10006

		var_49_6(var_49_5, var_49_7, var_1_10006.BuildDataEnter(var_49_4, 1, var_49_2))

		getProxy = var_49_6
		NewEducateProxy = var_49_5

		local var_49_8 = var_49_6(var_49_5)

		var_3.RecordEnterTime(var_49_8, 0)
	end

	return
end

function var_0_0.GetAllUnlockSecretaryIds()
	getProxy = var_1_10000
	EducateProxy = var_1_10001

	local var_50_0 = var_1_10000(var_1_10001)
	local var_50_1

	if not var_0.GetSecretaryIDs(var_50_0) then
		var_50_1 = {}
	end

	LOCK_NEW_EDUCATE_SYSTEM = var_50_0

	if not var_50_0 then
		getProxy = var_50_0
		NewEducateProxy = var_1_10002

		local var_50_2 = var_50_0(var_1_10002)

		ipairs = var_1_10002
		pg = var_1_10003

		for iter_50_0, iter_50_1 in var_1_10002(var_1_10003.child2_data.all) do
			if var_50_2:GetChar(iter_50_1) then
				local var_50_3 = var_50_2:GetChar(iter_50_1)

				if var_7.GetPermanentData(var_50_3) then
					local var_50_4 = var_50_2:GetChar(iter_50_1)
					local var_50_5 = var_7.GetPermanentData(var_50_4)
					local var_50_6 = var_7.GetUnlockSecretaryIds(var_50_5)

					table = var_50_5
					var_50_1 = var_50_5.mergeArray(var_50_1, var_50_6)
				end
			end
		end
	end

	return var_50_1
end

function var_0_0.GetEducateCharacterList()
	local var_51_0 = {}

	pairs = var_1_10001
	pg = var_1_10002

	for iter_51_0, iter_51_1 in var_1_10001(var_1_10002.secretary_special_ship.get_id_list_by_character_id) do
		LOCK_NEW_EDUCATE_SYSTEM = var_1_10006

		if not var_1_10006 or iter_51_0 == 1000 then
			table = var_1_10006
			var_1_10006 = var_1_10006.insert

			local var_51_1 = var_51_0

			EducateCharCharacter = var_1_10008

			var_1_10006(var_51_1, var_1_10008.New(iter_51_0))
		end
	end

	return var_51_0
end

function var_0_0.GetSecIdBySkinId(arg_52_0)
	ipairs = var_1_10001
	pg = var_1_10002

	for iter_52_0, iter_52_1 in var_1_10001(var_1_10002.secretary_special_ship.all) do
		pg = var_1_10006
		var_1_10006 = var_1_10006.secretary_special_ship[iter_52_1].unlock_type
		EducateConst = var_1_10007

		if var_1_10006 == var_1_10007.SECRETARY_UNLCOK_TYPE_SHOP then
			pg = var_1_10006

			if var_1_10006.secretary_special_ship[iter_52_1].unlock[1] == arg_52_0 then
				return iter_52_1
			end
		end
	end

	return
end

function var_0_0.GetShipNameBySecId(arg_53_0)
	pg = var_1_10001

	return var_1_10001.secretary_special_ship[arg_53_0].name
end

function var_0_0.IsUnlockDefaultShip(arg_54_0)
	pg = var_1_10001

	local var_54_0 = var_1_10001.secretary_special_ship[arg_54_0].character_id
	local var_54_1 = var_0_0.GetAllUnlockSecretaryIds()

	table = var_1_10003

	return var_1_10003.contains(var_54_1, var_54_0)
end

function var_0_0.HasAnyUnlockShip()
	if not var_0_0.GetAllUnlockSecretaryIds() then
		return false
	end

	_ = var_1_10001

	return var_1_10001.any(var_0, function(arg_56_0)
		pg = var_2_10001

		return var_2_10001.secretary_special_ship[arg_56_0].character_id == arg_56_0
	end)
end

function var_0_0.UpdateUnlockBySkinId(arg_57_0)
	local var_57_0 = var_0_0.GetSecIdBySkinId(arg_57_0)

	pg = var_2

	if var_2.secretary_special_ship[var_57_0].tb_id == 0 then
		getProxy = var_1_10003
		EducateProxy = var_1_10004
		var_1_10004 = var_1_10003(var_1_10004)

		var_1_10003.updateSecretaryIDs(var_1_10004, true)
	else
		getProxy = var_1_10003
		NewEducateProxy = var_1_10004

		local var_57_1 = var_1_10003(var_1_10004)

		var_3.UpdateUnlock(var_57_1, var_2)
	end

	return
end

function var_0_0.GetEducateCharSlotMaxCnt()
	LOCK_EDUCATE_SYSTEM = var_1_10000

	if var_1_10000 then
		return 0
	end

	getProxy = var_1_10000
	PlayerProxy = var_1_10001

	local var_58_0 = var_1_10000(var_1_10001)
	local var_58_1 = var_0.getRawData(var_58_0)

	if var_0.ExistEducateChar(var_58_1) or var_0_0.HasAnyUnlockShip() then
		return 1
	else
		return 0
	end

	return
end

function var_0_0.ReqDataForServer()
	local var_59_0 = {}

	LOCK_EDUCATE_SYSTEM = var_1_10001

	if not var_1_10001 then
		table = var_1_10001

		var_1_10001.insert(var_59_0, function(arg_60_0)
			pg = var_2_10001

			local var_60_0 = var_2_10001.ConnectionMgr.GetInstance()

			var_1.Send(var_60_0, 27000, {
				type = 1
			}, 27001, arg_60_0)

			return
		end)
	end

	LOCK_NEW_EDUCATE_SYSTEM = var_1_10001

	if not var_1_10001 then
		ipairs = var_1_10001
		pg = var_1_10002

		for iter_59_0, iter_59_1 in var_1_10001(var_1_10002.child2_data.all) do
			table = var_1_10006

			var_1_10006.insert(var_59_0, function(arg_61_0)
				pg = var_2_10001

				local var_61_0 = var_2_10001.ConnectionMgr.GetInstance()

				var_1.Send(var_61_0, 29001, {
					id = iter_59_1
				}, 29002, arg_61_0)

				return
			end)
		end
	end

	seriesAsync = var_1_10001

	var_1_10001(var_59_0, function()
		return
	end)

	return
end

return var_0_0
