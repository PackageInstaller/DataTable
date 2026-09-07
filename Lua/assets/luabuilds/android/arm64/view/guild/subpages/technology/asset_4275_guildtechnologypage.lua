local GuildTechnologyPage = class("GuildTechnologyPage", import("...base.GuildBasePage"))

GuildTechnologyPage.PAGE_DEV = 1
GuildTechnologyPage.PAGE_UPGRADE = 2
GuildTechnologyPage.PAGE_DEV_ITEM = 3

function GuildTechnologyPage:getTargetUI()
	return "TechnologyBluePage", "TechnologyRedPage"
end

function GuildTechnologyPage:OnLoaded()
	self.frame = self._tf:Find("frame")
	self.toggle = self._tf:Find("frame/toggle")
	self.upgradeList = UIItemList.New(self._tf:Find("frame/upgrade/content"), self._tf:Find("frame/upgrade/content/tpl"))
	self.breakOutList = UIItemList.New(self._tf:Find("frame/breakout/content"), self._tf:Find("frame/upgrade/content/tpl"))
	self.breakoutListPanel = self._tf:Find("frame/breakout")
	self.upgradePanel = self._tf:Find("frame/upgrade")
	self.inDevelopmentPanel = self._tf:Find("frame/dev")
	self.inDevelopmentIcon = self.inDevelopmentPanel:Find("item/icon"):GetComponent(typeof(Image))
	self.inDevelopmentName = self.inDevelopmentPanel:Find("item/name"):GetComponent(typeof(Text))
	self.inDevelopmentLevel1Txt = self.inDevelopmentPanel:Find("level1/Text"):GetComponent(typeof(Text))
	self.inDevelopmentLevel2Txt = self.inDevelopmentPanel:Find("level2/Text"):GetComponent(typeof(Text))
	self.inDevelopmentLevel1Desc = self.inDevelopmentPanel:Find("level1/level/Text"):GetComponent(typeof(Text))
	self.inDevelopmentLevel2Desc = self.inDevelopmentPanel:Find("level2/level/Text"):GetComponent(typeof(Text))
	self.inDevelopmentProgress = self.inDevelopmentPanel:Find("progress/bar")
	self.inDevelopmentProgressTxt = self.inDevelopmentPanel:Find("progress/Text"):GetComponent(typeof(Text))
	self.donateBtn = self.inDevelopmentPanel:Find("skin_btn")
	self.cancelBtn = self.inDevelopmentPanel:Find("cancel_btn")

	setText(self.inDevelopmentPanel:Find("level1/level/label"), i18n("guild_tech_label_max_level"))
	setText(self.inDevelopmentPanel:Find("level2/level/label"), i18n("guild_tech_label_max_level"))
	setText(self.inDevelopmentPanel:Find("progress/title/Text"), i18n("guild_tech_label_dev_progress"))
	setText(self.inDevelopmentPanel:Find("progress/title/label"), i18n("guild_tech_label_condition"))

	return
end

function GuildTechnologyPage:OnInit()
	pg.UIMgr.GetInstance():OverlayPanel(self.frame, {
		pbList = {
			self.frame
		},
		overlayType = LayerWeightConst.OVERLAY_UI_ADAPT
	})
	setActive(self._tf, true)
	onToggle(self, self.toggle, function(arg_4_0)
		if arg_4_0 then
			self:UpdateBreakOutList()
		else
			self:UpdateUpgradeList()
		end

		setActive(self.toggle:Find("on"), arg_4_0)
		setActive(self.toggle:Find("off"), not arg_4_0)

		return
	end, SFX_PANEL)
	onButton(self, self.donateBtn, function()
		self:emit(GuildTechnologyMediator.ON_OPEN_OFFICE)

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Switch2BreakOutList()

		return
	end, SFX_PANEL)

	return
end

function GuildTechnologyPage:SetUp(arg_7_1)
	self:Update(arg_7_1)
	triggerToggle(self.toggle, false)

	return
end

function GuildTechnologyPage:Update(arg_8_1)
	self.guildVO = arg_8_1
	self.technologyVOs = self.guildVO:getTechnologys()
	self.technologyGroupVOs = self.guildVO:getTechnologyGroups()
	self.activityGroup = _.detect(self.technologyGroupVOs, function(arg_9_0)
		return arg_9_0:GetState() == GuildTechnologyGroup.STATE_START
	end)
	self.isAdmin = GuildMember.IsAdministrator(arg_8_1:getSelfDuty())

	return
end

function GuildTechnologyPage:Flush()
	if GuildTechnologyPage.PAGE_DEV == self.page then
		self:InitBreakOutList()
	elseif GuildTechnologyPage.PAGE_UPGRADE == self.page then
		self:UpdateUpgradeList()
	elseif GuildTechnologyPage.PAGE_DEV_ITEM == self.page then
		self:InitDevingItem()
	end

	return
