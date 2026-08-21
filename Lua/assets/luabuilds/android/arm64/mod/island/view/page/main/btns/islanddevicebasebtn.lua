local var_0_0 = class("IslandDeviceBaseBtn", import(".IslandMainBaseBtn"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0._tf = arg_1_1
	arg_1_0.event = arg_1_2
	arg_1_0.configId = arg_1_3
	arg_1_0.config = pg.island_main_btns[arg_1_0.configId]
	arg_1_0.lockTF = arg_1_0._tf:Find("lock")

	local var_1_0 = arg_1_0.lockTF:Find("Text")

	if var_1_0 then
		setText(var_1_0, i18n("island_freight_btn_locked"))
	end

	arg_1_0.unlockTF = arg_1_0._tf:Find("unlock")
	arg_1_0.tipTF = arg_1_0.unlockTF:Find("tip")
	arg_1_0.nameTF = arg_1_0._tf:Find("name")

	local var_1_1 = arg_1_0.nameTF and arg_1_0.nameTF:GetComponent(typeof(Text))

	if var_1_1 then
		var_1_1.text = arg_1_0.config.name
	end

	arg_1_0:Init()

	return
end

function var_0_0.CheckCanPressDown(arg_2_0)
	if arg_2_0.configId == 19 and _IslandCore then
		if _IslandCore:GetView():GetController():IsPlayerInTimeline() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_photo_fur_lock"))

			return false
		end
	end

	return true
end

function var_0_0.Init(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		if not arg_3_0:IsUnlock() then
			return
		end

		if not arg_3_0:CheckCanPressDown() then
			return
		end

		arg_3_0:OnClick()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UnlockCheck(arg_5_0)
	local var_5_0 = arg_5_0:IsUnlock()

	setActive(arg_5_0.lockTF, not var_5_0)
	setActive(arg_5_0.unlockTF, var_5_0)

	if var_5_0 then
		arg_5_0:FlushDataUI()
	end

	return
end

function var_0_0.FlushDataUI(arg_6_0)
	return
end

return var_0_0
