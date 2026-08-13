class = var_0_10000

local var_0_0 = "CommanderResetTalentPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CommanderCatResetTalentUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.resetCancelBtn = var_1.Find(var_2_0, "bg/frame/cancel_btn")

	local var_2_1 = arg_2_0._tf

	arg_2_0.resetConfirmBtn = var_1.Find(var_2_1, "bg/frame/confirm_btn")

	local var_2_2 = arg_2_0._tf

	arg_2_0.resetCloseBtn = var_1.Find(var_2_2, "bg/frame/close_btn")

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "bg/frame/bg/tip/texts/Text")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.resetGoldTxt = var_2_5(var_2_4, var_4(var_1_10006))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "bg/frame/bg/tip/texts1/Text")
	local var_2_8 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.resetPointTxt = var_2_8(var_2_7, var_4(var_1_10006))
	UIItemList = var_1

	local var_2_9 = var_1.New
	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_3.Find(var_2_10, "bg/frame/bg/talents/content")
	local var_2_12 = arg_2_0._tf

	arg_2_0.resetList = var_2_9(var_2_11, var_4.Find(var_2_12, "bg/frame/bg/talents/content/talent_tpl"))
	i18n = var_1

	local var_2_13 = var_1("commander_choice_talent_reset")

	string = var_1_10002

	local var_2_14 = var_1_10002.split(var_2_13, "$1")

	string = var_3

	local var_2_15 = var_3.split(var_2_14[2], "\t")

	string = var_4

	local var_2_16 = var_4.split(var_2_15[2], "$2")

	setText = var_5

	local var_2_17 = arg_2_0._tf

	var_5(var_7.Find(var_2_17, "bg/frame/bg/tip/texts/label"), var_2_14[1] .. " ")

	setText = var_5

	local var_2_18 = arg_2_0._tf

	var_5(var_7.Find(var_2_18, "bg/frame/bg/tip/texts/label1"), " " .. var_2_15[1])

	setText = var_5

	local var_2_19 = arg_2_0._tf

	var_5(var_7.Find(var_2_19, "bg/frame/bg/tip/texts1/label"), var_2_16[1] .. " ")

	setText = var_5

	local var_2_20 = arg_2_0._tf

	var_5(var_7.Find(var_2_20, "bg/frame/bg/tip/texts1/label1"), " " .. var_2_16[2])

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
	local var_3_4 = arg_3_0.resetCloseBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.resetCancelBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.resetConfirmBtn

	local function var_3_11()
		if arg_3_0.commanderVO then
			getProxy = var_0
			PlayerProxy = var_2_10002

			local var_7_0 = var_0(var_2_10002)

			if var_0.getRawData(var_7_0).gold < arg_3_0.total then
				GoShoppingMsgBox = var_1
				i18n = var_2_10003

				local var_7_1 = "switch_to_shop_tip_2"

				i18n = var_2_10006

				local var_7_2 = var_2_10003(var_7_1, var_2_10006("word_gold"))

				ChargeScene = var_2_10004

				var_1(var_7_2, var_2_10004.TYPE_ITEM, {
					{
						59001,
						arg_3_0.total - var_0.gold,
						arg_3_0.total
					}
				})

				return
			end

			local var_7_3 = arg_3_0.contextData.msgBox
			local var_7_4 = var_1.ExecuteAction
			local var_7_5 = "Show"
			local var_7_6 = {}

			i18n = var_2_10006
			var_7_6.content = var_2_10006("commander_reset_talent_tip")

			function var_7_6.onYes()
				local var_8_0 = arg_3_0
				local var_8_1 = var_0.emit

				CommanderCatMediator = var_3_10003

				var_8_1(var_8_0, var_3_10003.RESET_TALENT, arg_3_0.commanderVO.id)

				local var_8_2 = arg_3_0

				var_0.Hide(var_8_2)

				return
			end

			var_7_4(var_7_3, var_7_5, var_7_6)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10006)

	return
end

function var_0_1.Show(arg_9_0, arg_9_1)
	var_0_1.super.Show(arg_9_0)

	local var_9_0 = arg_9_0._tf

	var_2.SetAsLastSibling(var_9_0)

	arg_9_0.commanderVO = arg_9_1

	arg_9_0:Flush()

	return
end

function var_0_1.Flush(arg_10_0)
	local var_10_0 = arg_10_0.commanderVO
	local var_10_1 = var_1.getTalentOrigins(var_10_0)
	local var_10_2 = arg_10_0.resetList

	var_3.make(var_10_2, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = arg_10_0

			var_3.UpdateTalentCard(var_11_0, arg_11_2, var_10_1[arg_11_1 + 1])
		end

		return
	end)

	local var_10_3 = arg_10_0.resetList

	var_3.align(var_10_3, #var_10_1)

	getProxy = var_3
	PlayerProxy = var_10_3

	local var_10_4 = var_3(var_10_3)
	local var_10_5 = var_3.getRawData(var_10_4)

	arg_10_0.total = var_1:getResetTalentConsume()

	local var_10_6 = arg_10_0.resetGoldTxt

	if var_10_5.gold < arg_10_0.total then
		local var_10_7 = "<color="

		COLOR_RED = var_6

		local var_10_8

		if not (var_10_7 .. var_6 .. ">" .. arg_10_0.total .. "</color>") then
			var_10_8 = arg_10_0.total
		end

		var_10_6.text = var_10_8

		local var_10_9 = arg_10_0.resetPointTxt
		local var_10_10 = var_1

		var_10_9.text = var_1.getTotalPoint(var_10_10)
		GetComponent = var_10_9

		local var_10_11 = arg_10_0.resetGoldTxt

		typeof = var_10_10
		Outline = var_1_10009
		var_10_9(var_10_11, var_10_10(var_1_10009)).enabled = var_10_5.gold >= arg_10_0.total

		return
	end
end

function var_0_1.UpdateTalentCard(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1
	local var_12_1 = arg_12_1.Find(var_12_0, "unlock")
	local var_12_2 = arg_12_1
	local var_12_3 = arg_12_1.Find(var_12_2, "lock")

	if arg_12_2 then
		GetImageSpriteFromAtlasAsync = var_12_0

		local var_12_4 = "CommanderTalentIcon/" .. arg_12_2:getConfig("icon")
		local var_12_5 = ""
		local var_12_6 = var_12_1

		var_12_0(var_12_4, var_12_5, var_12_1.Find(var_12_6, "icon"))

		if var_12_1:Find("tree_btn") then
			onButton = var_12_2

			local var_12_7 = arg_12_0
			local var_12_8 = var_12_0

			local function var_12_9()
				local var_13_0 = arg_12_0.contextData.treePanel

				var_0.ExecuteAction(var_13_0, "Show", arg_12_2)

				return
			end

			SFX_PANEL = var_12_6

			var_12_2(var_12_7, var_12_8, var_12_9, var_12_6)
		end

		setText = var_12_2

		var_12_2(var_12_1:Find("name_bg/Text"), arg_12_2:getConfig("name"))

		setScrollText = var_12_2

		var_12_2(var_12_1:Find("desc/Text"), arg_12_2:getConfig("desc"))
	end

	setActive = var_12_0

	var_12_0(var_12_1, arg_12_2)

	if var_12_3 then
		setActive = var_12_0

		var_12_0(var_12_3, not arg_12_2)
	end

	return
end

function var_0_1.OnDestroy(arg_14_0)
	return
end

return var_0_1
