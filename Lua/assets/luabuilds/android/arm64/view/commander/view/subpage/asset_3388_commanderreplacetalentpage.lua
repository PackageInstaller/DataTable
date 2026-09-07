local CommanderReplaceTalentPage = class("CommanderReplaceTalentPage", import("view.base.BaseSubView"))

function CommanderReplaceTalentPage:getUIName()
	return "CommanderCatReplaceTalentUI"
end

function CommanderReplaceTalentPage:OnLoaded()
	self.replaceList = UIItemList.New(self._tf:Find("bg/frame/bg/talents/content"), self._tf:Find("bg/frame/bg/talents/content/talent"))
	self.replaceTargetTF = self._tf:Find("bg/frame/bg/talent")
	self.replaceTalent = self._tf:Find("bg/frame/bg/replace")
	self.replaceCloseBtn = self._tf:Find("bg/frame/close_btn")
	self.replaceCancelBtn = self._tf:Find("bg/frame/cancel_btn")
	self.confirmBtn = self._tf:Find("bg/frame/confirm_btn")

	setActive(self._tf:Find("bg/frame/consume"), false)
	setText(self._tf:Find("bg/frame/bg/title/Text"), i18n("commander_choice_talent_3"))
	setText(self._tf:Find("bg/frame/bg/talents/title/Text"), i18n("commander_choice_talent_2"))

	return
end

function CommanderReplaceTalentPage:OnInit()
	onButton(self, self.replaceCloseBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.replaceCancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function CommanderReplaceTalentPage:Show(arg_7_1, arg_7_2)
	CommanderReplaceTalentPage.super.Show(self)
	self._tf:SetAsLastSibling()

	self.commander = arg_7_1

	self:UpdateTalents(arg_7_2, nil)
	self:UpdateList(arg_7_2)

	return
end

function CommanderReplaceTalentPage:UpdateList(arg_8_1)
	local var_8_0 = self.commander:getTalents()

	self.replaceList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			local var_9_0 = var_8_0[arg_9_1 + 1]

			onButton(self, arg_9_2, function()
				if self.prevToggle ~= arg_9_2 then
					self:UpdateTalents(arg_8_1, var_9_0)

					if self.prevToggle then
						setActive(self.prevToggle:Find("mark"), false)
					end

					self.prevToggle = arg_9_2

					setActive(arg_9_2:Find("mark"), true)
				end

				return
			end, SFX_PANEL)
			GetImageSpriteFromAtlasAsync("CommanderTalentIcon/" .. var_8_0[arg_9_1 + 1]:getConfig("icon"), "", arg_9_2)
		end

		return
	end)
	self.replaceList:align(#var_8_0)

	return
end

function CommanderReplaceTalentPage:UpdateTalents(arg_11_1, arg_11_2)
	local var_11_0 = self.commander

	self:UpdateTalentCard(self.replaceTargetTF, arg_11_1)
	self:UpdateTalentCard(self.replaceTalent, arg_11_2)
	onButton(self, self.confirmBtn, function()
		if arg_11_2 and arg_11_1 and var_11_0 then
			if arg_11_2:getConfig("worth") > 1 then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("commander_ability_replace_warning"),
					onYes = function()
						self:emit(CommanderCatMediator.LEARN_TALENT, var_11_0.id, arg_11_1.id, arg_11_2.id)
						self:Hide()

						return
					end
				})
			else
				self:emit(CommanderCatMediator.LEARN_TALENT, var_11_0.id, arg_11_1.id, arg_11_2.id)
				self:Hide()
			end
		end

		return
	end, SFX_PANEL)

	return
end

function CommanderReplaceTalentPage:UpdateTalentCard(arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1:Find("unlock")
	local var_14_1 = arg_14_1:Find("lock")

	if arg_14_2 then
		GetImageSpriteFromAtlasAsync("CommanderTalentIcon/" .. arg_14_2:getConfig("icon"), "", var_14_0:Find("icon"))

		local var_14_2 = var_14_0:Find("tree_btn")

		if var_14_2 then
			onButton(self, var_14_2, function()
				self.contextData.treePanel:ExecuteAction("Show", arg_14_2)

				return
			end, SFX_PANEL)
		end

		setText(var_14_0:Find("name_bg/Text"), arg_14_2:getConfig("name"))
		setScrollText(var_14_0:Find("desc/Text"), arg_14_2:getConfig("desc"))
	end

	setActive(var_14_0, arg_14_2)

	if var_14_1 then
		setActive(var_14_1, not arg_14_2)
	end

	return
end

function CommanderReplaceTalentPage:Hide()
	CommanderReplaceTalentPage.super.Hide(self)

	if self.prevToggle then
		setActive(self.prevToggle:Find("mark"), false)

		self.prevToggle = nil
	end

	return
end

function CommanderReplaceTalentPage:OnDestroy()
	return
end

return CommanderReplaceTalentPage
