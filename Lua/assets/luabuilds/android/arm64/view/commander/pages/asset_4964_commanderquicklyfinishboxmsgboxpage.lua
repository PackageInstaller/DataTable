local CommanderQuicklyFinishBoxMsgBoxPage = class("CommanderQuicklyFinishBoxMsgBoxPage", import(".CommanderMsgBoxPage"))

function CommanderQuicklyFinishBoxMsgBoxPage:getUIName()
	return "CommanderQuicklyFinishBoxUI"
end

function CommanderQuicklyFinishBoxMsgBoxPage:OnInit()
	CommanderQuicklyFinishBoxMsgBoxPage.super.OnInit(self)

	self.ssrToggle = self._tf:Find("frame/bg/content/rarity/ssr")
	self.srToggle = self._tf:Find("frame/bg/content/rarity/sr")
	self.rToggle = self._tf:Find("frame/bg/content/rarity/r")
	self.descTxt = self._tf:Find("frame/bg/content/rarity/Text"):GetComponent(typeof(Text))

	return
end

function CommanderQuicklyFinishBoxMsgBoxPage:Show(arg_3_1)
	CommanderQuicklyFinishBoxMsgBoxPage.super.Show(self, arg_3_1)

	self.descTxt.text = i18n("acceleration_tips_3")

	onButton(self, self.confirmBtn, function()
		local var_4_0, var_4_1, var_4_2, var_4_3 = getProxy(CommanderProxy):CalcQuickItemUsageCnt(self.toggleFlags)

		if var_4_0 <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("noacceleration_tips"))

			return
		end

		if arg_3_1.onYes then
			arg_3_1.onYes(var_4_0, var_4_1, var_4_2, self.toggleFlags)
		end

		self:SaveConfig()
		self:Hide()

		return
	end, SFX_PANEL)
	self:InitToggle()
	self:UpdateContent()

	return
end

function CommanderQuicklyFinishBoxMsgBoxPage:UpdateContent()
	local var_5_0, var_5_1, var_5_2, var_5_3 = getProxy(CommanderProxy):CalcQuickItemUsageCnt(self.toggleFlags)

	setText(self.text1, (i18n("acceleration_tips_1", var_5_0, var_5_1)))
	setText(self.text2, (i18n("acceleration_tips_2", var_5_3[1], var_5_3[2], var_5_3[3])))

	return
end

function CommanderQuicklyFinishBoxMsgBoxPage:InitToggle()
	self.toggleFlags = {}

	onToggle(self, self.ssrToggle, function(arg_7_0)
		self.toggleFlags[1] = arg_7_0

		self:UpdateContent()

		return
	end, SFX_PANEL)
	onToggle(self, self.srToggle, function(arg_8_0)
		self.toggleFlags[2] = arg_8_0

		self:UpdateContent()

		return
	end, SFX_PANEL)
	onToggle(self, self.rToggle, function(arg_9_0)
		self.toggleFlags[3] = arg_9_0

		self:UpdateContent()

		return
	end, SFX_PANEL)

	local var_6_0 = self:GetConfig()

	triggerToggle(self.ssrToggle, var_6_0[1])
	triggerToggle(self.srToggle, var_6_0[2])
	triggerToggle(self.rToggle, var_6_0[3])

	return
end

function CommanderQuicklyFinishBoxMsgBoxPage:GetConfig()
	return (getProxy(SettingsProxy):GetCommanderQuicklyToolRarityConfig())
end

function CommanderQuicklyFinishBoxMsgBoxPage:SaveConfig()
	getProxy(SettingsProxy):SaveCommanderQuicklyToolRarityConfig(self.toggleFlags)

	return
end

return CommanderQuicklyFinishBoxMsgBoxPage