end

function GuildTechnologyPage:UpdateUpgradeList()
	table.sort(self.technologyVOs, function(arg_12_0, arg_12_1)
		return arg_12_0.id < arg_12_1.id
	end)
	self.upgradeList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			GuildTechnologyCard.New(arg_13_2:Find("content"), self):Update(self.technologyVOs[arg_13_1 + 1], self.activityGroup)
			setActive(arg_13_2:Find("back"), false)
		end

		return
	end)
	self.upgradeList:align(#self.technologyVOs)
	setActive(self.upgradePanel, true)
	setActive(self.inDevelopmentPanel, false)
	setActive(self.breakoutListPanel, false)

	self.page = GuildTechnologyPage.PAGE_UPGRADE

	return
end

function GuildTechnologyPage:UpdateBreakOutList()
	if self.activityGroup then
		self:InitDevingItem()
	else
		self:InitBreakOutList()
	end

	setActive(self.upgradePanel, false)
	setActive(self.inDevelopmentPanel, self.activityGroup)
	setActive(self.breakoutListPanel, not self.activityGroup)

	return
end

function GuildTechnologyPage:Switch2BreakOutList()
	setActive(self.upgradePanel, false)
	setActive(self.inDevelopmentPanel, false)
	setActive(self.breakoutListPanel, true)
	self:InitBreakOutList(true)

	return
end

function GuildTechnologyPage:InitBreakOutList(arg_16_1)
	table.sort(self.technologyGroupVOs, function(arg_17_0, arg_17_1)
		return arg_17_0.pid < arg_17_1.pid
	end)
	self.breakOutList:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			local var_18_0 = GuildTechnologyGroupCard.New(arg_18_2:Find("content"), self)

			var_18_0:Update(self.technologyGroupVOs[arg_18_1 + 1], self.activityGroup, self.isAdmin)

			local var_18_1 = arg_16_1 and self.activityGroup and self.activityGroup.id == self.technologyGroupVOs[arg_18_1 + 1].id

			setActive(var_18_0._tf, not var_18_1)
			setActive(arg_18_2:Find("back"), var_18_1)

			if var_18_1 then
				onButton(self, arg_18_2:Find("back"), function()
					self:UpdateBreakOutList()

					return
				end, SFX_PANEL)
				arg_18_2:SetAsFirstSibling()
			end
		end

		return
	end)
	self.breakOutList:align(#self.technologyGroupVOs)

	self.page = GuildTechnologyPage.PAGE_DEV

	return
end

function GuildTechnologyPage:InitDevingItem()
	self.inDevelopmentIcon.sprite = GetSpriteFromAtlas("GuildTechnology", self.activityGroup.id)
	self.inDevelopmentName.text = self.activityGroup:getConfig("name")

	local var_20_0 = self.activityGroup:bindConfigTable()
	local var_20_1
	local var_20_2
	local var_20_3
	local var_20_4
	local var_20_5
	local var_20_6

	if var_20_0[self.activityGroup.pid].next_tech ~= 0 then
		var_20_1 = self.activityGroup:GetLevel()
		var_20_2 = var_20_0[var_20_0[self.activityGroup.pid].next_tech].level
		var_20_3 = GuildConst.GET_TECHNOLOGY_DESC(self.activityGroup:getConfig("effect_args"), self.activityGroup:getConfig("num"))
		var_20_4 = GuildConst.GET_TECHNOLOGY_DESC(var_20_0[var_20_0[self.activityGroup.pid].next_tech].effect_args, var_20_0[var_20_0[self.activityGroup.pid].next_tech].num)
		var_20_5 = self.activityGroup:GetProgress()
		var_20_6 = self.activityGroup:GetTargetProgress()
	else
		var_20_1 = self.activityGroup:GetLevel()
		var_20_2 = "MAX"
		var_20_3 = GuildConst.GET_TECHNOLOGY_DESC(self.activityGroup:getConfig("effect_args"), self.activityGroup:getConfig("num"))
		var_20_4 = ""
		var_20_5 = 1
		var_20_6 = 1
	end

	self.inDevelopmentLevel1Txt.text = var_20_3
	self.inDevelopmentLevel1Desc.text = "Lv" .. var_20_1
	self.inDevelopmentLevel2Desc.text = "Lv" .. var_20_2
	self.inDevelopmentLevel2Txt.text = var_20_4

	setFillAmount(self.inDevelopmentProgress, var_20_5 / var_20_6)

	self.inDevelopmentProgressTxt.text = var_20_5 .. "/" .. var_20_6
	self.page = GuildTechnologyPage.PAGE_DEV_ITEM

	return
end

function GuildTechnologyPage:OnDestroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.frame, self._tf)

	return
end

return GuildTechnologyPage
