local var_0_0 = class("LimitChallengeCommanderFormationPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "CommanderFormationUI"
end

function var_0_0.OnInit(arg_2_0)
	setActive(arg_2_0.samllTF, true)

	arg_2_0.pos1 = arg_2_0.samllTF:Find("commander1")
	arg_2_0.pos2 = arg_2_0.samllTF:Find("commander2")

	setActive(arg_2_0.descPanel, false)

	arg_2_0.descFrameTF = arg_2_0.descPanel:Find("frame")
	arg_2_0.descPos1 = arg_2_0.descFrameTF:Find("commander1/frame/info")
	arg_2_0.descPos2 = arg_2_0.descFrameTF:Find("commander2/frame/info")
	arg_2_0.skillTFPos1 = arg_2_0.descFrameTF:Find("commander1/skill_info")
	arg_2_0.skillTFPos2 = arg_2_0.descFrameTF:Find("commander2/skill_info")
	arg_2_0.abilitysTF = UIItemList.New(arg_2_0.descFrameTF:Find("atttr_panel/abilitys/mask/content"), arg_2_0.descFrameTF:Find("atttr_panel/abilitys/mask/content/attr"))
	arg_2_0.talentsTF = UIItemList.New(arg_2_0.descFrameTF:Find("atttr_panel/talents/mask/content"), arg_2_0.descFrameTF:Find("atttr_panel/talents/mask/content/attr"))
	arg_2_0.abilityArr = arg_2_0.descPanel:Find("frame/atttr_panel/abilitys/arr")
	arg_2_0.talentsArr = arg_2_0.descPanel:Find("frame/atttr_panel/talents/arr")
	arg_2_0.restAllBtn = arg_2_0.descFrameTF:Find("rest_all")

	setActive(arg_2_0.restAllBtn, false)

	arg_2_0.quickBtn = arg_2_0.descFrameTF:Find("quick_btn")

	setActive(arg_2_0.quickBtn, false)
	onButton(arg_2_0, arg_2_0.samllTF, function()
		arg_2_0:openDescPanel()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.descPanel, function()
		arg_2_0:closeDescPanel()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Update(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.fleet = arg_5_1
	arg_5_0.prefabFleets = arg_5_2

	local var_5_0 = arg_5_0.fleet:getCommanders()

	for iter_5_0 = 1, CommanderConst.MAX_FORMATION_POS do
		assert(arg_5_0["pos" .. iter_5_0], "pos tf can not nil")
		arg_5_0:updateCommander(arg_5_0["pos" .. iter_5_0], iter_5_0, var_5_0[iter_5_0])
	end

	arg_5_0:updateDesc()

	return
end

function var_0_0.openDescPanel(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1 or 0.2

	if LeanTween.isTweening(go(arg_6_0.samllTF)) or LeanTween.isTweening(go(arg_6_0.descFrameTF)) then
		return
	end

	setAnchoredPosition(arg_6_0.samllTF, {
		x = 0
	})
	LeanTween.moveX(arg_6_0.samllTF, 800, var_6_0):setOnComplete(System.Action(function()
		setActive(arg_6_0.descPanel, true)
		arg_6_0:OverlayPanel(arg_6_0._tf)
		setAnchoredPosition(arg_6_0.descFrameTF, {
			x = 800
		})
		LeanTween.moveX(arg_6_0.descFrameTF, 0, var_6_0)

		return
	end))

	arg_6_0.contextData.inDescPage = true

	arg_6_0._tf:SetAsLastSibling()

	return
end

function var_0_0.closeDescPanel(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 or 0.2

	if LeanTween.isTweening(go(arg_8_0.samllTF)) or LeanTween.isTweening(go(arg_8_0.descFrameTF)) then
		return
	end

	setAnchoredPosition(arg_8_0.descFrameTF, {
		x = 0
	})
	LeanTween.moveX(arg_8_0.descFrameTF, 800, var_8_0):setOnComplete(System.Action(function()
		setActive(arg_8_0.descPanel, false)
		arg_8_0:UnOverlayPanel(arg_8_0._tf, arg_8_0._parentTf)
		setAnchoredPosition(arg_8_0.samllTF, {
			x = 800
		})
		LeanTween.moveX(arg_8_0.samllTF, 0, var_8_0)

		return
	end))

	arg_8_0.contextData.inDescPage = false

	return
end

function var_0_0.updateDesc(arg_10_0)
	local var_10_0 = arg_10_0.fleet:getCommanders()

	for iter_10_0 = 1, CommanderConst.MAX_FORMATION_POS do
		assert(arg_10_0["pos" .. iter_10_0], "pos tf can not nil")
		arg_10_0:updateCommander(arg_10_0["descPos" .. iter_10_0], iter_10_0, var_10_0[iter_10_0], true)
		arg_10_0:updateSkillTF(var_10_0[iter_10_0], arg_10_0["skillTFPos" .. iter_10_0])
	end

	arg_10_0:updateAdditions()

	return
end

function var_0_0.updateAdditions(arg_11_0)
	local var_11_0 = _.values(arg_11_0.fleet:getCommandersTalentDesc())
	local var_11_1, var_11_2 = arg_11_0.fleet:getCommandersAddition()

	arg_11_0.abilitysTF:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			setText(arg_12_2:Find("name"), AttributeType.Type2Name(var_11_1[arg_12_1 + 1].attrName))
			setText(arg_12_2:Find("Text"), ("+" .. math.floor(var_11_1[arg_12_1 + 1].value * 1000) / 1000) .. "%")
			GetImageSpriteFromAtlasAsync("attricon", var_11_1[arg_12_1 + 1].attrName, arg_12_2:Find("icon"), false)
			setImageAlpha(arg_12_2:Find("bg"), arg_12_1 % 2)
		end

		return
	end)
	arg_11_0.abilitysTF:align(#var_11_1)
	setActive(arg_11_0.abilityArr, #var_11_1 > 4)
	arg_11_0.talentsTF:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			local var_13_0 = var_11_0[arg_13_1 + 1]

			setScrollText(findTF(arg_13_2, "name_mask/name"), var_11_0[arg_13_1 + 1].name)
			setText(arg_13_2:Find("Text"), (var_13_0.value > 0 and "+" or "") .. var_13_0.value .. (var_13_0.type == CommanderConst.TALENT_ADDITION_RATIO and "%" or ""))
			setImageAlpha(arg_13_2:Find("bg"), arg_13_1 % 2)
		end

		return
	end)
	arg_11_0.talentsTF:align(#var_11_0)
	setActive(arg_11_0.talentsArr, #var_11_0 > 4)

	return
end

function var_0_0.updateSkillTF(arg_14_0, arg_14_1, arg_14_2)
	setActive(arg_14_2, arg_14_1)

	if arg_14_1 then
		local var_14_0 = arg_14_1:getSkills()[1]

		GetImageSpriteFromAtlasAsync("CommanderSkillIcon/" .. var_14_0:getConfig("icon"), "", arg_14_2:Find("icon"))
		setText(arg_14_2:Find("level"), "Lv." .. var_14_0:getLevel())
		onButton(arg_14_0, arg_14_2, function()
			arg_14_0:emit(LimitChallengePreCombatMediator.ON_CMD_SKILL, var_14_0)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_14_2)
	end

	return
end

function var_0_0.updateCommander(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = arg_16_1:Find("add")
	local var_16_1 = arg_16_1:Find("info")

	if arg_16_3 then
		GetImageSpriteFromAtlasAsync("CommanderHrz/" .. arg_16_3:getPainting(), "", (arg_16_1:Find("info/mask/icon")))

		local var_16_2 = arg_16_1:Find("info/name")

		if var_16_2 then
			setText(var_16_2, arg_16_3:getName())
		end

		setImageSprite(arg_16_1:Find("info/frame"), GetSpriteFromAtlas("weaponframes", "commander_" .. Commander.rarity2Frame(arg_16_3:getRarity())))
	end

	if arg_16_4 then
		onButton(arg_16_0, var_16_1, function()
			arg_16_0:emit(LimitChallengePreCombatMediator.ON_SELECT_COMMANDER, arg_16_2, arg_16_0.fleet.id)

			return
		end, SFX_PANEL)
		onButton(arg_16_0, var_16_0, function()
			arg_16_0:emit(LimitChallengePreCombatMediator.ON_SELECT_COMMANDER, arg_16_2, arg_16_0.fleet.id)

			return
		end, SFX_PANEL)
	end

	setActive(var_16_0, not arg_16_3)
	setActive(var_16_1, arg_16_3)

	return
end

function var_0_0.OnDestroy(arg_19_0)
	if arg_19_0:isShowing() then
		LeanTween.cancel(go(arg_19_0.samllTF))
		LeanTween.cancel(go(arg_19_0.descFrameTF))

		if isActive(arg_19_0.descPanel) then
			arg_19_0:UnOverlayPanel(arg_19_0._tf, arg_19_0._parentTf)
		end
	end

	return
end

return var_0_0
