class = var_0_10000

local var_0_0 = "CourtYardComfortablePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CourtYardComfortablePanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "frame/close")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "frame/view/subtitle2/Text")
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.subTitleTxt = var_2_3(var_2_2, var_3(var_1_10004))
	setText = var_1

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_2.Find(var_2_4, "frame/view/subtitle1/Text")

	i18n = var_2_4

	var_1(var_2_5, var_2_4("backyard_backyardScene_comforChatContent1"))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "frame/view/express/Text")
	local var_2_8 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.expressionTxt = var_2_8(var_2_7, var_3(var_4))

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_1.Find(var_2_9, "frame/view/express/icon")
	local var_2_11 = var_1.GetComponent

	typeof = var_3
	Image = var_4
	arg_2_0.comfortableImg = var_2_11(var_2_10, var_3(var_4))

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_1.Find(var_2_12, "frame/view/express")
	local var_2_14 = var_1.GetComponent

	typeof = var_3
	Image = var_4
	arg_2_0.comfortableBg = var_2_14(var_2_13, var_3(var_4))
	UIItemList = var_1

	local var_2_15 = var_1.New
	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_2.Find(var_2_16, "frame/view/list/content")
	local var_2_18 = arg_2_0._tf

	arg_2_0.uiItemList = var_2_15(var_2_17, var_3.Find(var_2_18, "frame/view/list/content/tpl"))

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_1.Find(var_2_19, "frame/view")
	local var_2_21 = var_1.GetComponent

	typeof = var_3
	Animation = var_2_18
	arg_2_0.animation = var_2_21(var_2_20, var_3(var_2_18))

	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_1.Find(var_2_22, "frame/view")
	local var_2_24 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_2_18
	arg_2_0.dftAniEvent = var_2_24(var_2_23, var_3(var_2_18))

	local var_2_25 = arg_2_0._tf

	arg_2_0.foldBtn = var_1.Find(var_2_25, "frame/view/fold")

	local var_2_26 = arg_2_0._tf

	arg_2_0.arr = var_1.Find(var_2_26, "frame/view/fold/up")

	local var_2_27 = arg_2_0._tf

	arg_2_0.subTitle = var_1.Find(var_2_27, "frame/view/subtitle2")

	local var_2_28 = arg_2_0._tf
	local var_2_29 = var_1.Find(var_2_28, "frame/exp/Text")
	local var_2_30 = var_1.GetComponent

	typeof = var_3
	Text = var_2_18
	arg_2_0.expAdditionTxt = var_2_30(var_2_29, var_3(var_2_18))
	setText = var_1

	local var_2_31 = arg_2_0._tf
	local var_2_32 = var_2.Find(var_2_31, "frame/exp")

	i18n = var_2_31

	var_1(var_2_32, var_2_31("courtyard_label_comfortable_addition"))

	setText = var_1

	local var_2_33 = arg_2_0._tf
	local var_2_34 = var_2.Find(var_2_33, "frame/title")

	i18n = var_2_33

	var_1(var_2_34, var_2_33("word_comfort_level"))

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

	local var_3_6 = false

	onButton = var_3_3

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.foldBtn

	local function var_3_9()
		var_3_6 = not var_3_6

		if var_3_6 then
			setActive = var_0

			var_0(arg_3_0.subTitle, true)
		end

		local var_6_0 = arg_3_0.dftAniEvent

		var_0.SetEndEvent(var_6_0, function()
			local var_7_0 = arg_3_0.dftAniEvent

			var_0.SetEndEvent(var_7_0, nil)

			setActive = var_0

			var_0(arg_3_0.subTitle, false)

			return
		end)

		local var_6_1 = arg_3_0.animation

		var_0.Play(var_6_1, var_3_6 and "anim_courtyard_comfortable_viewin" or "anim_courtyard_comfortable_viewhide")

		return
	end

	SFX_PANEL = var_1_10006

	var_3_3(var_3_7, var_3_8, var_3_9, var_1_10006)

	return
end

function var_0_1.Show(arg_8_0, arg_8_1)
	var_0_1.super.Show(arg_8_0)

	arg_8_0.dorm = arg_8_1

	local var_8_0 = arg_8_1:getComfortable()

	arg_8_0:FlushSubTitle()
	arg_8_0:FlushExpression(var_8_0)
	arg_8_0:FlushList()
	arg_8_0:FlushAddition(var_8_0)

	return
