local NewEducateInfoPanel = class("NewEducateInfoPanel", import("view.base.BaseSubView"))

function NewEducateInfoPanel:getUIName()
	return "NewEducateInfoPanel"
end

function NewEducateInfoPanel:OnLoaded()
	self.foldPanelTF = self._tf:Find("fold_panel")
	self.showBtn = self.foldPanelTF:Find("show_btn")
	self.showPanelTF = self._tf:Find("show_panel")
	self.showAnim = self.showPanelTF:GetComponent(typeof(Animation))
	self.showAnimEvent = self.showPanelTF:GetComponent(typeof(DftAniEvent))

	self.showAnimEvent:SetEndEvent(function()
		setActive(self.showPanelTF, false)

		return
	end)

	self.blurBg = self.showPanelTF:Find("content")
	self.foldBtn = self.showPanelTF:Find("fold_btn")
	self.contnetTF = self.showPanelTF:Find("content")

	setText(self.contnetTF:Find("personality/personality_title/Text"), i18n("child2_personality_title"))

	self.personalityTF = self.contnetTF:Find("personality/personality")
	self.personalityValueTF = self.personalityTF:Find("slider/handle/Image/bubble/Text")

	setText(self.contnetTF:Find("attrs/attr_title/Text"), i18n("child2_attr_title"))

	local var_2_0 = self.contnetTF:Find("attrs/attrs/content")

	self.gradientBgTF = self.contnetTF:Find("attrs/attrs/bg_gradient")
	self.attrUIList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))

	setText(self.contnetTF:Find("talent/talent_title/Text"), i18n("child2_talent_title"))

	local var_2_1 = self.contnetTF:Find("talent/talents/content")

	self.talentUIList = UIItemList.New(var_2_1, var_2_1:Find("tpl"))
	self.statusTF = self.contnetTF:Find("status")

	setText(self.statusTF:Find("status_title/Text"), i18n("child2_status_title"))

	local var_2_2 = self.statusTF:Find("status/content/content")

	self.statusUIList = UIItemList.New(var_2_2, var_2_2:Find("tpl"))
	self.tarotTF = self.contnetTF:Find("tarot")

	setText(self.tarotTF:Find("title/Text"), i18n("child2_tarot_title"))

	self.tarotIconTF = self.tarotTF:Find("bg/icon")
	self.tarotNameTF = self.tarotTF:Find("bg/name")
	self.tarotEntryTF = self.tarotTF:Find("bg/entry")
	self.attrIds = self.contextData.char:GetAttrIds()
	self.talentRoundIds = self.contextData.char:GetRoundData():GetTalentRoundIds()

	return
end

function NewEducateInfoPanel:OnInit()
	LoadImageSpriteAsync("neweducateicon/" .. self.contextData.char:getConfig("child2_data_personality_icon")[1], self.personalityTF:Find("slider/handle/Image"), true)
	LoadImageSpriteAsync("neweducateicon/" .. self.contextData.char:getConfig("personality_bar_icon"), self.personalityTF, true)
	onButton(self, self.showBtn, function()
		self:ShowPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.foldBtn, function()
		self:HidePanel()

		return
	end, SFX_PANEL)
	onButton(self, self.tarotTF:Find("bg"), function()
		self:emit(NewEducateBaseUI.GO_SUBLAYER, Context.New({
			mediator = NewEducateTarotEntryMediator,
			viewComponent = NewEducateTarotEntryLayer,
			data = {
				inShop = self.inShop
			}
		}))

		return
	end, SFX_PANEL)
	self.attrUIList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventInit then
			LoadImageSpriteAsync("neweducateicon/" .. pg.child2_attr[self.attrIds[arg_8_1 + 1]].icon, arg_8_2:Find("icon_bg/icon"))
			setScrollText(arg_8_2:Find("name_mask/name"), pg.child2_attr[self.attrIds[arg_8_1 + 1]].name)
		elseif arg_8_0 == UIItemList.EventUpdate then
			self:OnUpdateAttrItem(arg_8_1, arg_8_2)
		end

		return
	end)
	self.talentUIList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			self:OnUpdateTalentItem(arg_9_1, arg_9_2)
		end

		return
	end)
	self.statusUIList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			self:OnUpdateStatusItem(arg_10_1, arg_10_2)
		end

		return
	end)
	self:OverlayPanel(self._tf, {
		groupDelta = -1,
		pbList = {
			self.blurBg
		}
	})
	setActive(self.foldPanelTF, true)
	setActive(self.showPanelTF, false)

	if self.contextData.hide then
		self:HidePanel()
	elseif self.contextData.isMainEnter then
		onDelayTick(function()
			self:ShowPanel()

			return
		end, 0.396)
	else
		self:ShowPanel()
	end

	self.isTarotChar = self.contextData.char:GetPermanentData():IsTarotType()

	setActive(self.tarotTF, self.isTarotChar)
	setActive(self.statusTF, not self.isTarotChar)
	self:Flush()

	return
