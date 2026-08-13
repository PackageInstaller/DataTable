class = var_0_10000

local var_0_0 = var_0_10000("WorldbossPtBtn")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	arg_1_0.ptTF = arg_1_1

	local var_1_0 = arg_1_1:Find("Text")
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.pt = var_1_1(var_1_0, var_4(var_1_10005))
	arg_1_0.ptRecoveTF = arg_1_1:Find("time")

	local var_1_2 = arg_1_1:Find("time/Text")
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.ptRecove = var_1_3(var_1_2, var_4(var_1_10005))

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.ptRecoveTFFlag = false
	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.ptTF

	local function var_2_2()
		local var_3_0 = arg_2_0

		var_3_0.ptRecoveTFFlag = not arg_2_0.ptRecoveTFFlag
		setActive = var_3_0

		var_3_0(arg_2_0.ptRecoveTF, arg_2_0.ptRecoveTFFlag)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_0, var_2_1, var_2_2, var_1_10005)

	setActive = var_1

	var_1(arg_2_0.ptRecoveTF, arg_2_0.ptRecoveTFFlag)
	arg_2_0:Update()

	return
end

function var_0_0.Update(arg_4_0)
	nowWorld = var_1_10001

	local var_4_0 = var_1_10001()
	local var_4_1

	if not var_1.GetBossProxy(var_4_0).pt then
		var_4_1 = 0
	end

	local var_4_2 = arg_4_0.pt

	var_4_2.text = var_4_1 .. "/" .. var_1:GetMaxPt()
	pg = var_4_2

	local var_4_3 = var_4_2.gameset.joint_boss_ap_recove_cnt_pre_day.key_value
	local var_4_4 = arg_4_0.ptRecove

	i18n = var_5
	var_4_4.text = var_5("world_boss_pt_recove_desc", var_4_3)

	return
end

function var_0_0.Dispose(arg_5_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_5_0)

	return
end

return var_0_0
