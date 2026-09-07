local SettingsSecondPwLimitedOpPanle = class("SettingsSecondPwLimitedOpPanle", import(".SettingsBasePanel"))

function SettingsSecondPwLimitedOpPanle:GetUIName()
	return "SettingsSecondPwLimitedOp"
end

function SettingsSecondPwLimitedOpPanle:GetTitle()
	return i18n("Settings_title_Secpwlimop")
end

function SettingsSecondPwLimitedOpPanle:GetTitleEn()
	return "  / PROTECTION LIST"
end

function SettingsSecondPwLimitedOpPanle:OnInit()
	self.uiList = UIItemList.New(findTF(self._tf, "options"), findTF(self._tf, "options/notify_tpl"))

	self.uiList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_5_1 + 1, arg_5_2)
		end

		return
	end)
	self:SetData()

	return
end

function SettingsSecondPwLimitedOpPanle:SetData()
	self.rawdata = getProxy(SecondaryPWDProxy):getRawData()

	return
end

function SettingsSecondPwLimitedOpPanle:UpdateItem(arg_7_1, arg_7_2)
	local var_7_0 = self.list[arg_7_1].key

	findTF(arg_7_2, "mask/Text"):GetComponent("ScrollText"):SetText(self.list[arg_7_1].title)

	local var_7_1 = pg.SecondaryPWDMgr.GetInstance()

	onButton(self, arg_7_2, function()
		local var_8_0 = table.contains(self.rawdata.system_list, var_7_0)
		local var_8_1

		if not var_8_0 then
			var_8_1 = Clone(self.rawdata.system_list)
			var_8_1[#var_8_1 + 1] = var_7_0

			table.sort(var_8_1, function(arg_9_0, arg_9_1)
				return arg_9_0 < arg_9_1
			end)
		elseif var_8_0 then
			var_8_1 = Clone(self.rawdata.system_list)

			for iter_8_0 = #var_8_1, 1, -1 do
				if var_8_1[iter_8_0] == var_7_0 then
					table.remove(var_8_1, iter_8_0)
				end
			end
		end

		var_7_1:ChangeSetting(var_8_1, function()
			self:UpdateBtnsState()

			return
		end)

		return
	end, SFX_UI_TAG)

	return
end

function SettingsSecondPwLimitedOpPanle:UpdateBtnsState()
	if not self:IsLoaded() then
		return
	end

	local function var_11_0(arg_12_0, arg_12_1)
		local var_12_0 = table.contains(self.rawdata.system_list, arg_12_0.key)

		arg_12_1:GetComponent(typeof(Button)).interactable = self.rawdata.state > 0

		triggerToggle(arg_12_1:Find("on"), var_12_0)
		triggerToggle(arg_12_1:Find("off"), not var_12_0)

		return
	end

	self.uiList:eachActive(function(arg_13_0, arg_13_1)
		var_11_0(self.list[arg_13_0 + 1], arg_13_1)

		return
	end)

	return
end

function SettingsSecondPwLimitedOpPanle:OnUpdate()
	self.list = self:GetList()

	self.uiList:align(#self.list)
	self:UpdateBtnsState()

	return
end

function SettingsSecondPwLimitedOpPanle:GetList()
	local var_15_0 = pg.SecondaryPWDMgr.GetInstance()
	local var_15_1 = {
		{
			key = var_15_0.UNLOCK_SHIP,
			title = i18n("words_settings_unlock_ship")
		},
		{
			key = var_15_0.RESOLVE_EQUIPMENT,
			title = i18n("words_settings_resolve_equip")
		},
		{
			key = var_15_0.UNLOCK_COMMANDER,
			title = i18n("words_settings_unlock_commander")
		},
		{
			key = var_15_0.CREATE_INHERIT,
			title = i18n("words_settings_create_inherit")
		}
	}

	for iter_15_0 = #var_15_1, 1, -1 do
		if not table.contains(var_15_0.LIMITED_OPERATION, var_15_1[iter_15_0].key) then
			table.remove(var_15_1, iter_15_0)
		end
	end

	return var_15_1
end

return SettingsSecondPwLimitedOpPanle
