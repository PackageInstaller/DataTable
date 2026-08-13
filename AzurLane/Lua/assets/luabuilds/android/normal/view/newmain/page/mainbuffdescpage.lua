class = var_0_10000

local var_0_0 = "MainBuffDescPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	NewMainScene = var_6

	var_1_1(var_1_0, var_6.ON_BUFF_DESC, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0

		var_3.ExecuteAction(var_2_0, "Show", arg_2_1, arg_2_2)

		return
	end)

	return
end

function var_0_1.getUIName(arg_3_0)
	return "MainUIBuffDescWindow"
end

function var_0_1.OnLoaded(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "Text")
	local var_4_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_4_0.descTxt = var_4_2(var_4_1, var_3(var_1_10004))

	return
end

function var_0_1.Show(arg_5_0, arg_5_1, arg_5_2)
	var_0_1.super.Show(arg_5_0)
	arg_5_0:RemoveDescTimer()
	arg_5_0:AddCloseTimer()
	arg_5_0:UpdateDesc(arg_5_1)

	arg_5_0._tf.localPosition = arg_5_2
	arg_5_0._parentTf = arg_5_0._tf.parent
	pg = var_3

	local var_5_0 = var_3.UIMgr.GetInstance()

	var_3.OverlayPanel(var_5_0, arg_5_0._tf)

	return
end

function var_0_1.UpdateDesc(arg_6_0, arg_6_1)
	local var_6_0

	if arg_6_1:getConfig("max_time") <= 0 then
		var_6_0 = arg_6_0.descTxt
		var_6_0.text = arg_6_1:getConfig("desc")

		return
	end

	Timer = var_6_0
	arg_6_0.descTimer = var_6_0.New(function()
		local var_7_0 = arg_6_0

		var_0.UpdateDescPreSce(var_7_0, arg_6_1)

		return
	end, 1, -1)

	local var_6_1 = arg_6_0.descTimer

	var_3.Start(var_6_1)
	arg_6_0.descTimer.func()

	return
end

function var_0_1.UpdateDescPreSce(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.getConfig(var_8_0, "desc")

	pg = var_8_0

	local var_8_2 = var_8_0.TimeMgr.GetInstance()
	local var_8_3 = var_3.GetServerTime(var_8_2)
	local var_8_4 = arg_8_1.timestamp - var_8_3

	if 0 < var_8_4 then
		pg = var_5

		local var_8_5 = var_5.TimeMgr.GetInstance()
		local var_8_6 = var_5.DescCDTime(var_8_5, var_8_4)
		local var_8_7 = arg_8_0.descTxt

		string = var_7
		var_8_7.text = var_7.gsub(var_8_1, "$1", var_8_6)
	else
		arg_8_0:Hide()
	end

	return
end

function var_0_1.RemoveDescTimer(arg_9_0)
	if arg_9_0.descTimer then
		local var_9_0 = arg_9_0.descTimer

		var_1.Stop(var_9_0)

		arg_9_0.descTimer = nil
	end

	return
end

function var_0_1.AddCloseTimer(arg_10_0)
	arg_10_0:RemoveCloseTimer()

	Timer = var_1
	arg_10_0.timer = var_1.New(function()
		local var_11_0 = arg_10_0

		var_0.Hide(var_11_0)

		return
	end, 7, 1)

	local var_10_0 = arg_10_0.timer

	var_1.Start(var_10_0)

	return
end

function var_0_1.RemoveCloseTimer(arg_12_0)
	if arg_12_0.timer then
		local var_12_0 = arg_12_0.timer

		var_1.Stop(var_12_0)

		arg_12_0.timer = nil
	end

	return
end

function var_0_1.Hide(arg_13_0)
	var_0_1.super.Hide(arg_13_0)

	pg = var_1

	local var_13_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_13_0, arg_13_0._tf, arg_13_0._parentTf)
	arg_13_0:RemoveCloseTimer()
	arg_13_0:RemoveDescTimer()

	return
end

function var_0_1.Disable(arg_14_0)
	if arg_14_0:GetLoaded() and arg_14_0:isShowing() then
		arg_14_0:Hide()
	end

	return
end

function var_0_1.OnDestroy(arg_15_0)
	arg_15_0:RemoveCloseTimer()
	arg_15_0:RemoveDescTimer()

	return
end

return var_0_1
