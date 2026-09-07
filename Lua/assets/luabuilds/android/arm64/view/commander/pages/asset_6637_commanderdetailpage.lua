local CommanderDetailPage = class("CommanderDetailPage", import("...base.BaseSubView"))

function CommanderDetailPage:getUIName()
	return "CommanderDetailUI"
end

function CommanderDetailPage:Ctor(arg_2_1, arg_2_2, arg_2_3)
	CommanderDetailPage.super.Ctor(self, arg_2_1, arg_2_2, arg_2_3)
	self:Load()

	return
end

function CommanderDetailPage:RegisterEvent()
	self:bind(CommanderCatScene.EVENT_CLOSE_DESC, function(arg_4_0)
		triggerToggle(self.skillBtn, false)
		triggerToggle(self.additionBtn, false)
		triggerToggle(self.otherBtn, false)

		return
	end)
	self:bind(CommanderCatScene.EVENT_FOLD, function(arg_5_0, arg_5_1)
		triggerToggle(self.skillBtn, false)
		triggerToggle(self.additionBtn, false)
		triggerToggle(self.otherBtn, false)

		if arg_5_1 then
			LeanTween.moveY(rtf(self.commanderInfo), -400, 0.5)
		else
			LeanTween.moveY(rtf(self.commanderInfo), 71, 0.5)
		end

		return
	end)
	self:bind(CommanderCatScene.EVENT_PREVIEW, function(arg_6_0, arg_6_1)
		self:UpdatePreView(arg_6_1)

		return
	end)
	self:bind(CommanderCatScene.EVENT_PREVIEW_REVERSE, function(arg_7_0, arg_7_1, arg_7_2)
		self:UpdateReversePreView(arg_7_1, arg_7_2)

		return
	end)
	self:bind(CommanderCatScene.EVENT_PREVIEW_PLAY, function(arg_8_0, arg_8_1, arg_8_2)
		triggerToggle(self.skillBtn, true)
		triggerToggle(self.otherBtn, not (not arg_8_1 or #arg_8_1 <= 0 or arg_8_2))
		triggerToggle(self.additionBtn, false)
		setToggleEnabled(self.additionBtn, false)
		self:UpdatePreViewWithOther(arg_8_1)

		return
	end)
	self:bind(CommanderCatScene.EVENT_PREVIEW_ADDITION, function(arg_9_0, arg_9_1)
		triggerToggle(self.skillBtn, true)
		triggerToggle(self.additionBtn, true)
		self:UpdatePreviewAddition(arg_9_1)

		return
	end)
	self:bind(CommanderCatDockPage.ON_SORT, function(arg_10_0, arg_10_1)
		self:OnSort(arg_10_1)

		return
	end)

	return
end

function CommanderDetailPage:OnLoaded()
	self.statement = self._tf:Find("detail/statement")
	self.statement.localScale = Vector3(1, 0, 1)
	self.talentSkill = self._tf:Find("detail/talent_skill")

	local var_11_0 = self.talentSkill:Find("talent/content")

	self.talentList = UIItemList.New(var_11_0, var_11_0:GetChild(0))
	self.abilityAdditionTF = self.statement:Find("atttrs/content")
	self.talentAdditionTF = self.statement:Find("talents/scroll/content")
	self.talentAdditionList = UIItemList.New(self.talentAdditionTF, self.talentAdditionTF:GetChild(0))
	self.skillIcon = self.talentSkill:Find("skill/icon/Image")
	self.lockTF = self._tf:Find("info/lock")
	self.commanderInfo = self._tf:Find("info")
	self.expPanel = self.commanderInfo:Find("exp")
	self.commanderLevelTxt = self.commanderInfo:Find("exp/level"):GetComponent(typeof(Text))
	self.commanderExpImg = self.commanderInfo:Find("exp/Image"):GetComponent(typeof(Image))
	self.commanderNameTxt = self.commanderInfo:Find("name_bg/mask/Text"):GetComponent("ScrollText")
	self.modifyNameBtn = self.commanderInfo:Find("name_bg/modify")

	setActive(self.modifyNameBtn, pg.gameset.commander_rename_open.key_value == 1)

	self.line = self.commanderInfo:Find("line")
	self.fleetnums = self.commanderInfo:Find("line/numbers")
	self.fleetTF = self.commanderInfo:Find("line/fleet")
	self.subTF = self.commanderInfo:Find("line/sub_fleet")
	self.leisureTF = self.commanderInfo:Find("line/leisure")
	self.labelInBattleTF = self.commanderInfo:Find("line/inbattle")
	self.rarityImg = self.commanderInfo:Find("rarity"):GetComponent(typeof(Image))
	self.abilityTF = self.commanderInfo:Find("ablitys")
	self.skillBtn = self.commanderInfo:Find("skill_btn")
	self.additionBtn = self.commanderInfo:Find("addition_btn")
	self.otherBtn = self.commanderInfo:Find("other_btn")
	self.otherCommanderNameTxt = self._tf:Find("detail/other/name/Text"):GetComponent(typeof(Text))
	self.otherCommanderSkillImg = self._tf:Find("detail/other/skill/Image")
	self.otherCommanderTalentList = UIItemList.New(self._tf:Find("detail/other/talent"), self._tf:Find("detail/other/talent/tpl"))
	self.otherCommanderDescTxt = self._tf:Find("detail/other/desc/mask/Text"):GetComponent(typeof(ScrollText))
	self.blurPanel = self._parentTf.parent
	self.blurPanelParent = self.blurPanel.parent
	self.renamePanel = CommanderRenamePage.New(pg.UIMgr.GetInstance().OverlayMain, self.event)

	setText(self._tf:Find("detail/statement/atttrs/title/Text"), i18n("commander_subtile_ablity"))
	setText(self._tf:Find("detail/statement/talents/title/Text"), i18n("commander_subtile_talent"))

	return
end

function CommanderDetailPage:OnInit()
	self:RegisterEvent()

	self.isOnAddition = false
	self.isOnSkill = false

	onToggle(self, self.skillBtn, function(arg_13_0)
		self.isOnSkill = arg_13_0

		self:Blur()

		if arg_13_0 then
			self:emit(CommanderCatScene.EVENT_OPEN_DESC)
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.additionBtn, function(arg_14_0)
		self.isOnAddition = arg_14_0
		self.statement.localScale = arg_14_0 and Vector3(1, 1, 1) or Vector3(1, 0, 1)

		self:Blur()

		if arg_14_0 then
			self:emit(CommanderCatScene.EVENT_OPEN_DESC)
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.otherBtn, function(arg_15_0)
		self.isOnOther = arg_15_0

		self:Blur()

		if arg_15_0 then
			self:emit(CommanderCatScene.EVENT_OPEN_DESC)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.modifyNameBtn, function()
		if not self.commanderVO:canModifyName() then
			self.contextData.msgBox:ExecuteAction("Show", {
				content = i18n("commander_rename_coldtime_tip", (self.commanderVO:getRenameTimeDesc()))
			})
		else
			self.renamePanel:ExecuteAction("Show", self.commanderVO)
		end

		return
	end, SFX_PANEL)

	return
end

function CommanderDetailPage:Update(arg_17_1, arg_17_2)
	self.commanderVO = arg_17_1

	self:UpdateInfo()
	self:UpdateTalents()
	self:UpdateSkills()
	self:UpdateAbilityAddition()
	self:UpdateTalentAddition()
	self:UpdateAbilitys()
	self:UpdateLockState()
	self:UpdateLevel()
	self:UpdateStyle(arg_17_2)
	self._tf:SetAsFirstSibling()
	self:Show()

	return
end

function CommanderDetailPage:UpdateLockState()
	local var_18_0 = self.commanderVO:getLock()

	setActive(self.lockTF:Find("image"), var_18_0 == 0)
	onButton(self, self.lockTF, function()
		self:emit(CommanderCatMediator.LOCK, self.commanderVO.id, 1 - var_18_0)

		return
	end, SFX_PANEL)

	return
end

function CommanderDetailPage:UpdateStyle(arg_20_1)
	if arg_20_1 then
		triggerToggle(self.skillBtn, true)
		triggerToggle(self.additionBtn, true)
		setActive(self.lockTF, false)
	end

	setButtonEnabled(self.modifyNameBtn, not arg_20_1)

	return
end

function CommanderDetailPage:UpdateInfo()
	local var_21_0 = self.commanderVO
	local var_21_1 = Commander.rarity2Print(self.commanderVO:getRarity())

	if self.rarityPrint ~= var_21_1 then
		LoadImageSpriteAsync("CommanderRarity/" .. var_21_1, self.rarityImg, true)

		self.rarityPrint = var_21_1
	end

	eachChild(self.fleetnums, function(arg_22_0)
		setActive(arg_22_0, go(arg_22_0).name == tostring(var_21_0.fleetId or ""))

		return
	end)

	local var_21_2 = var_21_0.fleetId and (not var_21_0.inBattle and var_21_0.sub or false)
	local var_21_3

	var_21_3.sizeDelta = Vector2(var_21_2 and 260 or 200, self.line.sizeDelta.y)

	setActive(self.subTF, var_21_2)
	setActive(self.fleetTF, var_21_0.fleetId and not var_21_0.inBattle and not var_21_0.sub)
	setActive(self.leisureTF, not var_21_0.inFleet and not var_21_0.inBattle)
	setActive(self.labelInBattleTF, var_21_0.inBattle)
	self.commanderNameTxt:SetText(self.commanderVO:getName((defaultValue(self.forceDefaultName, false))))

	return
end

function CommanderDetailPage:OnSort(arg_23_1)
	self.forceDefaultName = not arg_23_1

	self.commanderNameTxt:SetText(self.commanderVO:getName(not arg_23_1))

	return
end

function CommanderDetailPage:UpdatePreView(arg_24_1)
	self:UpdateAbilitys(arg_24_1)
	self:UpdatePreviewAddition(arg_24_1)
	self:UpdateLevel(arg_24_1)

	return
end

function CommanderDetailPage:UpdateReversePreView(arg_25_1, arg_25_2)
	self:_UpdateAbilitys(arg_25_2, arg_25_1)
	self:_UpdateAbilityAddition(arg_25_2, arg_25_1)
	self:_UpdateTalentAddition(arg_25_2)
	self:UpdateLevel(arg_25_2)

	return
end

function CommanderDetailPage:UpdatePreViewWithOther(arg_26_1)
	if not arg_26_1 or #arg_26_1 <= 0 then
		return
	end

	local var_26_0 = Clone(self.commanderVO)

	var_26_0:addExp((CommanderCatUtil.GetSkillExpAndCommanderExp(var_26_0, arg_26_1)))
	self:UpdateOtherCommander((getProxy(CommanderProxy):getCommanderById(arg_26_1[#arg_26_1])))
	self:UpdateLevel(var_26_0)
	self:UpdateAbilitys(var_26_0)

	return
end

function CommanderDetailPage:UpdatePreviewAddition(arg_27_1)
	self:UpdateAbilityAddition(arg_27_1)
	self:UpdateTalentAddition()

	return
end

function CommanderDetailPage:UpdateOtherCommander(arg_28_1)
	self.otherCommanderNameTxt.text = arg_28_1:getName()

	local var_28_0 = arg_28_1:GetDisplayTalents()

	GetImageSpriteFromAtlasAsync("commanderskillicon/" .. arg_28_1:getSkills()[1]:getConfig("icon"), "", self.otherCommanderSkillImg)
	self.otherCommanderTalentList:make(function(arg_29_0, arg_29_1, arg_29_2)
		if arg_29_0 == UIItemList.EventUpdate then
			setText(arg_29_2:Find("Text"), "")

			local var_29_0 = var_28_0[arg_29_1 + 1]

			if var_28_0[arg_29_1 + 1] then
				self:UpdateTalent(arg_28_1, var_29_0, arg_29_2)
				onToggle(self, arg_29_2, function(arg_30_0)
					if arg_30_0 then
						self.otherCommanderDescTxt:SetText(var_29_0:getConfig("desc"))
					end

					return
				end, SFX_PANEL)

				if arg_29_1 == 0 then
					triggerToggle(arg_29_2, true)
				end
			end

			setActive(arg_29_2:Find("empty"), var_29_0 == nil)

			arg_29_2:GetComponent(typeof(Image)).enabled = var_29_0 ~= nil

			setActive(arg_29_2:Find("lock"), var_29_0 and not arg_28_1:IsLearnedTalent(var_29_0.id))
		end

		return
	end)
	self.otherCommanderTalentList:align(5)

	return
end

function CommanderDetailPage:UpdateLevel(arg_31_1)
	local var_31_0 = arg_31_1 or self.commanderVO

	self.commanderLevelTxt.text = setColorStr("LV." .. var_31_0.level, (arg_31_1 and arg_31_1.level > self.commanderVO.level or nil) and (COLOR_GREEN or COLOR_WHITE))
	self.commanderExpImg.fillAmount = var_31_0:isMaxLevel() and 1 or var_31_0.exp / var_31_0:getNextLevelExp()

	return
end

function CommanderDetailPage:UpdateAbilitys(arg_32_1)
	self:_UpdateAbilitys(self.commanderVO, arg_32_1)

	return
end

function CommanderDetailPage:_UpdateAbilitys(arg_33_1, arg_33_2)
	local var_33_0

	if arg_33_2 then
		var_33_0 = arg_33_2:getAbilitys()
	end

	for iter_33_0, iter_33_1 in pairs((arg_33_1:getAbilitys())) do
		local var_33_1 = self.abilityTF:Find(iter_33_0)
		local var_33_2

		if var_33_0 then
			var_33_2 = var_33_0[iter_33_0].value - iter_33_1.value

			if var_33_0[iter_33_0].value - iter_33_1.value <= 0 then
				var_33_2 = nil
			end
		end

		local var_33_3 = var_33_2 and setColorStr("+" .. var_33_2, COLOR_GREEN) or " "

		setText(var_33_1:Find("add/base"), iter_33_1.value)
		setText(var_33_1:Find("add"), var_33_3)
	end

	return
end

function CommanderDetailPage:UpdateAbilityAddition(arg_34_1)
	self:_UpdateAbilityAddition(self.commanderVO, arg_34_1)

	return
end

function CommanderDetailPage:_UpdateAbilityAddition(arg_35_1, arg_35_2)
	local var_35_0

	if arg_35_2 then
		var_35_0 = arg_35_2:getAbilitysAddition()
	end

	local var_35_1 = 0

	for iter_35_0, iter_35_1 in pairs((arg_35_1:getAbilitysAddition())) do
		if iter_35_1 > 0 then
			local var_35_2 = self.abilityAdditionTF:GetChild(var_35_1)

			GetImageSpriteFromAtlasAsync("attricon", iter_35_0, var_35_2:Find("bg/icon"), false)
			setText(var_35_2:Find("bg/name"), AttributeType.Type2Name(iter_35_0))

			local var_35_3 = string.format("%0.3f", iter_35_1)

			setText(var_35_2:Find("bg/value"), ("+" .. math.floor(iter_35_1 * 1000) / 1000) .. "%")

			local var_35_4

			if var_35_0 then
				var_35_4 = var_35_0[iter_35_0] or iter_35_1
			end

			setActive(var_35_2:Find("up"), var_35_4 < iter_35_1)
			setActive(var_35_2:Find("down"), iter_35_1 < var_35_4)

			var_35_1 = var_35_1 + 1
		end
	end

	return
end

function CommanderDetailPage:UpdateTalents()
	local var_36_0 = self.commanderVO
	local var_36_1 = self.commanderVO:GetDisplayTalents()

	self.talentList:make(function(arg_37_0, arg_37_1, arg_37_2)
		if arg_37_0 == UIItemList.EventUpdate then
			self:UpdateTalent(var_36_0, var_36_1[arg_37_1 + 1], arg_37_2)
		end

		return
	end)
	self.talentList:align(#var_36_1)

	return
end

function CommanderDetailPage:UpdateTalent(arg_38_1, arg_38_2, arg_38_3)
	setText(arg_38_3:Find("Text"), arg_38_2:getConfig("name"))
	GetImageSpriteFromAtlasAsync("CommanderTalentIcon/" .. arg_38_2:getConfig("icon"), "", arg_38_3)

	if arg_38_3:GetComponent(typeof(Button)) then
		onButton(self, arg_38_3, function()
			self.contextData.treePanel:ExecuteAction("Show", arg_38_2)

			return
		end, SFX_PANEL)
	end

	setActive(arg_38_3:Find("lock"), not arg_38_1:IsLearnedTalent(arg_38_2.id))

	return
end

function CommanderDetailPage:UpdateTalentAddition()
	self:_UpdateTalentAddition(self.commanderVO)

	return
end

function CommanderDetailPage:_UpdateTalentAddition(arg_41_1)
	local var_41_1 = _.values(arg_41_1:getTalentsDesc())

	self.talentAdditionList:make(function(arg_42_0, arg_42_1, arg_42_2)
		if arg_42_0 == UIItemList.EventUpdate then
			local var_42_0 = var_41_1[arg_42_1 + 1]

			setScrollText(findTF(arg_42_2, "bg/name_mask/name"), var_41_1[arg_42_1 + 1].name)
			setText(arg_42_2:Find("bg/value"), (var_42_0.value > 0 and "+" or "") .. var_42_0.value .. (var_42_0.type == CommanderConst.TALENT_ADDITION_RATIO and "%" or ""))
			setActive(arg_42_2:Find("up"), false)
			setActive(arg_42_2:Find("down"), false)

			arg_42_2:Find("bg"):GetComponent(typeof(Image)).enabled = arg_42_1 % 2 ~= 0
		end

		return
	end)
	self.talentAdditionList:align(#var_41_1)

	return
end

function CommanderDetailPage:UpdateSkills()
	local var_43_0 = self.commanderVO:getSkills()[1]

	GetImageSpriteFromAtlasAsync("commanderskillicon/" .. var_43_0:getConfig("icon"), "", self.skillIcon)
	onButton(self, self.skillIcon, function()
		self:emit(CommanderCatMediator.SKILL_INFO, var_43_0)

		return
	end, SFX_PANEL)

	return
end

function CommanderDetailPage:CanBack()
	if self.renamePanel and self.renamePanel:GetLoaded() and self.renamePanel:isShowing() then
		self.renamePanel:Hide()

		return false
	end

	return true
end

function CommanderDetailPage:OnDestroy()
	if self.isBlur then
		pg.UIMgr.GetInstance():UnOverlayPanel(self.blurPanel, self.blurPanelParent)
	end

	if self.renamePanel then
		self.renamePanel:Destroy()

		self.renamePanel = nil
	end

	return
end

function CommanderDetailPage:Blur()
	if self.isOnAddition or self.isOnSkill or self.isOnOther then
		self.isBlur = true

		pg.UIMgr.GetInstance():BlurPanel(self.blurPanel)
	else
		self.isBlur = false

		pg.UIMgr.GetInstance():UnOverlayPanel(self.blurPanel, self.blurPanelParent)
	end

	return
end

return CommanderDetailPage
