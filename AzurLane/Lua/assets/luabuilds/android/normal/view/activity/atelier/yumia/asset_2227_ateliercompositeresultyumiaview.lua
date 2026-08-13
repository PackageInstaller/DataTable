class = var_0_10000

local var_0_0 = "AtelierCompositeResultYumiaView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.Atelier.base.AtelierCompositeResultView"))

function var_0_1.ShowCompositeResult(arg_1_0, arg_1_1)
	GetComponent = var_1_10002

	local var_1_0 = arg_1_0._tf

	typeof = var_1_10004
	Animation = var_1_10005

	local var_1_1 = var_1_10002(var_1_0, var_1_10004(var_1_10005))

	var_2.Play(var_1_1, "Anim_AtelierCompositeYumiaUI_ConfirmWindow_Resultwindow_In")

	setActive = var_3

	var_3(arg_1_0._go, true)

	pg = var_3

	local var_1_2 = var_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_1_2, arg_1_0._tf)

	if arg_1_1[1] == nil then
		return
	end

	local var_1_3 = arg_1_0._tf
	local var_1_4 = var_4.Find(var_1_3, "Window/itemContant")
	local var_1_5 = arg_1_0._tf
	local var_1_6 = var_5.Find(var_1_5, "Window/AtelierCommonYumiaItem")
	local var_1_7 = var_3.type

	DROP_TYPE_RYZA_DROP = var_7

	if var_1_7 ~= var_7 then
		setActive = var_1_7

		var_1_7(var_1_6, false)

		setActive = var_1_7

		var_1_7(var_1_4, true)

		UIItemList = var_1_7
		var_1_7 = var_1_7.StaticAlign

		local var_1_8 = var_1_4
		local var_1_9 = arg_1_0._tf

		var_1_7(var_1_8, var_8.Find(var_1_9, "Window/itemContant/Icon"), #arg_1_1, function(arg_2_0, arg_2_1, arg_2_2)
			UIItemList = var_2_10003

			if arg_2_0 == var_2_10003.EventUpdate then
				local var_2_0 = arg_1_1[arg_2_1 + 1]
				local var_2_1 = arg_1_0._parentClass

				var_4.UpdateRyzaDrop(var_2_1, arg_2_2, var_2_0)

				setActive = var_4

				var_4(arg_2_2, true)
			end

			return
		end)

		var_1_7 = 0
		ipairs = var_1_8

		for iter_1_0, iter_1_1 in var_1_8(arg_1_1) do
			var_1_7 = iter_1_1:getCount() + var_1_7
		end

		setText = var_7

		local var_1_10 = arg_1_0._tf

		var_7(var_8.Find(var_1_10, "Window/CountBG/Text"), var_1_7)
	else
		AtelierMaterial = var_1_7

		local var_1_11 = var_1_7.New({
			configId = var_3.id
		})

		var_1_11.count = var_3:getCount()

		local var_1_12 = arg_1_0._parentClass

		var_7.UpdateRyzaItem(var_1_12, var_1_6, var_1_11)

		setActive = var_7

		var_7(var_1_6, true)

		setActive = var_7

		var_7(var_1_4, false)

		setText = var_7

		local var_1_13 = arg_1_0._tf

		var_7(var_8.Find(var_1_13, "Window/CountBG/Text"), var_3:getCount())
	end

	return
end

function var_0_1.HideCompositeResult(arg_3_0)
	isActive = var_1_10001

	if not var_1_10001(arg_3_0._go) then
		return
	end

	GetComponent = var_1

	local var_3_0 = arg_3_0._tf

	typeof = var_1_10003
	Animation = var_1_10004

	local var_3_1 = var_1(var_3_0, var_1_10003(var_1_10004))

	var_1.Play(var_3_1, "Anim_AtelierCompositeYumiaUI_ConfirmWindow_Resultwindow_Out")

	pg = var_2

	local var_3_2 = var_2.UIMgr.GetInstance()

	var_2.LoadingOn(var_3_2, false)

	FrameTimer = var_2
	arg_3_0.closeTimer = var_2.New(function()
		local var_4_0 = var_0

		if not var_0.IsPlaying(var_4_0, "Anim_AtelierCompositeYumiaUI_ConfirmWindow_Resultwindow_Out") then
			local var_4_1 = arg_3_0

			var_0.StopCloseTimer(var_4_1)

			pg = var_0

			local var_4_2 = var_0.UIMgr.GetInstance()

			var_0.LoadingOff(var_4_2)
			var_0_1.super.HideCompositeResult(arg_3_0)
		end

		return
	end, 1, -1)

	local var_3_3 = arg_3_0.closeTimer

	var_2.Start(var_3_3)

	return true
end

function var_0_1.StopCloseTimer(arg_5_0)
	if arg_5_0.closeTimer then
		local var_5_0 = arg_5_0.closeTimer

		var_1.Stop(var_5_0)

		arg_5_0.closeTimer = nil
	end

	return
end

function var_0_1.PlayGuide(arg_6_0)
	return
end

return var_0_1
