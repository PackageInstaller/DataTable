class = var_0_10000

local var_0_0 = "ActivityBossPtAwardSubPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubPanel"))

function var_0_1.getUIName(arg_1_0)
	return "ActivitybonusWindow_btnVer"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.scrollPanel = var_1.Find(var_2_0, "window/panel")
	UIItemList = var_1

	local var_2_1 = var_1.New
	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_2.Find(var_2_2, "window/panel/list")
	local var_2_4 = arg_2_0._tf

	arg_2_0.UIlist = var_2_1(var_2_3, var_3.Find(var_2_4, "window/panel/list/item"))

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "window/pt/Text")
	local var_2_7 = var_1.GetComponent

	typeof = var_3
	Text = var_2_4
	arg_2_0.totalTxt = var_2_7(var_2_6, var_3(var_2_4))

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.Find(var_2_8, "window/pt/title")
	local var_2_10 = var_1.GetComponent

	typeof = var_3
	Text = var_2_4
	arg_2_0.totalTitleTxt = var_2_10(var_2_9, var_3(var_2_4))

	local var_2_11 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_11, "window/top/btnBack")

	local var_2_12 = arg_2_0._tf

	arg_2_0.btn_banned = var_1.Find(var_2_12, "window/btn_banned")

	local var_2_13 = arg_2_0._tf

	arg_2_0.btn_get = var_1.Find(var_2_13, "window/btn_get")

	local var_2_14 = arg_2_0._tf

	arg_2_0.btn_got = var_1.Find(var_2_14, "window/btn_got")
	onButton = var_1

	local var_2_15 = arg_2_0
	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_3.Find(var_2_16, "bg_dark")

	local function var_2_18()
		local var_3_0 = arg_2_0

		var_0.Hide(var_3_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_15, var_2_17, var_2_18, var_5)

	onButton = var_1

	local var_2_19 = arg_2_0
	local var_2_20 = arg_2_0.closeBtn

	local function var_2_21()
		local var_4_0 = arg_2_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_19, var_2_20, var_2_21, var_5)

	onButton = var_1

	local var_2_22 = arg_2_0
	local var_2_23 = arg_2_0.btn_get

	local function var_2_24()
		local var_5_0 = arg_2_0.ptData
		local var_5_1, var_5_2 = var_0.GetResProgress(var_5_0)
		local var_5_3 = arg_2_0
		local var_5_4 = var_2.emit

		ActivityMediator = var_2_10004

		local var_5_5 = var_2_10004.EVENT_PT_OPERATION
		local var_5_6 = {
			cmd = 1
		}
		local var_5_7 = arg_2_0.ptData

		var_5_6.activity_id = var_6.GetId(var_5_7)
		var_5_6.arg1 = var_5_2

		var_5_4(var_5_3, var_5_5, var_5_6)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_22, var_2_23, var_2_24, var_5)

	return
end