end

function NewEducateInfoPanel:IsShowPanel()
	return isActive(self.showPanelTF)
end

function NewEducateInfoPanel:ShowPanel()
	setActive(self.foldPanelTF, false)
	setActive(self.showPanelTF, true)

	return
end

function NewEducateInfoPanel:HidePanel(arg_14_1)
	setActive(self.foldPanelTF, true)

	if not arg_14_1 then
		self.showAnim:Play("anim_educate_archive_show_out")
	else
		setActive(self.showPanelTF, false)
	end

	eachChild(self.talentUIList.container, function(arg_15_0)
		triggerToggle(arg_15_0:Find("unlock"), false)

		return
	end)
	eachChild(self.statusUIList.container, function(arg_16_0)
		triggerToggle(arg_16_0, false)

		return
	end)

	return
end

function NewEducateInfoPanel:OnUpdateAttrItem(arg_17_1, arg_17_2)
	local var_17_0, var_17_1 = NewEducateInfoPanel.GetArrtInfo(pg.child2_attr[self.attrIds[arg_17_1 + 1]].rank, (self.contextData.char:GetAttr(self.attrIds[arg_17_1 + 1])))

	setText(arg_17_2:Find("rank/Text"), var_17_0)
	setText(arg_17_2:Find("value"), var_17_1)
	setImageColor(self.gradientBgTF:GetChild(arg_17_1), Color.NewHex(EducateConst.GRADE_2_COLOR[var_17_0][1]))
	setImageColor(arg_17_2:Find("rank"), Color.NewHex(EducateConst.GRADE_2_COLOR[var_17_0][2]))
	setToggleEnabled(arg_17_2, self.isTarotChar)

	if self.isTarotChar then
		setText(arg_17_2:Find("info/content/name"), pg.child2_attr[self.attrIds[arg_17_1 + 1]].name)
		setText(arg_17_2:Find("info/content/value"), var_17_1)

		local var_17_2, var_17_3 = self.contextData.char:GetBenefitData():GetDisplayPctByDrop({
			type = NewEducateConst.DROP_TYPE.ATTR,
			id = self.attrIds[arg_17_1 + 1]
		})

		setText(arg_17_2:Find("info/content/desc"), i18n("child2_benefit_summary") .. var_17_2 .. "%" .. "\n" .. i18n("child2_benefit_summary2") .. var_17_3 .. "%")
	end

	return
end

function NewEducateInfoPanel:OnUpdateTalentItem(arg_18_1, arg_18_2)
	setActive(arg_18_2:Find("unlock"), self.talents[arg_18_1 + 1])
	setActive(arg_18_2:Find("lock"), not self.talents[arg_18_1 + 1])

	if self.talents[arg_18_1 + 1] then
		LoadImageSpriteAsync("neweducateicon/" .. self.talents[arg_18_1 + 1]:getConfig("item_icon_little"), arg_18_2:Find("unlock/icon"))
		setText(arg_18_2:Find("unlock/name"), shortenString(self.talents[arg_18_1 + 1]:getConfig("name"), 5))
		setText(arg_18_2:Find("unlock/info/content/name"), self.talents[arg_18_1 + 1]:getConfig("name"))
		setText(arg_18_2:Find("unlock/info/content/desc"), self.talents[arg_18_1 + 1]:getConfig("desc"))
	end

	local var_18_0 = self.talentRoundIds[arg_18_1 + 1]

	onButton(self, arg_18_2:Find("lock"), function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("child2_talent_unlock_tip", var_18_0))

		return
	end, SFX_PANEL)
	onScroll(self, self.statusTF:Find("status"), function(arg_20_0)
		eachChild(self.statusUIList.container, function(arg_21_0)
			triggerToggle(arg_21_0, false)

			return
		end)

		return
	end)

	return
