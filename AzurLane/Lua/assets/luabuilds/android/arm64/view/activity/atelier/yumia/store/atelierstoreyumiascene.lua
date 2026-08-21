local var_0_0 = class("AtelierStoreYumiaScene", import("view.activity.Atelier.Store.AtelierStoreBaseScene"))

function var_0_0.getUIName(arg_1_0)
	return "AtelierStoreYumiaUI"
end

function var_0_0.InitCustom(arg_2_0)
	setText(arg_2_0._tf:Find("Window/Text"), i18n("yumia_atelier_tip13"))
	setText(arg_2_0._tf:Find("Window/textBg/Name"), i18n("yumia_atelier_tip16"))

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0.activity = arg_3_0.contextData.activity

	onButton(arg_3_0, arg_3_0._tf:Find("Window/textBg/closeBtn"), function()
		arg_3_0:PlayCloseAni()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("BG"), function()
		arg_3_0:PlayCloseAni()

		return
	end, SFX_CANCEL)
	arg_3_0:ShowStoreHouseWindow()

	return
end

function var_0_0.PlayCloseAni(arg_6_0)
	local var_6_0 = GetComponent(arg_6_0._tf, typeof(Animation))

	GetComponent(arg_6_0._tf, typeof(Animation)):Play("Anim_AtelierStoreYumiaUI_Out")
	pg.UIMgr.GetInstance():LoadingOn(false)

	arg_6_0.closeTimer = FrameTimer.New(function()
		if not var_6_0:IsPlaying("Anim_AtelierStoreYumiaUI_Out") then
			arg_6_0:StopCloseTimer()
			pg.UIMgr.GetInstance():LoadingOff()
			arg_6_0:closeView()
		end

		return
	end, 1, -1)

	arg_6_0.closeTimer:Start()

	return
end

function var_0_0.StopCloseTimer(arg_8_0)
	if arg_8_0.closeTimer then
		arg_8_0.closeTimer:Stop()

		arg_8_0.closeTimer = nil
	end

	return
end

function var_0_0.ShowStoreHouseWindow(arg_9_0)
	local var_9_0

	if not arg_9_0.contextData.versionIndex then
		var_9_0 = 2
	end

	pg.UIMgr.GetInstance():BlurPanel(arg_9_0._tf)

	local var_9_1 = _.filter(_.values(arg_9_0.activity:GetItems()), function(arg_10_0)
		return arg_10_0.count > 0 and arg_10_0:GetVersion() == var_9_0 and arg_10_0:IsShow() ~= 0
	end)

	table.sort(var_9_1, function(arg_11_0, arg_11_1)
		return arg_11_0:GetConfigID() < arg_11_1:GetConfigID()
	end)
	setActive(arg_9_0._tf:Find("Window/Empty"), #var_9_1 == 0)
	setActive(arg_9_0._tf:Find("Window/ScrollView"), #var_9_1 > 0)

	if #var_9_1 == 0 then
		return
	end

	function arg_9_0.storehouseRect.onUpdateItem(arg_12_0, arg_12_1)
		arg_12_0 = arg_12_0 + 1

		local var_12_0 = tf(arg_12_1)

		arg_9_0:UpdateRyzaItem(var_12_0, var_9_1[arg_12_0])
		onButton(arg_9_0, var_12_0, function()
			arg_9_0:ShowItemDetail(var_0)

			return
		end, SFX_PANEL)

		return
	end

	arg_9_0.storehouseRect:SetTotalCount(#var_9_1)
	arg_9_0:AddTimer(#var_9_1)

	return
end

function var_0_0.UpdateRyzaItem(arg_14_0, arg_14_1, arg_14_2)
	AtelierTools.UpdateYumiaItem(arg_14_1, arg_14_2)

	return
end

function var_0_0.ShowItemDetail(arg_15_0, arg_15_1)
	arg_15_0:emit(AtelierMaterialDetailMediator.SHOW_DETAIL, arg_15_1)

	return
end

function var_0_0.AddTimer(arg_16_0, arg_16_1)
	local var_16_1 = arg_16_0._tf:Find("Window/ScrollView/Viewport/Content")

	arg_16_0.timer = FrameTimer.New(function()
		if math.min(var_16_1.childCount, 15) <= arg_16_1 then
			arg_16_0:StopTimer()
			arg_16_0:AddTimer2()
		end

		return
	end, 1, -1)

	arg_16_0.timer:Start()

	return
end

function var_0_0.AddTimer2(arg_18_0)
	local var_18_0 = arg_18_0._tf:Find("Window/ScrollView/Viewport/Content")
	local var_18_1 = var_18_0.childCount

	SetComponentEnabled(arg_18_0._tf:Find("Window/ScrollView"), "LScrollRect", false)

	for iter_18_0 = 0, var_18_0.childCount - 1 do
		SetComponentEnabled(var_18_0:GetChild(iter_18_0), typeof(Animation), false)

		GetComponent(var_18_0:GetChild(iter_18_0), typeof(CanvasGroup)).alpha = 0
	end

	local var_18_2 = 0

	arg_18_0.timer = Timer.New(function()
		if var_18_2 >= var_18_1 then
			arg_18_0:StopTimer()
			SetComponentEnabled(arg_18_0._tf:Find("Window/ScrollView"), "LScrollRect", true)

			return
		end

		local var_19_0 = GetComponent(var_18_0:GetChild(var_18_2), typeof(Animation))

		var_19_0.enabled = true

		var_19_0:Stop()
		var_19_0:Play("Anim_AtelierStoreYumiaUI_Tpl_In")

		var_18_2 = var_18_2 + 1

		return
	end, 0.08, -1)

	arg_18_0.timer:Start()

	return
end

function var_0_0.StopTimer(arg_20_0)
	if arg_20_0.timer then
		arg_20_0.timer:Stop()

		arg_20_0.timer = nil
	end

	return
end

function var_0_0.willExit(arg_21_0)
	arg_21_0:StopTimer()
	var_0_0.super.willExit(arg_21_0)

	return
end

return var_0_0
