local var_0_0 = class("MonopolyCar2026SetNamePage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "MonopolyCar2026SetNameUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.confirmBtn = arg_2_0._tf:Find("btn")
	arg_2_0.input = arg_2_0._tf:Find("main/input")
	arg_2_0.bgTr = arg_2_0._tf:Find("bg")

	setText(arg_2_0.confirmBtn:Find("Text"), i18n("word_ok"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		local var_4_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MONOPOLY)

		if not var_4_0 or var_4_0:isEnd() then
			if arg_3_0.callback then
				arg_3_0.callback()
			end

			return
		end

		local var_4_1 = var_4_0:getConfig("config_client").link_act
		local var_4_2 = getInputText(arg_3_0.input)

		if var_4_2 == "" then
			return
		end

		if not nameValidityCheck(var_4_2, 0, 20, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"login_newPlayerScene_name_tooLong",
			"playerinfo_mask_word"
		}) then
			return
		end

		pg.m02:sendNotification(GAME.ACTIVITY_STORE_DATE, {
			intValue = 0,
			activity_id = var_4_1,
			strValue = var_4_2 or "",
			callback = function()
				if arg_3_0.callback then
					arg_3_0.callback()
				end

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_6_0, arg_6_1)
	arg_6_0.callback = arg_6_1

	var_0_0.super.Show(arg_6_0)
	arg_6_0:BlurPanel()

	return
end

function var_0_0.BlurPanel(arg_7_0)
	setParent(arg_7_0.bgTr, pg.NewStoryMgr.GetInstance()._go)
	setParent(pg.NewStoryMgr.GetInstance()._go, pg.UIMgr.GetInstance().UIMain)
	pg.UIMgr.GetInstance():BlurPanel(arg_7_0._tf)

	return
end

function var_0_0.UnBlurPanel(arg_8_0)
	setParent(arg_8_0.bgTr, arg_8_0._tf)
	arg_8_0.bgTr:SetAsFirstSibling()
	setParent(pg.NewStoryMgr.GetInstance()._go, pg.UIMgr.GetInstance().OverlayToast)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_8_0._tf, arg_8_0._parentTf)

	return
end

function var_0_0.Hide(arg_9_0)
	arg_9_0:UnBlurPanel()
	var_0_0.super.Hide(arg_9_0)

	return
end

function var_0_0.OnDestroy(arg_10_0)
	arg_10_0.callback = nil

	if arg_10_0:isShowing() then
		arg_10_0:Hide()
	end

	return
end

return var_0_0
