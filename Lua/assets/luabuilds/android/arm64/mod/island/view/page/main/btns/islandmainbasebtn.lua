local var_0_0 = class("IslandMainBaseBtn")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0._tf = arg_1_1
	arg_1_0.event = arg_1_2
	arg_1_0.configId = arg_1_3
	arg_1_0.config = pg.island_main_btns[arg_1_0.configId]
	arg_1_0.iconTF = arg_1_0._tf
	arg_1_0.tipTF = arg_1_0._tf:Find("tip")

	arg_1_0:Init()

	return
end

function var_0_0.SetAsLastSibling(arg_2_0)
	arg_2_0._tf:SetAsLastSibling()

	return
end

function var_0_0.Init(arg_3_0)
	LoadImageSpriteAtlasAsync("island/islandbtnicon", arg_3_0.config.icon, arg_3_0.iconTF, true)

	arg_3_0._tf.name = arg_3_0.config.btn_name

	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:OnClick()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.GetAbilityId(arg_5_0)
	return arg_5_0.config.ability_id
end

function var_0_0.OnClick(arg_6_0)
	if arg_6_0.config.open_page ~= "" then
		arg_6_0:emit(IslandMediator.OPEN_PAGE, arg_6_0.config.open_page, arg_6_0.config.page_param)
	end

	return
end

function var_0_0.Flush(arg_7_0)
	arg_7_0:UnlockCheck()
	arg_7_0:TipCheck()

	return
end

function var_0_0.UnlockCheck(arg_8_0)
	setActive(arg_8_0._tf, arg_8_0:IsUnlock())

	return
end

function var_0_0.IsUnlock(arg_9_0)
	return getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(arg_9_0:GetAbilityId())
end

function var_0_0.TipCheck(arg_10_0)
	local var_10_0 = arg_10_0:IsUnlock() and arg_10_0:IsTip()

	setActive(arg_10_0.tipTF, var_10_0)

	return
end

function var_0_0.IsTip(arg_11_0)
	return IslandMainBtnTipHelper.IsTip(arg_11_0.config.btn_name)
end

function var_0_0.emit(arg_12_0, ...)
	arg_12_0.event:emit(...)

	return
end

function var_0_0.Dispose(arg_13_0)
	pg.DelegateInfo.Dispose(arg_13_0)

	return
end

return var_0_0
