class = var_0_10000

local var_0_0 = var_0_10000("SettingsBasePanel")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.parentTF = arg_1_1
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	arg_1_0.state = var_0_1

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	if arg_2_0.state == var_0_1 then
		arg_2_0:Load(arg_2_1)
	else
		arg_2_1()
	end

	return
end

function var_0_0.IsLoaded(arg_3_0)
	return arg_3_0.state == var_0_3
end

function var_0_0.Load(arg_4_0, arg_4_1)
	arg_4_0.state = var_0_2
	PoolMgr = var_2

	local var_4_0 = var_2.GetInstance()

	var_2.GetUI(var_4_0, arg_4_0:GetUIName(), true, function(arg_5_0)
		if arg_4_0.exited then
			PoolMgr = var_1

			local var_5_0 = var_1.GetInstance()
			local var_5_1 = var_1.ReturnUI
			local var_5_2 = arg_4_0

			var_5_1(var_5_0, var_4.GetUIName(var_5_2), arg_5_0)

			return
		end

		arg_4_0.state = var_0_3
		arg_4_0._go = arg_5_0

		local var_5_3 = arg_4_0

		var_5_3._tf = arg_5_0.transform
		setParent = var_5_3

		var_5_3(arg_4_0._tf, arg_4_0.parentTF)

		local var_5_4 = arg_4_0

		var_1.InitTitle(var_5_4)

		local var_5_5 = arg_4_0

		var_1.OnInit(var_5_5)

		local var_5_6 = arg_4_0

		var_1.OnUpdate(var_5_6)

		setActive = var_1

		var_1(arg_4_0._tf, true)
		arg_4_1()

		return
	end)

	return
end

function var_0_0.InitTitle(arg_6_0)
	setText = var_1_10001

	local var_6_0 = arg_6_0._tf

	var_1_10001(var_3.Find(var_6_0, "title"), arg_6_0:GetTitle())

	setText = var_1_10001

	local var_6_1 = arg_6_0._tf

	var_1_10001(var_3.Find(var_6_1, "title/title_text"), arg_6_0:GetTitleEn())

	return
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.exited = true
	pg = var_1

	var_1.DelegateInfo.Dispose(arg_7_0)

	if arg_7_0.state >= var_0_3 then
		PoolMgr = var_1

		local var_7_0 = var_1.GetInstance()

		var_1.ReturnUI(var_7_0, arg_7_0:GetUIName(), arg_7_0._go)
	end

	return
end

function var_0_0.GetUIName(arg_8_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite me !!!")

	return
end

function var_0_0.GetTitle(arg_9_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite me !!!")

	return
end

function var_0_0.GetTitleEn(arg_10_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite me !!!")

	return
end

function var_0_0.OnInit(arg_11_0)
	return
end

function var_0_0.OnUpdate(arg_12_0)
	return
end

return var_0_0
