class = var_0_10000

local var_0_0 = "ChargeItemBoxLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ChargeItemBoxUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()
	arg_2_0:initUIText()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:updatePanel()

	pg = var_1

	local var_3_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)

	return
end

function var_0_1.willExit(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf)

	return
end

function var_0_1.initData(arg_5_0)
	arg_5_0.panelConfig = arg_5_0.contextData.panelConfig

	return
end

function var_0_1.initUIText(arg_6_0)
	local var_6_0 = arg_6_0._tf
	local var_6_1 = var_1.Find(var_6_0, "window/button_container/button_cancel/Image")
	local var_6_2 = arg_6_0._tf
	local var_6_3 = var_2.Find(var_6_2, "window/button_container/button_ok/Image")

	setText = var_6_2

	local var_6_4 = var_6_1

	i18n = var_1_10005

	var_6_2(var_6_4, var_1_10005("text_cancel"))

	setText = var_6_2

	local var_6_5 = var_6_3

	i18n = var_5

	var_6_2(var_6_5, var_5("text_buy"))

	return
end

function var_0_1.findUI(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.bg = var_1.Find(var_7_0, "back_sign")

	local var_7_1 = arg_7_0._tf

	arg_7_0.detailWindow = var_1.Find(var_7_1, "window")

	local var_7_2 = arg_7_0.detailWindow

	arg_7_0.cancelBtn = var_1.Find(var_7_2, "button_container/button_cancel")

	local var_7_3 = arg_7_0.detailWindow

	arg_7_0.confirmBtn = var_1.Find(var_7_3, "button_container/button_ok")

	local var_7_4 = arg_7_0.detailWindow

	arg_7_0.detailName = var_1.Find(var_7_4, "goods/name")

	local var_7_5 = arg_7_0.detailWindow

	arg_7_0.detailIcon = var_1.Find(var_7_5, "goods/icon")

	local var_7_6 = arg_7_0.detailWindow

	arg_7_0.detailRmb = var_1.Find(var_7_6, "prince_bg/contain/icon_rmb")

	local var_7_7 = arg_7_0.detailWindow

	arg_7_0.detailGem = var_1.Find(var_7_7, "prince_bg/contain/icon_gem")

	local var_7_8 = arg_7_0.detailWindow

	arg_7_0.detailPrice = var_1.Find(var_7_8, "prince_bg/contain/Text")

	local var_7_9 = arg_7_0.detailWindow

	arg_7_0.detailTag = var_1.Find(var_7_9, "goods/tag")
	arg_7_0.detailTags = {}
	table = var_1

	local var_7_10 = var_1.insert
	local var_7_11 = arg_7_0.detailTags
	local var_7_12 = arg_7_0.detailTag

	var_7_10(var_7_11, var_3.Find(var_7_12, "hot"))

	table = var_7_10

	local var_7_13 = var_7_10.insert
	local var_7_14 = arg_7_0.detailTags
	local var_7_15 = arg_7_0.detailTag

	var_7_13(var_7_14, var_3.Find(var_7_15, "new"))

	table = var_7_13

	local var_7_16 = var_7_13.insert
	local var_7_17 = arg_7_0.detailTags
	local var_7_18 = arg_7_0.detailTag

	var_7_16(var_7_17, var_3.Find(var_7_18, "advice"))

	table = var_7_16

	local var_7_19 = var_7_16.insert
	local var_7_20 = arg_7_0.detailTags
	local var_7_21 = arg_7_0.detailTag

	var_7_19(var_7_20, var_3.Find(var_7_21, "double"))

	table = var_7_19

	local var_7_22 = var_7_19.insert
	local var_7_23 = arg_7_0.detailTags
	local var_7_24 = arg_7_0.detailTag

	var_7_22(var_7_23, var_3.Find(var_7_24, "discount"))

	arg_7_0.detailTagAdviceTF = arg_7_0.detailTags[3]
	arg_7_0.detailTagDoubleTF = arg_7_0.detailTags[4]

	local var_7_25 = arg_7_0.detailWindow

	arg_7_0.detailNormalTip = var_1.Find(var_7_25, "NormalTips")

	return
end

function var_0_1.addListener(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.bg

	local function var_8_2()
		local var_9_0 = arg_8_0

		var_0.closeView(var_9_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10005)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.cancelBtn

	local function var_8_5()
		local var_10_0 = arg_8_0

		var_0.closeView(var_10_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10005)

	onButton = var_1_10001

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0.confirmBtn

	local function var_8_8()
		if arg_8_0.panelConfig.onYes then
			arg_8_0.panelConfig.onYes()

			local var_11_0 = arg_8_0

			var_0.closeView(var_11_0)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_6, var_8_7, var_8_8, var_1_10005)

	return
end

function var_0_1.updatePanel(arg_12_0)
	local var_12_0 = arg_12_0.panelConfig.icon
	local var_12_1

	if not arg_12_0.panelConfig.name or not arg_12_0.panelConfig.name then
		var_12_1 = ""
	end

	if not arg_12_0.panelConfig.tipBonus then
		local var_12_2 = ""
	end

	local var_12_3 = arg_12_0.panelConfig.bonusItem

	if not arg_12_0.panelConfig.tipExtra or not arg_12_0.panelConfig.tipExtra then
		local var_12_4 = ""
	end

	if not arg_12_0.panelConfig.extraItems or not arg_12_0.panelConfig.extraItems then
		local var_12_5 = {}
	end

	local var_12_6

	if not arg_12_0.panelConfig.price or not arg_12_0.panelConfig.price then
		var_12_6 = 0
	end

	local var_12_7 = arg_12_0.panelConfig.isChargeType
	local var_12_8 = arg_12_0.panelConfig.isLocalPrice
	local var_12_9 = arg_12_0.panelConfig.isMonthCard
	local var_12_10 = arg_12_0.panelConfig.tagType
	local var_12_11 = arg_12_0.panelConfig.normalTip
	local var_12_12 = arg_12_0.panelConfig.extraDrop

	if arg_12_0.detailNormalTip then
		setActive = var_14

		var_14(arg_12_0.detailNormalTip, var_12_11)
	end

	if var_12_11 then
		local var_12_13 = arg_12_0.detailNormalTip

		if var_14.GetComponent(var_12_13, "Text") then
			setText = var_14

			var_14(arg_12_0.detailNormalTip, var_12_11)
		else
			setButtonText = var_14

			var_14(arg_12_0.detailNormalTip, var_12_11)
		end
	end

	setActive = var_14

	var_14(arg_12_0.detailTag, var_12_10 > 0)

	if 0 < var_12_10 then
		ipairs = var_14

		for iter_12_0, iter_12_1 in var_14(arg_12_0.detailTags) do
			setActive = var_1_10019

			var_1_10019(iter_12_1, iter_12_0 == var_12_10)
		end
	end

	GetImageSpriteFromAtlasAsync = var_14

	var_14(var_12_0, "", arg_12_0.detailIcon, false)

	setText = var_14

	var_14(arg_12_0.detailName, var_12_1)

	PLATFORM_CODE = var_14
	PLATFORM_CHT = var_15

	if var_14 == var_15 then
		setActive = var_14

		var_14(arg_12_0.detailRmb, var_12_7 and not var_12_8)
	else
		setActive = var_14

		var_14(arg_12_0.detailRmb, var_12_7)
	end

	setActive = var_14

	var_14(arg_12_0.detailGem, not var_12_7)

	setText = var_14

	var_14(arg_12_0.detailPrice, var_12_6)

	return
end

return var_0_1
