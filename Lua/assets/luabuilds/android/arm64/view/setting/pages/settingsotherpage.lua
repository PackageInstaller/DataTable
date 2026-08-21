local var_0_0 = class("SettingsOtherPage", import(".SettingsOptionPage"))

function var_0_0.OnShowTranscode(arg_1_0, arg_1_1)
	if PLATFORM_CODE == PLATFORM_JP then
		-- block empty
	end

	return
end

function var_0_0.OnCheckAllAccountState(arg_2_0)
	if PLATFORM_CODE == PLATFORM_JP then
		-- block empty
	elseif PLATFORM_CODE == PLATFORM_US then
		arg_2_0:GetPanel(SettingsAccountUSPanle):checkAllAccountState_US()
	end

	return
end

function var_0_0.OnClearExchangeCode(arg_3_0)
	local var_3_0 = arg_3_0:GetPanel(SettingsRedeemPanel)

	if var_3_0 then
		var_3_0:ClearExchangeCode()
	end

	return
end

function var_0_0.OnSecondPwdStateChange(arg_4_0)
	local var_4_0 = arg_4_0:GetPanel(SettingsSecondPwLimitedOpPanle)

	if var_4_0 then
		var_4_0:UpdateBtnsState()
	end

	return
end

function var_0_0.GetPanels(arg_5_0)
	if arg_5_0:NeedRedeem() then
		table.insert({
			SettingsSecondPasswordPanle,
			SettingsSecondPwLimitedOpPanle
		}, 1, SettingsRedeemPanel)
	end

	if PLATFORM_CODE == PLATFORM_JP then
		table.insert({
			SettingsSecondPasswordPanle,
			SettingsSecondPwLimitedOpPanle
		}, 1, SettingsAccountJPPanle)
	end

	if PLATFORM_CODE == PLATFORM_US then
		table.insert({
			SettingsSecondPasswordPanle,
			SettingsSecondPwLimitedOpPanle
		}, 1, SettingsAccountUSPanle)
	end

	if PLATFORM_CODE == PLATFORM_CHT then
		table.insert({
			SettingsSecondPasswordPanle,
			SettingsSecondPwLimitedOpPanle
		}, 1, SettingsAccountTwPanle)

		if CSharpVersion >= 50 then
			table.insert({
				SettingsSecondPasswordPanle,
				SettingsSecondPwLimitedOpPanle
			}, SettingsAccountCHTPanle)
		end

		table.insert({
			SettingsSecondPasswordPanle,
			SettingsSecondPwLimitedOpPanle
		}, SettingsAgreementCHTPanle)
	end

	if PLATFORM_CODE == PLATFORM_CH then
		table.insert({
			SettingsSecondPasswordPanle,
			SettingsSecondPwLimitedOpPanle
		}, SettingsAgreementPanle)

		local var_5_0 = LuaHelper.GetCHPackageType()

		if var_5_0 == 1 and CSharpVersion >= 50 and not LOCK_SDK_SERVIVE then
			table.insert({
				SettingsSecondPasswordPanle,
				SettingsSecondPwLimitedOpPanle
			}, SettingsServicePanle)
		end

		if var_5_0 ~= 1 then
			if var_5_0 == 3 then
				if pg.SdkMgr.GetInstance():IsHuaweiPackage() then
					table.insert({
						SettingsSecondPasswordPanle,
						SettingsSecondPwLimitedOpPanle
					}, SettingsAccountCHPanle)
				end
			end

			if var_5_0 == 1 and OPEN_EXCEPTION_TEST then
				table.insert({
					SettingsSecondPasswordPanle,
					SettingsSecondPwLimitedOpPanle
				}, SettingsTestUploadExceptionPanle)
			end

			if PLATFORM_CODE == PLATFORM_US then
				table.insert({
					SettingsSecondPasswordPanle,
					SettingsSecondPwLimitedOpPanle
				}, SettingsAccountSpecialPanel)
			end

			return {
				SettingsSecondPasswordPanle,
				SettingsSecondPwLimitedOpPanle
			}
		end
	end
end

function var_0_0.NeedRedeem(arg_6_0)
	if PLATFORM == PLATFORM_IPHONEPLAYER then
		return SettingsProxy.IsExchangeCodeActive()
	else
		return true
	end

	return
end

function var_0_0.OnInitPanle(arg_7_0)
	if PlayerPrefs.GetInt("firstIntoOtherPanel", 0) == 0 then
		arg_7_0:ScrollToPanel((arg_7_0:GetPanel(SettingsSecondPasswordPanle)))
		PlayerPrefs.DeleteKey("firstIntoOtherPanel")
		PlayerPrefs.SetInt("firstIntoOtherPanel", 1)
		PlayerPrefs.Save()
		pg.EasyRedDotMgr.GetInstance():TriggerMarks("SETTING")
	end

	return
end

return var_0_0
