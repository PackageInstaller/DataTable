local var_0_0 = class("SVPoisonPanel", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "SVPoisonPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.rtName = arg_3_0._tf:Find("window/content/name_mask/name")
	arg_3_0.rtDesc = arg_3_0._tf:Find("window/content/intro_view/Viewport/Content/intro")
	arg_3_0.rtPoisonRate = arg_3_0._tf:Find("window/content/poison_rate")
	arg_3_0.rtBg = arg_3_0._tf:Find("bg")
	arg_3_0.btnClose = arg_3_0._tf:Find("window/top/btnBack")
	arg_3_0.btnConfirm = arg_3_0._tf:Find("window/button_container/confirm_btn")

	onButton(arg_3_0, arg_3_0.rtBg, function()
		arg_3_0:Hide()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.btnClose, function()
		arg_3_0:Hide()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.btnConfirm, function()
		arg_3_0:Hide()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.OnDestroy(arg_7_0)
	return
end

function var_0_0.Show(arg_8_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_8_0._tf)
	setActive(arg_8_0._tf, true)

	return
end

function var_0_0.Hide(arg_9_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_9_0._tf, arg_9_0._parentTf)
	setActive(arg_9_0._tf, false)

	return
end

function var_0_0.Setup(arg_10_0, arg_10_1)
	setText(arg_10_0.rtName, i18n("world_sairen_title"))

	local var_10_0 = Clone(pg.gameset.world_sairen_infection.description)

	table.insert(var_10_0, 1, 0)
	table.insert(var_10_0, 999)
	eachChild(arg_10_0.rtPoisonRate:Find("bg/ring"), function(arg_11_0)
		local var_11_0 = arg_11_0:GetSiblingIndex() + 1

		if arg_10_1 >= var_10_0[var_11_0] and arg_10_1 < var_10_0[var_11_0 + 1] then
			setActive(arg_11_0, true)

			arg_11_0:GetComponent(typeof(Image)).fillAmount = arg_10_1 / 100

			setText(arg_10_0.rtDesc, i18n("world_sairen_description" .. var_11_0, arg_10_1))
		else
			setActive(arg_11_0, false)
		end

		setText(arg_10_0.rtPoisonRate:Find("bg/Text"), arg_10_1 .. "%")

		return
	end)

	return
end

return var_0_0
