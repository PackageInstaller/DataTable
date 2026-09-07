local CommanderUsageTalentPage = class("CommanderUsageTalentPage", import("view.base.BaseSubView"))

function CommanderUsageTalentPage:getUIName()
	return "CommanderCatUsageTalentUI"
end

function CommanderUsageTalentPage:OnLoaded()
	self.usageList = UIItemList.New(self._tf:Find("bg/frame/bg/talents/content"), self._tf:Find("bg/frame/bg/talents/content/talent"))
	self.usageCancelBtn = self._tf:Find("bg/frame/cancel_btn")
	self.usageConfirmBtn = self._tf:Find("bg/frame/confirm_btn")
	self.usageConfirmUpgrade = self._tf:Find("bg/frame/confirm_btn/upgrade")
	self.usageConfirmILearned = self._tf:Find("bg/frame/confirm_btn/learned")
	self.usageTalent = self._tf:Find("bg/frame/bg/talent")
	self.usageCostIconTF = self._tf:Find("bg/frame/consume/Image")
	self.usageCostTxtTF = self._tf:Find("bg/frame/consume/Text")
	self.usageCostTxt = self.usageCostTxtTF:GetComponent(typeof(Text))
	self.usageCloseBtn = self._tf:Find("bg/frame/close_btn")
	self.replacePage = CommanderReplaceTalentPage.New(self._parentTf.parent, self.event)

	setText(self._tf:Find("bg/frame/bg/title/Text"), i18n("commander_choice_talent_1"))
	setText(self._tf:Find("bg/frame/bg/talents/title/Text"), i18n("commander_choice_talent_2"))
	setText(self._tf:Find("bg/frame/consume/label"), i18n("word_consume"))

	return
end

function CommanderUsageTalentPage:OnInit()
	self:RegisterEvent()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.usageCancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.usageCloseBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.usageConfirmBtn, function()
		if self.talent and self.commanderVO:fullTalentCnt() and not self.commanderVO:hasTalent(self.talent) then
			self.replacePage:ExecuteAction("Show", self.commanderVO, self.talent)
		elseif self.talent then
			self:emit(CommanderCatMediator.LEARN_TALENT, self.commanderVO.id, self.talent.id, 0)
		end

		return
	end, SFX_PANEL)

	return
end

function CommanderUsageTalentPage:RegisterEvent()
	self:bind(CommanderCatScene.MSG_FETCH_TALENT_LIST, function(arg_9_0)
		if self.commanderVO then
			self:Flush((getProxy(CommanderProxy):getCommanderById(self.commanderVO.id)))
		end

		return
	end)
	self:bind(CommanderCatScene.MSG_LEARN_TALENT, function(arg_10_0)
		if self.commanderVO then
			local var_10_0 = getProxy(CommanderProxy):getCommanderById(self.commanderVO.id)

			if var_10_0:getTalentPoint() <= 0 then
				self:Hide()

				return
			end

			self:Flush(var_10_0)
		end

		return
	end)

	return
end

function CommanderUsageTalentPage:Show(arg_11_1)
	CommanderUsageTalentPage.super.Show(self)
	self._tf:SetAsLastSibling()
	self:Flush(arg_11_1)
	self:UpdateStyle()

	return
end

function CommanderUsageTalentPage:Flush(arg_12_1)
	self.commanderVO = arg_12_1

	local var_12_0 = arg_12_1:getNotLearnedList()

	if not var_12_0 or #var_12_0 == 0 then
		self:FetchList()
	else
		self:UpdateList()
	end

	return
end

function CommanderUsageTalentPage:UpdateStyle()
	setActive(self.usageCostIconTF, false)
	setActive(self.usageCostTxtTF, false)

	return
end

function CommanderUsageTalentPage:FetchList()
	self:emit(CommanderCatMediator.FETCH_NOT_LEARNED_TALENT, self.commanderVO.id)

	return
end

function CommanderUsageTalentPage:UpdateList()
	local var_15_0 = self.commanderVO:getNotLearnedList()

	self.usageList:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			self:UpdateCard(var_15_0[arg_16_1 + 1], arg_16_2)

			if arg_16_1 == 0 then
				triggerToggle(arg_16_2, true)
			end
		end

		return
	end)
	self.usageList:align(#var_15_0)

	return
end

function CommanderUsageTalentPage:UpdateCard(arg_17_1, arg_17_2)
	local var_17_0 = self.commanderVO

	setActive(arg_17_2:Find("up"), (self.commanderVO:hasTalent(arg_17_1)))
	GetImageSpriteFromAtlasAsync("CommanderTalentIcon/" .. arg_17_1:getConfig("icon"), "", arg_17_2)
	onToggle(self, arg_17_2, function(arg_18_0)
		if arg_18_0 and (not self.talent or self.talent.id ~= arg_17_1.id) then
			self.talent = arg_17_1

			self:UpdateTalentCard(self.usageTalent, arg_17_1)

			local var_18_0 = arg_17_1:getConfig("cost")

			setActive(self.usageCostIconTF, var_18_0 > 0)
			setActive(self.usageCostTxtTF, var_18_0 > 0)

			self.usageCostTxt.text = var_18_0

			setActive(self.usageConfirmUpgrade, var_17_0:hasTalent(arg_17_1))
			setActive(self.usageConfirmILearned, not var_17_0:hasTalent(arg_17_1))
		end

		return
	end, SFX_PANEL)

	return
end

function CommanderUsageTalentPage:UpdateTalentCard(arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1:Find("unlock")
	local var_19_1 = arg_19_1:Find("lock")

	if arg_19_2 then
		GetImageSpriteFromAtlasAsync("CommanderTalentIcon/" .. arg_19_2:getConfig("icon"), "", var_19_0:Find("icon"))

		local var_19_2 = var_19_0:Find("tree_btn")

		if var_19_2 then
			onButton(self, var_19_2, function()
				self.contextData.treePanel:ExecuteAction("Show", arg_19_2)

				return
			end, SFX_PANEL)
		end

		setText(var_19_0:Find("name_bg/Text"), arg_19_2:getConfig("name"))
		setScrollText(var_19_0:Find("desc/Text"), arg_19_2:getConfig("desc"))
	end

	setActive(var_19_0, arg_19_2)

	if var_19_1 then
		setActive(var_19_1, not arg_19_2)
	end

	return
end

function CommanderUsageTalentPage:CanBack()
	if self.replacePage and self.replacePage:GetLoaded() and self.replacePage:isShowing() then
		self.replacePage:Hide()

		return false
	end

	return true
end

function CommanderUsageTalentPage:OnDestroy()
	if self.replacePage then
		self.replacePage:Destroy()

		self.replacePage = nil
	end

	return
end

return CommanderUsageTalentPage
