local CommanderCatTalentPage = class("CommanderCatTalentPage", import("view.base.BaseSubView"))

function CommanderCatTalentPage:getUIName()
	return "CommanderCatTalentui"
end

function CommanderCatTalentPage:OnLoaded()
	self.resetFrame = self._tf:Find("frame/point/reset_frame")
	self.resetTimeTF = self._tf:Find("frame/point/reset_frame/reset_time")
	self.resetTimeTxt = self._tf:Find("frame/point/reset_frame/reset_time/Text"):GetComponent(typeof(Text))
	self.resetTimeBtn = self._tf:Find("frame/point/reset_frame/reset_btn")
	self.pointTxt = self._tf:Find("frame/point/usage_frame/point/Text"):GetComponent(typeof(Text))
	self.useBtn = self._tf:Find("frame/point/usage_frame/use_btn")
	self.uilist = UIItemList.New(self._tf:Find("frame/talents/content"), self._tf:Find("frame/talents/content/talent_tpl"))
	self.resetPanel = CommanderResetTalentPage.New(self._parentTf, self.event, self.contextData)
	self.usagePanel = CommanderUsageTalentPage.New(self._parentTf, self.event, self.contextData)

	setText(self._tf:Find("frame/point/Text"), i18n("commander_level_up_tip"))

	return
end

function CommanderCatTalentPage:OnInit()
	self:RegisterEvent()
	onButton(self, self.resetTimeBtn, function()
		if self.commanderVO:IsSameTalent() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_reset_talent_is_not_need"))

			return
		end

		if self.inChapter then
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_is_in_battle"))

			return
		end

		if self.commanderVO:CanReset() then
			self.resetPanel:ExecuteAction("Show", self.commanderVO)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_reset_talent_time_no_rearch"))
		end

		return
	end, SFX_PANEL)
	onButton(self, self.useBtn, function()
		if self.inChapter then
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_is_in_battle"))

			return
		end

		if self.commanderVO:getTalentPoint() > 0 then
			self.usagePanel:ExecuteAction("Show", self.commanderVO)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_skill_point_noengough"))
		end

		return
	end, SFX_PANEL)

	return
end

function CommanderCatTalentPage:RegisterEvent()
	self:bind(CommanderCatScene.EVENT_FOLD, function(arg_7_0, arg_7_1)
		if arg_7_1 then
			LeanTween.moveX(rtf(self._tf), 1000, 0.5)
		else
			LeanTween.moveX(rtf(self._tf), -410, 0.5)
		end

		return
	end)
	self:bind(CommanderCatScene.EVENT_SELECTED, function(arg_8_0, arg_8_1)
		self:Flush(arg_8_1)

		return
	end)

	return
end

function CommanderCatTalentPage:Show(arg_9_1)
	CommanderCatTalentPage.super.Show(self)
	self:Flush(arg_9_1)

	return
end

function CommanderCatTalentPage:Flush(arg_10_1)
	self.commanderVO = arg_10_1
	self.inChapter = CommanderCatUtil.CommanderInChapter(self.commanderVO)

	self:RemoveTimer()
	self:UpdatePoint()
	self:UpdateStyle()
	self:UpdateTimer()
	self:UpdateTalents()

	return
end

function CommanderCatTalentPage:UpdateTalents()
	local var_11_0 = self.commanderVO
	local var_11_1 = self.commanderVO:GetDisplayTalents()

	self.uilist:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			self:UpdateTalentCard(arg_12_2, var_11_1[arg_12_1 + 1])

			if var_11_1[arg_12_1 + 1] then
				setActive(arg_12_2:Find("unlock/lock"), not var_11_0:IsLearnedTalent(var_11_1[arg_12_1 + 1].id))
			end
		end

		return
	end)
	self.uilist:align(CommanderConst.MAX_TELENT_COUNT)

	return
end

function CommanderCatTalentPage:UpdateTalentCard(arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1:Find("unlock")
	local var_13_1 = arg_13_1:Find("lock")

	if arg_13_2 then
		GetImageSpriteFromAtlasAsync("CommanderTalentIcon/" .. arg_13_2:getConfig("icon"), "", var_13_0:Find("icon"))

		local var_13_2 = var_13_0:Find("tree_btn")

		if var_13_2 then
			onButton(self, var_13_2, function()
				self.contextData.treePanel:ExecuteAction("Show", arg_13_2)

				return
			end, SFX_PANEL)
		end

		setText(var_13_0:Find("name_bg/Text"), arg_13_2:getConfig("name"))
		setScrollText(var_13_0:Find("desc/Text"), arg_13_2:getConfig("desc"))
	end

	setActive(var_13_0, arg_13_2)

	if var_13_1 then
		setActive(var_13_1, not arg_13_2)
	end

	return
end

function CommanderCatTalentPage:UpdateTimer()
	local var_15_0 = self.commanderVO:getPt() > 0 or pg.TimeMgr.GetInstance():GetServerTime() < self.commanderVO:GetNextResetAbilityTime()

	setActive(self.resetTimeBtn, var_15_0)
	setActive(self.resetTimeTF, var_15_0)
	self:AddTimer()

	return
end

function CommanderCatTalentPage:AddTimer()
	local var_16_0 = self.commanderVO:GetNextResetAbilityTime()
	local var_16_1 = pg.TimeMgr.GetInstance():GetServerTime()

	if var_16_0 <= var_16_1 then
		self.resetTimeTxt.text = i18n("commander_reset_talent")

		setActive(self.resetTimeTF, false)

		return
	end

	self.timer = Timer.New(function()
		var_16_1 = pg.TimeMgr.GetInstance():GetServerTime()

		if var_16_0 - var_16_1 > 0 then
			self.resetTimeTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_16_0 - var_16_1)
		else
			self.resetTimeTxt.text = i18n("commander_reset_talent")

			setActive(self.resetTimeTF, false)
		end

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function CommanderCatTalentPage:UpdatePoint()
	self.pointTxt.text = self.commanderVO:getTalentPoint()

	return
end

function CommanderCatTalentPage:UpdateStyle()
	setActive(self.resetFrame, not self.commanderVO:IsRegularTalent())

	return
end

function CommanderCatTalentPage:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function CommanderCatTalentPage:CanBack()
	if self.usagePanel and self.usagePanel:GetLoaded() and self.usagePanel.CanBack and not self.usagePanel:CanBack() then
		return false
	end

	if self.usagePanel and self.usagePanel:GetLoaded() and self.usagePanel:isShowing() then
		self.usagePanel:Hide()

		return false
	end

	if self.resetPanel and self.resetPanel:GetLoaded() and self.resetPanel:isShowing() then
		self.resetPanel:Hide()

		return false
	end

	return true
end

function CommanderCatTalentPage:OnDestroy()
	self:RemoveTimer()

	if self.usagePanel then
		self.usagePanel:Destroy()

		self.usagePanel = nil
	end

	if self.resetPanel then
		self.resetPanel:Destroy()

		self.resetPanel = nil
	end

	return
end

return CommanderCatTalentPage
