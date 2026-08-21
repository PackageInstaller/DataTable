local var_0_0 = class("LevelCMDFormationView", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "LevelCommanderView"
end

function var_0_0.init(arg_2_0)
	arg_2_0.descFrameTF = arg_2_0._tf:Find("frame")
	arg_2_0.descPos1 = arg_2_0.descFrameTF:Find("commander1/frame/info")
	arg_2_0.descPos2 = arg_2_0.descFrameTF:Find("commander2/frame/info")
	arg_2_0.skillTFPos1 = arg_2_0.descFrameTF:Find("commander1/skill_info")
	arg_2_0.skillTFPos2 = arg_2_0.descFrameTF:Find("commander2/skill_info")
	arg_2_0.abilitysTF = UIItemList.New(arg_2_0.descFrameTF:Find("atttr_panel/abilitys/mask/content"), arg_2_0.descFrameTF:Find("atttr_panel/abilitys/mask/content/attr"))
	arg_2_0.talentsTF = UIItemList.New(arg_2_0.descFrameTF:Find("atttr_panel/talents/mask/content"), arg_2_0.descFrameTF:Find("atttr_panel/talents/mask/content/attr"))
	arg_2_0.abilityArr = arg_2_0._tf:Find("frame/atttr_panel/abilitys/arr")
	arg_2_0.talentsArr = arg_2_0._tf:Find("frame/atttr_panel/talents/arr")
	arg_2_0.restAllBtn = arg_2_0.descFrameTF:Find("rest_all")
	arg_2_0.quickBtn = arg_2_0.descFrameTF:Find("quick_btn")
	arg_2_0.recordPanel = arg_2_0._tf:Find("record_panel")
	arg_2_0.recordCommanders = {
		arg_2_0.recordPanel:Find("current/commanders/commander1/frame/info"),
		arg_2_0.recordPanel:Find("current/commanders/commander2/frame/info")
	}
	arg_2_0.reocrdSkills = {
		arg_2_0.recordPanel:Find("current/commanders/commander1/skill_info"),
		arg_2_0.recordPanel:Find("current/commanders/commander2/skill_info")
	}
	arg_2_0.recordList = UIItemList.New(arg_2_0.recordPanel:Find("record/content"), arg_2_0.recordPanel:Find("record/content/commanders"))

	onButton(arg_2_0, arg_2_0.restAllBtn, function()
		arg_2_0.callback({
			type = LevelUIConst.COMMANDER_OP_REST_ALL
		})

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.quickBtn, function()
		arg_2_0:OpenRecordPanel()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.recordPanel:Find("back"), function()
		arg_2_0:CloseRecordPanel()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0._tf:Find("bg"), function()
		arg_2_0:onBackPressed()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.didEnter(arg_7_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_7_0._tf)

	return
end

function var_0_0.willExit(arg_8_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_8_0._tf)

	return
end

function var_0_0.setCallback(arg_9_0, arg_9_1)
	arg_9_0.callback = arg_9_1

	return
end

function var_0_0.updateFleet(arg_10_0, arg_10_1)
	arg_10_0.fleet = arg_10_1

	arg_10_0:updateDesc()
	arg_10_0:updateRecordFleet()

	return
end

function var_0_0.setCommanderPrefabs(arg_11_0, arg_11_1)
	arg_11_0.prefabFleets = arg_11_1

	arg_11_0:updateRecordPanel()

	return
end

function var_0_0.updateRecordFleet(arg_12_0)
	local var_12_0 = arg_12_0.fleet:getCommanders()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.recordCommanders) do
		arg_12_0:updateCommander(iter_12_1, iter_12_0, var_12_0[iter_12_0])
		arg_12_0:updateSkillTF(var_12_0[iter_12_0], arg_12_0.reocrdSkills[iter_12_0])
	end

	return
end

function var_0_0.updateRecordPanel(arg_13_0)
	local var_13_0 = arg_13_0.fleet:getCommanders()

	arg_13_0.recordList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			arg_13_0:UpdatePrefabFleet(arg_13_0.prefabFleets[arg_14_1 + 1], arg_14_2, var_13_0)
		end

		return
	end)
	arg_13_0.recordList:align(#arg_13_0.prefabFleets)

	return
end

function var_0_0.UpdatePrefabFleet(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_2:Find("fleet_name")
	local var_15_1 = arg_15_1:getName()

	onInputEndEdit(arg_15_0, var_15_0, function()
		arg_15_0.callback({
			type = LevelUIConst.COMMANDER_OP_RENAME,
			id = arg_15_1.id,
			str = getInputText(var_15_0),
			onFailed = function()
				setInputText(var_15_0, var_15_1)

				return
			end
		})

		return
	end)
	setInputText(var_15_0, (arg_15_1:getName()))
	onButton(arg_15_0, arg_15_2:Find("use_btn"), function()
		arg_15_0.callback({
			type = LevelUIConst.COMMANDER_OP_USE_PREFAB,
			id = arg_15_1.id
		})
		arg_15_0:CloseRecordPanel()

		return
	end, SFX_PANEL)
	onButton(arg_15_0, arg_15_2:Find("record_btn"), function()
		arg_15_0.callback({
			type = LevelUIConst.COMMANDER_OP_RECORD_PREFAB,
			id = arg_15_1.id
		})

		return
	end, SFX_PANEL)

	local var_15_2 = {
		arg_15_2:Find("commander1/skill_info"),
		arg_15_2:Find("commander2/skill_info")
	}

	for iter_15_0, iter_15_1 in ipairs({
		arg_15_2:Find("commander1/frame/info"),
		arg_15_2:Find("commander2/frame/info")
	}) do
		local var_15_3 = arg_15_1:getCommanderByPos(iter_15_0)

		arg_15_0:updateCommander(iter_15_1, iter_15_0, var_15_3)
		arg_15_0:updateSkillTF(var_15_3, var_15_2[iter_15_0])
	end

	return
end

function var_0_0.updateDesc(arg_20_0)
	local var_20_0 = arg_20_0.fleet:getCommanders()

	for iter_20_0 = 1, CommanderConst.MAX_FORMATION_POS do
		arg_20_0:updateCommander(arg_20_0["descPos" .. iter_20_0], iter_20_0, var_20_0[iter_20_0], true)
		arg_20_0:updateSkillTF(var_20_0[iter_20_0], arg_20_0["skillTFPos" .. iter_20_0])
	end

	arg_20_0:updateAdditions()

	return
end

function var_0_0.updateAdditions(arg_21_0)
	local var_21_0 = _.values(arg_21_0.fleet:getCommandersTalentDesc())
	local var_21_1, var_21_2 = arg_21_0.fleet:getCommandersAddition()

	arg_21_0.abilitysTF:make(function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			setText(arg_22_2:Find("name"), AttributeType.Type2Name(var_21_1[arg_22_1 + 1].attrName))
			setText(arg_22_2:Find("Text"), string.format("%0.3f", var_21_1[arg_22_1 + 1].value) .. "%")
			GetImageSpriteFromAtlasAsync("attricon", var_21_1[arg_22_1 + 1].attrName, arg_22_2:Find("icon"), false)
			setImageAlpha(arg_22_2:Find("bg"), arg_22_1 % 2)
		end

		return
	end)
	arg_21_0.abilitysTF:align(#var_21_1)
	setActive(arg_21_0.abilityArr, #var_21_1 > 4)
	arg_21_0.talentsTF:make(function(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0 == UIItemList.EventUpdate then
			local var_23_0 = var_21_0[arg_23_1 + 1]

			setScrollText(findTF(arg_23_2, "name_mask/name"), var_21_0[arg_23_1 + 1].name)
			setText(arg_23_2:Find("Text"), var_23_0.value .. (var_23_0.type == CommanderConst.TALENT_ADDITION_RATIO and "%" or ""))
			setImageAlpha(arg_23_2:Find("bg"), arg_23_1 % 2)
		end

		return
	end)
	arg_21_0.talentsTF:align(#var_21_0)
	setActive(arg_21_0.talentsArr, #var_21_0 > 4)

	return
end

function var_0_0.updateSkillTF(arg_24_0, arg_24_1, arg_24_2)
	setActive(arg_24_2, arg_24_1)

	if arg_24_1 then
		local var_24_0 = arg_24_1:getSkills()[1]

		GetImageSpriteFromAtlasAsync("CommanderSkillIcon/" .. var_24_0:getConfig("icon"), "", arg_24_2:Find("icon"))
		setText(arg_24_2:Find("level"), "Lv." .. var_24_0:getLevel())
		onButton(arg_24_0, arg_24_2, function()
			arg_24_0.callback({
				type = LevelUIConst.COMMANDER_OP_SHOW_SKILL,
				skill = var_24_0
			})

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_24_2)
	end

	return
end

function var_0_0.updateCommander(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local var_26_0 = arg_26_1:Find("add")
	local var_26_1 = arg_26_1:Find("info")

	if arg_26_3 then
		GetImageSpriteFromAtlasAsync("CommanderHrz/" .. arg_26_3:getPainting(), "", (arg_26_1:Find("info/mask/icon")))

		local var_26_2 = arg_26_1:Find("info/name")

		if var_26_2 then
			setText(var_26_2, arg_26_3:getName())
		end

		setImageSprite(arg_26_1:Find("info/frame"), GetSpriteFromAtlas("weaponframes", "commander_" .. Commander.rarity2Frame(arg_26_3:getRarity())))
	end

	if arg_26_4 then
		onButton(arg_26_0, var_26_1, function()
			arg_26_0.callback({
				type = LevelUIConst.COMMANDER_OP_ADD,
				pos = arg_26_2
			})

			return
		end, SFX_PANEL)
		onButton(arg_26_0, var_26_0, function()
			arg_26_0.callback({
				type = LevelUIConst.COMMANDER_OP_ADD,
				pos = arg_26_2
			})

			return
		end, SFX_PANEL)
	end

	setActive(var_26_0, not arg_26_3)
	setActive(var_26_1, arg_26_3)

	return
end

function var_0_0.OpenRecordPanel(arg_29_0)
	setActive(arg_29_0.descFrameTF, false)
	setActive(arg_29_0.recordPanel, true)

	return
end

function var_0_0.CloseRecordPanel(arg_30_0)
	setActive(arg_30_0.descFrameTF, true)
	setActive(arg_30_0.recordPanel, false)

	return
end

return var_0_0
