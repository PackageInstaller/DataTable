class = var_0_10000

local var_0_0 = "SettingsAccountTwPanle"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "SettingsAccountTW"
end

function var_0_1.InitTitle(arg_2_0)
	return
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.googleBtn = var_1.Find(var_3_0, "page1/bind_google")

	local var_3_1 = arg_3_0._tf

	arg_3_0.gamecenterBtn = var_1.Find(var_3_1, "page1/bind_gamecenter")

	local var_3_2 = arg_3_0._tf

	arg_3_0.faceBookBtn = var_1.Find(var_3_2, "page1/bind_facebook")

	local var_3_3 = arg_3_0._tf

	arg_3_0.phoneBtn = var_1.Find(var_3_3, "page1/bind_phone")

	local var_3_4 = arg_3_0._tf

	arg_3_0.appleBtn = var_1.Find(var_3_4, "page1/bind_apple")
	setActive = var_1

	var_1(arg_3_0.appleBtn, true)

	local var_3_5 = {
		arg_3_0.faceBookBtn,
		arg_3_0.googleBtn,
		arg_3_0.phoneBtn,
		arg_3_0.gamecenterBtn,
		arg_3_0.appleBtn
	}

	pg = var_2

	local var_3_6 = var_2.SdkMgr.GetInstance()
	local var_3_7 = var_2.IsBindFaceBook(var_3_6)
	local var_3_8 = var_2:IsBindGoogle()
	local var_3_9 = var_2:IsBindPhone()
	local var_3_10 = var_2:IsBindGameCenter()
	local var_3_11 = var_2
	local var_3_12 = var_2.IsBindApple(var_3_11)
	local var_3_13 = {
		var_3_7,
		var_3_8,
		var_3_9,
		var_3_10,
		var_3_12
	}

	ipairs = var_3_11

	for iter_3_0, iter_3_1 in var_3_11(var_3_5) do
		local var_3_14 = var_3_13[iter_3_0]

		setActive = var_1_10015

		var_1_10015(iter_3_1:Find("unbind"), not var_3_14)

		setActive = var_1_10015

		var_1_10015(iter_3_1:Find("bind"), var_3_14)

		onButton = var_1_10015

		local var_3_15 = arg_3_0
		local var_3_16 = iter_3_1

		local function var_3_17()
			if not var_3_14 then
				local var_4_0 = var_0

				var_0.BindSocial(var_4_0, iter_3_0)
			end

			return
		end

		SFX_PANEL = var_20

		var_1_10015(var_3_15, var_3_16, var_3_17, var_20)
	end

	return
end

function var_0_1.OnUpdate(arg_5_0)
	PLATFORM = var_1_10001
	PLATFORM_ANDROID = var_1_10002

	if var_1_10001 == var_1_10002 then
		setActive = var_1_10001

		var_1_10001(arg_5_0.googleBtn, true)

		setActive = var_1_10001

		var_1_10001(arg_5_0.gamecenterBtn, false)
	else
		setActive = var_1_10001

		var_1_10001(arg_5_0.googleBtn, true)

		setActive = var_1_10001

		var_1_10001(arg_5_0.gamecenterBtn, false)
	end

	return
end

return var_0_1
