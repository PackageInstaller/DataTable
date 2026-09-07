local CommanderLockFlagSettingPage = class("CommanderLockFlagSettingPage", import("view.base.BaseSubView"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3

function CommanderLockFlagSettingPage:getUIName()
	return "CommanderLockFlagSettingui"
end

function CommanderLockFlagSettingPage:OnLoaded()
	self.closeBtn = self._tf:Find("frame/close_btn")
	self.cancelBtn = self._tf:Find("frame/cancel")
	self.confirmBtn = self._tf:Find("frame/confirm")
	self.allBtn = self._tf:Find("frame/title/all_btn")
	self.allSel = self.allBtn:Find("Image")
	self.ssrToggle = self._tf:Find("frame/toggles/rarity/ssr")
	self.srToggle = self._tf:Find("frame/toggles/rarity/sr")
	self.rToggle = self._tf:Find("frame/toggles/rarity/r")
	self.talentUIlist = UIItemList.New(self._tf:Find("frame/toggles/scrollrect/content/talent"), self._tf:Find("frame/toggles/scrollrect/content/talent/tpl"))
	self.descTxt = self._tf:Find("frame/desc/Text"):GetComponent(typeof(Text))

	setText(self._tf:Find("frame/title/rarity"), i18n("word_rarity") .. ": ")
	setText(self._tf:Find("frame/title/talent"), i18n("word_talent") .. ": ")
	setText(self._tf:Find("frame/desc/Text"), i18n("commander_lock_setting_title"))

	return
end

function CommanderLockFlagSettingPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		if self:UnselAnyTalent() or self:UnselAnyRarity() then
			self.contextData.msgBox:ExecuteAction("Show", {
				content = i18n("commander_unsel_lock_flag_tip"),
				onYes = function()
					self:Conform()

					return
				end
			})
		else
			self:Conform()
		end

		return
	end, SFX_PANEL)

	return
end

function CommanderLockFlagSettingPage:UnselAnyTalent()
	for iter_9_0, iter_9_1 in pairs(self.talentList) do
		if iter_9_1 == true then
			return false
		end
	end

	return true
end

function CommanderLockFlagSettingPage:UnselAnyRarity()
	for iter_10_0, iter_10_1 in pairs(self.rarityList) do
		if iter_10_1 == true then
			return false
		end
	end

	return true
end

function CommanderLockFlagSettingPage:Conform()
	self:SaveRarityConfig(self.rarityList)
	self:SaveTalentConfig(self.talentList)
	self:Hide()

	return
end

function CommanderLockFlagSettingPage:Show()
	CommanderLockFlagSettingPage.super.Show(self)
	self:InitRarity()
	self:InitTalent()

	return
end

function CommanderLockFlagSettingPage:InitRarity()
	local var_13_0 = self:GetRarityConfig()

	self.rarityList = {}

	onToggle(self, self.ssrToggle, function(arg_14_0)
		self.rarityList[var_0_1] = arg_14_0

		return
	end, SFX_PANEL)
	onToggle(self, self.srToggle, function(arg_15_0)
		self.rarityList[var_0_2] = arg_15_0

		return
	end, SFX_PANEL)
	onToggle(self, self.rToggle, function(arg_16_0)
		self.rarityList[var_0_3] = arg_16_0

		return
	end, SFX_PANEL)
	triggerToggle(self.ssrToggle, var_13_0[var_0_1])
	triggerToggle(self.srToggle, var_13_0[var_0_2])
	triggerToggle(self.rToggle, var_13_0[var_0_3])

	return
end

function CommanderLockFlagSettingPage:InitTalent()
	self.talentList = {}
	self.talentCards = {}

	local var_17_0 = CommanderCatUtil.GetAllTalentNames()

	self.talentUIlist:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			local var_18_0 = var_17_0[arg_18_1 + 1].id

			onToggle(self, arg_18_2, function(arg_19_0)
				self.talentList[var_18_0] = arg_19_0

				self:UpdateAllBtnStyle()

				return
			end, SFX_PANEL)
			setText(arg_18_2:Find("Text"), var_17_0[arg_18_1 + 1].name)

			arg_18_2.gameObject.name = var_17_0[arg_18_1 + 1].id
			self.talentCards[var_17_0[arg_18_1 + 1].id] = arg_18_2
		end

		return
	end)
	self.talentUIlist:align(#var_17_0)

	for iter_17_0, iter_17_1 in pairs((self:GetTalentConfig())) do
		if self.talentCards[iter_17_0] then
			triggerToggle(self.talentCards[iter_17_0], iter_17_1)
		end
	end

	onButton(self, self.allBtn, function()
		if self:AnyCardUnSelected() then
			self:TriggerAllCardTrue()
		else
			self:TriggerAllCardFalse()
		end

		self:UpdateAllBtnStyle()

		return
	end, SFX_PANEL)
	self:UpdateAllBtnStyle()

	return
end

function CommanderLockFlagSettingPage:UpdateAllBtnStyle()
	setActive(self.allSel, not self:AnyCardUnSelected())

	return
end

function CommanderLockFlagSettingPage:AnyCardUnSelected()
	for iter_22_0, iter_22_1 in pairs(self.talentCards) do
		if not iter_22_1:GetComponent(typeof(Toggle)).isOn then
			return true
		end
	end

	return false
end

function CommanderLockFlagSettingPage:TriggerAllCardTrue()
	for iter_23_0, iter_23_1 in pairs(self.talentCards) do
		triggerToggle(iter_23_1, true)
	end

	return
end

function CommanderLockFlagSettingPage:TriggerAllCardFalse()
	for iter_24_0, iter_24_1 in pairs(self.talentCards) do
		triggerToggle(iter_24_1, false)
	end

	return
end

function CommanderLockFlagSettingPage:GetRarityConfig()
	return (getProxy(SettingsProxy):GetCommanderLockFlagRarityConfig())
end

function CommanderLockFlagSettingPage:SaveRarityConfig(arg_26_1)
	getProxy(SettingsProxy):SaveCommanderLockFlagRarityConfig(arg_26_1)

	return
end

function CommanderLockFlagSettingPage:GetTalentConfig()
	return (getProxy(SettingsProxy):GetCommanderLockFlagTalentConfig())
end

function CommanderLockFlagSettingPage:SaveTalentConfig(arg_28_1)
	getProxy(SettingsProxy):SaveCommanderLockFlagTalentConfig(arg_28_1)

	return
end

function CommanderLockFlagSettingPage:OnDestroy()
	return
end

return CommanderLockFlagSettingPage
