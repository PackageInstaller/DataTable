local var_0_0 = class("CmdLevelFormationPanel", import("..base.BasePanel"))

function var_0_0.init(arg_1_0)
	arg_1_0.descPanel = arg_1_0._tf:Find("desc")
	arg_1_0.descFrameTF = arg_1_0._tf:Find("desc/frame")
	arg_1_0.descPos1 = arg_1_0.descFrameTF:Find("commander1/frame/info")
	arg_1_0.descPos2 = arg_1_0.descFrameTF:Find("commander2/frame/info")
	arg_1_0.skillTFPos1 = arg_1_0.descFrameTF:Find("commander1/skill_info")
	arg_1_0.skillTFPos2 = arg_1_0.descFrameTF:Find("commander2/skill_info")
	arg_1_0.abilitysTF = UIItemList.New(arg_1_0.descFrameTF:Find("atttr_panel/abilitys/mask/content"), arg_1_0.descFrameTF:Find("atttr_panel/abilitys/mask/content/attr"))
	arg_1_0.talentsTF = UIItemList.New(arg_1_0.descFrameTF:Find("atttr_panel/talents/mask/content"), arg_1_0.descFrameTF:Find("atttr_panel/talents/mask/content/attr"))
	arg_1_0.abilityArr = arg_1_0._tf:Find("desc/frame/atttr_panel/abilitys/arr")
	arg_1_0.talentsArr = arg_1_0._tf:Find("desc/frame/atttr_panel/talents/arr")
	arg_1_0.animtion = arg_1_0.descPanel:GetComponent("Animation")
	arg_1_0.animtionEvent = arg_1_0._tf:Find("desc"):GetComponent(typeof(DftAniEvent))

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.callback = arg_2_2

	assert(arg_2_1)

	arg_2_0.fleet = arg_2_1

	arg_2_0:updateDesc()

	return
end

function var_0_0.attach(arg_3_0, arg_3_1)
	var_0_0.super.attach(arg_3_0, arg_3_1)
	setActive(arg_3_0._go, false)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:close()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.playAnim(arg_5_0, arg_5_1)
	arg_5_0.animtion:Play(arg_5_1)

	return
end

function var_0_0.open(arg_6_0)
	arg_6_0:playAnim("cmdopen")
	setActive(arg_6_0._go, true)
	setParent(arg_6_0._go, pg.UIMgr.GetInstance().OverlayMain)
	arg_6_0._tf:SetAsLastSibling()

	return
end

function var_0_0.close(arg_7_0)
	arg_7_0:playAnim("cmdclose")
	setActive(arg_7_0._go, false)

	return
end

function var_0_0.updateDesc(arg_8_0)
	local var_8_0 = arg_8_0.fleet:getCommanders()

	for iter_8_0 = 1, CommanderConst.MAX_FORMATION_POS do
		arg_8_0:updateCommander(arg_8_0["descPos" .. iter_8_0], iter_8_0, var_8_0[iter_8_0])
		arg_8_0:updateSkillTF(var_8_0[iter_8_0], arg_8_0["skillTFPos" .. iter_8_0])
	end

	arg_8_0:updateAdditions()

	return
end

function var_0_0.updateAdditions(arg_9_0)
	local var_9_0 = _.values(arg_9_0.fleet:getCommandersTalentDesc())
	local var_9_1, var_9_2 = arg_9_0.fleet:getCommandersAddition()

	arg_9_0.abilitysTF:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			setText(arg_10_2:Find("name"), AttributeType.Type2Name(var_9_1[arg_10_1 + 1].attrName))
			setText(arg_10_2:Find("Text"), string.format("%0.3f", var_9_1[arg_10_1 + 1].value) .. "%")
			GetImageSpriteFromAtlasAsync("attricon", var_9_1[arg_10_1 + 1].attrName, arg_10_2:Find("icon"), false)
			setActive(arg_10_2:Find("bg"), arg_10_1 % 2 ~= 0)
		end

		return
	end)
	arg_9_0.abilitysTF:align(#var_9_1)
	setActive(arg_9_0.abilityArr, #var_9_1 > 4)
	arg_9_0.talentsTF:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = var_9_0[arg_11_1 + 1]

			setScrollText(findTF(arg_11_2, "name_mask/name"), var_9_0[arg_11_1 + 1].name)
			setText(arg_11_2:Find("Text"), var_11_0.value .. (var_11_0.type == CommanderConst.TALENT_ADDITION_RATIO and "%" or ""))
			setActive(arg_11_2:Find("bg"), arg_11_1 % 2 ~= 0)
		end

		return
	end)
	arg_9_0.talentsTF:align(#var_9_0)
	setActive(arg_9_0.talentsArr, #var_9_0 > 4)

	return
end

function var_0_0.updateSkillTF(arg_12_0, arg_12_1, arg_12_2)
	setActive(arg_12_2, arg_12_1)

	if arg_12_1 then
		local var_12_0 = arg_12_1:getSkills()[1]

		GetImageSpriteFromAtlasAsync("CommanderSkillIcon/" .. var_12_0:getConfig("icon"), "", arg_12_2:Find("icon"))
		setText(arg_12_2:Find("level"), "Lv." .. var_12_0:getLevel())
	end

	return
end

function var_0_0.updateCommander(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1:Find("add")
	local var_13_1 = arg_13_1:Find("info")

	if arg_13_3 then
		GetImageSpriteFromAtlasAsync("CommanderHrz/" .. arg_13_3:getPainting(), "", (arg_13_1:Find("info/mask/icon")))

		local var_13_2 = arg_13_1:Find("info/name")

		if var_13_2 then
			setText(var_13_2, arg_13_3:getName())
		end

		setImageSprite(arg_13_1:Find("info/frame"), GetSpriteFromAtlas("weaponframes", "commander_" .. Commander.rarity2Frame(arg_13_3:getRarity())))
	end

	onButton(arg_13_0, var_13_1, function()
		if arg_13_0.callback then
			arg_13_0.callback(arg_13_2)
		end

		return
	end, SFX_PANEL)
	onButton(arg_13_0, var_13_0, function()
		if arg_13_0.callback then
			arg_13_0.callback(arg_13_2)
		end

		return
	end, SFX_PANEL)
	setActive(var_13_0, not arg_13_3)
	setActive(var_13_1, arg_13_3)

	return
end

function var_0_0.enable(arg_16_0, arg_16_1)
	setActive(arg_16_0._go, arg_16_1)

	return
end

function var_0_0.clear(arg_17_0)
	setActive(arg_17_0._go, false)
	setParent(arg_17_0._go, arg_17_0.parent.topPanel)

	return
end

return var_0_0
