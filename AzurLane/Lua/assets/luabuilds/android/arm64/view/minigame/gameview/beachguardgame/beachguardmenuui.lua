class = var_0_10000

local var_0_0 = var_0_10000("BeachGuardMenuUI")
local var_0_1 = "beach_guard_chaijun"
local var_0_2 = "beach_guard_jianye"
local var_0_3 = "beach_guard_lituoliao"
local var_0_4 = "beach_guard_bominghan"
local var_0_5 = "beach_guard_nengdai"
local var_0_6 = "beach_guard_m_craft"
local var_0_7 = "beach_guard_m_atk"
local var_0_8 = "beach_guard_m_guard"
local var_0_9 = "beach_guard_m_craft_name"
local var_0_10 = "beach_guard_m_atk_name"
local var_0_11 = "beach_guard_m_guard_name"
local var_0_12 = "beach_guard_e1"
local var_0_13 = "beach_guard_e2"
local var_0_14 = "beach_guard_e3"
local var_0_15 = "beach_guard_e4"
local var_0_16 = "beach_guard_e5"
local var_0_17 = "beach_guard_e6"
local var_0_18 = "beach_guard_e7"
local var_0_19 = "beach_guard_e1_desc"
local var_0_20 = "beach_guard_e2_desc"
local var_0_21 = "beach_guard_e3_desc"
local var_0_22 = "beach_guard_e4_desc"
local var_0_23 = "beach_guard_e5_desc"
local var_0_24 = "beach_guard_e6_desc"
local var_0_25 = "beach_guard_e7_desc"
local var_0_26 = {
	{
		{
			img = "char_1",
			img_desc = "char_1_desc",
			id = 900913,
			icon = "char_1_icon",
			desc = var_0_1
		},
		{
			img = "char_2",
			img_desc = "char_2_desc",
			id = 319011,
			icon = "char_2_icon",
			desc = var_0_2
		},
		{
			img = "char_3",
			img_desc = "char_3_desc",
			id = 605021,
			icon = "char_3_icon",
			desc = var_0_3
		},
		{
			img = "char_4",
			img_desc = "char_4_desc",
			id = 102231,
			icon = "char_4_icon",
			desc = var_0_4
		},
		{
			img = "char_5",
			img_desc = "char_5_desc",
			id = 302211,
			icon = "char_5_icon",
			desc = var_0_5
		},
		{
			icon = "m_craft_icon",
			img = "m_craft",
			name = var_0_9,
			desc = var_0_6
		},
		{
			icon = "m_atk_icon",
			img = "m_atk",
			name = var_0_10,
			desc = var_0_7
		},
		{
			icon = "m_guard_icon",
			img = "m_guard",
			name = var_0_11,
			desc = var_0_8
		}
	},
	{
		{
			icon = "e1_icon",
			img = "e1",
			name = var_0_12,
			desc = var_0_19
		},
		{
			icon = "e2_icon",
			img = "e2",
			name = var_0_13,
			desc = var_0_20
		},
		{
			icon = "e3_icon",
			img = "e3",
			name = var_0_14,
			desc = var_0_21
		},
		{
			icon = "e4_icon",
			img = "e4",
			name = var_0_15,
			desc = var_0_22
		},
		{
			icon = "e5_icon",
			img = "e5",
			name = var_0_16,
			desc = var_0_23
		},
		{
			icon = "e6_icon",
			img = "e6",
			name = var_0_17,
			desc = var_0_24
		},
		{
			icon = "e7_icon",
			img = "e7",
			name = var_0_18,
			desc = var_0_25
		}
	},
	{}
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_3
	arg_1_0._gameData = arg_1_2
	findTF = var_1_10004
	arg_1_0.menuUI = var_1_10004(arg_1_0._tf, "ui/menuUI")
	GetComponent = var_4
	findTF = var_6

	local var_1_0 = var_6(arg_1_0.menuUI, "ad/battList")

	typeof = var_7
	ScrollRect = var_9
	arg_1_0.battleScrollRect = var_4(var_1_0, var_7(var_9))
	arg_1_0.totalTimes = arg_1_0._gameData.total_times
	arg_1_0.battleItems = {}
	arg_1_0.dropItems = {}
	GetComponent = var_4
	findTF = var_1_0

	local var_1_1 = var_1_0(arg_1_0.menuUI, "desc")

	typeof = var_7
	Image = var_9

	local var_1_2 = var_4(var_1_1, var_7(var_9))

	var_4.SetNativeSize(var_1_2)

	onButton = var_5

	local var_1_3 = arg_1_0._event

	findTF = var_8

	local var_1_4 = var_8(arg_1_0.menuUI, "ad/rightPanelBg/arrowUp")

	local function var_1_5()
		local var_2_0 = arg_1_0.battleScrollRect.normalizedPosition.y + 1 / (arg_1_0.totalTimes - 4)

		if 1 < var_2_0 then
			var_2_0 = 1
		end

		scrollTo = var_1

		var_1(arg_1_0.battleScrollRect, 0, var_2_0)

		return
	end

	SFX_CANCEL = var_10

	var_5(var_1_3, var_1_4, var_1_5, var_10)

	onButton = var_5

	local var_1_6 = arg_1_0._event

	findTF = var_1_4

	local var_1_7 = var_1_4(arg_1_0.menuUI, "ad/rightPanelBg/arrowDown")

	local function var_1_8()
		local var_3_0

		if arg_1_0.battleScrollRect.normalizedPosition.y - 1 / (arg_1_0.totalTimes - 4) < 0 then
			var_3_0 = 0
		end

		scrollTo = var_1

		var_1(arg_1_0.battleScrollRect, 0, var_3_0)

		return
	end

	SFX_CANCEL = var_10

	var_5(var_1_6, var_1_7, var_1_8, var_10)

	onButton = var_5

	local var_1_9 = arg_1_0._event

	findTF = var_1_7

	local var_1_10 = var_1_7(arg_1_0.menuUI, "ad/btnBack")

	local function var_1_11()
		local var_4_0 = arg_1_0._event
		local var_4_1 = var_0.emit

		BeachGuardGameView = var_2_10003

		var_4_1(var_4_0, var_2_10003.CLOSE_GAME)

		return
	end

	SFX_CANCEL = var_10

	var_5(var_1_9, var_1_10, var_1_11, var_10)

	onButton = var_5

	local var_1_12 = arg_1_0._event

	findTF = var_1_10

	local var_1_13 = var_1_10(arg_1_0.menuUI, "btnRule")

	local function var_1_14()
		local var_5_0 = arg_1_0._event
		local var_5_1 = var_0.emit

		BeachGuardGameView = var_2_10003

		var_5_1(var_5_0, var_2_10003.SHOW_RULE)

		return
	end

	SFX_CANCEL = var_10

	var_5(var_1_12, var_1_13, var_1_14, var_10)

	onButton = var_5

	local var_1_15 = arg_1_0._event

	findTF = var_1_13

	local var_1_16 = var_1_13(arg_1_0.menuUI, "btnStart")

	local function var_1_17()
		local var_6_0 = arg_1_0._event
		local var_6_1 = var_0.emit

		BeachGuardGameView = var_2_10003

		var_6_1(var_6_0, var_2_10003.READY_START)

		return
	end

	SFX_CANCEL = var_10

	var_5(var_1_15, var_1_16, var_1_17, var_10)

	onButton = var_5

	local var_1_18 = arg_1_0._event

	findTF = var_1_16

	local var_1_19 = var_1_16(arg_1_0.menuUI, "ad/btnGameBook")

	local function var_1_20()
		isActive = var_2_10000

		if var_2_10000(arg_1_0.bookUI) then
			setActive = var_0

			var_0(arg_1_0.bookUI, false)

			local var_7_0 = arg_1_0._event
			local var_7_1 = var_0.emit

			BeachGuardGameView = var_2_10003

			var_7_1(var_7_0, var_2_10003.OPEN_BOOK, false)
		else
			local var_7_2 = arg_1_0._event
			local var_7_3 = var_0.emit

			BeachGuardGameView = var_2_10003

			var_7_3(var_7_2, var_2_10003.OPEN_BOOK, true)

			setActive = var_7_3

			var_7_3(arg_1_0.bookUI, true)
		end

		return
	end

	SFX_CANCEL = var_10

	var_5(var_1_18, var_1_19, var_1_20, var_10)

	findTF = var_5

	local var_1_21 = var_5(arg_1_0.menuUI, "tplBattleItem")
	local var_1_22 = arg_1_0._gameData.drop

	for iter_1_0 = 1, 7 do
		tf = var_1_23
		instantiate = var_1_10013

		local var_1_23 = var_1_23(var_1_10013(var_1_21))

		var_1_23.name = "battleItem_" .. iter_1_0
		setParent = var_12
		var_1_10014 = var_1_23
		findTF = var_1_10015

		var_12(var_1_10014, var_1_10015(arg_1_0.menuUI, "ad/battList/Viewport/Content"))

		local var_1_24 = iter_1_0

		GetSpriteFromAtlasAsync = var_1_10013

		var_1_10013(arg_1_0._gameData.path, "battleDesc" .. var_1_24, function(arg_8_0)
			if arg_8_0 then
				setImageSprite = var_2_10001
				findTF = var_2_10003

				var_2_10001(var_2_10003(var_1_23, "state_open/desc"), arg_8_0, true)

				setImageSprite = var_2_10001
				findTF = var_3

				var_2_10001(var_3(var_1_23, "state_clear/desc"), arg_8_0, true)

				setImageSprite = var_2_10001
				findTF = var_3

				var_2_10001(var_3(var_1_23, "state_current/desc"), arg_8_0, true)

				setImageSprite = var_2_10001
				findTF = var_3

				var_2_10001(var_3(var_1_23, "state_closed/desc"), arg_8_0, true)
			end

			return
		end)

		findTF = var_1_10013
		var_1_10013 = var_1_10013(var_1_23, "icon")
		var_1_10014 = {
			type = var_1_22[iter_1_0][1],
			id = var_1_22[iter_1_0][2],
			amount = var_1_22[iter_1_0][3]
		}
		updateDrop = var_1_10015

		var_1_10015(var_1_10013, var_1_10014)

		onButton = var_1_10015

		local var_1_25 = arg_1_0._event
		local var_1_26 = var_1_10013

		function var_1_10019()
			local var_9_0 = arg_1_0._event
			local var_9_1 = var_0.emit

			BaseUI = var_2_10003

			var_9_1(var_9_0, var_2_10003.ON_DROP, var_1_10014)

			return
		end

		SFX_PANEL = var_1_10020

		var_1_10015(var_1_25, var_1_26, var_1_10019, var_1_10020)

		table = var_1_10015

		var_1_10015.insert(arg_1_0.dropItems, var_1_10013)

		setActive = var_1_10015

		var_1_10015(var_1_23, true)

		table = var_1_10015

		var_1_10015.insert(arg_1_0.battleItems, var_1_23)
	end

	findTF = var_7
	arg_1_0.bookUI = var_7(arg_1_0.menuUI, "bookUI")
	setActive = var_7

	var_7(arg_1_0.bookUI, false)

	onButton = var_7

	local var_1_27 = arg_1_0._event

	findTF = var_10

	local var_1_28 = var_10(arg_1_0.bookUI, "bottom")

	local function var_1_29()
		isActive = var_2_10000

		if var_2_10000(arg_1_0.bookUI) then
			setActive = var_0

			var_0(arg_1_0.bookUI, false)
		end

		return
	end

	SFX_PANEL = var_12

	var_7(var_1_27, var_1_28, var_1_29, var_12)

	arg_1_0.selectTagIndex = nil
	arg_1_0.selectGridIndex = nil
	arg_1_0.bookUITags = {}
	arg_1_0.grids = {}
	findTF = var_7
	arg_1_0.iconImage = var_7(arg_1_0.bookUI, "bg/icon/img")
	findTF = var_7
	arg_1_0.iconDesc = var_7(arg_1_0.bookUI, "bg/icon/img_desc")
	findTF = var_7
	arg_1_0.descBoundTxt = var_7(arg_1_0.bookUI, "bg/descBound/desc")
	findTF = var_7
	arg_1_0.descBoundTitle = var_7(arg_1_0.bookUI, "bg/descBound/title")

	local var_1_30 = 8

	for iter_1_1 = 1, 3 do
		local var_1_31 = iter_1_1

		findTF = var_1_32

		local var_1_32 = var_1_32(arg_1_0.bookUI, "bg/tag" .. iter_1_1)

		if iter_1_1 == 3 then
			setActive = var_1_10014

			var_1_10014(var_1_32, false)
		end

		onButton = var_1_10014
		var_1_10016 = arg_1_0._event

		local var_1_33 = var_1_32

		local function var_1_34()
			local var_11_0 = arg_1_0

			var_0.selectBookTag(var_11_0, var_1_31)

			return
		end

		SFX_PANEL = var_1_10019

		var_1_10014(var_1_10016, var_1_33, var_1_34, var_1_10019)

		table = var_1_10014

		var_1_10014.insert(arg_1_0.bookUITags, var_1_32)
	end

	findTF = var_8

	local var_1_35 = var_8(arg_1_0.bookUI, "bg/gridTpl")

	for iter_1_2 = 1, var_1_30 do
		local var_1_36 = iter_1_2

		tf = var_1_10014
		instantiate = var_1_10016
		var_1_10014 = var_1_10014(var_1_10016(var_1_35))
		setActive = var_1_10015

		var_1_10015(var_1_10014, true)

		setParent = var_1_10015

		local var_1_37 = var_1_10014

		findTF = var_18

		var_1_10015(var_1_37, var_18(arg_1_0.bookUI, "container/Viewport/Content"))

		onButton = var_1_10015

		local var_1_38 = arg_1_0._event
		local var_1_39 = var_1_10014

		local function var_1_40()
			local var_12_0 = arg_1_0

			var_0.selectGrid(var_12_0, var_1_36)

			return
		end

		SFX_PANEL = var_20

		var_1_10015(var_1_38, var_1_39, var_1_40, var_20)

		table = var_1_10015

		var_1_10015.insert(arg_1_0.grids, var_1_10014)
	end

	arg_1_0:selectBookTag(1)

	return
end

function var_0_0.selectBookTag(arg_13_0, arg_13_1)
	if arg_13_0.selectTagIndex ~= arg_13_1 then
		arg_13_0.selectTagIndex = arg_13_1
		arg_13_0.bookDatas = var_0_26[arg_13_1]

		for iter_13_0 = 1, #arg_13_0.bookUITags do
			if arg_13_1 == iter_13_0 then
				setActive = var_1_10006
				findTF = var_1_10008

				var_1_10006(var_1_10008(arg_13_0.bookUITags[iter_13_0], "select"), true)
			else
				setActive = var_1_10006
				findTF = var_1_10008

				var_1_10006(var_1_10008(arg_13_0.bookUITags[iter_13_0], "select"), false)
			end
		end

		for iter_13_1 = 1, #arg_13_0.grids do
			local var_13_0 = arg_13_0.grids[iter_13_1]
			local var_13_1

			if iter_13_1 <= #arg_13_0.bookDatas then
				var_13_1 = arg_13_0.bookDatas[iter_13_1]
				GetSpriteFromAtlas = var_1_10008
				var_1_10008 = var_1_10008(arg_13_0._gameData.path, var_13_1.icon)

				local var_13_2

				if var_13_1.id then
					pg = var_10
					var_13_2 = var_10.ship_data_statistics[var_13_1.id].name
				else
					i18n = var_10
					var_13_2 = var_10(var_13_1.name)
				end

				setText = var_10
				findTF = var_1_10012

				var_10(var_1_10012(var_13_0, "name"), var_13_2)

				setImageSprite = var_10
				findTF = var_1_10012

				var_10(var_1_10012(var_13_0, "icon"), var_1_10008, true)

				setActive = var_10

				var_10(var_13_0, true)
			else
				setActive = var_13_1

				var_13_1(var_13_0, false)
			end
		end

		arg_13_0.selectGridIndex = nil

		arg_13_0:selectGrid(1)
	end

	return
end

function var_0_0.selectGrid(arg_14_0, arg_14_1)
	if arg_14_0.selectGridIndex ~= arg_14_1 then
		arg_14_0.selectGridIndex = arg_14_1

		local var_14_0 = arg_14_0.bookDatas[arg_14_1]

		for iter_14_0 = 1, #arg_14_0.grids do
			local var_14_1 = arg_14_0.grids[iter_14_0]

			if iter_14_0 == arg_14_1 then
				setActive = var_1_10008
				findTF = var_1_10010

				var_1_10008(var_1_10010(var_14_1, "select"), true)
			else
				setActive = var_1_10008
				findTF = var_1_10010

				var_1_10008(var_1_10010(var_14_1, "select"), false)
			end
		end

		local var_14_2

		if var_14_0.img then
			GetSpriteFromAtlas = var_14_2
			var_14_2 = var_14_2(arg_14_0._gameData.path, var_14_0.img)
			setImageSprite = var_4

			var_4(arg_14_0.iconImage, var_14_2, true)

			setActive = var_4

			var_4(arg_14_0.iconImage, true)
		else
			setActive = var_14_2

			var_14_2(arg_14_0.iconImage, false)
		end

		local var_14_3

		if var_14_0.img_desc then
			GetSpriteFromAtlas = var_14_3
			var_14_3 = var_14_3(arg_14_0._gameData.path, var_14_0.img_desc)
			setImageSprite = var_4

			var_4(arg_14_0.iconDesc, var_14_3, true)

			setActive = var_4

			var_4(arg_14_0.iconDesc, true)
		else
			setActive = var_14_3

			var_14_3(arg_14_0.iconDesc, false)
		end

		i18n = var_14_3

		local var_14_4 = var_14_3(var_14_0.desc)

		setText = var_4

		var_4(arg_14_0.descBoundTxt, var_14_4)
	end

	return
end

function var_0_0.updateBookUI(arg_15_0)
	return
end

function var_0_0.show(arg_16_0, arg_16_1)
	setActive = var_1_10002

	var_1_10002(arg_16_0.menuUI, arg_16_1)

	return
end

function var_0_0.update(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getGameUsedTimes(arg_17_1)
	local var_17_1 = arg_17_0:getGameTimes(arg_17_1)

	for iter_17_0 = 1, #arg_17_0.battleItems do
		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_17_0.battleItems[iter_17_0], "state_open"), false)

		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_17_0.battleItems[iter_17_0], "state_closed"), false)

		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_17_0.battleItems[iter_17_0], "state_clear"), false)

		setActive = var_1_10008
		findTF = var_1_10010

		var_1_10008(var_1_10010(arg_17_0.battleItems[iter_17_0], "state_current"), false)

		if iter_17_0 <= var_17_0 then
			SetParent = var_1_10008
			var_1_10010 = arg_17_0.dropItems[iter_17_0]
			findTF = var_11

			var_1_10008(var_1_10010, var_11(arg_17_0.battleItems[iter_17_0], "state_clear/icon"))

			setActive = var_1_10008

			var_1_10008(arg_17_0.dropItems[iter_17_0], true)

			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_17_0.battleItems[iter_17_0], "state_clear"), true)
		elseif iter_17_0 == var_17_0 + 1 and 1 <= var_17_1 then
			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_17_0.battleItems[iter_17_0], "state_current"), true)

			SetParent = var_1_10008
			var_1_10010 = arg_17_0.dropItems[iter_17_0]
			findTF = var_11

			var_1_10008(var_1_10010, var_11(arg_17_0.battleItems[iter_17_0], "state_current/icon"))

			setActive = var_1_10008

			var_1_10008(arg_17_0.dropItems[iter_17_0], true)
		elseif var_17_0 < iter_17_0 and iter_17_0 <= var_17_0 + var_17_1 then
			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_17_0.battleItems[iter_17_0], "state_open"), true)

			SetParent = var_1_10008
			var_1_10010 = arg_17_0.dropItems[iter_17_0]
			findTF = var_11

			var_1_10008(var_1_10010, var_11(arg_17_0.battleItems[iter_17_0], "state_open/icon"))

			setActive = var_1_10008

			var_1_10008(arg_17_0.dropItems[iter_17_0], true)
		else
			setActive = var_1_10008
			findTF = var_1_10010

			var_1_10008(var_1_10010(arg_17_0.battleItems[iter_17_0], "state_closed"), true)

			SetParent = var_1_10008
			var_1_10010 = arg_17_0.dropItems[iter_17_0]
			findTF = var_11

			var_1_10008(var_1_10010, var_11(arg_17_0.battleItems[iter_17_0], "state_closed/icon"))

			setActive = var_1_10008

			var_1_10008(arg_17_0.dropItems[iter_17_0], true)
		end
	end

	local var_17_2 = 1 - (var_17_0 - 3 < 0 and 0 or var_17_0 - 3) / (arg_17_0.totalTimes - 4)

	if 1 < var_17_2 then
		var_17_2 = 1
	end

	scrollTo = var_6

	var_6(arg_17_0.battleScrollRect, 0, var_17_2)

	setActive = var_6
	findTF = var_8

	var_6(var_8(arg_17_0.menuUI, "btnStart/tip"), var_17_1 > 0)
	arg_17_0:CheckGet(arg_17_1)

	return