end

function NewEducateInfoPanel:OnUpdateStatusItem(arg_22_1, arg_22_2)
	local var_22_0 = self.status[arg_22_1 + 1]

	if arg_22_2.name ~= tostring(self.status[arg_22_1 + 1].id) then
		arg_22_2.name = var_22_0.id

		LoadImageSpriteAsync("neweducateicon/" .. var_22_0:getConfig("item_icon"), arg_22_2:Find("icon"))
	end

	setText(arg_22_2:Find("time/Text"), var_22_0:getConfig("during_time") == -1 and i18n("child2_status_time2") or i18n("child2_status_time1", var_22_0:GetEndRound() - self.contextData.char:GetRoundData().round))
	setText(arg_22_2:Find("info/content/name"), var_22_0:getConfig("name"))
	setText(arg_22_2:Find("info/content/desc"), var_22_0:getConfig("desc"))

	return
end

function NewEducateInfoPanel:Flush()
	self:FlushAttrs()
	self:FlushTalents()
	self:FlushStatus()
	self:FlushTarot()

	return
end

function NewEducateInfoPanel:FlushAttrs()
	local var_24_0 = self.contextData.char:GetPersonalityMiddle()
	local var_24_1 = self.contextData.char:GetPersonalityTag()
	local var_24_2 = self.contextData.char:GetPersonality()

	setSlider(self.personalityTF:Find("slider"), -var_24_0, var_24_0, var_24_2 - var_24_0)
	setText(self.personalityValueTF, math.abs(var_24_2 - var_24_0))
	setTextColor(self.personalityValueTF, Color.NewHex(var_24_1 == "tag1" and "26b1f3" or "ff6767"))
	self.attrUIList:align(#self.attrIds)

	return
end

function NewEducateInfoPanel:FlushTalents()
	self.talents = self.contextData.char:GetTalentList()

	self.talentUIList:align(#self.talentRoundIds)

	return
end

function NewEducateInfoPanel:FlushStatus()
	self.status = self.contextData.char:GetStatusList()

	self.statusUIList:align(#self.status)

	return
end

function NewEducateInfoPanel:FlushTarot()
	self.tarotId = self.contextData.char:GetTarotId()

	setActive(self.tarotIconTF, self.tarotId)

	if self.tarotId then
		LoadImageSpriteAsync("neweducateicon/" .. pg.child2_benefit_list[self.tarotId].item_icon_little, self.tarotIconTF)
	end

	setText(self.tarotNameTF, (self.tarotId or nil) and (pg.child2_benefit_list[self.tarotId].name or "EMPTY"))

	self.entries = self.contextData.char:GetBenefitData():GetListByType(NewEducateBuff.TYPE.ENTRY)

	setText(self.tarotEntryTF, i18n("child2_entry_summary") .. #self.entries)

	return
end

function NewEducateInfoPanel:SetShopOpen(arg_28_1)
	self.inShop = arg_28_1

	return
end

function NewEducateInfoPanel:OnDestroy()
	self:UnOverlayPanel(self._tf)

	return
end

function NewEducateInfoPanel:GetArrtInfo(arg_30_1)
	for iter_30_0, iter_30_1 in ipairs(self) do
		if arg_30_1 >= iter_30_1[1][1] and arg_30_1 < iter_30_1[1][2] then
			return iter_30_1[2], arg_30_1 .. "/" .. iter_30_1[1][2]
		end
	end

	return self[#self][2], arg_30_1 .. "/" .. self[#self][1][2]
end

return NewEducateInfoPanel
