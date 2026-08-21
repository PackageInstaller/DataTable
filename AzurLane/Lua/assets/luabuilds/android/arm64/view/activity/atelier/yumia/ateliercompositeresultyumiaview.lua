local var_0_0 = class("AtelierCompositeResultYumiaView", import("view.activity.Atelier.base.AtelierCompositeResultView"))

function var_0_0.ShowCompositeResult(arg_1_0, arg_1_1)
	GetComponent(arg_1_0._tf, typeof(Animation)):Play("Anim_AtelierCompositeYumiaUI_ConfirmWindow_Resultwindow_In")
	setActive(arg_1_0._go, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_1_0._tf)

	if arg_1_1[1] == nil then
		return
	end

	local var_1_0 = arg_1_0._tf:Find("Window/itemContant")
	local var_1_1 = arg_1_0._tf:Find("Window/AtelierCommonYumiaItem")

	if arg_1_1[1].type ~= DROP_TYPE_RYZA_DROP then
		setActive(var_1_1, false)
		setActive(var_1_0, true)
		UIItemList.StaticAlign(var_1_0, arg_1_0._tf:Find("Window/itemContant/Icon"), #arg_1_1, function(arg_2_0, arg_2_1, arg_2_2)
			if arg_2_0 == UIItemList.EventUpdate then
				arg_1_0._parentClass:UpdateRyzaDrop(arg_2_2, arg_1_1[arg_2_1 + 1])
				setActive(arg_2_2, true)
			end

			return
		end)

		local var_1_2 = 0

		for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
			var_1_2 = iter_1_1:getCount() + var_1_2
		end

		setText(arg_1_0._tf:Find("Window/CountBG/Text"), var_1_2)
	else
		local var_1_3 = AtelierMaterial.New({
			configId = arg_1_1[1].id
		})

		var_1_3.count = arg_1_1[1]:getCount()

		arg_1_0._parentClass:UpdateRyzaItem(var_1_1, var_1_3)
		setActive(var_1_1, true)
		setActive(var_1_0, false)
		setText(arg_1_0._tf:Find("Window/CountBG/Text"), arg_1_1[1]:getCount())
	end

	return
end

function var_0_0.HideCompositeResult(arg_3_0)
	if not isActive(arg_3_0._go) then
		return
	end

	local var_3_0 = GetComponent(arg_3_0._tf, typeof(Animation))

	var_3_0:Play("Anim_AtelierCompositeYumiaUI_ConfirmWindow_Resultwindow_Out")
	pg.UIMgr.GetInstance():LoadingOn(false)

	arg_3_0.closeTimer = FrameTimer.New(function()
		if not var_3_0:IsPlaying("Anim_AtelierCompositeYumiaUI_ConfirmWindow_Resultwindow_Out") then
			arg_3_0:StopCloseTimer()
			pg.UIMgr.GetInstance():LoadingOff()
			var_0_0.super.HideCompositeResult(arg_3_0)
		end

		return
	end, 1, -1)

	arg_3_0.closeTimer:Start()

	return true
end

function var_0_0.StopCloseTimer(arg_5_0)
	if arg_5_0.closeTimer then
		arg_5_0.closeTimer:Stop()

		arg_5_0.closeTimer = nil
	end

	return
end

function var_0_0.PlayGuide(arg_6_0)
	return
end

return var_0_0
