local var_0_0 = class("CommanderFormationPage", import("...base.BaseSubView"))

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
	arg_2_0.quickBtn = arg_2_0.descFrameTF:Find("quick_btn")
	arg_2_0.recordCommanders = {
		arg_2_0.recordPanel:Find("current/commanders/commander1/frame/info"),
		arg_2_0.recordPanel:Find("current/commanders/commander2/frame/info")
	}
	arg_2_0.reocrdSkills = {
		arg_2_0.recordPanel:Find("current/commanders/commander1/skill_info"),
		arg_2_0.recordPanel:Find("current/commanders/commander2/skill_info")
	}
	arg_2_0.recordList = UIItemList.New(arg_2_0.recordPanel:Find("record/content"), arg_2_0.recordPanel:Find("record/content/commanders"))

	onButton(arg_2_0, arg_2_0.samllTF, function()
		arg_2_0:openDescPanel()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.quickBtn, function()
		arg_2_0:OpenRecordPanel()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0._tf:Find("bg"), function()
		if isActive(arg_2_0.recordPanel) then
			arg_2_0:CloseRecordPanel()
		elseif isActive(arg_2_0.descPanel) then
			arg_2_0:closeDescPanel()
		end

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.restAllBtn, function()
		arg_2_0:emit(FormationMediator.COMMANDER_FORMATION_OP, {
			FleetType = LevelUIConst.FLEET_TYPE_SELECT,
			data = {
				type = LevelUIConst.COMMANDER_OP_REST_ALL
			},
			fleetId = arg_2_0.fleet.id
		})

		return
	end, SFX_PANEL)
	setText(arg_2_0.descPanel:Find("frame/atttr_panel/abilitys/title/Text"), i18n("commander_subtile_ablity"))
	setText(arg_2_0.descPanel:Find("frame/atttr_panel/talents/title/Text"), i18n("commander_subtile_talent"))
	setText(arg_2_0.recordPanel:Find("current/title/Text"), i18n("commander_formation_prefab_fleet"))

	return
end