end

function var_0_1.FlushSubTitle(arg_9_0)
	local var_9_0 = arg_9_0.dorm.level
	local var_9_1 = arg_9_0.subTitleTxt

	i18n = var_1_10003
	var_9_1.text = var_1_10003("backyard_backyardScene_comforChatContent2", var_9_0 - 1)

	return
end

function var_0_1.FlushExpression(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.dorm
	local var_10_1 = var_2.GetComfortableLevel(var_10_0, arg_10_1)
	local var_10_2 = arg_10_0.expressionTxt

	i18n = var_4
	var_10_2.text = var_4("backyard_backyardScene_expression_label_" .. var_10_1)
	LoadSpriteAtlasAsync = var_10_2

	var_10_2("ui/CourtyardUI_atlas", "express_" .. var_10_1, function(arg_11_0)
		if arg_10_0.exited then
			return
		end

		arg_10_0.comfortableImg.sprite = arg_11_0

		local var_11_0 = arg_10_0.comfortableImg

		var_1.SetNativeSize(var_11_0)

		return
	end)

	local var_10_3 = arg_10_0.comfortableBg
	local var_10_4 = arg_10_0.dorm

	var_10_3.color = var_4.GetComfortableColor(var_10_4, var_10_1)

	return
end

local var_0_2 = {}

i18n = var_2
var_0_2[1] = var_2("word_wallpaper")
i18n = var_2
var_0_2[2] = var_2("word_furniture")
i18n = var_2
var_0_2[3] = var_2("word_decorate")
i18n = var_2
var_0_2[4] = var_2("word_floorpaper")
i18n = var_2
var_0_2[5] = var_2("word_mat")
i18n = var_2
var_0_2[6] = var_2("word_wall")
i18n = var_2
var_0_2[7] = var_2("word_collection")

function var_0_1.FlushList(arg_12_0)
	local var_12_0 = arg_12_0.dorm
	local var_12_1 = var_1.getConfig(var_12_0, "comfortable_count")
	local var_12_2 = arg_12_0.uiItemList

	var_2.make(var_12_2, function(arg_13_0, arg_13_1, arg_13_2)
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventUpdate then
			local var_13_0 = arg_13_1 + 1

			LoadSpriteAtlasAsync = var_2_10004

			var_2_10004("ui/CourtyardUI_atlas", "icon_" .. var_13_0, function(arg_14_0)
				if arg_12_0.exited then
					return
				end

				local var_14_0 = arg_13_2
				local var_14_1 = var_1.Find(var_14_0, "icon")
				local var_14_2 = var_1.GetComponent

				typeof = var_3
				Image = var_3_10004

				local var_14_3 = var_14_2(var_14_1, var_3(var_3_10004))

				var_14_3.sprite = arg_14_0

				var_14_3:SetNativeSize()

				return
			end)

			setText = var_2_10004

			var_2_10004(arg_13_2:Find("name"), var_0_2[var_13_0])

			setText = var_2_10004

			var_2_10004(arg_13_2:Find("Text"), "X" .. var_12_1[var_13_0][2])

			local var_13_1 = var_13_0 % 2 ~= 0

			setActive = var_5

			var_5(arg_13_2:Find("line"), var_13_1)

			setActive = var_5

			var_5(arg_13_2:Find("bg"), var_13_1)
		end

		return
	end)

	local var_12_3 = arg_12_0.uiItemList

	var_2.align(var_12_3, 7)

	return
end

function var_0_1.FlushAddition(arg_15_0, arg_15_1)
	pg = var_1_10002

	local var_15_0 = var_1_10002.gameset.dorm_exp_ratio_comfort_degree.key_value
	local var_15_1 = 0

	if var_15_0 + arg_15_1 ~= 0 then
		var_15_1 = arg_15_1 / (var_15_0 + arg_15_1) * 100
	end

	local var_15_2 = arg_15_0.expAdditionTxt

	string = var_1_10005
	var_15_2.text = var_1_10005.format("%d", var_15_1) .. "%"

	return
end

function var_0_1.OnDestroy(arg_16_0)
	local var_16_0 = arg_16_0.dftAniEvent

	var_1.SetTriggerEvent(var_16_0, nil)

	arg_16_0.exited = true

	return
end

return var_0_1
