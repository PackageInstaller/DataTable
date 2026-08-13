class = var_0_10000

local var_0_0 = "IslandOrderLevelInfoPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandOrderLevelInfoUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/animroot/level")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.levelTxt = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf

	arg_2_0.expTr = var_1.Find(var_2_3, "frame/animroot/slider")

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "frame/animroot/exp")
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.expTxt = var_2_6(var_2_5, var_3(var_1_10004))

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.Find(var_2_7, "frame/bg/Image/cnt")
	local var_2_9 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.cntTxt = var_2_9(var_2_8, var_3(var_1_10004))
	UIItemList = var_1

	local var_2_10 = var_1.New
	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_2.Find(var_2_11, "frame/animroot/rect/content")
	local var_2_13 = arg_2_0._tf

	arg_2_0.uiItemList = var_2_10(var_2_12, var_3.Find(var_2_13, "frame/animroot/rect/content/tpl"))
	GetOrAddComponent = var_1

	local var_2_14 = arg_2_0._tf

	typeof = var_3
	CanvasGroup = var_2_13
	arg_2_0.canvasGroup = var_1(var_2_14, var_3(var_2_13))

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

	return
end

function var_0_1.AddListeners(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.AddListener

	IslandOrderAgency = var_1_10003

	var_5_1(var_5_0, var_1_10003.ORDER_FINISH_UPDATE, arg_5_0.OnReset)

	return
end

function var_0_1.RemoveListeners(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.RemoveListener

	IslandOrderAgency = var_1_10003

	var_6_1(var_6_0, var_1_10003.ORDER_FINISH_UPDATE, arg_6_0.OnReset)

	return
end

function var_0_1.OnReset(arg_7_0)
	arg_7_0:Flush()

	return
end

function var_0_1.Show(arg_8_0)
	var_0_1.super.Show(arg_8_0)
	arg_8_0:Flush()

	return
end

function var_0_1.Flush(arg_9_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_9_0 = var_1_10001(var_1_10002)
	local var_9_1 = var_1.GetIsland(var_9_0)
	local var_9_2 = var_1.GetOrderAgency(var_9_1)

	arg_9_0:FlushCnt(var_9_2)
	arg_9_0:FlushLevelInfo(var_9_2)
	arg_9_0:FlushList(var_9_2)

	return
end

function var_0_1.FlushCnt(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.cntTxt

	i18n = var_1_10003
	var_10_0.text = var_1_10003("island_order_leftcnt_dispaly", arg_10_1:GetLeftUrgentCnt())

	return
end

function var_0_1.FlushLevelInfo(arg_11_0, arg_11_1)
	arg_11_0.levelTxt.text = "Lv." .. arg_11_1:GetLevel()

	if arg_11_1:IsMaxLevel() then
		setSlider = var_2

		var_2(arg_11_0.expTr, 0, 1, 1)

		arg_11_0.expTxt.text = "MAX"
	else
		local var_11_0 = arg_11_1
		local var_11_1 = arg_11_1.GetExp(var_11_0)

		math = var_11_0

		local var_11_2 = var_11_0.max(1, arg_11_1:GetNextTargetExp())

		setSlider = var_4

		var_4(arg_11_0.expTr, 0, 1, var_11_1 / var_11_2)

		arg_11_0.expTxt.text = "<size=60><color=#ffaf1b>" .. var_11_1 .. "</color></size><color=#979797>/" .. var_11_2 .. "</color>"
	end

	return
end

function var_0_1.FlushList(arg_12_0, arg_12_1)
	pg = var_1_10002

	local var_12_0 = var_1_10002.island_order_favor.all
	local var_12_1 = 1
	local var_12_2 = arg_12_0.uiItemList

	var_4.make(var_12_2, function(arg_13_0, arg_13_1, arg_13_2)
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventUpdate then
			local var_13_0 = var_12_0[arg_13_1 + 1]
			local var_13_1 = arg_12_0

			var_4.UpdateCard(var_13_1, arg_12_1, arg_13_2, var_13_0)

			local var_13_2 = arg_12_1

			if var_4.IsGotAward(var_13_2, var_13_0) then
				var_12_1 = arg_13_1 + 1
			end
		end

		return
	end)

	local var_12_3 = arg_12_0.uiItemList

	var_4.align(var_12_3, #var_12_0)

	scrollTo = var_4

	var_4(arg_12_0.uiItemList.container.parent, 0, 1)
	arg_12_0:ScrollTo(var_12_1, var_12_0)

	return
end

function var_0_1.ScrollTo(arg_14_0, arg_14_1, arg_14_2)
	onNextTick = var_1_10003

	var_1_10003(function()
		math = var_2_10000

		local var_15_0 = var_2_10000.min(arg_14_1, #arg_14_2 * 0.5 - 1)
		local var_15_1 = arg_14_0.uiItemList.container
		local var_15_2 = var_1.GetChild(var_15_1, 0)
		local var_15_3 = arg_14_0.uiItemList.container
		local var_15_4 = var_2.GetChild(var_15_3, var_15_0)

		math = var_15_3

		local var_15_5 = var_15_3.abs(var_15_4.localPosition.x - var_15_2.localPosition.x)
		local var_15_6 = arg_14_0.uiItemList.container.localPosition
		local var_15_7 = arg_14_0.uiItemList.container

		Vector3 = var_2_10006
		var_15_7.localPosition = var_2_10006(var_15_6.x - var_15_5, var_15_6.y, 0)

		return
	end)

	return
end

function var_0_1.UpdateCard(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0:UpdateAwards(arg_16_2, arg_16_3)

	local var_16_0 = arg_16_1:IsGotAward(arg_16_3)
	local var_16_1 = arg_16_1:CanGetAward(arg_16_3) or var_16_0

	setActive = var_7

	var_7(arg_16_2:Find("got"), var_16_0)

	setActive = var_7

	var_7(arg_16_2:Find("finish"), var_16_1)

	local var_16_2

	if not (arg_16_3 < 10) or not ("0" .. arg_16_3) then
		var_16_2 = arg_16_3
	end

	setText = var_8

	local var_16_3 = arg_16_2
	local var_16_4 = arg_16_2.Find(var_16_3, "num")

	setColorStr = var_16_3

	var_8(var_16_4, var_16_3(var_16_2, var_16_1 and "#FFFFFF" or "#979797"))

	onButton = var_8

	local var_16_5 = arg_16_0
	local var_16_6 = arg_16_2

	local function var_16_7()
		if var_0 and not var_16_0 then
			local var_17_0 = arg_16_0
			local var_17_1 = var_0.emit

			IslandMediator = var_2_10002

			var_17_1(var_17_0, var_2_10002.ON_GET_ORDER_EXP_AWARD, arg_16_3)
		end

		return
	end

	SFX_PANEL = var_12

	var_8(var_16_5, var_16_6, var_16_7, var_12)

	return
end

function var_0_1.UpdateAwards(arg_18_0, arg_18_1, arg_18_2)
	pg = var_1_10003

	local var_18_0 = var_1_10003.island_order_favor[arg_18_2].award_display

	UIItemList = var_1_10004

	local var_18_1 = var_1_10004.New(arg_18_1:Find("awards"), arg_18_1:Find("awards/IslandItemTpl"))

	var_4.make(var_18_1, function(arg_19_0, arg_19_1, arg_19_2)
		UIItemList = var_2_10003

		if arg_19_0 == var_2_10003.EventUpdate then
			local var_19_0 = var_18_0[arg_19_1 + 1]

			Drop = var_4

			local var_19_1 = var_4.Create(var_19_0)

			updateCustomDrop = var_5

			var_5(arg_19_2, var_19_1)
		end

		return
	end)

	local var_18_2 = var_4
	local var_18_3 = var_4.align

	math = var_7

	var_18_3(var_18_2, var_7.min(2, #var_18_0))

	return
end

function var_0_1.OnDestroy(arg_20_0)
	return
end

return var_0_1