function var_0_1.UpdateView(arg_6_0, arg_6_1)
	arg_6_0.ptData = arg_6_1

	local var_6_0 = arg_6_1.dropList
	local var_6_1 = arg_6_1.targets
	local var_6_2 = arg_6_1.level
	local var_6_3 = arg_6_1.count
	local var_6_4 = arg_6_1.resId

	Drop = var_1_10007

	local var_6_5 = var_1_10007.New
	local var_6_6 = {}

	DROP_TYPE_RESOURCE = var_1_10009
	var_6_6.type = var_1_10009
	var_6_6.id = var_6_4

	local var_6_7 = var_6_5(var_6_6)
	local var_6_8 = var_7.getName(var_6_7)

	if arg_6_1.type == 2 then
		i18n = var_1_10009

		local var_6_9 = "pt_count"

		i18n = var_1_10011
		var_1_10009 = var_1_10009(var_6_9, var_1_10011("pt_cosume", var_6_8))
		i18n = var_6_9

		local var_6_10 = "pt_total_count"

		i18n = var_12
		arg_6_0.cntTitle = var_6_9(var_6_10, var_12("pt_cosume", var_6_8))
		arg_6_0.resTitle = var_1_10009
	else
		i18n = var_1_10009

		local var_6_11 = var_1_10009("pt_count", var_6_8)

		i18n = var_10
		arg_6_0.cntTitle = var_10("pt_total_count", var_6_8)
		arg_6_0.resTitle = var_6_11
	end

	local var_6_12 = arg_6_0.ptData
	local var_6_13 = var_9.CanGetAward(var_6_12)
	local var_6_14 = arg_6_0.ptData
	local var_6_15 = var_10.GetBossProgress(var_6_14)

	setActive = var_6_14

	var_6_14(arg_6_0.btn_get, var_6_13)

	setActive = var_6_14

	var_6_14(arg_6_0.btn_banned, not var_6_13)
	arg_6_0:UpdateList(var_6_0, var_6_1, var_6_2, var_6_15)

	Canvas = var_11

	var_11.ForceUpdateCanvases()

	return
end

function var_0_1.UpdateList(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	assert = var_1_10005

	var_1_10005(#arg_7_1 == #arg_7_2)

	local var_7_0 = arg_7_0.UIlist

	var_5.make(var_7_0, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_8_0 = arg_7_1[arg_8_1 + 1]
		local var_8_1 = arg_7_2[arg_8_1 + 1]

		setText = var_5

		var_5(arg_8_2:Find("title/Text"), "PHASE " .. arg_8_1 + 1)

		setText = var_5

		var_5(arg_8_2:Find("target/Text"), var_8_1)

		setText = var_5

		var_5(arg_8_2:Find("target/title"), arg_7_0.resTitle)

		local var_8_2 = {
			type = var_8_0[1],
			id = var_8_0[2],
			count = var_8_0[3]
		}

		updateDrop = var_6

		var_6(arg_8_2:Find("award"), var_8_2, {
			hideName = true
		})

		onButton = var_6

		local var_8_3 = arg_7_0
		local var_8_4 = arg_8_2:Find("award")

		local function var_8_5()
			local var_9_0 = arg_7_0
			local var_9_1 = var_0.emit

			BaseUI = var_3_10002

			var_9_1(var_9_0, var_3_10002.ON_DROP, var_8_2)

			return
		end

		SFX_PANEL = var_10

		var_6(var_8_3, var_8_4, var_8_5, var_10)

		setActive = var_6

		var_6(arg_8_2:Find("award/mask"), arg_8_1 + 1 <= arg_7_3)

		local var_8_6 = arg_7_0.ptData.progress_target[arg_8_1 + 1] < arg_7_4

		setActive = var_7

		var_7(arg_8_2:Find("mask"), var_8_6)

		if var_8_6 then
			setText = var_7

			local var_8_7 = arg_8_2
			local var_8_8 = arg_8_2.Find(var_8_7, "mask/Text")

			i18n = var_8_7

			local var_8_9 = "world_boss_award_limit"

			math = var_2_10011

			var_7(var_8_8, var_8_7(var_8_9, var_2_10011.round(arg_7_0.ptData.progress_target[arg_8_1 + 1] / 100)))
		end

		setActive = var_7

		var_7(arg_8_2:Find("award/mask/Image"), arg_8_1 + 1 <= arg_7_3)

		return
	end)

	local var_7_1 = arg_7_0.UIlist

	var_5.align(var_7_1, #arg_7_1)

	scrollTo = var_5

	var_5(arg_7_0.scrollPanel, 0, 1 - arg_7_3 * 166 / (#arg_7_2 * 166 + 20 - 570))

	return
end

function var_0_1.OnShow(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_10_0, arg_10_0._tf)

	return
end

function var_0_1.OnHide(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_11_0, arg_11_0._tf, arg_11_0.viewParent._tf)

	return
end

return var_0_1
