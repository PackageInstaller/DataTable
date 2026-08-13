class = var_0_10000

local var_0_0 = "NewEducateBuffLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))
local var_0_2 = {}

NewEducateBuff = var_2

local var_0_3 = var_2.TYPE.TAROT

i18n = var_3
var_0_2[var_0_3] = var_3("child2_collect_tarot_progress")
NewEducateBuff = var_0_3

local var_0_4 = var_0_3.TYPE.ENTRY

i18n = var_3
var_0_2[var_0_4] = var_3("child2_collect_entry_progress")
NewEducateBuff = var_0_4

local var_0_5 = var_0_4.TYPE.TALENT

i18n = var_3
var_0_2[var_0_5] = var_3("child2_collect_talent_progress")

local var_0_6 = {}

NewEducateBuff = var_3

local var_0_7 = var_3.TYPE.TAROT

i18n = var_4
var_0_6[var_0_7] = var_4("child2_collect_tarot")
NewEducateBuff = var_0_7

local var_0_8 = var_0_7.TYPE.ENTRY

i18n = var_4
var_0_6[var_0_8] = var_4("child2_collect_entry")
NewEducateBuff = var_0_8

local var_0_9 = var_0_8.TYPE.TALENT

i18n = var_4
var_0_6[var_0_9] = var_4("child2_collect_talent")

function var_0_1.getUIName(arg_1_0)
	return "NewEducateBuffUI"
end

function var_0_1.getGroupName(arg_2_0)
	return "NewEducateBaseUI"
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.windowTF = var_1.Find(var_3_0, "window")

	local var_3_1 = arg_3_0.windowTF

	arg_3_0.nextBtn = var_1.Find(var_3_1, "next_btn")

	local var_3_2 = arg_3_0.windowTF

	arg_3_0.lastBtn = var_1.Find(var_3_2, "last_btn")

	local var_3_3 = arg_3_0.windowTF

	arg_3_0.togglesTF = var_1.Find(var_3_3, "toggles")

	local var_3_4 = arg_3_0.windowTF
	local var_3_5 = var_1.Find(var_3_4, "pages")

	arg_3_0.pageTFs = {}

	local var_3_6 = arg_3_0.pageTFs

	NewEducateBuff = var_3

	local var_3_7 = var_3.TYPE.TAROT
	local var_3_8 = var_3_5
	local var_3_9 = var_3_5.Find

	tostring = var_1_10006
	NewEducateBuff = var_1_10007
	var_3_6[var_3_7] = var_3_9(var_3_8, var_1_10006(var_1_10007.TYPE.TAROT))

	local var_3_10 = arg_3_0.pageTFs

	NewEducateBuff = var_3_7

	local var_3_11 = var_3_7.TYPE.ENTRY
	local var_3_12 = var_3_5
	local var_3_13 = var_3_5.Find

	tostring = var_6
	NewEducateBuff = var_7
	var_3_10[var_3_11] = var_3_13(var_3_12, var_6(var_7.TYPE.ENTRY))

	local var_3_14 = arg_3_0.pageTFs

	NewEducateBuff = var_3_11

	local var_3_15 = var_3_11.TYPE.TALENT
	local var_3_16 = var_3_5
	local var_3_17 = var_3_5.Find

	tostring = var_6
	NewEducateBuff = var_7
	var_3_14[var_3_15] = var_3_17(var_3_16, var_6(var_7.TYPE.TALENT))

	local var_3_18 = arg_3_0._tf

	arg_3_0.boxsTF = var_2.Find(var_3_18, "detail_boxs")

	local var_3_19 = arg_3_0._tf
	local var_3_20 = var_2.Find(var_3_19, "window")
	local var_3_21 = var_2.GetComponent

	typeof = var_4
	Animation = var_3_16
	arg_3_0.animCom = var_3_21(var_3_20, var_4(var_3_16))

	return
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:OverlayPanel(arg_4_0._tf, {
		groupDelta = 2
	})

	onButton = var_1

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_3.Find(var_4_1, "bg")

	local function var_4_3()
		local var_5_0 = arg_4_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_4_0, var_4_2, var_4_3, var_5)

	eachChild = var_1

	var_1(arg_4_0.togglesTF, function(arg_6_0)
		tonumber = var_2_10001

		local var_6_0 = var_2_10001(arg_6_0.name)

		setText = var_2

		var_2(arg_6_0:Find("name"), var_0_6[var_6_0])

		onButton = var_2

		local var_6_1 = arg_4_0
		local var_6_2 = arg_6_0

		local function var_6_3()
			local var_7_0 = arg_4_0.animCom

			var_0.Play(var_7_0, "anim_NewEducateBuffUI_left_click")

			tonumber = var_0

			local var_7_1 = var_0(arg_6_0.name)
			local var_7_2 = arg_4_0

			var_1.SwtichView(var_7_2, var_7_1)

			return
		end

		SFX_PANEL = var_2_10006

		var_2(var_6_1, var_6_2, var_6_3, var_2_10006)

		return
	end)

	onButton = var_1

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0.nextBtn

	local function var_4_6()
		arg_4_0.curPageIdx = arg_4_0.curPageIdx + 1

		local var_8_0 = arg_4_0.animCom

		var_0.Play(var_8_0, "anim_NewEducateBuffUI_left_click")

		local var_8_1 = arg_4_0

		var_0.UpdatePage(var_8_1)

		return
	end

	SFX_PANEL = var_5

	var_1(var_4_4, var_4_5, var_4_6, var_5)

	onButton = var_1

	local var_4_7 = arg_4_0
	local var_4_8 = arg_4_0.lastBtn

	local function var_4_9()
		arg_4_0.curPageIdx = arg_4_0.curPageIdx - 1

		local var_9_0 = arg_4_0.animCom

		var_0.Play(var_9_0, "anim_NewEducateBuffUI_left_click")

		local var_9_1 = arg_4_0

		var_0.UpdatePage(var_9_1)

		return
	end

	SFX_PANEL = var_5

	var_1(var_4_7, var_4_8, var_4_9, var_5)

	eachChild = var_1

	var_1(arg_4_0.boxsTF, function(arg_10_0)
		onButton = var_2_10001

		local var_10_0 = arg_4_0
		local var_10_1 = arg_10_0

		local function var_10_2()
			setActive = var_3_10000

			var_3_10000(arg_10_0, false)

			return
		end

		SFX_PANEL = var_2_10005

		var_2_10001(var_10_0, var_10_1, var_10_2, var_2_10005)

		return
	end)
	arg_4_0:InitData()
	arg_4_0:UpdateToggles()

	local var_4_10 = arg_4_0
	local var_4_11 = arg_4_0.SwtichView

	tonumber = var_3

	local var_4_12 = arg_4_0.togglesTF

	var_4_11(var_4_10, var_3(var_4.GetChild(var_4_12, 0).name))

	return
