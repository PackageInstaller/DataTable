class = var_0_10000

local var_0_0 = "SettingsOtherPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SettingsOptionPage"))

function var_0_1.OnShowTranscode(arg_1_0, arg_1_1)
	PLATFORM_CODE = var_1_10002
	PLATFORM_JP = var_1_10003

	if var_1_10002 == var_1_10003 then
		-- block empty
	end

	return
end

function var_0_1.OnCheckAllAccountState(arg_2_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_JP = var_1_10002

	if var_1_10001 == var_1_10002 then
		-- block empty
	else
		PLATFORM_CODE = var_1_10001
		PLATFORM_US = var_1_10002

		if var_1_10001 == var_1_10002 then
			local var_2_0 = arg_2_0
			local var_2_1 = arg_2_0.GetPanel

			SettingsAccountUSPanle = var_1_10004

			local var_2_2 = var_2_1(var_2_0, var_1_10004)

			var_1.checkAllAccountState_US(var_2_2)
		end
	end

	return
end

function var_0_1.OnClearExchangeCode(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.GetPanel

	SettingsRedeemPanel = var_1_10004

	if var_3_1(var_3_0, var_1_10004) then
		var_1:ClearExchangeCode()
	end

	return
end

function var_0_1.OnSecondPwdStateChange(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.GetPanel

	SettingsSecondPwLimitedOpPanle = var_1_10004

	if var_4_1(var_4_0, var_1_10004) then
		var_1:UpdateBtnsState()
	end

	return
end

function var_0_1.GetPanels(arg_5_0)
	local var_5_0 = {}

	SettingsSecondPasswordPanle = var_1_10002
	var_5_0[1] = var_1_10002
	SettingsSecondPwLimitedOpPanle = var_1_10002
	var_5_0[2] = var_1_10002

	local var_5_1

	if arg_5_0:NeedRedeem() then
		table = var_5_1
		var_5_1 = var_5_1.insert

		local var_5_2 = var_5_0

		var_1_10005 = 1
		SettingsRedeemPanel = var_1_10006

		var_5_1(var_5_2, var_1_10005, var_1_10006)
	end

	PLATFORM_CODE = var_5_1
	PLATFORM_JP = var_1_10003

	if var_5_1 == var_1_10003 then
		table = var_5_1
		var_5_1 = var_5_1.insert

		local var_5_3 = var_5_0

		var_1_10005 = 1
		SettingsAccountJPPanle = var_1_10006

		var_5_1(var_5_3, var_1_10005, var_1_10006)
	end

	PLATFORM_CODE = var_5_1
	PLATFORM_US = var_1_10003

	if var_5_1 == var_1_10003 then
		table = var_5_1
		var_5_1 = var_5_1.insert

		local var_5_4 = var_5_0

		var_1_10005 = 1
		SettingsAccountUSPanle = var_1_10006

		var_5_1(var_5_4, var_1_10005, var_1_10006)
	end

	PLATFORM_CODE = var_5_1
	PLATFORM_CHT = var_1_10003

	if var_5_1 == var_1_10003 then
		table = var_5_1
		var_5_1 = var_5_1.insert

		local var_5_5 = var_5_0

		var_1_10005 = 1
		SettingsAccountTwPanle = var_1_10006

		var_5_1(var_5_5, var_1_10005, var_1_10006)

		CSharpVersion = var_5_1

		if 50 <= var_5_1 then
			table = var_5_1
			var_5_1 = var_5_1.insert

			local var_5_6 = var_5_0

			SettingsAccountCHTPanle = var_1_10005

			var_5_1(var_5_6, var_1_10005)
		end

		table = var_5_1
		var_5_1 = var_5_1.insert

		local var_5_7 = var_5_0

		SettingsAgreementCHTPanle = var_1_10005

		var_5_1(var_5_7, var_1_10005)
	end

	PLATFORM_CODE = var_5_1
	PLATFORM_CH = var_1_10003

	if var_5_1 == var_1_10003 then
		table = var_5_1
		var_5_1 = var_5_1.insert

		local var_5_8 = var_5_0

		SettingsAgreementPanle = var_1_10005

		var_5_1(var_5_8, var_1_10005)

		LuaHelper = var_5_1

		if var_5_1.GetCHPackageType() == 1 then
			CSharpVersion = var_1_10003

			if var_1_10003 >= 50 then
				LOCK_SDK_SERVIVE = var_1_10003

				if not var_1_10003 then
					table = var_1_10003
					var_1_10003 = var_1_10003.insert
					var_1_10005 = var_5_0
					SettingsServicePanle = var_1_10006

					var_1_10003(var_1_10005, var_1_10006)
				end
			end
		end

		if var_5_1 ~= 1 then
			if var_5_1 == 3 then
				pg = var_1_10003
				var_1_10005 = var_1_10003.SdkMgr.GetInstance()

				if var_1_10003.IsHuaweiPackage(var_1_10005) then
					table = var_1_10003
					var_1_10003 = var_1_10003.insert
					var_1_10005 = var_5_0
					SettingsAccountCHPanle = var_1_10006

					var_1_10003(var_1_10005, var_1_10006)
				end
			end

			if var_5_1 == 1 then
				OPEN_EXCEPTION_TEST = var_1_10003

				if var_1_10003 then
					table = var_1_10003
					var_1_10003 = var_1_10003.insert
					var_1_10005 = var_5_0
					SettingsTestUploadExceptionPanle = var_1_10006

					var_1_10003(var_1_10005, var_1_10006)
				end
			end

			PLATFORM_CODE = var_5_1
			PLATFORM_US = var_1_10003

			if var_5_1 == var_1_10003 then
				table = var_5_1

				local var_5_9 = var_5_1.insert
				local var_5_10 = var_5_0

				SettingsAccountSpecialPanel = var_1_10005

				var_5_9(var_5_10, var_1_10005)
			end

			return var_5_0
		end
	end
end

function var_0_1.NeedRedeem(arg_6_0)
	PLATFORM = var_1_10001
	PLATFORM_IPHONEPLAYER = var_1_10002

	if var_1_10001 == var_1_10002 then
		SettingsProxy = var_1_10001

		return var_1_10001.IsExchangeCodeActive()
	else
		return true
	end

	return
end

function var_0_1.OnInitPanle(arg_7_0)
	PlayerPrefs = var_1_10001

	if var_1_10001.GetInt("firstIntoOtherPanel", 0) == 0 then
		local var_7_0 = arg_7_0
		local var_7_1 = arg_7_0.GetPanel

		SettingsSecondPasswordPanle = var_1_10005

		local var_7_2 = var_7_1(var_7_0, var_1_10005)

		arg_7_0:ScrollToPanel(var_7_2)

		PlayerPrefs = var_3

		var_3.DeleteKey("firstIntoOtherPanel")

		PlayerPrefs = var_3

		var_3.SetInt("firstIntoOtherPanel", 1)

		PlayerPrefs = var_3

		var_3.Save()

		pg = var_3

		local var_7_3 = var_3.EasyRedDotMgr.GetInstance()

		var_3.TriggerMarks(var_7_3, "SETTING")
	end

	return
end

return var_0_1
