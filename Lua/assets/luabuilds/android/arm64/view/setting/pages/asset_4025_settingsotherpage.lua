local SettingsOtherPage = class("SettingsOtherPage", import(".SettingsOptionPage"))

function SettingsOtherPage:OnShowTranscode(arg_1_1)
	if PLATFORM_CODE == PLATFORM_JP then
		-- block empty
	end

	return
end

function SettingsOtherPage:OnCheckAllAccountState()
	if PLATFORM_CODE == PLATFORM_JP then
		-- block empty
	elseif PLATFORM_CODE == PLATFORM_US then
		self:GetPanel(SettingsAccountUSPanle):checkAllAccountState_US()
	end

	return
end

function SettingsOtherPage:OnClearExchangeCode()
	local var_3_0 = self:GetPanel(SettingsRedeemPanel)

	if var_3_0 then
		var_3_0:ClearExchangeCode()
	end

	return
end

function SettingsOtherPage:OnSecondPwdStateChange()
	local var_4_0 = self:GetPanel(SettingsSecondPwLimitedOpPanle)

	if var_4_0 then
		var_4_0:UpdateBtnsState()
	end

	return
end

function SettingsOtherPage:GetPanels()
	local var_5_0 = {
		SettingsSecondPasswordPanle,
		SettingsSecondPwLimitedOpPanle
	}

	if self:NeedRedeem() then
		table.insert(var_5_0, 1, SettingsRedeemPanel)
	end

	if PLATFORM_CODE == PLATFORM_JP then
		table.insert(var_5_0, 1, SettingsAccountJPPanle)
	end

	if PLATFORM_CODE == PLATFORM_US then
		table.insert(var_5_0, 1, SettingsAccountUSPanle)
	end

	if PLATFORM_CODE == PLATFORM_CHT then
		table.insert(var_5_0, 1, SettingsAccountTwPanle)

		if CSharpVersion >= 50 then
			table.insert(var_5_0, SettingsAccountCHTPanle)
		end

		table.insert(var_5_0, SettingsAgreementCHTPanle)
	end

	if PLATFORM_CODE == PLATFORM_CH then
		table.insert(var_5_0, SettingsAgreementPanle)

		local var_5_1 = LuaHelper.GetCHPackageType()

		if var_5_1 == 1 and CSharpVersion >= 50 and not LOCK_SDK_SERVIVE then
			table.insert(var_5_0, SettingsServicePanle)
		end

		if var_5_1 ~= 1 then
			if var_5_1 == 3 then
				if pg.SdkMgr.GetInstance():IsHuaweiPackage() then
					table.insert(var_5_0, SettingsAccountCHPanle)
				end
			end

			if var_5_1 == 1 and OPEN_EXCEPTION_TEST then
				table.insert(var_5_0, SettingsTestUploadExceptionPanle)
			end

			if PLATFORM_CODE == PLATFORM_US then
				table.insert(var_5_0, SettingsAccountSpecialPanel)
			end
		end
	end

	return var_5_0
end

function SettingsOtherPage:NeedRedeem()
	if PLATFORM == PLATFORM_IPHONEPLAYER then
		return SettingsProxy.IsExchangeCodeActive()
	else
		return true
	end

	return
end

function SettingsOtherPage:OnInitPanle()
	if PlayerPrefs.GetInt("firstIntoOtherPanel", 0) == 0 then
		self:ScrollToPanel((self:GetPanel(SettingsSecondPasswordPanle)))
		PlayerPrefs.DeleteKey("firstIntoOtherPanel")
		PlayerPrefs.SetInt("firstIntoOtherPanel", 1)
		PlayerPrefs.Save()
		pg.EasyRedDotMgr.GetInstance():TriggerMarks("SETTING")
	end

	return
end

return SettingsOtherPage
