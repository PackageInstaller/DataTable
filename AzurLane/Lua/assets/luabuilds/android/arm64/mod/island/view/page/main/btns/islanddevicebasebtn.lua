class = var_0_10000

local var_0_0 = "IslandDeviceBaseBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandMainBaseBtn"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	pg = var_1_10004

	var_1_10004.DelegateInfo.New(arg_1_0)

	arg_1_0._tf = arg_1_1
	arg_1_0.event = arg_1_2
	arg_1_0.configId = arg_1_3
	pg = var_4
	arg_1_0.config = var_4.island_main_btns[arg_1_0.configId]

	local var_1_0 = arg_1_0._tf

	arg_1_0.lockTF = var_4.Find(var_1_0, "lock")

	local var_1_1 = arg_1_0.lockTF

	if var_4.Find(var_1_1, "Text") then
		setText = var_5

		local var_1_2 = var_4

		i18n = var_1_10008

		var_5(var_1_2, var_1_10008("island_freight_btn_locked"))
	end

	local var_1_3 = arg_1_0._tf

	arg_1_0.unlockTF = var_5.Find(var_1_3, "unlock")

	local var_1_4 = arg_1_0.unlockTF

	arg_1_0.tipTF = var_5.Find(var_1_4, "tip")

	local var_1_5 = arg_1_0._tf

	arg_1_0.nameTF = var_5.Find(var_1_5, "name")

	local var_1_7

	if arg_1_0.nameTF then
		local var_1_6 = arg_1_0.nameTF

		var_1_7 = var_1_7.GetComponent
		typeof = var_8
		Text = var_1_10010
		var_1_7 = var_1_7(var_1_6, var_8(var_1_10010))
	end

	if var_1_7 then
		var_1_7.text = arg_1_0.config.name
	end

	arg_1_0:Init()

	return
end

function var_0_1.CheckCanPressDown(arg_2_0)
	if arg_2_0.configId == 19 then
		_IslandCore = var_1

		if var_1 then
			_IslandCore = var_1

			local var_2_0 = var_1:GetView()
			local var_2_1 = var_1.GetController(var_2_0)

			if var_1.IsPlayerInTimeline(var_2_1) then
				pg = var_1

				local var_2_2 = var_1.TipsMgr.GetInstance()
				local var_2_3 = var_1.ShowTips

				i18n = var_1_10004

				var_2_3(var_2_2, var_1_10004("island_photo_fur_lock"))

				return false
			end
		end
	end

	return true
end

function var_0_1.Init(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		if not var_0.IsUnlock(var_4_0) then
			return
		end

		local var_4_1 = arg_3_0

		if not var_0.CheckCanPressDown(var_4_1) then
			return
		end

		local var_4_2 = arg_3_0

		var_0.OnClick(var_4_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	return
end

function var_0_1.UnlockCheck(arg_5_0)
	local var_5_0 = arg_5_0:IsUnlock()

	setActive = var_1_10002

	var_1_10002(arg_5_0.lockTF, not var_5_0)

	setActive = var_1_10002

	var_1_10002(arg_5_0.unlockTF, var_5_0)

	if var_5_0 then
		arg_5_0:FlushDataUI()
	end

	return
end

function var_0_1.FlushDataUI(arg_6_0)
	return
end

return var_0_1