end

function var_0_0.CheckGet(arg_18_0, arg_18_1)
	setActive = var_1_10002
	findTF = var_1_10004

	var_1_10002(var_1_10004(arg_18_0.menuUI, "got"), false)

	if arg_18_0:getUltimate(arg_18_1) and var_2 ~= 0 then
		setActive = var_1_10003
		findTF = var_5

		var_1_10003(var_5(arg_18_0.menuUI, "got"), true)
	end

	if var_2 == 0 then
		if arg_18_0._gameData.total_times > arg_18_0:getGameUsedTimes(arg_18_1) then
			return
		end

		pg = var_5

		local var_18_0 = var_5.m02
		local var_18_1 = var_5.sendNotification

		GAME = var_1_10008

		local var_18_2 = var_1_10008.SEND_MINI_GAME_OP
		local var_18_3 = {
			hubid = arg_18_1.id
		}

		MiniGameOPCommand = var_10
		var_18_3.cmd = var_10.CMD_ULTIMATE
		var_18_3.args1 = {}

		var_18_1(var_18_0, var_18_2, var_18_3)

		setActive = var_18_1
		findTF = var_18_0

		var_18_1(var_18_0(arg_18_0.menuUI, "got"), true)
	end

	return
end

function var_0_0.getGameTimes(arg_19_0, arg_19_1)
	return arg_19_1.count
end

function var_0_0.getGameUsedTimes(arg_20_0, arg_20_1)
	return arg_20_1.usedtime
end

function var_0_0.getUltimate(arg_21_0, arg_21_1)
	return arg_21_1.ultimate
end

return var_0_0
