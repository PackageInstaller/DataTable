local var_0_0 = class("CommanderDetailPage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "CommanderDetailUI"
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.super.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:Load()

	return
end

function var_0_0.RegisterEvent(arg_3_0)
	arg_3_0:bind(CommanderCatScene.EVENT_CLOSE_DESC, function(arg_4_0)
		triggerToggle(arg_3_0.skillBtn, false)
		triggerToggle(arg_3_0.additionBtn, false)
		triggerToggle(arg_3_0.otherBtn, false)

		return
	end)
	arg_3_0:bind(CommanderCatScene.EVENT_FOLD, function(arg_5_0, arg_5_1)
		triggerToggle(arg_3_0.skillBtn, false)
		triggerToggle(arg_3_0.additionBtn, false)
		triggerToggle(arg_3_0.otherBtn, false)

		if arg_5_1 then
			LeanTween.moveY(rtf(arg_3_0.commanderInfo), -400, 0.5)
		else
			LeanTween.moveY(rtf(arg_3_0.commanderInfo), 71, 0.5)
		end

		return
	end)
	arg_3_0:bind(CommanderCatScene.EVENT_PREVIEW, function(arg_6_0, arg_6_1)
		arg_3_0:UpdatePreView(arg_6_1)

		return
	end)
	arg_3_0:bind(CommanderCatScene.EVENT_PREVIEW_REVERSE, function(arg_7_0, arg_7_1, arg_7_2)
		arg_3_0:UpdateReversePreView(arg_7_1, arg_7_2)

		return
	end)
	arg_3_0:bind(CommanderCatScene.EVENT_PREVIEW_PLAY, function(arg_8_0, arg_8_1, arg_8_2)
		triggerToggle(arg_3_0.skillBtn, true)
		triggerToggle(arg_3_0.otherBtn, not (not arg_8_1 or #arg_8_1 <= 0 or arg_8_2))
		triggerToggle(arg_3_0.additionBtn, false)
		setToggleEnabled(arg_3_0.additionBtn, false)
		arg_3_0:UpdatePreViewWithOther(arg_8_1)

		return
	end)
	arg_3_0:bind(CommanderCatScene.EVENT_PREVIEW_ADDITION, function(arg_9_0, arg_9_1)
		triggerToggle(arg_3_0.skillBtn, true)
		triggerToggle(arg_3_0.additionBtn, true)
		arg_3_0:UpdatePreviewAddition(arg_9_1)

		return
	end)
	arg_3_0:bind(CommanderCatDockPage.ON_SORT, function(arg_10_0, arg_10_1)
		arg_3_0:OnSort(arg_10_1)

		return
	end)

	return
end

function var_0_0.OnLoaded(arg_11_0)
	arg_11_0.statement = arg_11_0._tf:Find("detail/statement")
	arg_11_0.statement.localScale = Vector3(1, 0, 1)
	arg_11_0.talentSkill = arg_11_0._tf:Find("detail/talent_skill")

	local var_11_0 = arg_11_0.talentSkill:Find("talent/content")

	arg_11_0.talentList = UIItemList.New(var_11_0, var_11_0:GetChild(0))
	arg_11_0.abilityAdditionTF = arg_11_0.statement:Find("atttrs/content")
	arg_11_0.talentAdditionTF = arg_11_0.statement:Find("talents/scroll/content")
	arg_11_0.talentAdditionList = UIItemList.New(arg_11_0.talentAdditionTF, arg_11_0.talentAdditionTF:GetChild(0))
	arg_11_0.skillIcon = arg_11_0.talentSkill:Find("skill/icon/Image")
	arg_11_0.lockTF = arg_11_0._tf:Find("info/lock")
	arg_11_0.commanderInfo = arg_11_0._tf:Find("info")
	arg_11_0.expPanel = arg_11_0.commanderInfo:Find("exp")
	arg_11_0.commanderLevelTxt = arg_11_0.commanderInfo:Find("exp/level"):GetComponent(typeof(Text))
	arg_11_0.commanderExpImg = arg_11_0.commanderInfo:Find("exp/Image"):GetComponent(typeof(Image))
	arg_11_0.commanderNameTxt = arg_11_0.commanderInfo:Find("name_bg/mask/Text"):GetComponent("ScrollText")
	arg_11_0.modifyNameBtn = arg_11_0.commanderInfo:Find("name_bg/modify")

	setActive(arg_11_0.modifyNameBtn, pg.gameset.commander_rename_open.key_value == 1)

	arg_11_0.line = arg_11_0.commanderInfo:Find("line")
	arg_11_0.fleetnums = arg_11_0.commanderInfo:Find("line/numbers")
	arg_11_0.fleetTF = arg_11_0.commanderInfo:Find("line/fleet")
	arg_11_0.subTF = arg_11_0.commanderInfo:Find("line/sub_fleet")
	arg_11_0.leisureTF = arg_11_0.commanderInfo:Find("line/leisure")
	arg_11_0.labelInBattleTF = arg_11_0.commanderInfo:Find("line/inbattle")
	arg_11_0.rarityImg = arg_11_0.commanderInfo:Find("rarity"):GetComponent(typeof(Image))
	arg_11_0.abilityTF = arg_11_0.commanderInfo:Find("ablitys")
	arg_11_0.skillBtn = arg_11_0.commanderInfo:Find("skill_btn")
	arg_11_0.additionBtn = arg_11_0.commanderInfo:Find("addition_btn")
	arg_11_0.otherBtn = arg_11_0.commanderInfo:Find("other_btn")
	arg_11_0.otherCommanderNameTxt = arg_11_0._tf:Find("detail/other/name/Text"):GetComponent(typeof(Text))
	arg_11_0.otherCommanderSkillImg = arg_11_0._tf:Find("detail/other/skill/Image")
	arg_11_0.otherCommanderTalentList = UIItemList.New(arg_11_0._tf:Find("detail/other/talent"), arg_11_0._tf:Find("detail/other/talent/tpl"))
	arg_11_0.otherCommanderDescTxt = arg_11_0._tf:Find("detail/other/desc/mask/Text"):GetComponent(typeof(ScrollText))
	arg_11_0.blurPanel = arg_11_0._parentTf.parent
	arg_11_0.blurPanelParent = arg_11_0.blurPanel.parent
	arg_11_0.renamePanel = CommanderRenamePage.New(pg.UIMgr.GetInstance().OverlayMain, arg_11_0.event)

	setText(arg_11_0._tf:Find("detail/statement/atttrs/title/Text"), i18n("commander_subtile_ablity"))
	setText(arg_11_0._tf:Find("detail/statement/talents/title/Text"), i18n("commander_subtile_talent"))

	return
end

function var_0_0.OnInit(arg_12_0)
	arg_12_0:RegisterEvent()

	arg_12_0.isOnAddition = false
	arg_12_0.isOnSkill = false

	onToggle(arg_12_0, arg_12_0.skillBtn, function(arg_13_0)
		arg_12_0.isOnSkill = arg_13_0

		arg_12_0:Blur()

		if arg_13_0 then
			arg_12_0:emit(CommanderCatScene.EVENT_OPEN_DESC)
		end

		return
	end, SFX_PANEL)
	onToggle(arg_12_0, arg_12_0.additionBtn, function(arg_14_0)
		arg_12_0.isOnAddition = arg_14_0

		local var_14_0 = arg_12_0.statement

		var_14_0.localScale = arg_14_0 and Vector3(1, 1, 1) or Vector3(1, 0, 1)

		arg_12_0:Blur()

		if arg_14_0 then
			arg_12_0:emit(CommanderCatScene.EVENT_OPEN_DESC)
		end

		return
	end, SFX_PANEL)
	onToggle(arg_12_0, arg_12_0.otherBtn, function(arg_15_0)
		arg_12_0.isOnOther = arg_15_0

		arg_12_0:Blur()

		if arg_15_0 then
			arg_12_0:emit(CommanderCatScene.EVENT_OPEN_DESC)
		end

		return
	end, SFX_PANEL)
	onButton(arg_12_0, arg_12_0.modifyNameBtn, function()
		if not arg_12_0.commanderVO:canModifyName() then
			arg_12_0.contextData.msgBox:ExecuteAction("Show", {
				content = i18n("commander_rename_coldtime_tip", (arg_12_0.commanderVO:getRenameTimeDesc()))
			})
		else
			arg_12_0.renamePanel:ExecuteAction("Show", arg_12_0.commanderVO)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Update(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.commanderVO = arg_17_1

	arg_17_0:UpdateInfo()
	arg_17_0:UpdateTalents()
	arg_17_0:UpdateSkills()
	arg_17_0:UpdateAbilityAddition()
	arg_17_0:UpdateTalentAddition()
	arg_17_0:UpdateAbilitys()
	arg_17_0:UpdateLockState()
	arg_17_0:UpdateLevel()
	arg_17_0:UpdateStyle(arg_17_2)
	arg_17_0._tf:SetAsFirstSibling()
	arg_17_0:Show()

	return
end

function var_0_0.UpdateLockState(arg_18_0)
	setActive(arg_18_0.lockTF:Find("image"), arg_18_0.commanderVO:getLock() == 0)
	onButton(arg_18_0, arg_18_0.lockTF, function()
		arg_18_0:emit(CommanderCatMediator.LOCK, arg_18_0.commanderVO.id, 1 - var_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateStyle(arg_20_0, arg_20_1)
	if arg_20_1 then
		triggerToggle(arg_20_0.skillBtn, true)
		triggerToggle(arg_20_0.additionBtn, true)
		setActive(arg_20_0.lockTF, false)
	end

	setButtonEnabled(arg_20_0.modifyNameBtn, not arg_20_1)

	return
end

function var_0_0.UpdateInfo(arg_21_0)
	local var_21_0 = arg_21_0.commanderVO
	local var_21_1 = Commander.rarity2Print(arg_21_0.commanderVO:getRarity())

	if arg_21_0.rarityPrint ~= var_21_1 then
		LoadImageSpriteAsync("CommanderRarity/" .. var_21_1, arg_21_0.rarityImg, true)

		arg_21_0.rarityPrint = var_21_1
	end

	eachChild(arg_21_0.fleetnums, function(arg_22_0)
		local var_22_0 = arg_22_0
		local var_22_1 = go(arg_22_0).name
		local var_22_3 = var_21_0.fleetId or ""

		setActive(var_22_0, var_22_1 == var_22_2(var_22_3))

		return
	end)

	local var_21_2 = var_21_0.fleetId and (not var_21_0.inBattle and var_21_0.sub or false)
	local var_21_3

	if false then
		var_21_2 = true
		var_21_3 = arg_21_0.line
	end

	var_21_3.sizeDelta = Vector2(var_21_2 and 260 or 200, arg_21_0.line.sizeDelta.y)

	setActive(arg_21_0.subTF, var_21_2)

	local var_21_4 = var_21_0.fleetId and not var_21_0.inBattle and not var_21_0.sub

	setActive(arg_21_0.fleetTF, var_21_4)
	setActive(arg_21_0.leisureTF, not var_21_0.inFleet and not var_21_0.inBattle)
	setActive(arg_21_0.labelInBattleTF, var_21_0.inBattle)
	arg_21_0.commanderNameTxt:SetText(arg_21_0.commanderVO:getName((defaultValue(arg_21_0.forceDefaultName, false))))

	return
end

function var_0_0.OnSort(arg_23_0, arg_23_1)
	arg_23_0.forceDefaultName = not arg_23_1

	arg_23_0.commanderNameTxt:SetText(arg_23_0.commanderVO:getName(not arg_23_1))

	return
end

function var_0_0.UpdatePreView(arg_24_0, arg_24_1)
	arg_24_0:UpdateAbilitys(arg_24_1)
	arg_24_0:UpdatePreviewAddition(arg_24_1)
	arg_24_0:UpdateLevel(arg_24_1)

	return
end

function var_0_0.UpdateReversePreView(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:_UpdateAbilitys(arg_25_2, arg_25_1)
	arg_25_0:_UpdateAbilityAddition(arg_25_2, arg_25_1)
	arg_25_0:_UpdateTalentAddition(arg_25_2)
	arg_25_0:UpdateLevel(arg_25_2)

	return
end

function var_0_0.UpdatePreViewWithOther(arg_26_0, arg_26_1)
	if not arg_26_1 or #arg_26_1 <= 0 then
		return
	end

	local var_26_0 = Clone(arg_26_0.commanderVO)

	var_26_0:addExp((CommanderCatUtil.GetSkillExpAndCommanderExp(var_26_0, arg_26_1)))
	arg_26_0:UpdateOtherCommander((getProxy(CommanderProxy):getCommanderById(arg_26_1[#arg_26_1])))
	arg_26_0:UpdateLevel(var_26_0)
	arg_26_0:UpdateAbilitys(var_26_0)

	return
end

function var_0_0.UpdatePreviewAddition(arg_27_0, arg_27_1)
	arg_27_0:UpdateAbilityAddition(arg_27_1)
	arg_27_0:UpdateTalentAddition()

	return
end

function var_0_0.UpdateOtherCommander(arg_28_0, arg_28_1)
	arg_28_0.otherCommanderNameTxt.text = arg_28_1:getName()

	local var_28_0 = arg_28_1:GetDisplayTalents()

	GetImageSpriteFromAtlasAsync("commanderskillicon/" .. arg_28_1:getSkills()[1]:getConfig("icon"), "", arg_28_0.otherCommanderSkillImg)
	arg_28_0.otherCommanderTalentList:make(function(arg_29_0, arg_29_1, arg_29_2)
		if arg_29_0 == UIItemList.EventUpdate then
			setText(arg_29_2:Find("Text"), "")

			local var_29_0 = var_28_0[arg_29_1 + 1]

			if var_28_0[arg_29_1 + 1] then
				arg_28_0:UpdateTalent(arg_28_1, var_29_0, arg_29_2)
				onToggle(arg_28_0, arg_29_2, function(arg_30_0)
					if arg_30_0 then
						arg_28_0.otherCommanderDescTxt:SetText(var_29_0:getConfig("desc"))
					end

					return
				end, SFX_PANEL)

				if arg_29_1 == 0 then
					triggerToggle(arg_29_2, true)
				end
			end

			setActive(arg_29_2:Find("empty"), var_29_0 == nil)

			arg_29_2:GetComponent(typeof(Image)).enabled = var_29_0 ~= nil

			local var_29_1 = var_29_0 and not arg_28_1:IsLearnedTalent(var_29_0.id)

			setActive(arg_29_2:Find("lock"), var_29_1)
		end

		return
	end)
	arg_28_0.otherCommanderTalentList:align(5)

	return
end

function var_0_0.UpdateLevel(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_1 or arg_31_0.commanderVO

	if arg_31_1 and arg_31_1.level > arg_31_0.commanderVO.level then
		local var_31_1 = COLOR_GREEN or COLOR_WHITE

		arg_31_0.commanderLevelTxt.text = setColorStr("LV." .. var_31_0.level, var_31_1)
		arg_31_0.commanderExpImg.fillAmount = var_31_0:isMaxLevel() and 1 or var_31_0.exp / var_31_0:getNextLevelExp()

		return
	end
end

function var_0_0.UpdateAbilitys(arg_32_0, arg_32_1)
	arg_32_0:_UpdateAbilitys(arg_32_0.commanderVO, arg_32_1)

	return
end

function var_0_0._UpdateAbilitys(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0

	if arg_33_2 then
		var_33_0 = arg_33_2:getAbilitys()
	end

	for iter_33_0, iter_33_1 in pairs((arg_33_1:getAbilitys())) do
		local var_33_1 = arg_33_0.abilityTF:Find(iter_33_0)
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

function var_0_0.UpdateAbilityAddition(arg_34_0, arg_34_1)
	arg_34_0:_UpdateAbilityAddition(arg_34_0.commanderVO, arg_34_1)

	return
end

function var_0_0._UpdateAbilityAddition(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0

	if arg_35_2 then
		var_35_0 = arg_35_2:getAbilitysAddition()
	end

	local var_35_1 = 0

	for iter_35_0, iter_35_1 in pairs((arg_35_1:getAbilitysAddition())) do
		if iter_35_1 > 0 then
			local var_35_2 = arg_35_0.abilityAdditionTF:GetChild(var_35_1)

			GetImageSpriteFromAtlasAsync("attricon", iter_35_0, var_35_2:Find("bg/icon"), false)
			setText(var_35_2:Find("bg/name"), AttributeType.Type2Name(iter_35_0))

			local var_35_3 = string.format("%0.3f", iter_35_1)

			setText(var_35_2:Find("bg/value"), ("+" .. math.floor(iter_35_1 * 1000) / 1000) .. "%")

			if var_35_0 then
				local var_35_4 = var_35_0[iter_35_0] or iter_35_1

				setActive(var_35_2:Find("up"), var_35_4 < iter_35_1)
				setActive(var_35_2:Find("down"), iter_35_1 < var_35_4)

				var_35_1 = var_35_1 + 1
			end
		end
	end

	return
end

function var_0_0.UpdateTalents(arg_36_0)
	local var_36_0 = arg_36_0.commanderVO:GetDisplayTalents()

	arg_36_0.talentList:make(function(arg_37_0, arg_37_1, arg_37_2)
		if arg_37_0 == UIItemList.EventUpdate then
			arg_36_0:UpdateTalent(var_0, var_36_0[arg_37_1 + 1], arg_37_2)
		end

		return
	end)
	arg_36_0.talentList:align(#arg_36_0.commanderVO:GetDisplayTalents())

	return
end

function var_0_0.UpdateTalent(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	setText(arg_38_3:Find("Text"), arg_38_2:getConfig("name"))
	GetImageSpriteFromAtlasAsync("CommanderTalentIcon/" .. arg_38_2:getConfig("icon"), "", arg_38_3)

	if arg_38_3:GetComponent(typeof(Button)) then
		onButton(arg_38_0, arg_38_3, function()
			arg_38_0.contextData.treePanel:ExecuteAction("Show", arg_38_2)

			return
		end, SFX_PANEL)
	end

	setActive(arg_38_3:Find("lock"), not arg_38_1:IsLearnedTalent(arg_38_2.id))

	return
end

function var_0_0.UpdateTalentAddition(arg_40_0)
	arg_40_0:_UpdateTalentAddition(arg_40_0.commanderVO)

	return
end

function var_0_0._UpdateTalentAddition(arg_41_0, arg_41_1)
	local var_41_1 = _.values(arg_41_1:getTalentsDesc())

	arg_41_0.talentAdditionList:make(function(arg_42_0, arg_42_1, arg_42_2)
		if arg_42_0 == UIItemList.EventUpdate then
			local var_42_0 = var_41_1[arg_42_1 + 1]

			setScrollText(findTF(arg_42_2, "bg/name_mask/name"), var_41_1[arg_42_1 + 1].name)
			setText(arg_42_2:Find("bg/value"), (var_42_0.value > 0 and "+" or "") .. var_42_0.value .. (var_42_0.type == CommanderConst.TALENT_ADDITION_RATIO and "%" or ""))
			setActive(arg_42_2:Find("up"), false)
			setActive(arg_42_2:Find("down"), false)

			local var_42_1 = arg_42_2:Find("bg")

			var_42_1:GetComponent(typeof(Image)).enabled = arg_42_1 % 2 ~= 0
		end

		return
	end)
	arg_41_0.talentAdditionList:align(#_.values(arg_41_1:getTalentsDesc()))

	return
end

function var_0_0.UpdateSkills(arg_43_0)
	local var_43_0 = arg_43_0.commanderVO:getSkills()[1]

	GetImageSpriteFromAtlasAsync("commanderskillicon/" .. arg_43_0.commanderVO:getSkills()[1]:getConfig("icon"), "", arg_43_0.skillIcon)
	onButton(arg_43_0, arg_43_0.skillIcon, function()
		arg_43_0:emit(CommanderCatMediator.SKILL_INFO, var_43_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.CanBack(arg_45_0)
	if arg_45_0.renamePanel and arg_45_0.renamePanel:GetLoaded() and arg_45_0.renamePanel:isShowing() then
		arg_45_0.renamePanel:Hide()

		return false
	end

	return true
end

function var_0_0.OnDestroy(arg_46_0)
	if arg_46_0.isBlur then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_46_0.blurPanel, arg_46_0.blurPanelParent)
	end

	if arg_46_0.renamePanel then
		arg_46_0.renamePanel:Destroy()

		arg_46_0.renamePanel = nil
	end

	return
end

function var_0_0.Blur(arg_47_0)
	if arg_47_0.isOnAddition or arg_47_0.isOnSkill or arg_47_0.isOnOther then
		arg_47_0.isBlur = true

		pg.UIMgr.GetInstance():BlurPanel(arg_47_0.blurPanel)
	else
		arg_47_0.isBlur = false

		pg.UIMgr.GetInstance():UnOverlayPanel(arg_47_0.blurPanel, arg_47_0.blurPanelParent)
	end

	return
end

return var_0_0
