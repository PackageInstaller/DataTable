class = var_0_10000

local var_0_0 = "ArchivesWorldBossMsgboxPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ArchivesWorldBossMsgboxUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.yesBtn = var_1.Find(var_2_0, "Box/ConfirmBtn")

	local var_2_1 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_1, "Box/CancelBtn")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "Box/Text")
	local var_2_4 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.contentTxt = var_2_4(var_2_3, var_3(var_1_10004))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.yesBtn

	local function var_3_5()
		if arg_3_0.onYes then
			arg_3_0.onYes()
		end

		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.cancelBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	return
end

function var_0_1.Show(arg_7_0, arg_7_1)
	var_0_1.super.Show(arg_7_0)

	arg_7_0.contentTxt.text = arg_7_1.content
	arg_7_0.onYes = arg_7_1.onYes

	return
end

function var_0_1.Hide(arg_8_0)
	var_0_1.super.Hide(arg_8_0)

	if arg_8_0.onYes then
		arg_8_0.onYes = nil
	end

	return
end

function var_0_1.OnDestroy(arg_9_0)
	if arg_9_0:isShowing() then
		arg_9_0:Hide()
	end

	return
end

return var_0_1
