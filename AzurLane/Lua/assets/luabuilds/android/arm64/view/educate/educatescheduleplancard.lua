class = var_0_10000

local var_0_0 = var_0_10000("EducateSchedulePlanCard")
local var_0_1 = {
	top = 0,
	spacing = 8,
	size = {
		x = 216,
		y = 142
	}
}
local var_0_2 = {
	top = 4,
	spacing = 14,
	size = {
		x = 216,
		y = 328
	}
}
local var_0_3 = {
	x = 0,
	y = 87
}
local var_0_4 = {
	x = 0,
	y = 110
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	var_1_10003.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_1
	tf = var_3
	arg_1_0._tf = var_3(arg_1_0._go)
	arg_1_0.viewComponent = arg_1_2

	local var_1_0 = arg_1_0._tf

	arg_1_0.selectedTF = var_3.Find(var_1_0, "selected")

	local var_1_1 = arg_1_0._tf

	arg_1_0.iconBgTF = var_3.Find(var_1_1, "icon_bg")

	local var_1_2 = arg_1_0.iconBgTF

	arg_1_0.iconTF = var_3.Find(var_1_2, "icon")

	local var_1_3 = arg_1_0._tf

	arg_1_0.progressTF = var_3.Find(var_1_3, "progress")

	local var_1_4 = arg_1_0._tf

	arg_1_0.sliderTF = var_3.Find(var_1_4, "slider")

	local var_1_5 = arg_1_0._tf

	arg_1_0.nameTF = var_3.Find(var_1_5, "name_mask")

	local var_1_6 = arg_1_0.nameTF

	arg_1_0.nameTextTF = var_3.Find(var_1_6, "name")

	local var_1_7 = arg_1_0._tf

	arg_1_0.enNameTF = var_3.Find(var_1_7, "name_en")

	local var_1_8 = arg_1_0._tf

	arg_1_0.limitTF = var_3.Find(var_1_8, "limit")
	UIItemList = var_3

	local var_1_9 = var_3.New
	local var_1_10 = arg_1_0.limitTF
	local var_1_11 = arg_1_0.limitTF

	arg_1_0.limitUIList = var_1_9(var_1_10, var_6.Find(var_1_11, "tpl"))

	local var_1_12 = arg_1_0.limitUIList

	var_3.make(var_1_12, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			local var_2_0 = arg_1_0

			var_3.updateLimitItem(var_2_0, arg_2_1, arg_2_2)
		end

		return
	end)

	local var_1_13 = arg_1_0._tf

	arg_1_0.costTF = var_3.Find(var_1_13, "cost")

	local var_1_14 = arg_1_0._tf

	arg_1_0.costEmptyTF = var_3.Find(var_1_14, "cost_empty")
	setText = var_3

	local var_1_15 = arg_1_0.costEmptyTF
	local var_1_16 = var_5.Find(var_1_15, "Text")

	i18n = var_6

	var_3(var_1_16, var_6("child_plan_no_cost"))

	UIItemList = var_3

	local var_1_17 = var_3.New
	local var_1_18 = arg_1_0.costTF
	local var_1_19 = arg_1_0.costTF

	arg_1_0.costUIList = var_1_17(var_1_18, var_6.Find(var_1_19, "tpl"))

	local var_1_20 = arg_1_0.costUIList

	var_3.make(var_1_20, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			local var_3_0 = arg_1_0

			var_3.updateCostItem(var_3_0, arg_3_1, arg_3_2)
		end

		return
	end)

	local var_1_21 = arg_1_0._tf

	arg_1_0.awardTF = var_3.Find(var_1_21, "award")
	UIItemList = var_3

	local var_1_22 = var_3.New
	local var_1_23 = arg_1_0.awardTF
	local var_1_24 = var_5.Find(var_1_23, "content")
	local var_1_25 = arg_1_0.awardTF

	arg_1_0.awardUIList = var_1_22(var_1_24, var_6.Find(var_1_25, "content/tpl"))

	local var_1_26 = arg_1_0.awardUIList

	var_3.make(var_1_26, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_1_0

			var_3.updateAwardItem(var_4_0, arg_4_1, arg_4_2)
		end

		return
	end)

	local var_1_27 = arg_1_0.awardTF

	arg_1_0.foldBtn = var_3.Find(var_1_27, "fold_btn")

	local var_1_28 = arg_1_0.awardTF

	arg_1_0.unfoldBtn = var_3.Find(var_1_28, "unfold_btn")

	local var_1_29 = arg_1_0.awardTF
	local var_1_30 = var_3.Find(var_1_29, "content")
	local var_1_31 = var_3.GetComponent

	typeof = var_6
	VerticalLayoutGroup = var_1_25
	arg_1_0.awardLayouCom = var_1_31(var_1_30, var_6(var_1_25))
	getProxy = var_3
	EducateProxy = var_1_30

	local var_1_32 = var_3(var_1_30)

	arg_1_0.char = var_3.GetCharData(var_1_32)

	return
end

function var_0_0.updateLimitItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.limitCfg[arg_5_1 + 1][2]

	LoadImageSpriteAtlasAsync = var_1_10005

	local var_5_1 = "ui/educatecommonui_atlas"
	local var_5_2 = "attr_" .. var_5_0

	findTF = var_9

	var_1_10005(var_5_1, var_5_2, var_9(arg_5_2, "icon_bg/icon"), true)

	setText = var_1_10005
	findTF = var_5_1

	var_1_10005(var_5_1(arg_5_2, "value"), var_3[3])

	setText = var_1_10005
	findTF = var_7

	local var_5_3 = var_7(arg_5_2, "name")

	pg = var_8

	var_1_10005(var_5_3, var_8.child_attr[var_5_0].name)

	local var_5_4 = var_3[4] and "606064" or "ed7373"

	setTextColor = var_1_10006
	findTF = var_8

	local var_5_5 = var_8(arg_5_2, "value")

	Color = var_9

	var_1_10006(var_5_5, var_9.NewHex(var_5_4))

	setTextColor = var_1_10006
	findTF = var_5_5

	local var_5_6 = var_5_5(arg_5_2, "name")

	Color = var_9

	var_1_10006(var_5_6, var_9.NewHex(var_5_4))

	return
end

function var_0_0.updateCostItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.costCfg[arg_6_1 + 1]

	LoadImageSpriteAtlasAsync = var_4

	local var_6_1 = "ui/educatecommonui_atlas"
	local var_6_2 = "res_" .. var_6_0.id

	findTF = var_8

	var_4(var_6_1, var_6_2, var_8(arg_6_2, "icon"), true)

	setText = var_4
	findTF = var_6_1

	var_4(var_6_1(arg_6_2, "value"), "-" .. var_6_0.num)

	setText = var_4
	findTF = var_6

	local var_6_3 = var_6(arg_6_2, "name")

	pg = var_7

	var_4(var_6_3, var_7.child_resource[var_6_0.id].name)

	return
end

function var_0_0.updateAwardItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.awardCfg[arg_7_1 + 1]
	local var_7_1 = {
		type = var_7_0[1],
		id = var_7_0[2],
		number = var_7_0[3]
	}

	EducateHelper = var_5

	var_5.UpdateDropShowForAttr(arg_7_2, var_7_1)

	return
end

function var_0_0.update(arg_8_0, arg_8_1, arg_8_2)
	setActive = var_1_10003

	var_1_10003(arg_8_0.selectedTF, arg_8_1.id == arg_8_2)

	GetImageSpriteFromAtlasAsync = var_1_10003

	var_1_10003("ui/educatescheduleui_atlas", arg_8_1:GetIconBgName(), arg_8_0.iconBgTF, true)

	LoadImageSpriteAsync = var_1_10003

	var_1_10003("educateprops/" .. arg_8_1:getConfig("icon"), arg_8_0.iconTF, true)

	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.getConfig(var_8_0, "pre_next")

	setActive = var_1_10004

	var_1_10004(arg_8_0.progressTF, var_8_1 ~= 0)

	setActive = var_1_10004

	var_1_10004(arg_8_0.sliderTF, var_8_1 ~= 0)

	setActive = var_1_10004

	var_1_10004(arg_8_0.enNameTF, var_8_1 == 0)

	if var_8_1 ~= 0 then
		assert = var_1_10004
		pg = var_6

		var_1_10004(var_6.child_plan[var_8_1], "no exist next plan id" .. var_8_1)

		pg = var_1_10004
		var_1_10004 = var_1_10004.child_plan[var_8_1].pre[2]
		getProxy = var_8_0
		EducateProxy = var_7

		local var_8_2 = var_8_0(var_7)
		local var_8_3 = var_8_0.GetPlanProxy(var_8_2)
		local var_8_4 = var_8_0.GetHistoryCntById(var_8_3, arg_8_1.id) / var_1_10004

		setSlider = var_8_3

		var_8_3(arg_8_0.sliderTF, 0, 1, var_8_4)

		setText = var_8_3

		var_8_3(arg_8_0.progressTF, var_8_4 >= 1 and "MAX" or var_8_0 .. "/" .. var_1_10004)
	end

	setScrollText = var_1_10004

	var_1_10004(arg_8_0.nameTextTF, arg_8_1:getConfig("name"))

	setLocalPosition = var_1_10004

	local var_8_5 = arg_8_0.nameTF
	local var_8_6

	if var_8_1 ~= 0 or not var_0_4 then
		var_8_6 = var_0_3
	end

	var_1_10004(var_8_5, var_8_6)

	local var_8_7 = not arg_8_1:IsMatchAttr(arg_8_0.char)

	setActive = var_8_0

	var_8_0(arg_8_0.limitTF, var_8_7)

	local var_8_8 = arg_8_1:getConfig("ability")

	arg_8_0.limitCfg = {}

	for iter_8_0 = 1, #var_8_8 do
		Clone = var_8_9

		local var_8_9 = var_8_9(var_8_8[iter_8_0])

		var_1_10013 = arg_8_0.char

		local var_8_10 = var_11.GetAttrById(var_1_10013, var_8_9[2])
		local var_8_11 = var_8_9[3] <= var_8_10

		table = var_12

		var_12.insert(var_8_9, var_8_11)

		table = var_12

		var_12.insert(arg_8_0.limitCfg, var_8_9)
	end

	table = var_6

	local var_8_12 = var_6.sort
	local var_8_13 = arg_8_0.limitCfg

	CompareFuncs = iter_8_0

	var_8_12(var_8_13, iter_8_0({
		function(arg_9_0)
			return arg_9_0[4] and 1 or 0
		end
	}))

	local var_8_14 = arg_8_0.limitUIList

	var_6.align(var_8_14, #arg_8_0.limitCfg)

	arg_8_0.costCfg = {}

	local var_8_15, var_8_16 = arg_8_1:GetCost()

	if 0 < var_8_15 then
		table = var_8

		local var_8_17 = var_8.insert
		local var_8_18 = arg_8_0.costCfg
		local var_8_19 = {}

		EducateChar = var_12
		var_8_19.id = var_12.RES_MONEY_ID
		var_8_19.num = var_8_15

		var_8_17(var_8_18, var_8_19)
	end

	local var_8_20

	if 0 < var_8_16 then
		table = var_8_20
		var_8_20 = var_8_20.insert

		local var_8_21 = arg_8_0.costCfg
		local var_8_22 = {}

		EducateChar = var_12
		var_8_22.id = var_12.RES_MOOD_ID
		var_8_22.num = var_8_16

		var_8_20(var_8_21, var_8_22)
	end

	setActive = var_8_20

	var_8_20(arg_8_0.costTF, not var_8_7)

	setActive = var_8_20

	var_8_20(arg_8_0.costEmptyTF, not var_8_7 and #arg_8_0.costCfg == 0)

	local var_8_23 = arg_8_0.costUIList

	var_8.align(var_8_23, #arg_8_0.costCfg)

	arg_8_0.awardCfg = arg_8_1:GetResult()

	arg_8_0:setAwardParam(var_0_1)

	local var_8_24 = arg_8_0.awardUIList

	var_8.align(var_8_24, #arg_8_0.awardCfg > 2 and 2 or #arg_8_0.awardCfg)

	setActive = var_8

	var_8(arg_8_0.unfoldBtn, #arg_8_0.awardCfg > 2)

	setActive = var_8

	var_8(arg_8_0.foldBtn, false)

	onButton = var_8

	local var_8_25 = arg_8_0
	local var_8_26 = arg_8_0.unfoldBtn

	local function var_8_27()
		local var_10_0 = arg_8_0

		var_0.setAwardParam(var_10_0, var_0_2)

		setActive = var_0

		var_0(arg_8_0.foldBtn, true)

		setActive = var_0

		var_0(arg_8_0.unfoldBtn, false)

		setActive = var_0

		var_0(arg_8_0.limitTF, false)

		setActive = var_0

		var_0(arg_8_0.costTF, false)

		setActive = var_0

		var_0(arg_8_0.costEmptyTF, false)

		local var_10_1 = arg_8_0.awardUIList

		var_0.align(var_10_1, #arg_8_0.awardCfg)

		return
	end

	SFX_PANEL = var_1_10013

	var_8(var_8_25, var_8_26, var_8_27, var_1_10013)

	onButton = var_8

	local var_8_28 = arg_8_0
	local var_8_29 = arg_8_0.foldBtn

	local function var_8_30()
		local var_11_0 = arg_8_0

		var_0.setAwardParam(var_11_0, var_0_1)

		setActive = var_0

		var_0(arg_8_0.foldBtn, false)

		setActive = var_0

		var_0(arg_8_0.unfoldBtn, true)

		setActive = var_0

		var_0(arg_8_0.limitTF, var_8_7)

		setActive = var_0

		var_0(arg_8_0.costTF, not var_8_7)

		setActive = var_0

		var_0(arg_8_0.costEmptyTF, not var_8_7 and #arg_8_0.costCfg == 0)

		local var_11_1 = arg_8_0.awardUIList

		var_0.align(var_11_1, #arg_8_0.awardCfg > 2 and 2 or #arg_8_0.awardCfg)

		return
	end

	SFX_PANEL = var_1_10013

	var_8(var_8_28, var_8_29, var_8_30, var_1_10013)

	onButton = var_8

	local var_8_31 = arg_8_0
	local var_8_32 = arg_8_0._tf

	local function var_8_33()
		local var_12_0 = arg_8_0.viewComponent

		var_0.OnPlanCardClick(var_12_0, arg_8_1)

		return
	end

	SFX_PANEL = var_1_10013

	var_8(var_8_31, var_8_32, var_8_33, var_1_10013)

	return
end

function var_0_0.setAwardParam(arg_13_0, arg_13_1)
	setSizeDelta = var_1_10002

	var_1_10002(arg_13_0.awardTF, arg_13_1.size)

	arg_13_0.awardLayouCom.spacing = arg_13_1.spacing
	arg_13_0.awardLayouCom.padding.top = arg_13_1.top

	return
end

function var_0_0.dispose(arg_14_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_14_0)

	return
end

return var_0_0
