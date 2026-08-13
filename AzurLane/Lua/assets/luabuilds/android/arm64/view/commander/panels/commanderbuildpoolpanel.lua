class = var_0_10000

local var_0_0 = "CommanderBuildPoolPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CommanderBuildPoolUI"
end

local var_0_2 = 10

function var_0_1.OnLoaded(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "frame/bg/content/list")
	local var_2_3 = arg_2_0._tf

	arg_2_0.buildPoolList = var_2_0(var_2_2, var_4.Find(var_2_3, "frame/bg/content/list/1"))

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "frame/bg/content/queue/list1/pos")

	UIItemList = var_1_10002

	local var_2_6 = var_1_10002.New
	local var_2_7 = arg_2_0._tf

	arg_2_0.posListTop = var_2_6(var_4.Find(var_2_7, "frame/bg/content/queue/list1"), var_2_5)
	UIItemList = var_2

	local var_2_8 = var_2.New
	local var_2_9 = arg_2_0._tf

	arg_2_0.posListBottom = var_2_8(var_4.Find(var_2_9, "frame/bg/content/queue/list2"), var_2_5)

	local var_2_10 = arg_2_0._tf

	arg_2_0.autoBtn = var_2.Find(var_2_10, "frame/bg/auto_btn")

	local var_2_11 = arg_2_0._tf

	arg_2_0.startBtn = var_2.Find(var_2_11, "frame/bg/start_btn")

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_2.Find(var_2_12, "statistics/Text")
	local var_2_14 = var_2.GetComponent

	typeof = var_5
	Text = var_7
	arg_2_0.selectedTxt = var_2_14(var_2_13, var_5(var_7))

	local var_2_15 = {}
	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_3.Find(var_2_16, "frame/bg/content/list/1/icon/iconImg")
	local var_2_18 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	var_2_15[1] = var_2_18(var_2_17, var_6(var_1_10008)).sprite

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_3.Find(var_2_19, "frame/bg/content/list/2/icon/iconImg")
	local var_2_21 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	var_2_15[2] = var_2_21(var_2_20, var_6(var_1_10008)).sprite

	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_3.Find(var_2_22, "frame/bg/content/list/3/icon/iconImg")
	local var_2_24 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	var_2_15[3] = var_2_24(var_2_23, var_6(var_1_10008)).sprite
	arg_2_0.sprites = var_2_15
	setText = var_2_15

	local var_2_25 = arg_2_0._tf
	local var_2_26 = var_4.Find(var_2_25, "frame/bg/content/Text")

	i18n = var_2_23

	var_2_15(var_2_26, var_2_23("commander_use_box_tip"))

	setText = var_2_15

	local var_2_27 = arg_2_0._tf
	local var_2_28 = var_4.Find(var_2_27, "frame/bg/content/queue/title/Text")

	i18n = var_5

	var_2_15(var_2_28, var_5("commander_use_box_queue"))

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

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf
	local var_3_5 = var_4.Find(var_3_4, "frame/bg/close_btn")

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_3_4

	var_1_10001(var_3_3, var_3_5, var_3_6, var_3_4)

	onButton = var_1_10001

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.autoBtn

	local function var_3_9()
		if #arg_3_0.selected >= var_0_2 then
			return
		end

		local var_6_0 = arg_3_0

		var_0.AutoSelect(var_6_0)

		local var_6_1 = arg_3_0

		var_0.UpdatePos(var_6_1)

		return
	end

	SFX_PANEL = var_3_4

	var_1_10001(var_3_7, var_3_8, var_3_9, var_3_4)

	onButton = var_1_10001

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0.startBtn

	local function var_3_12()
		if #arg_3_0.selected == 0 then
			return
		end

		local var_7_0 = arg_3_0.contextData.msgBox
		local var_7_1 = var_0.ExecuteAction
		local var_7_2 = "Show"
		local var_7_3 = {}

		i18n = var_2_10005
		var_7_3.content = var_2_10005("commander_select_box_tip", #arg_3_0.selected)

		function var_7_3.onYes()
			local var_8_0 = arg_3_0
			local var_8_1 = var_0.emit

			CommanderCatMediator = var_3_10003

			var_8_1(var_8_0, var_3_10003.BATCH_BUILD, arg_3_0.selected)

			local var_8_2 = arg_3_0

			var_0.Hide(var_8_2)

			return
		end

		var_7_1(var_7_0, var_7_2, var_7_3)

		return
	end

	SFX_PANEL = var_3_4

	var_1_10001(var_3_10, var_3_11, var_3_12, var_3_4)

	return
end

function var_0_1.AutoSelect(arg_9_0)
	local var_9_0 = arg_9_0.pools

	local function var_9_1()
		local var_10_0

		pairs = var_2_10001

		for iter_10_0, iter_10_1 in var_2_10001(arg_9_0.counts) do
			if iter_10_1 > 0 then
				var_10_0 = iter_10_0
			end
		end

		return var_10_0
	end

	local var_9_2 = var_0_2 - #arg_9_0.selected

	for iter_9_0 = 1, var_9_2 do
		if var_9_1() then
			arg_9_0:ReduceCount(var_8, -1)
		end
	end

	return
end

function var_0_1.Show(arg_11_0, arg_11_1, arg_11_2)
	var_0_2 = arg_11_2
	arg_11_0.selected = {}
	arg_11_0.pools = arg_11_1

	local var_11_0 = arg_11_0.pools

	arg_11_0.counts = {}
	ipairs = var_4

	for iter_11_0, iter_11_1 in var_4(arg_11_0.pools) do
		arg_11_0.counts[iter_11_1.id] = iter_11_1:getItemCount()
	end

	arg_11_0.boxesTxt = {}
	table = var_4

	var_4.sort(var_11_0, function(arg_12_0, arg_12_1)
		return arg_12_0.id < arg_12_1.id
	end)

	local var_11_1 = arg_11_0.buildPoolList

	var_4.make(var_11_1, function(arg_13_0, arg_13_1, arg_13_2)
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventUpdate then
			local var_13_0 = var_11_0[arg_13_1 + 1]

			pressPersistTrigger = var_4

			local var_13_1 = arg_13_2:Find("icon")
			local var_13_2 = 0.5

			local function var_13_3(arg_14_0)
				if #arg_11_0.selected < var_0_2 and arg_11_0.counts[var_13_0.id] > 0 then
					local var_14_0 = arg_11_0

					var_1.ReduceCount(var_14_0, var_13_0.id, -1)
				else
					arg_14_0()
				end

				return
			end

			local var_13_4
			local var_13_5 = true
			local var_13_6 = true
			local var_13_7 = 0.15

			SFX_PANEL = var_2_10013

			var_4(var_13_1, var_13_2, var_13_3, var_13_4, var_13_5, var_13_6, var_13_7, var_2_10013)

			setText = var_4

			var_4(arg_13_2:Find("name"), var_13_0:getName())

			arg_11_0.boxesTxt[var_13_0.id] = arg_13_2:Find("Text")

			local var_13_8 = arg_11_0

			var_4.ReduceCount(var_13_8, var_13_0.id, 0)
		end

		return
	end)

	local var_11_2 = arg_11_0.buildPoolList

	var_4.align(var_11_2, #var_11_0)
	arg_11_0:UpdatePos()

	setActive = var_4

	var_4(arg_11_0._tf, true)

	arg_11_0.isShow = true

	return
end

function var_0_1.ReduceCount(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	assert = var_1_10004

	var_1_10004(arg_15_2 == 1 or arg_15_2 == 0 or arg_15_2 == -1)

	local var_15_0 = arg_15_0.boxesTxt[arg_15_1]
	local var_15_1 = arg_15_0.counts[arg_15_1] + arg_15_2
	local var_15_2 = arg_15_0.counts

	var_15_2[arg_15_1] = var_15_1
	setText = var_15_2

	var_15_2(var_15_0, var_15_1)

	if arg_15_2 < 0 then
		table = var_6

		var_6.insert(arg_15_0.selected, arg_15_1)
		arg_15_0:UpdatePos()
	elseif 0 < arg_15_2 then
		table = var_6

		var_6.remove(arg_15_0.selected, arg_15_3)
		arg_15_0:UpdatePos()
	end

	return
end

function var_0_1.poolId2Sprite(arg_16_0, arg_16_1)
	return arg_16_0.sprites[arg_16_1]
end

function var_0_1.UpdatePos(arg_17_0)
	local function var_17_0(arg_18_0, arg_18_1)
		local var_18_0 = arg_17_0.selected[arg_18_0]
		local var_18_1 = arg_18_1:Find("icon")

		if var_18_0 then
			local var_18_2 = var_18_1

			var_2_10004 = var_18_1.GetComponent
			typeof = var_2_10007
			Image = var_2_10009
			var_2_10004 = var_2_10004(var_18_2, var_2_10007(var_2_10009))

			local var_18_3 = arg_17_0

			var_2_10004.sprite = var_5.poolId2Sprite(var_18_3, var_18_0)
			onButton = var_2_10004

			local var_18_4 = arg_17_0
			local var_18_5 = var_18_1

			local function var_18_6()
				local var_19_0 = arg_17_0

				var_0.ReduceCount(var_19_0, var_18_0, 1, arg_18_0)

				return
			end

			SFX_PANEL = var_2_10009

			var_2_10004(var_18_4, var_18_5, var_18_6, var_2_10009)
		else
			setText = var_2_10004

			var_2_10004(arg_18_1:Find("empty/Text"), arg_18_0)
		end

		setActive = var_2_10004

		var_2_10004(arg_18_1:Find("empty"), not var_18_0)

		setActive = var_2_10004

		var_2_10004(var_18_1, var_18_0)

		return
	end

	local var_17_1 = arg_17_0.posListTop

	var_2.make(var_17_1, function(arg_20_0, arg_20_1, arg_20_2)
		UIItemList = var_2_10003

		if arg_20_0 == var_2_10003.EventUpdate then
			var_17_0(arg_20_1 + 1, arg_20_2)
		end

		return
	end)

	local var_17_2 = arg_17_0.posListTop
	local var_17_3 = var_2.align

	math = var_5

	var_17_3(var_17_2, var_5.min(5, var_0_2))

	local var_17_4 = arg_17_0.posListBottom

	var_2.make(var_17_4, function(arg_21_0, arg_21_1, arg_21_2)
		UIItemList = var_2_10003

		if arg_21_0 == var_2_10003.EventUpdate then
			var_17_0(arg_21_1 + 6, arg_21_2)
		end

		return
	end)

	local var_17_5 = arg_17_0.posListBottom
	local var_17_6 = var_2.align

	math = var_5

	local var_17_7 = var_5.max
	local var_17_8 = 0

	math = var_8

	var_17_6(var_17_5, var_17_7(var_17_8, var_8.min(5, var_0_2 - 5)))

	arg_17_0.selectedTxt.text = #arg_17_0.selected .. "/" .. var_0_2

	return
end

function var_0_1.Hide(arg_22_0)
	setActive = var_1_10001

	var_1_10001(arg_22_0._tf, false)

	arg_22_0.isShow = false

	return
end

function var_0_1.OnDestroy(arg_23_0)
	return
end

return var_0_1
