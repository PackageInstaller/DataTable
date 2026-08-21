local var_0_0 = class("CourtYardComfortablePage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "CourtYardComfortablePanel"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/close")
	arg_2_0.subTitleTxt = arg_2_0._tf:Find("frame/view/subtitle2/Text"):GetComponent(typeof(Text))

	setText(arg_2_0._tf:Find("frame/view/subtitle1/Text"), i18n("backyard_backyardScene_comforChatContent1"))

	arg_2_0.expressionTxt = arg_2_0._tf:Find("frame/view/express/Text"):GetComponent(typeof(Text))
	arg_2_0.comfortableImg = arg_2_0._tf:Find("frame/view/express/icon"):GetComponent(typeof(Image))
	arg_2_0.comfortableBg = arg_2_0._tf:Find("frame/view/express"):GetComponent(typeof(Image))
	arg_2_0.uiItemList = UIItemList.New(arg_2_0._tf:Find("frame/view/list/content"), arg_2_0._tf:Find("frame/view/list/content/tpl"))
	arg_2_0.animation = arg_2_0._tf:Find("frame/view"):GetComponent(typeof(Animation))
	arg_2_0.dftAniEvent = arg_2_0._tf:Find("frame/view"):GetComponent(typeof(DftAniEvent))
	arg_2_0.foldBtn = arg_2_0._tf:Find("frame/view/fold")
	arg_2_0.arr = arg_2_0._tf:Find("frame/view/fold/up")
	arg_2_0.subTitle = arg_2_0._tf:Find("frame/view/subtitle2")
	arg_2_0.expAdditionTxt = arg_2_0._tf:Find("frame/exp/Text"):GetComponent(typeof(Text))

	setText(arg_2_0._tf:Find("frame/exp"), i18n("courtyard_label_comfortable_addition"))
	setText(arg_2_0._tf:Find("frame/title"), i18n("word_comfort_level"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	local var_3_0 = false

	onButton(arg_3_0, arg_3_0.foldBtn, function()
		var_3_0 = not var_3_0

		if var_3_0 then
			setActive(arg_3_0.subTitle, true)
		end

		arg_3_0.dftAniEvent:SetEndEvent(function()
			arg_3_0.dftAniEvent:SetEndEvent(nil)
			setActive(arg_3_0.subTitle, false)

			return
		end)
		arg_3_0.animation:Play(var_3_0 and "anim_courtyard_comfortable_viewin" or "anim_courtyard_comfortable_viewhide")

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_8_0, arg_8_1)
	var_0_0.super.Show(arg_8_0)

	arg_8_0.dorm = arg_8_1

	local var_8_0 = arg_8_1:getComfortable()

	arg_8_0:FlushSubTitle()
	arg_8_0:FlushExpression(var_8_0)
	arg_8_0:FlushList()
	arg_8_0:FlushAddition(var_8_0)

	return
end

function var_0_0.FlushSubTitle(arg_9_0)
	arg_9_0.subTitleTxt.text = i18n("backyard_backyardScene_comforChatContent2", arg_9_0.dorm.level - 1)

	return
end

function var_0_0.FlushExpression(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.dorm:GetComfortableLevel(arg_10_1)

	arg_10_0.expressionTxt.text = i18n("backyard_backyardScene_expression_label_" .. var_10_0)

	LoadSpriteAtlasAsync("ui/CourtyardUI_atlas", "express_" .. var_10_0, function(arg_11_0)
		if arg_10_0.exited then
			return
		end

		arg_10_0.comfortableImg.sprite = arg_11_0

		arg_10_0.comfortableImg:SetNativeSize()

		return
	end)

	arg_10_0.comfortableBg.color = arg_10_0.dorm:GetComfortableColor(var_10_0)

	return
end

local var_0_1 = {
	i18n("word_wallpaper"),
	i18n("word_furniture"),
	i18n("word_decorate"),
	i18n("word_floorpaper"),
	i18n("word_mat"),
	i18n("word_wall"),
	i18n("word_collection")
}

function var_0_0.FlushList(arg_12_0)
	local var_12_0 = arg_12_0.dorm:getConfig("comfortable_count")

	arg_12_0.uiItemList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			local var_13_0 = arg_13_1 + 1

			LoadSpriteAtlasAsync("ui/CourtyardUI_atlas", "icon_" .. arg_13_1 + 1, function(arg_14_0)
				if arg_12_0.exited then
					return
				end

				local var_14_0 = arg_13_2:Find("icon"):GetComponent(typeof(Image))

				var_14_0.sprite = arg_14_0

				var_14_0:SetNativeSize()

				return
			end)
			setText(arg_13_2:Find("name"), var_0_1[var_13_0])
			setText(arg_13_2:Find("Text"), "X" .. var_12_0[var_13_0][2])

			local var_13_1 = var_13_0 % 2 ~= 0

			setActive(arg_13_2:Find("line"), var_13_0 % 2 ~= 0)
			setActive(arg_13_2:Find("bg"), var_13_1)
		end

		return
	end)
	arg_12_0.uiItemList:align(7)

	return
end

function var_0_0.FlushAddition(arg_15_0, arg_15_1)
	local var_15_0 = 0

	if pg.gameset.dorm_exp_ratio_comfort_degree.key_value + arg_15_1 ~= 0 then
		var_15_0 = arg_15_1 / (pg.gameset.dorm_exp_ratio_comfort_degree.key_value + arg_15_1) * 100
	end

	arg_15_0.expAdditionTxt.text = string.format("%d", var_15_0) .. "%"

	return
end

function var_0_0.OnDestroy(arg_16_0)
	arg_16_0.dftAniEvent:SetTriggerEvent(nil)

	arg_16_0.exited = true

	return
end

return var_0_0