function var_0_0.Update(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.fleet = arg_7_1
	arg_7_0.prefabFleets = arg_7_2

	local var_7_0 = arg_7_0.fleet:getCommanders()

	for iter_7_0 = 1, CommanderConst.MAX_FORMATION_POS do
		assert(arg_7_0["pos" .. iter_7_0], "pos tf can not nil")
		arg_7_0:updateCommander(arg_7_0["pos" .. iter_7_0], iter_7_0, var_7_0[iter_7_0])
	end

	arg_7_0:updateDesc()
	arg_7_0:updateRecordPanel()

	return
end

function var_0_0.openDescPanel(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 or 0.2

	if LeanTween.isTweening(go(arg_8_0.samllTF)) or LeanTween.isTweening(go(arg_8_0.descFrameTF)) then
		return
	end

	setAnchoredPosition(arg_8_0.samllTF, {
		x = 0
	})
	LeanTween.moveX(arg_8_0.samllTF, 800, var_8_0):setOnComplete(System.Action(function()
		setActive(arg_8_0.descPanel, true)
		setActive(arg_8_0.descBg, true)
		pg.UIMgr.GetInstance():OverlayPanel(arg_8_0._tf)
		setAnchoredPosition(arg_8_0.descFrameTF, {
			x = 800
		})
		LeanTween.moveX(arg_8_0.descFrameTF, 0, var_8_0)

		return
	end))

	arg_8_0.contextData.inDescPage = true

	return
end

function var_0_0.closeDescPanel(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1 or 0.2

	if LeanTween.isTweening(go(arg_10_0.samllTF)) or LeanTween.isTweening(go(arg_10_0.descFrameTF)) then
		return
	end

	setAnchoredPosition(arg_10_0.descFrameTF, {
		x = 0
	})
	LeanTween.moveX(arg_10_0.descFrameTF, 800, var_10_0):setOnComplete(System.Action(function()
		setActive(arg_10_0.descPanel, false)
		setActive(arg_10_0.descBg, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_10_0._tf, arg_10_0._parentTf)
		setAnchoredPosition(arg_10_0.samllTF, {
			x = 800
		})
		LeanTween.moveX(arg_10_0.samllTF, 0, var_10_0)

		return
	end))

	arg_10_0.contextData.inDescPage = false

	return
end

function var_0_0.updateDesc(arg_12_0)
	local var_12_0 = arg_12_0.fleet:getCommanders()

	for iter_12_0 = 1, CommanderConst.MAX_FORMATION_POS do
		assert(arg_12_0["pos" .. iter_12_0], "pos tf can not nil")
		arg_12_0:updateCommander(arg_12_0["descPos" .. iter_12_0], iter_12_0, var_12_0[iter_12_0], true)
		arg_12_0:updateSkillTF(var_12_0[iter_12_0], arg_12_0["skillTFPos" .. iter_12_0])
	end

	arg_12_0:updateAdditions()

	return
end

function var_0_0.updateAdditions(arg_13_0)
	local var_13_0 = _.values(arg_13_0.fleet:getCommandersTalentDesc())
	local var_13_1, var_13_2 = arg_13_0.fleet:getCommandersAddition()

	arg_13_0.abilitysTF:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			setText(arg_14_2:Find("name"), AttributeType.Type2Name(var_13_1[arg_14_1 + 1].attrName))
			setText(arg_14_2:Find("Text"), ("+" .. math.floor(var_13_1[arg_14_1 + 1].value * 1000) / 1000) .. "%")
			GetImageSpriteFromAtlasAsync("attricon", var_13_1[arg_14_1 + 1].attrName, arg_14_2:Find("icon"), false)
			setImageAlpha(arg_14_2:Find("bg"), arg_14_1 % 2)
		end

		return
	end)
	arg_13_0.abilitysTF:align(#var_13_1)
	setActive(arg_13_0.abilityArr, #var_13_1 > 4)
	arg_13_0.talentsTF:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			local var_15_0 = var_13_0[arg_15_1 + 1]

			setScrollText(findTF(arg_15_2, "name_mask/name"), var_13_0[arg_15_1 + 1].name)
			setText(arg_15_2:Find("Text"), (var_15_0.value > 0 and "+" or "") .. var_15_0.value .. (var_15_0.type == CommanderConst.TALENT_ADDITION_RATIO and "%" or ""))
			setImageAlpha(arg_15_2:Find("bg"), arg_15_1 % 2)
		end

		return
	end)
	arg_13_0.talentsTF:align(#var_13_0)
	setActive(arg_13_0.talentsArr, #var_13_0 > 4)
	Canvas.ForceUpdateCanvases()

	return
end

function var_0_0.updateSkillTF(arg_16_0, arg_16_1, arg_16_2)
	setActive(arg_16_2, arg_16_1)

	if arg_16_1 then
		local var_16_0 = arg_16_1:getSkills()[1]

		GetImageSpriteFromAtlasAsync("CommanderSkillIcon/" .. var_16_0:getConfig("icon"), "", arg_16_2:Find("icon"))
		setText(arg_16_2:Find("level"), "Lv." .. var_16_0:getLevel())
		onButton(arg_16_0, arg_16_2, function()
			arg_16_0:emit(FormationMediator.ON_CMD_SKILL, var_16_0)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_16_2)
	end

	return
end

function var_0_0.updateCommander(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = arg_18_1:Find("add")
	local var_18_1 = arg_18_1:Find("info")

	if arg_18_3 then
		GetImageSpriteFromAtlasAsync("CommanderHrz/" .. arg_18_3:getPainting(), "", (arg_18_1:Find("info/mask/icon")))

		local var_18_2 = arg_18_1:Find("info/name")

		if var_18_2 then
			setText(var_18_2, arg_18_3:getName())
		end

		setImageSprite(arg_18_1:Find("info/frame"), GetSpriteFromAtlas("weaponframes", "commander_" .. Commander.rarity2Frame(arg_18_3:getRarity())))
	end

	if arg_18_4 then
		onButton(arg_18_0, var_18_1, function()
			arg_18_0:emit(FormationMediator.ON_SELECT_COMMANDER, arg_18_2, arg_18_0.fleet.id)

			return
		end, SFX_PANEL)
		onButton(arg_18_0, var_18_0, function()
			arg_18_0:emit(FormationMediator.ON_SELECT_COMMANDER, arg_18_2, arg_18_0.fleet.id)

			return
		end, SFX_PANEL)
	end

	setActive(var_18_0, not arg_18_3)
	setActive(var_18_1, arg_18_3)

	return
end

function var_0_0.OpenRecordPanel(arg_21_0)
	setActive(arg_21_0.descFrameTF, false)
	setActive(arg_21_0.recordPanel, true)

	return
end

function var_0_0.updateRecordPanel(arg_22_0)
	local var_22_0 = arg_22_0.fleet:getCommanders()

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.recordCommanders) do
		arg_22_0:updateCommander(iter_22_1, iter_22_0, var_22_0[iter_22_0])
		arg_22_0:updateSkillTF(var_22_0[iter_22_0], arg_22_0.reocrdSkills[iter_22_0])
	end

	arg_22_0.recordList:make(function(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0 == UIItemList.EventUpdate then
			arg_22_0:UpdatePrefabFleet(arg_22_0.prefabFleets[arg_23_1 + 1], arg_23_2, var_22_0)
		end

		return
	end)
	arg_22_0.recordList:align(#arg_22_0.prefabFleets)

	return
end

function var_0_0.UpdatePrefabFleet(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_2:Find("fleet_name")
	local var_24_1 = arg_24_1:getName()

	onInputEndEdit(arg_24_0, var_24_0, function()
		arg_24_0:emit(FormationMediator.COMMANDER_FORMATION_OP, {
			FleetType = LevelUIConst.FLEET_TYPE_SELECT,
			data = {
				type = LevelUIConst.COMMANDER_OP_RENAME,
				id = arg_24_1.id,
				str = getInputText(var_24_0),
				onFailed = function()
					setInputText(var_24_0, var_24_1)

					return
				end
			},
			fleetId = arg_24_0.fleet.id
		})

		return
	end)
	setInputText(var_24_0, (arg_24_1:getName()))
	onButton(arg_24_0, arg_24_2:Find("use_btn"), function()
		arg_24_0:emit(FormationMediator.COMMANDER_FORMATION_OP, {
			FleetType = LevelUIConst.FLEET_TYPE_SELECT,
			data = {
				type = LevelUIConst.COMMANDER_OP_USE_PREFAB,
				id = arg_24_1.id
			},
			fleetId = arg_24_0.fleet.id
		})
		arg_24_0:CloseRecordPanel()

		return
	end, SFX_PANEL)
	onButton(arg_24_0, arg_24_2:Find("record_btn"), function()
		arg_24_0:emit(FormationMediator.COMMANDER_FORMATION_OP, {
			FleetType = LevelUIConst.FLEET_TYPE_SELECT,
			data = {
				type = LevelUIConst.COMMANDER_OP_RECORD_PREFAB,
				id = arg_24_1.id
			},
			fleetId = arg_24_0.fleet.id
		})

		return
	end, SFX_PANEL)

	local var_24_2 = {
		arg_24_2:Find("commander1/skill_info"),
		arg_24_2:Find("commander2/skill_info")
	}

	for iter_24_0, iter_24_1 in ipairs({
		arg_24_2:Find("commander1/frame/info"),
		arg_24_2:Find("commander2/frame/info")
	}) do
		local var_24_3 = arg_24_1:getCommanderByPos(iter_24_0)

		arg_24_0:updateCommander(iter_24_1, iter_24_0, var_24_3)
		arg_24_0:updateSkillTF(var_24_3, var_24_2[iter_24_0])
	end

	return
end

function var_0_0.CloseRecordPanel(arg_29_0)
	setActive(arg_29_0.descFrameTF, true)
	setActive(arg_29_0.recordPanel, false)

	return
end

function var_0_0.OnDestroy(arg_30_0)
	if arg_30_0:isShowing() then
		LeanTween.cancel(go(arg_30_0.samllTF))
		LeanTween.cancel(go(arg_30_0.descFrameTF))

		if isActive(arg_30_0.descPanel) then
			pg.UIMgr.GetInstance():UnOverlayPanel(arg_30_0._tf, arg_30_0._parentTf)
		end
	end

	return
end

return var_0_0