end

function var_0_1.InitData(arg_12_0)
	pg = var_1_10001
	arg_12_0.config = var_1_10001.child2_benefit_list

	local var_12_0 = {}

	NewEducateBuff = var_1_10002

	local var_12_1 = var_1_10002.TYPE.TAROT
	local var_12_2 = arg_12_0.contextData.permanentData

	var_12_0[var_12_1] = var_3.GetAllTarotIds(var_12_2)
	NewEducateBuff = var_12_1

	local var_12_3 = var_12_1.TYPE.ENTRY
	local var_12_4 = arg_12_0.contextData.permanentData

	var_12_0[var_12_3] = var_3.GetAllEntryIds(var_12_4)
	NewEducateBuff = var_12_3

	local var_12_5 = var_12_3.TYPE.TALENT
	local var_12_6 = arg_12_0.contextData.permanentData

	var_12_0[var_12_5] = var_3.GetAllTalentIds(var_12_6)
	arg_12_0.allIdMap = var_12_0

	local var_12_7 = {}

	NewEducateBuff = var_12_5

	local var_12_8 = var_12_5.TYPE.TAROT
	local var_12_9 = arg_12_0.contextData.permanentData

	var_12_7[var_12_8] = var_3.GetActivatedTarotIds(var_12_9)
	NewEducateBuff = var_12_8

	local var_12_10 = var_12_8.TYPE.ENTRY
	local var_12_11 = arg_12_0.contextData.permanentData

	var_12_7[var_12_10] = var_3.GetActivatedEntryIds(var_12_11)
	NewEducateBuff = var_12_10

	local var_12_12 = var_12_10.TYPE.TALENT
	local var_12_13 = arg_12_0.contextData.permanentData

	var_12_7[var_12_12] = var_3.GetActivatedTalentIds(var_12_13)
	arg_12_0.unlockIdMap = var_12_7
	arg_12_0.pageAllCntMap = {}
	pairs = var_1

	for iter_12_0, iter_12_1 in var_1(arg_12_0.allIdMap) do
		local var_12_14 = arg_12_0.pageTFs[iter_12_0]
		local var_12_15 = var_6.Find(var_12_14, "content").childCount
		local var_12_16 = arg_12_0.pageAllCntMap

		math = var_8
		var_12_16[iter_12_0] = var_8.ceil(#iter_12_1 / var_12_15)
	end

	return
end

function var_0_1.UpdateToggles(arg_13_0)
	eachChild = var_1_10001

	var_1_10001(arg_13_0.togglesTF, function(arg_14_0)
		tonumber = var_2_10001

		local var_14_0 = var_2_10001(arg_14_0.name)

		setText = var_2

		var_2(arg_14_0:Find("value"), #arg_13_0.unlockIdMap[var_14_0] .. "/" .. #arg_13_0.allIdMap[var_14_0])

		return
	end)

	pairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0.pageTFs) do
		setText = var_1_10006

		var_1_10006(iter_13_1:Find("progress/Text"), var_0_2[iter_13_0])

		setText = var_1_10006

		var_1_10006(iter_13_1:Find("progress/cur"), #arg_13_0.unlockIdMap[iter_13_0])

		setText = var_1_10006

		var_1_10006(iter_13_1:Find("progress/all"), "/" .. #arg_13_0.allIdMap[iter_13_0])
	end

	return
end

function var_0_1.SwtichView(arg_15_0, arg_15_1)
	if not arg_15_0.curType or arg_15_0.curType ~= arg_15_1 then
		arg_15_0.curType = arg_15_1

		arg_15_0:UpdateView()
	end

	eachChild = var_2

	var_2(arg_15_0.togglesTF, function(arg_16_0)
		setActive = var_2_10001

		local var_16_0 = arg_16_0
		local var_16_1 = arg_16_0.Find(var_16_0, "sel")

		tonumber = var_16_0

		var_2_10001(var_16_1, var_16_0(arg_16_0.name) == arg_15_1)

		return
	end)

	eachChild = var_2

	local var_15_0 = arg_15_0.windowTF

	var_2(var_3.Find(var_15_0, "pages"), function(arg_17_0)
		setActive = var_2_10001

		local var_17_0 = arg_17_0

		tonumber = var_2_10003

		var_2_10001(var_17_0, var_2_10003(arg_17_0.name) == arg_15_1)

		return
	end)

	return
end

function var_0_1.UpdateView(arg_18_0)
	if arg_18_0.reverse then
		arg_18_0.reverse = nil
		arg_18_0.curPageIdx = arg_18_0.pageAllCntMap[arg_18_0.curType]
	else
		arg_18_0.curPageIdx = 1
	end

	arg_18_0:UpdatePage()

	return
end

function var_0_1.GetNextType(arg_19_0)
	switch = var_1_10001

	local var_19_0 = arg_19_0.curType
	local var_19_1 = {}

	NewEducateBuff = var_1_10004
	var_19_1[var_1_10004.TYPE.TAROT] = function()
		NewEducateBuff = var_2_10000

		return var_2_10000.TYPE.ENTRY
	end
	NewEducateBuff = var_4
	var_19_1[var_4.TYPE.ENTRY] = function()
		NewEducateBuff = var_2_10000

		return var_2_10000.TYPE.TALENT
	end
	NewEducateBuff = var_4
	var_19_1[var_4.TYPE.TALENT] = function()
		return nil
	end

	return var_1_10001(var_19_0, var_19_1)
end

function var_0_1.GetLastType(arg_23_0)
	switch = var_1_10001

	local var_23_0 = arg_23_0.curType
	local var_23_1 = {}

	NewEducateBuff = var_1_10004
	var_23_1[var_1_10004.TYPE.TAROT] = function()
		return nil
	end
	NewEducateBuff = var_4
	var_23_1[var_4.TYPE.ENTRY] = function()
		NewEducateBuff = var_2_10000

		return var_2_10000.TYPE.TAROT
	end
	NewEducateBuff = var_4
	var_23_1[var_4.TYPE.TALENT] = function()
		NewEducateBuff = var_2_10000

		return var_2_10000.TYPE.ENTRY
	end

	return var_1_10001(var_23_0, var_23_1)
end

function var_0_1.UpdatePage(arg_27_0)
	local var_27_0 = arg_27_0.pageTFs[arg_27_0.curType]

	if arg_27_0.pageAllCntMap[arg_27_0.curType] < arg_27_0.curPageIdx then
		var_1_10004 = arg_27_0

		if arg_27_0.GetNextType(var_1_10004) then
			arg_27_0:SwtichView(var_3)

			return
		end
	elseif arg_27_0.curPageIdx < 1 then
		var_1_10004 = arg_27_0

		if arg_27_0.GetLastType(var_1_10004) then
			arg_27_0.reverse = true

			arg_27_0:SwtichView(var_3)

			return
		end
	end

	local var_27_1 = arg_27_0.curType

	NewEducateBuff = var_1_10004

	local var_27_2 = var_27_1 == var_1_10004.TYPE.TALENT and var_2 <= arg_27_0.curPageIdx

	setActive = var_4

	var_4(arg_27_0.nextBtn, not var_27_2)

	local var_27_3 = arg_27_0.curType

	NewEducateBuff = var_5

	local var_27_4 = var_27_3 == var_5.TYPE.TAROT and arg_27_0.curPageIdx <= 1

	setActive = var_5

	var_5(arg_27_0.lastBtn, not var_27_4)

	setText = var_5

	var_5(var_27_0:Find("pagination"), arg_27_0.curPageIdx .. "/" .. var_2)

	local var_27_5 = var_27_0:Find("content").childCount
	local var_27_6 = (arg_27_0.curPageIdx - 1) * var_27_5

	for iter_27_0 = 1, var_27_5 do
		local var_27_7 = var_5
		local var_27_8 = var_5.Find

		tostring = var_1_10014

		local var_27_9 = var_27_8(var_27_7, var_1_10014(iter_27_0))

		if arg_27_0.allIdMap[arg_27_0.curType][var_27_6 + iter_27_0] then
			setActive = var_1_10014

			var_1_10014(var_27_9, true)
			arg_27_0:UpdateItem(var_13, var_27_9)
		else
			setActive = var_1_10014

			var_1_10014(var_27_9, false)
		end
	end

	return
end

function var_0_1.UpdateItem(arg_28_0, arg_28_1, arg_28_2)
	table = var_1_10003

	local var_28_0 = var_1_10003.contains(arg_28_0.unlockIdMap[arg_28_0.curType], arg_28_1)

	setActive = var_4

	var_4(arg_28_2:Find("lock"), not var_28_0)

	setActive = var_4

	var_4(arg_28_2:Find("unlock"), var_28_0)

	switch = var_4

	local var_28_1 = arg_28_0.curType
	local var_28_2 = {}

	NewEducateBuff = var_7
	var_28_2[var_7.TYPE.TAROT] = function()
		NewEducateTarotCard = var_2_10000

		local var_29_0 = var_2_10000.StaticShow
		local var_29_1 = arg_28_2

		var_29_0(var_1.Find(var_29_1, "unlock"), arg_28_1)

		setText = var_29_0

		local var_29_2 = arg_28_2

		var_29_0(var_1.Find(var_29_2, "lock/Text"), arg_28_0.config[arg_28_1].get)

		setText = var_29_0

		local var_29_3 = arg_28_2

		var_29_0(var_1.Find(var_29_3, "lock/name/Text"), arg_28_0.config[arg_28_1].name)

		onButton = var_29_0

		local var_29_4 = arg_28_0
		local var_29_5 = arg_28_2

		local function var_29_6()
			if not var_28_0 then
				return
			end

			local var_30_0 = arg_28_0

			var_0.ShowDetailBox(var_30_0, arg_28_1)

			return
		end

		SFX_PANEL = var_2_10004

		var_29_0(var_29_4, var_29_5, var_29_6, var_2_10004)

		return
	end
	NewEducateBuff = var_7
	var_28_2[var_7.TYPE.ENTRY] = function()
		NewEducateEntryCard = var_2_10000

		local var_31_0 = var_2_10000.StaticShow
		local var_31_1 = arg_28_2

		var_31_0(var_1.Find(var_31_1, "unlock"), arg_28_1)

		setText = var_31_0

		local var_31_2 = arg_28_2

		var_31_0(var_1.Find(var_31_2, "lock/Text"), arg_28_0.config[arg_28_1].get)

		setText = var_31_0

		local var_31_3 = arg_28_2

		var_31_0(var_1.Find(var_31_3, "lock/name"), arg_28_0.config[arg_28_1].name)

		onButton = var_31_0

		local var_31_4 = arg_28_0
		local var_31_5 = arg_28_2

		local function var_31_6()
			if not var_28_0 then
				return
			end

			local var_32_0 = arg_28_0

			var_0.ShowDetailBox(var_32_0, arg_28_1)

			return
		end

		SFX_PANEL = var_2_10004

		var_31_0(var_31_4, var_31_5, var_31_6, var_2_10004)

		return
	end
	NewEducateBuff = var_7
	var_28_2[var_7.TYPE.TALENT] = function()
		local var_33_0 = arg_28_0.config[arg_28_1]

		LoadImageSpriteAsync = var_1

		local var_33_1 = "neweducateicon/" .. var_33_0.item_icon
		local var_33_2 = arg_28_2

		var_1(var_33_1, var_3.Find(var_33_2, "unlock/icon"))

		setText = var_1

		local var_33_3 = arg_28_2

		var_1(var_2.Find(var_33_3, "lock/Text"), var_33_0.get)

		setText = var_1

		local var_33_4 = arg_28_2

		var_1(var_2.Find(var_33_4, "name"), var_33_0.name)

		LoadImageSpriteAtlasAsync = var_1

		local var_33_5 = "ui/neweducatebuffui_atlas"
		local var_33_6 = "rarity_" .. var_33_0.rare
		local var_33_7 = arg_28_2

		var_1(var_33_5, var_33_6, var_4.Find(var_33_7, "unlock"))

		onButton = var_1

		local var_33_8 = arg_28_0
		local var_33_9 = arg_28_2

		local function var_33_10()
			if not var_28_0 then
				return
			end

			local var_34_0 = arg_28_0

			var_0.ShowDetailBox(var_34_0, arg_28_1)

			return
		end

		SFX_PANEL = var_33_7

		var_1(var_33_8, var_33_9, var_33_10, var_33_7)

		return
	end

	var_4(var_28_1, var_28_2)

	return
end

function var_0_1.ShowDetailBox(arg_35_0, arg_35_1, arg_35_2)
	eachChild = var_1_10003

	var_1_10003(arg_35_0.boxsTF, function(arg_36_0)
		setActive = var_2_10001

		local var_36_0 = arg_36_0
		local var_36_1 = arg_35_0.curType

		tonumber = var_2_10004

		var_2_10001(var_36_0, var_36_1 == var_2_10004(arg_36_0.name))

		return
	end)

	local var_35_0 = arg_35_0.boxsTF
	local var_35_1 = var_3.Find

	tostring = var_5

	local var_35_2 = var_35_1(var_35_0, var_5(arg_35_0.curType))

	switch = var_35_0

	local var_35_3 = arg_35_0.curType
	local var_35_4 = {}

	NewEducateBuff = var_1_10007
	var_35_4[var_1_10007.TYPE.TAROT] = function()
		NewEducateTarotCard = var_2_10000

		local var_37_0 = var_2_10000.StaticShow
		local var_37_1 = var_35_2

		var_37_0(var_1.Find(var_37_1, "bg/tarot"), arg_35_1)

		return
	end
	NewEducateBuff = var_7
	var_35_4[var_7.TYPE.ENTRY] = function()
		NewEducateEntryCard = var_2_10000

		local var_38_0 = var_2_10000.StaticShow
		local var_38_1 = var_35_2

		var_38_0(var_1.Find(var_38_1, "bg/entry/unlock"), arg_35_1)

		setText = var_38_0

		local var_38_2 = var_35_2

		var_38_0(var_1.Find(var_38_2, "bg/entry/lv"), "LV." .. arg_35_0.config[arg_35_1].benefit_level)

		setActive = var_38_0

		local var_38_3 = var_35_2

		var_38_0(var_1.Find(var_38_3, "bg/entry/unlock"), true)

		setActive = var_38_0

		local var_38_4 = var_35_2

		var_38_0(var_1.Find(var_38_4, "bg/entry/lock"), false)

		setActive = var_38_0

		local var_38_5 = var_35_2

		var_38_0(var_1.Find(var_38_5, "bg/toggles"), false)

		return
	end
	NewEducateBuff = var_7
	var_35_4[var_7.TYPE.TALENT] = function()
		local var_39_0 = arg_35_0.config[arg_35_1]
		local var_39_1 = var_35_2
		local var_39_2 = var_1.Find(var_39_1, "bg/talent")

		LoadImageSpriteAsync = var_39_1

		var_39_1("neweducateicon/" .. var_39_0.item_icon, var_39_2:Find("rarity/icon"))

		setText = var_39_1

		var_39_1(var_39_2:Find("name"), var_39_0.name)

		setText = var_39_1

		var_39_1(var_39_2:Find("level"), "LV." .. var_39_0.benefit_level)

		setText = var_39_1

		var_39_1(var_39_2:Find("desc/Text"), var_39_0.desc)

		LoadImageSpriteAtlasAsync = var_39_1

		var_39_1("ui/neweducatebuffui_atlas", "rarity_" .. var_39_0.rare, var_39_2:Find("rarity"))

		return
	end

	var_35_0(var_35_3, var_35_4)

	return
end

function var_0_1.ShowEntryBox(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	local var_40_0 = arg_40_0.entryGroup2Ids[arg_40_2]

	table = var_1_10005

	local var_40_1 = var_1_10005.sort
	local var_40_2 = var_40_0

	CompareFuncs = var_1_10007

	var_40_1(var_40_2, var_1_10007({
		function(arg_41_0)
			return arg_40_0.config[arg_41_0].benefit_level
		end,
		function(arg_42_0)
			return arg_42_0
		end
	}))

	UIItemList = var_40_1

	local var_40_3 = var_40_1.StaticAlign
	local var_40_4 = arg_40_1:Find("bg/toggles")
	local var_40_5 = arg_40_1:Find("bg/toggles")

	var_40_3(var_40_4, var_7.GetChild(var_40_5, 0), #var_40_0, function(arg_43_0, arg_43_1, arg_43_2)
		UIItemList = var_2_10003

		if arg_43_0 == var_2_10003.EventUpdate then
			local var_43_0 = var_40_0[arg_43_1 + 1]
			local var_43_1 = arg_40_0.config[var_43_0].benefit_level

			tostring = var_2_10006
			arg_43_2.name = var_2_10006(var_43_0)
			setText = var_6

			var_6(arg_43_2:Find("sel/Text"), "LV." .. var_43_1)

			setText = var_6

			var_6(arg_43_2:Find("unsel/Text"), "LV." .. var_43_1)

			table = var_6

			local var_43_2 = var_6.contains(arg_40_0.unlockEntryIds, var_43_0)

			setActive = var_7

			var_7(arg_43_2:Find("sel/Image"), not var_43_2)

			setActive = var_7

			var_7(arg_43_2:Find("unsel/Image"), not var_43_2)

			setActive = var_7

			var_7(arg_43_2:Find("sel/Text"), var_43_2)

			setActive = var_7

			var_7(arg_43_2:Find("unsel/Text"), var_43_2)

			onToggle = var_7

			local var_43_3 = arg_40_0
			local var_43_4 = arg_43_2

			local function var_43_5(arg_44_0)
				NewEducateEntryCard = var_3_10001

				local var_44_0 = var_3_10001.StaticShow
				local var_44_1 = arg_40_1

				var_44_0(var_2.Find(var_44_1, "bg/entry/unlock"), var_43_0)

				setText = var_44_0

				local var_44_2 = arg_40_1

				var_44_0(var_2.Find(var_44_2, "bg/entry/lv"), "LV." .. var_43_1)

				setActive = var_44_0

				local var_44_3 = arg_40_1

				var_44_0(var_2.Find(var_44_3, "bg/entry/unlock"), var_43_2)

				setActive = var_44_0

				local var_44_4 = arg_40_1

				var_44_0(var_2.Find(var_44_4, "bg/entry/lock"), not var_43_2)

				setText = var_44_0

				local var_44_5 = arg_40_1

				var_44_0(var_2.Find(var_44_5, "bg/entry/lock/Text"), var_0.get)

				setText = var_44_0

				local var_44_6 = arg_40_1

				var_44_0(var_2.Find(var_44_6, "bg/entry/lock/name"), var_0.name)

				return
			end

			SFX_PANEL = var_2_10011

			var_7(var_43_3, var_43_4, var_43_5, var_2_10011)
		end

		return
	end)

	triggerToggle = var_40_3

	local var_40_6 = arg_40_1:Find("bg/toggles")
	local var_40_7 = var_6.Find

	tostring = var_8

	var_40_3(var_40_7(var_40_6, var_8(arg_40_3)), true)

	return
end

function var_0_1.willExit(arg_45_0)
	arg_45_0:UnOverlayPanel(arg_45_0._tf)

	return
end

return var_0_1
