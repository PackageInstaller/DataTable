class = var_0_10000

local var_0_0 = var_0_10000("SettingsResRepairBtn")

function var_0_0.InitTpl(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.tpl
	local var_1_1 = arg_1_1.container
	local var_1_2 = arg_1_1.iconSP

	cloneTplTo = var_1_10005
	arg_1_0._tf = var_1_10005(var_1_0, var_1_1, "REPAIR")
	arg_1_0._go = arg_1_0._tf.gameObject
	setImageSprite = var_5

	local var_1_3 = arg_1_0._tf

	var_5(var_7.Find(var_1_3, "icon"), var_1_2)

	return
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0:InitTpl(arg_2_1)

	pg = var_2

	var_2.DelegateInfo.New(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.Progress = var_2.Find(var_2_0, "progress")

	local var_2_1 = arg_2_0._tf

	arg_2_0.ProgressHandle = var_2.Find(var_2_1, "progress/handle")

	local var_2_2 = arg_2_0._tf

	arg_2_0.Info1 = var_2.Find(var_2_2, "status")

	local var_2_3 = arg_2_0._tf

	arg_2_0.Info2 = var_2.Find(var_2_3, "version")

	local var_2_4 = arg_2_0._tf

	arg_2_0.LabelNew = var_2.Find(var_2_4, "version/new")

	local var_2_5 = arg_2_0._tf

	arg_2_0.Dot = var_2.Find(var_2_5, "new")

	local var_2_6 = arg_2_0._tf

	arg_2_0.Loading = var_2.Find(var_2_6, "loading")
	setText = var_2

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_4.Find(var_2_7, "title")

	i18n = var_5

	var_2(var_2_8, var_5("repair_setting_label"))

	local var_2_9 = false
	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_3.Find(var_2_10, "BG")
	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_4.Find(var_2_12, "BGDel")

	setActive = var_2_10

	var_2_10(var_2_11, not var_2_9)

	setActive = var_2_10

	var_2_10(var_2_13, var_2_9)

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_5.Find(var_2_14, "status")
	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_6.Find(var_2_16, "version")

	setAnchoredPosition = var_2_14

	local var_2_18 = var_2_15
	local var_2_19

	if not var_2_9 or not {
		y = -106
	} then
		var_2_19 = {
			y = -135
		}
	end

	var_2_14(var_2_18, var_2_19)

	setAnchoredPosition = var_2_14

	local var_2_20 = var_2_17
	local var_2_21

	if not var_2_9 or not {
		y = -160
	} then
		var_2_21 = {
			y = -198
		}
	end

	var_2_14(var_2_20, var_2_21)
	arg_2_0:Init()

	return
end

function var_0_0.Init(arg_3_0)
	arg_3_0:UpdateRepairStatus()

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		pg = var_2_10000

		local var_4_0 = var_2_10000.RepairResMgr.GetInstance()

		var_0.Repair(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)

	setActive = var_1
	findTF = var_3_0

	var_1(var_3_0(arg_3_0._tf, "DelBtn"), false)

	return
end

function var_0_0.UpdateRepairStatus(arg_5_0)
	setSlider = var_1_10001

	var_1_10001(arg_5_0.Progress, 0, 1, 0)

	setActive = var_1_10001

	var_1_10001(arg_5_0.Dot, false)

	setActive = var_1_10001

	var_1_10001(arg_5_0.Loading, false)

	i18n = var_1_10001

	local var_5_0 = var_1_10001("word_files_repair")
	local var_5_1 = ""

	setText = var_3

	var_3(arg_5_0.Info1, var_5_0)

	setText = var_3

	var_3(arg_5_0.Info2, var_5_1)

	local var_5_2 = 1

	setSlider = var_4

	var_4(arg_5_0.Progress, 0, 1, var_5_2)

	setActive = var_4

	var_4(arg_5_0.ProgressHandle, var_5_2 ~= 0 and var_5_2 ~= 1)

	setActive = var_4

	var_4(arg_5_0.Dot, false)

	setActive = var_4

	var_4(arg_5_0.Loading, false)

	setActive = var_4

	var_4(arg_5_0.LabelNew, false)

	return
end

function var_0_0.Dispose(arg_6_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_6_0)

	return
end

return var_0_0
