class = var_0_10000

local var_0_0 = "AwardWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ActivitybonusWindow_nonPt"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "window/top/btnBack")
	UIItemList = var_1

	local var_2_1 = var_1.New
	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_2.Find(var_2_2, "window/panel/list")
	local var_2_4 = arg_2_0._tf

	arg_2_0.uiItemList = var_2_1(var_2_3, var_3.Find(var_2_4, "window/panel/list/item"))

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "window/pt/title")
	local var_2_7 = var_1.GetComponent

	typeof = var_3
	Text = var_2_4
	arg_2_0.currentTitle = var_2_7(var_2_6, var_3(var_2_4))

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.Find(var_2_8, "window/pt/Text")
	local var_2_10 = var_1.GetComponent

	typeof = var_3
	Text = var_2_4
	arg_2_0.currentTxt = var_2_10(var_2_9, var_3(var_2_4))
	setText = var_1

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_2.Find(var_2_11, "window/top/bg/infomation")

	i18n = var_2_11

	var_1(var_2_12, var_2_11("world_expedition_reward_display"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	local var_3_6 = arg_3_0.uiItemList

	var_1.make(var_3_6, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = arg_3_0

			var_3.UpdateItem(var_6_0, arg_6_1, arg_6_2)
		end

		return
	end)

	return
end

function var_0_1.UpdateItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.awards[arg_7_1 + 1]
	local var_7_1 = arg_7_2:Find("award")
	local var_7_2 = {
		type = var_7_0[1],
		id = var_7_0[2],
		count = var_7_0[3]
	}

	updateDrop = var_6

	var_6(var_7_1, var_7_2)

	onButton = var_6

	local var_7_3 = arg_7_0
	local var_7_4 = var_7_1

	local function var_7_5()
		local var_8_0 = arg_7_0
		local var_8_1 = var_0.emit

		BaseUI = var_2_10002

		var_8_1(var_8_0, var_2_10002.ON_DROP, var_7_2)

		return
	end

	SFX_PANEL = var_1_10010

	var_6(var_7_3, var_7_4, var_7_5, var_1_10010)

	setActive = var_6

	var_6(arg_7_2:Find("award/mask"), arg_7_1 + 1 <= arg_7_0.finishIndex)

	setText = var_6

	var_6(arg_7_2:Find("target/title"), arg_7_0.targetTitle)

	setText = var_6

	var_6(arg_7_2:Find("target/Text"), arg_7_1 + 1)

	setText = var_6

	var_6(arg_7_2:Find("title/Text"), "PHASE  " .. arg_7_1 + 1)
	arg_7_0:ShowIndex(arg_7_1 + 1, arg_7_2)

	return
end

function var_0_1.Flush(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_0.awards = arg_9_1
	arg_9_0.finishIndex = arg_9_2
	arg_9_0.targetTitle = arg_9_3[2]
	arg_9_0.currentTitle.text = arg_9_3[1]
	arg_9_0.currentTxt.text = arg_9_2
	arg_9_0.showIndex = arg_9_4

	local var_9_0 = arg_9_0.uiItemList

	var_5.align(var_9_0, #arg_9_0.awards)
	arg_9_0:Show()

	return
end

function var_0_1.ShowIndex(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.showIndex ~= nil then
		setText = var_3

		var_3(arg_10_2:Find("target/Text"), arg_10_0.showIndex.targetList[arg_10_1])

		arg_10_0.currentTxt.text = arg_10_0.showIndex.nowGet
	end

	return
end

function var_0_1.Show(arg_11_0)
	var_0_1.super.Show(arg_11_0)

	pg = var_1

	local var_11_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_11_0, arg_11_0._tf)

	return
end

function var_0_1.Hide(arg_12_0)
	var_0_1.super.Hide(arg_12_0)

	pg = var_1

	local var_12_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_12_0, arg_12_0._tf, arg_12_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_13_0)
	return
end

return var_0_1
