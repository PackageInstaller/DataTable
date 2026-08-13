class = var_0_10000

local var_0_0 = "EducateCharSelectPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "EducateCharDockSelectUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "title/Text")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.titleTxt = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "left/label/icon")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.labelTxt = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0._tf

	arg_2_0.paintingTr = var_1.Find(var_2_6, "left/print/mask/painting")

	local var_2_7 = arg_2_0._tf

	arg_2_0.scrollrect = var_1.Find(var_2_7, "list")
	UIItemList = var_1

	local var_2_8 = var_1.New
	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_2.Find(var_2_9, "list/content")
	local var_2_11 = arg_2_0._tf

	arg_2_0.uiItemList = var_2_8(var_2_10, var_3.Find(var_2_11, "list/content/tpl"))
	UIItemList = var_1

	local var_2_12 = var_1.New
	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_2.Find(var_2_13, "list/dots")
	local var_2_15 = arg_2_0._tf

	arg_2_0.dotUIItemList = var_2_12(var_2_14, var_3.Find(var_2_15, "list/dots/tpl"))

	local var_2_16 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_16, "confirm_btn")

	local var_2_17 = arg_2_0._tf

	arg_2_0.nextArr = var_1.Find(var_2_17, "prints/next")

	local var_2_18 = arg_2_0._tf

	arg_2_0.prevArr = var_1.Find(var_2_18, "prints/prev")

	local var_2_19 = arg_2_0._tf

	arg_2_0.nextPrint = var_1.Find(var_2_19, "prints/print1")

	local var_2_20 = arg_2_0._tf

	arg_2_0.prevPrint = var_1.Find(var_2_20, "prints/print2")

	local var_2_21 = arg_2_0._tf
	local var_2_22 = var_1.GetComponent

	typeof = var_3
	Animation = var_2_15
	arg_2_0.animation = var_2_22(var_2_21, var_3(var_2_15))

	local var_2_23 = arg_2_0._tf
	local var_2_24 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_2_15
	arg_2_0.dftAniEvent = var_2_24(var_2_23, var_3(var_2_15))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.confirmBtn

	local function var_3_2()
		if arg_3_0.doAnim then
			return
		end

		if not arg_3_0.selectedId then
			return
		end

		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		EducateCharDockScene = var_2_10002

		var_4_1(var_4_0, var_2_10002.ON_SELECTED, arg_3_0.selectedId)

		arg_3_0.doAnim = true

		local var_4_2 = arg_3_0

		var_0.Back(var_4_2, function()
			arg_3_0.doAnim = nil

			local var_5_0 = arg_3_0
			local var_5_1 = var_0.emit

			EducateCharDockScene = var_3_10002

			var_5_1(var_5_0, var_3_10002.ON_CONFIRM, arg_3_0.selectedId)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.bind

	EducateCharDockScene = var_3_1

	var_3_4(var_3_3, var_3_1.MSG_CLEAR_TIP, function(arg_6_0, arg_6_1)
		return
	end)

	return
end

function var_0_1.Back(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.dftAniEvent

	var_2.SetEndEvent(var_7_0, function(arg_8_0)
		local var_8_0 = arg_7_0.dftAniEvent

		var_1.SetEndEvent(var_8_0, nil)
		arg_7_1()

		return
	end)

	local var_7_1 = arg_7_0.animation

	var_2.Play(var_7_1, "anim_educate_chardockselect_out")

	return
end

function var_0_1.Update(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.group = arg_9_1

	if arg_9_1:IsSelected(arg_9_2) then
		arg_9_0.selectedId = arg_9_2
	end

	arg_9_0.timers = {}

	arg_9_0:FlushPainting(arg_9_1:GetShowPainting())
	arg_9_0:InitLabel()
	arg_9_0:UpdateTitle()
	arg_9_0:InitList()
	arg_9_0:UpdateDots()
	arg_9_0:Show()

	return
end

function var_0_1.UpdateTitle(arg_10_0)
	local var_10_0 = arg_10_0.group

	arg_10_0.titleTxt.text = var_10_0:GetTitle()

	return
end

function var_0_1.InitLabel(arg_11_0)
	local var_11_0 = arg_11_0.group
	local var_11_1 = arg_11_0.labelTxt

	GetSpriteFromAtlas = var_1_10003
	var_11_1.sprite = var_1_10003("ui/EducateDockUI_atlas", var_11_0:GetSpriteName())

	local var_11_2 = arg_11_0.labelTxt

	var_2.SetNativeSize(var_11_2)

	return
end

function var_0_1.FlushPainting(arg_12_0, arg_12_1)
	arg_12_0:ReturnPainting()

	setPaintingPrefabAsync = var_2

	var_2(arg_12_0.paintingTr, arg_12_1, "tb1")

	arg_12_0.paintingName = arg_12_1

	return
end

function var_0_1.InitList(arg_13_0)
	local var_13_0 = arg_13_0.group
	local var_13_1 = var_1.GetCharIdList(var_13_0)

	arg_13_0:ReturnCardList()

	arg_13_0.cards = {}

	arg_13_0:RemoveAllTimer()

	local var_13_2 = arg_13_0.uiItemList

	var_3.make(var_13_2, function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			local var_14_0 = var_13_1[arg_14_1 + 1]
			local var_14_1 = arg_13_0

			var_4.UpdateCard(var_14_1, arg_14_2, var_14_0, arg_14_1)

			arg_13_0.cards[var_14_0] = arg_14_2
		end

		return
	end)

	local var_13_3 = arg_13_0.uiItemList

	var_3.align(var_13_3, #var_13_1)

	local var_13_4 = #var_13_1
	local var_13_5 = 2 < var_13_4

	setActive = var_4

	var_4(arg_13_0.nextArr, var_13_5)

	setActive = var_4

	var_4(arg_13_0.prevArr, var_13_5)

	setActive = var_4

	var_4(arg_13_0.nextPrint, not var_13_5)

	setActive = var_4

	var_4(arg_13_0.prevPrint, not var_13_5)

	scrollTo = var_4

	var_4(arg_13_0.scrollrect, 0, 0)

	return
end

function var_0_1.UpdateDots(arg_15_0)
	local var_15_0 = arg_15_0.group
	local var_15_1 = var_1.GetCharIdList(var_15_0)
	local var_15_2 = arg_15_0.dotUIItemList

	var_3.make(var_15_2, function(arg_16_0, arg_16_1, arg_16_2)
		UIItemList = var_2_10003

		if arg_16_0 == var_2_10003.EventUpdate then
			local var_16_0 = var_15_1[arg_16_1 + 1]

			setActive = var_4

			var_4(arg_16_2:Find("Image"), var_16_0 == arg_15_0.selectedId)
		end

		return
	end)

	local var_15_3 = arg_15_0.dotUIItemList

	var_3.align(var_15_3, #var_15_1)

	return
end

function var_0_1.IsLockCard(arg_17_0, arg_17_1)
	NewEducateHelper = var_1_10002

	local var_17_0 = var_1_10002.GetAllUnlockSecretaryIds()

	table = var_1_10003

	return not var_1_10003.contains(var_17_0, arg_17_1)
end

function var_0_1.UpdateCard(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_1
	local var_18_1 = arg_18_1.Find(var_18_0, "anim_root")

	pg = var_18_0

	local var_18_2 = var_18_0.secretary_special_ship[arg_18_2]

	setPaintingPrefab = var_6

	var_6(var_18_1:Find("mask/painting"), var_18_2.prefab, "tb")

	setActive = var_6

	var_6(var_18_1:Find("lock"), arg_18_0:IsLockCard(var_18_2.id))

	setScrollText = var_6

	var_6(var_18_1:Find("lock/desc/Text"), var_18_2.unlock_desc)
	;(function()
		setActive = var_2_10000

		local var_19_0 = var_18_1
		local var_19_1 = var_1.Find(var_19_0, "tip")

		getProxy = var_19_0
		SettingsProxy = var_3

		local var_19_2 = var_19_0(var_3)

		var_2_10000(var_19_1, var_2._ShouldEducateCharTip(var_19_2, arg_18_2))

		return
	end)()

	local function var_18_3()
		setActive = var_2_10000

		local var_20_0 = var_18_1

		var_2_10000(var_1.Find(var_20_0, "mark"), true)

		arg_18_0.selectedId = arg_18_2

		local var_20_1 = arg_18_0

		var_0.UpdateDots(var_20_1)

		local var_20_2 = arg_18_0

		var_0.FlushPainting(var_20_2, var_18_2.painting)

		arg_18_0.prevSelected = var_18_1

		local var_20_3 = arg_18_0.animation

		var_0.Stop(var_20_3)

		local var_20_4 = arg_18_0.animation

		var_0.Play(var_20_4, "anim_educate_chardockselect_change")

		return
	end

	onButton = var_8

	local var_18_4 = arg_18_0
	local var_18_5 = var_18_1

	local function var_18_6()
		local var_21_0 = arg_18_0
		local var_21_1

		if var_0.IsLockCard(var_21_0, arg_18_2) then
			pg = var_21_1
			var_21_0 = var_21_1.TipsMgr.GetInstance()
			var_21_1 = var_21_1.ShowTips
			i18n = var_2

			var_21_1(var_21_0, var_2("secretary_special_lock_tip"))

			return
		end

		getProxy = var_21_1
		SettingsProxy = var_21_0

		local var_21_2 = var_21_1(var_21_0)

		if var_0.ClearEducateCharTip(var_21_2, arg_18_2) then
			var_0()
		end

		local var_21_3 = arg_18_0

		var_0.ClearPrevSelected(var_21_3)

		if arg_18_0.selectedId == arg_18_2 then
			arg_18_0.selectedId = 0

			local var_21_4 = arg_18_0

			var_0.UpdateDots(var_21_4)

			return
		end

		var_18_3()

		return
	end

	SFX_PANEL = var_1_10012

	var_8(var_18_4, var_18_5, var_18_6, var_1_10012)

	if arg_18_0.selectedId == arg_18_2 then
		var_18_3()
	end

	setActive = var_8

	var_8(var_18_1, false)

	local var_18_7 = arg_18_0.timers

	Timer = var_9

	local var_18_8 = var_9.New

	local function var_18_9()
		setActive = var_2_10000

		var_2_10000(var_18_1, true)

		local var_22_0 = var_18_1
		local var_22_1 = var_0.GetComponent

		typeof = var_2
		Animation = var_2_10003

		local var_22_2 = var_22_1(var_22_0, var_2(var_2_10003))

		var_0.Play(var_22_2, "anim_educate_chardockselect_tpl")

		return
	end

	math = var_18_6
	var_18_7[arg_18_3] = var_18_8(var_18_9, var_18_6.max(1e-05, arg_18_3 * 0.066), 1)

	local var_18_10 = arg_18_0.timers[arg_18_3]

	var_8.Start(var_18_10)

	return
end

function var_0_1.RemoveAllTimer(arg_23_0)
	pairs = var_1_10001

	for iter_23_0, iter_23_1 in var_1_10001(arg_23_0.timers) do
		iter_23_1:Stop()

		iter_23_1 = nil
	end

	arg_23_0.timers = {}

	return
end

function var_0_1.ClearPrevSelected(arg_24_0)
	if arg_24_0.prevSelected then
		setActive = var_1

		local var_24_0 = arg_24_0.prevSelected

		var_1(var_2.Find(var_24_0, "mark"), false)

		arg_24_0.prevSelected = nil
	end

	return
end

function var_0_1.ReturnPainting(arg_25_0)
	if arg_25_0.paintingName then
		retPaintingPrefab = var_1

		var_1(arg_25_0.paintingTr, arg_25_0.paintingName)

		arg_25_0.paintingName = nil
	end

	return
end

function var_0_1.ReturnCardList(arg_26_0)
	pairs = var_1_10001

	local var_26_0

	if not arg_26_0.cards then
		var_26_0 = {}
	end

	for iter_26_0, iter_26_1 in var_1_10001(var_26_0) do
		pg = var_1_10006
		var_1_10006 = var_1_10006.secretary_special_ship[iter_26_0]
		retPaintingPrefab = var_1_10007

		var_1_10007(iter_26_1:Find("mask/painting"), var_1_10006.prefab)
	end

	arg_26_0.cards = {}

	return
end

function var_0_1.Hide(arg_27_0)
	var_0_1.super.Hide(arg_27_0)
	arg_27_0:ClearPrevSelected()

	arg_27_0.selectedId = nil

	arg_27_0:ReturnCardList()
	arg_27_0:RemoveAllTimer()

	return
end

function var_0_1.OnDestroy(arg_28_0)
	arg_28_0:RemoveAllTimer()
	arg_28_0:ReturnPainting()
	arg_28_0:ReturnCardList()

	local var_28_0 = arg_28_0.dftAniEvent

	var_1.SetEndEvent(var_28_0, nil)

	return
end

return var_0_1
