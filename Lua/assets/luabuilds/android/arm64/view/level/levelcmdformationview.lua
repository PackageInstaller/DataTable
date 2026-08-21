local var_0_0 = class("LevelCMDFormationView", import("..base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "LevelCommanderView"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:InitUI()

	return
end

function var_0_0.OnDestroy(arg_3_0)
	if arg_3_0:isShowing() then
		arg_3_0:Hide()
	end

	arg_3_0.callback = nil

	return
end

function var_0_0.Show(arg_4_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_4_0._tf)
	setActive(arg_4_0._tf, true)

	return
end

function var_0_0.Hide(arg_5_0)
	setActive(arg_5_0._go, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_5_0._tf, arg_5_0._parentTf)

	return
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0.descFrameTF = arg_6_0._tf:Find("frame")
	arg_6_0.descPos1 = arg_6_0.descFrameTF:Find("commander1/frame/info")
	arg_6_0.descPos2 = arg_6_0.descFrameTF:Find("commander2/frame/info")
	arg_6_0.skillTFPos1 = arg_6_0.descFrameTF:Find("commander1/skill_info")
	arg_6_0.skillTFPos2 = arg_6_0.descFrameTF:Find("commander2/skill_info")
	arg_6_0.abilitysTF = UIItemList.New(arg_6_0.descFrameTF:Find("atttr_panel/abilitys/mask/content"), arg_6_0.descFrameTF:Find("atttr_panel/abilitys/mask/content/attr"))
	arg_6_0.talentsTF = UIItemList.New(arg_6_0.descFrameTF:Find("atttr_panel/talents/mask/content"), arg_6_0.descFrameTF:Find("atttr_panel/talents/mask/content/attr"))
	arg_6_0.abilityArr = arg_6_0._tf:Find("frame/atttr_panel/abilitys/arr")
	arg_6_0.talentsArr = arg_6_0._tf:Find("frame/atttr_panel/talents/arr")
	arg_6_0.restAllBtn = arg_6_0.descFrameTF:Find("rest_all")
	arg_6_0.quickBtn = arg_6_0.descFrameTF:Find("quick_btn")
	arg_6_0.recordPanel = arg_6_0._tf:Find("record_panel")
	arg_6_0.recordCommanders = {
		arg_6_0.recordPanel:Find("current/commanders/commander1/frame/info"),
		arg_6_0.recordPanel:Find("current/commanders/commander2/frame/info")
	}
	arg_6_0.reocrdSkills = {
		arg_6_0.recordPanel:Find("current/commanders/commander1/skill_info"),
		arg_6_0.recordPanel:Find("current/commanders/commander2/skill_info")
	}
	arg_6_0.recordList = UIItemList.New(arg_6_0.recordPanel:Find("record/content"), arg_6_0.recordPanel:Find("record/content/commanders"))

	onButton(arg_6_0, arg_6_0.restAllBtn, function()
		arg_6_0.callback({
			type = LevelUIConst.COMMANDER_OP_REST_ALL
		})

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.quickBtn, function()
		arg_6_0:OpenRecordPanel()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.recordPanel:Find("back"), function()
		arg_6_0:CloseRecordPanel()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0._tf:Find("bg"), function()
		arg_6_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.setCallback(arg_11_0, arg_11_1)
	arg_11_0.callback = arg_11_1

	return
end

function var_0_0.update(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:updateFleet(arg_12_1)
	arg_12_0:updatePrefabs(arg_12_2)

	return
end

function var_0_0.updateFleet(arg_13_0, arg_13_1)
	arg_13_0.fleet = arg_13_1

	arg_13_0:updateDesc()
	arg_13_0:updateRecordFleet()

	return
end

function var_0_0.updatePrefabs(arg_14_0, arg_14_1)
	arg_14_0.prefabFleets = arg_14_1

	arg_14_0:updateRecordPanel()

	return
end

function var_0_0.updateRecordFleet(arg_15_0)
	local var_15_0 = arg_15_0.fleet:getCommanders()

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.recordCommanders) do
		arg_15_0:updateCommander(iter_15_1, iter_15_0, var_15_0[iter_15_0])
		arg_15_0:updateSkillTF(var_15_0[iter_15_0], arg_15_0.reocrdSkills[iter_15_0])
	end

	return
end

function var_0_0.updateRecordPanel(arg_16_0)
	local var_16_0 = arg_16_0.fleet:getCommanders()

	arg_16_0.recordList:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventUpdate then
			arg_16_0:UpdatePrefabFleet(arg_16_0.prefabFleets[arg_17_1 + 1], arg_17_2, var_16_0)
		end

		return
	end)
	arg_16_0.recordList:align(#arg_16_0.prefabFleets)

	return
end

function var_0_0.UpdatePrefabFleet(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_2:Find("fleet_name")
	local var_18_1 = arg_18_1:getName()

	onInputEndEdit(arg_18_0, var_18_0, function()
		arg_18_0.callback({
			type = LevelUIConst.COMMANDER_OP_RENAME,
			id = arg_18_1.id,
			str = getInputText(var_18_0),
			onFailed = function()
				setInputText(var_18_0, var_18_1)

				return
			end
		})

		return
	end)
	setInputText(var_18_0, (arg_18_1:getName()))
	onButton(arg_18_0, arg_18_2:Find("use_btn"), function()
		arg_18_0.callback({
			type = LevelUIConst.COMMANDER_OP_USE_PREFAB,
			id = arg_18_1.id
		})
		arg_18_0:CloseRecordPanel()

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_2:Find("record_btn"), function()
		arg_18_0.callback({
			type = LevelUIConst.COMMANDER_OP_RECORD_PREFAB,
			id = arg_18_1.id
		})

		return
	end, SFX_PANEL)

	local var_18_2 = {
		arg_18_2:Find("commander1/skill_info"),
		arg_18_2:Find("commander2/skill_info")
	}

	for iter_18_0, iter_18_1 in ipairs({
		arg_18_2:Find("commander1/frame/info"),
		arg_18_2:Find("commander2/frame/info")
	}) do
		local var_18_3 = arg_18_1:getCommanderByPos(iter_18_0)

		arg_18_0:updateCommander(iter_18_1, iter_18_0, var_18_3)
		arg_18_0:updateSkillTF(var_18_3, var_18_2[iter_18_0])
	end

	return
end

function var_0_0.updateDesc(arg_23_0)
	local var_23_0 = arg_23_0.fleet:getCommanders()

	for iter_23_0 = 1, CommanderConst.MAX_FORMATION_POS do
		arg_23_0:updateCommander(arg_23_0["descPos" .. iter_23_0], iter_23_0, var_23_0[iter_23_0], true)
		arg_23_0:updateSkillTF(var_23_0[iter_23_0], arg_23_0["skillTFPos" .. iter_23_0])
	end

	arg_23_0:updateAdditions()

	return
end

function var_0_0.updateAdditions(arg_24_0)
	local var_24_0 = _.values(arg_24_0.fleet:getCommandersTalentDesc())
	local var_24_1, var_24_2 = arg_24_0.fleet:getCommandersAddition()

	arg_24_0.abilitysTF:make(function(arg_25_0, arg_25_1, arg_25_2)
		if arg_25_0 == UIItemList.EventUpdate then
			setText(arg_25_2:Find("name"), AttributeType.Type2Name(var_24_1[arg_25_1 + 1].attrName))
			setText(arg_25_2:Find("Text"), string.format("%0.3f", var_24_1[arg_25_1 + 1].value) .. "%")
			GetImageSpriteFromAtlasAsync("attricon", var_24_1[arg_25_1 + 1].attrName, arg_25_2:Find("icon"), false)
			setImageAlpha(arg_25_2:Find("bg"), arg_25_1 % 2)
		end

		return
	end)
	arg_24_0.abilitysTF:align(#var_24_1)
	setActive(arg_24_0.abilityArr, #var_24_1 > 4)
	arg_24_0.talentsTF:make(function(arg_26_0, arg_26_1, arg_26_2)
		if arg_26_0 == UIItemList.EventUpdate then
			local var_26_0 = var_24_0[arg_26_1 + 1]

			setScrollText(findTF(arg_26_2, "name_mask/name"), var_24_0[arg_26_1 + 1].name)
			setText(arg_26_2:Find("Text"), var_26_0.value .. (var_26_0.type == CommanderConst.TALENT_ADDITION_RATIO and "%" or ""))
			setImageAlpha(arg_26_2:Find("bg"), arg_26_1 % 2)
		end

		return
	end)
	arg_24_0.talentsTF:align(#var_24_0)
	setActive(arg_24_0.talentsArr, #var_24_0 > 4)

	return
end

function var_0_0.updateSkillTF(arg_27_0, arg_27_1, arg_27_2)
	setActive(arg_27_2, arg_27_1)

	if arg_27_1 then
		local var_27_0 = arg_27_1:getSkills()[1]

		GetImageSpriteFromAtlasAsync("CommanderSkillIcon/" .. var_27_0:getConfig("icon"), "", arg_27_2:Find("icon"))
		setText(arg_27_2:Find("level"), "Lv." .. var_27_0:getLevel())
		onButton(arg_27_0, arg_27_2, function()
			arg_27_0.callback({
				type = LevelUIConst.COMMANDER_OP_SHOW_SKILL,
				skill = var_27_0
			})

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_27_2)
	end

	return
end

function var_0_0.updateCommander(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	local var_29_0 = arg_29_1:Find("add")
	local var_29_1 = arg_29_1:Find("info")

	if arg_29_3 then
		GetImageSpriteFromAtlasAsync("CommanderHrz/" .. arg_29_3:getPainting(), "", (arg_29_1:Find("info/mask/icon")))

		local var_29_2 = arg_29_1:Find("info/name")

		if var_29_2 then
			setText(var_29_2, arg_29_3:getName())
		end

		setImageSprite(arg_29_1:Find("info/frame"), GetSpriteFromAtlas("weaponframes", "commander_" .. Commander.rarity2Frame(arg_29_3:getRarity())))
	end

	if arg_29_4 then
		onButton(arg_29_0, var_29_1, function()
			arg_29_0.callback({
				type = LevelUIConst.COMMANDER_OP_ADD,
				pos = arg_29_2
			})

			return
		end, SFX_PANEL)
		onButton(arg_29_0, var_29_0, function()
			arg_29_0.callback({
				type = LevelUIConst.COMMANDER_OP_ADD,
				pos = arg_29_2
			})

			return
		end, SFX_PANEL)
	end

	setActive(var_29_0, not arg_29_3)
	setActive(var_29_1, arg_29_3)

	return
end

function var_0_0.OpenRecordPanel(arg_32_0)
	setActive(arg_32_0.descFrameTF, false)
	setActive(arg_32_0.recordPanel, true)

	return
end

function var_0_0.CloseRecordPanel(arg_33_0)
	setActive(arg_33_0.descFrameTF, true)
	setActive(arg_33_0.recordPanel, false)

	return
end

return var_0_0
