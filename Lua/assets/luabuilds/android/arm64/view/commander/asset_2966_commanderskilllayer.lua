local CommanderSkillLayer = class("CommanderSkillLayer", import("..base.BaseUI"))

function CommanderSkillLayer:getUIName()
	return "CommanderSkillUI"
end

function CommanderSkillLayer:init()
	self.backBtn = self._tf:Find("top/btnBack")
	self.skillInfoName = self._tf:Find("panel/bg/skill_name")
	self.skillInfoLv = self._tf:Find("panel/bg/skill_lv")
	self.skillInfoIntro = self._tf:Find("panel/bg/help_panel/skill_intro")
	self.skillInfoIcon = self._tf:Find("panel/bg/skill_icon")
	self.buttonList = self._tf:Find("panel/buttonList")
	self.skillDescTF = self._tf:Find("panel/bg/help_panel/Viewport/content/introTF")
	self.skillDescContent = self._tf:Find("panel/bg/help_panel/Viewport/content")

	setText(self.skillInfoName, self.contextData.skill:getConfig("name"))
	setText(self.skillInfoLv, "Lv." .. self.contextData.skill:getLevel())

	self.skillDescList = UIItemList.New(self.skillDescContent, self.skillDescTF)

	GetImageSpriteFromAtlasAsync("commanderskillicon/" .. self.contextData.skill:getConfig("icon"), "", self.skillInfoIcon)
	self:SetLocaliza()

	return
end

function CommanderSkillLayer:SetLocaliza()
	setText(self._tf:Find("top/title_list/infomation/title"), i18n("words_information"))
	setText(self._tf:Find("panel/buttonList/ok_button/Image"), i18n("word_ok"))

	return
end

function CommanderSkillLayer:didEnter()
	onButton(self, self._tf, function()
		self:emit(CommanderSkillLayer.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(self, self.backBtn, function()
		self:emit(CommanderSkillLayer.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("panel/buttonList/ok_button"), function()
		self:emit(CommanderSkillLayer.ON_CLOSE)

		return
	end, SFX_CONFIRM)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.commonFlag = defaultValue(self.contextData.commonFlag, true)

	self:UpdateList()

	return
end

function CommanderSkillLayer:UpdateList()
	local var_8_0 = self.contextData.skill:getConfig("lv")
	local var_8_1 = self.contextData.skill:GetSkillGroup()
	local var_8_2 = self.contextData.skill:getConfig("lv")

	self.skillDescList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			local var_9_0 = var_8_1[arg_9_1 + 1]
			local var_9_1 = self:GetColor(var_8_2 >= var_8_1[arg_9_1 + 1].lv)

			setText(arg_9_2, "<color=" .. var_9_1 .. ">" .. self:GetDesc(self.commonFlag, var_8_1[arg_9_1 + 1]) .. (var_8_2 < var_8_1[arg_9_1 + 1].lv and "(Lv." .. var_9_0.lv .. i18n("word_take_effect") .. ")" or "") .. "</color>")
			setText(arg_9_2:Find("level"), "<color=" .. var_9_1 .. ">" .. "Lv." .. var_9_0.lv .. "</color>")
		end

		return
	end)
	self.skillDescList:align(#var_8_1)

	return
end

function CommanderSkillLayer:GetDesc(arg_10_1, arg_10_2)
	if not arg_10_1 and arg_10_2.desc_world and arg_10_2.desc_world ~= "" then
		return arg_10_2.desc_world
	else
		return arg_10_2.desc
	end

	return
end

function CommanderSkillLayer:GetColor(arg_11_1)
	return "#FFFFFFFF"
end

function CommanderSkillLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function CommanderSkillLayer:onBackPressed()
	triggerButton(self.backBtn)

	return
end

return CommanderSkillLayer
