local var_0_0 = class("IslandShipBreakoutPage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandShipBreakoutUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.uiStarPreList = UIItemList.New(arg_2_0._tf:Find("frame_1/star/prev"), arg_2_0._tf:Find("frame_1/star/prev/tpl"))
	arg_2_0.uiStarNextList = UIItemList.New(arg_2_0._tf:Find("frame_1/star/now"), arg_2_0._tf:Find("frame_1/star/now/tpl"))
	arg_2_0.prevLevelTxt = arg_2_0._tf:Find("frame_1/level/prev"):GetComponent(typeof(Text))
	arg_2_0.nextLevelTxt = arg_2_0._tf:Find("frame_1/level/now"):GetComponent(typeof(Text))
	arg_2_0.skillTxt = arg_2_0._tf:Find("frame_1/skill/Text"):GetComponent(typeof(Text))
	arg_2_0.skillLabelTxt = arg_2_0._tf:Find("frame_1/skill/now"):GetComponent(typeof(Text))
	arg_2_0.uiAttrList = UIItemList.New(arg_2_0._tf:Find("frame_3/attrs"), arg_2_0._tf:Find("frame_3/attrs/tpl"))
	arg_2_0.uiConsumeList = UIItemList.New(arg_2_0._tf:Find("frame_2/comsume"), arg_2_0._tf:Find("frame_2/comsume/tpl"))
	arg_2_0.upgradeBtn = arg_2_0._tf:Find("btn_confirm")
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame_1/close")

	setText(arg_2_0._tf:Find("frame_1/title"), i18n("island_ship_breakout"))
	setText(arg_2_0._tf:Find("frame_2/consume_title/Text"), i18n("island_ship_breakout_consume"))
	setText(arg_2_0.upgradeBtn:Find("Text"), i18n("island_chara_breakout_button"))

	return
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddListener(GAME.ISLAND_SHIP_BREAKOUT_DONE, arg_3_0.OnBreakOutDone)

	return
end

function var_0_0.RemoveListeners(arg_4_0)
	arg_4_0:RemoveListener(GAME.ISLAND_SHIP_BREAKOUT_DONE, arg_4_0.OnBreakOutDone)

	return
end

function var_0_0.OnBreakOutDone(arg_5_0)
	arg_5_0:Hide()

	return
end

function var_0_0.OnInit(arg_6_0)
	onButton(arg_6_0, arg_6_0._tf, function()
		arg_6_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.closeBtn, function()
		arg_6_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnShow(arg_9_0, arg_9_1)
	local var_9_0 = Clone(arg_9_1)

	var_9_0:UpgradeBreakOut()
	arg_9_0:BlurPanel(var_9_0, arg_9_1)
	arg_9_0:UpdateBreakOutLevel(var_9_0, arg_9_1)
	arg_9_0:UpdateLevel(var_9_0, arg_9_1)
	arg_9_0:UpdateSkill(var_9_0, arg_9_1)
	arg_9_0:UpdateAttrs(var_9_0, arg_9_1)
	arg_9_0:UpdateConsume(var_9_0, arg_9_1)
	arg_9_0:UpdateUpgradeBtn(arg_9_1)

	return
end

function var_0_0.UpdateBreakOutLevel(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.uiStarPreList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			setActive(arg_11_2:Find("Image"), arg_11_1 + 1 <= arg_10_2:GetBreakLevel())
		end

		return
	end)
	arg_10_0.uiStarPreList:align(arg_10_2:GetBreakMaxLevel())
	arg_10_0.uiStarNextList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			setActive(arg_12_2:Find("Image"), arg_12_1 + 1 <= arg_10_1:GetBreakLevel())
		end

		return
	end)
	arg_10_0.uiStarNextList:align(arg_10_1:GetBreakMaxLevel())

	return
end

function var_0_0.UpdateLevel(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.prevLevelTxt.text = "Lv." .. arg_13_2:GetMaxLevel()
	arg_13_0.nextLevelTxt.text = "Lv." .. arg_13_1:GetMaxLevel()

	return
end

function var_0_0.UpdateSkill(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1:GetSkill():IsUnlock() and not arg_14_2:GetSkill():IsUnlock() then
		arg_14_0.skillTxt.text = arg_14_2:GetSkill():GetName()
		arg_14_0.skillLabelTxt.text = i18n("island_ship_newskill_unlock")
	else
		arg_14_0.skillTxt.text = ""
		arg_14_0.skillLabelTxt.text = ""
	end

	return
end

function var_0_0.UpdateAttrs(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1:GetGrowthAtt()
	local var_15_1 = arg_15_2:GetGrowthAtt()

	arg_15_0.uiAttrList:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			arg_16_2:Find("grade_bg"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/IslandShipUI_atlas", IslandShipAttr.Grade2Img((arg_15_2:GetAttrGrade(IslandShipAttr.ATTRS[arg_16_1 + 1])))[2])

			setText(arg_16_2:Find("name"), IslandShipAttr.ToChinese(IslandShipAttr.ATTRS[arg_16_1 + 1]))

			local var_16_0 = var_15_1[IslandShipAttr.ATTRS[arg_16_1 + 1]] or 0
			local var_16_1 = "  >>>  +"
			local var_16_2 = var_15_0[IslandShipAttr.ATTRS[arg_16_1 + 1]] or 0

			setText(arg_16_2:Find("value"), "+" .. var_16_0 .. var_16_1 .. var_16_2)
		end

		return
	end)
	arg_15_0.uiAttrList:align(#IslandShipAttr.ATTRS)

	return
end

function var_0_0.UpdateConsume(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_2:GetBreakoutMatrials()
	local var_17_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	arg_17_0.uiConsumeList:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			local var_18_0 = var_17_0[arg_18_1 + 1]

			updateCustomDrop(arg_18_2, var_17_0[arg_18_1 + 1])

			local var_18_1 = var_17_1:GetOwnCount(var_18_0.id)
			local var_18_3 = var_18_1

			if var_18_1 >= var_18_0.count then
				local var_18_4 = COLOR_GREEN or COLOR_RED

				setText(arg_18_2:Find("icon_bg/count_bg/count"), var_18_2(var_18_3, var_18_4) .. "/" .. var_18_0.count)

				return
			end
		end
	end)
	arg_17_0.uiConsumeList:align(#arg_17_2:GetBreakoutMatrials())

	return
end

function var_0_0.UpdateUpgradeBtn(arg_19_0, arg_19_1)
	local var_19_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	setGray(arg_19_0.upgradeBtn, not _.all(arg_19_1:GetBreakoutMatrials(), function(arg_20_0)
		return var_19_0:GetOwnCount(arg_20_0.id) >= arg_20_0.count
	end), true)
	onButton(arg_19_0, arg_19_0.upgradeBtn, function()
		if not var_0 then
			return
		end

		arg_19_0:emit(IslandMediator.SHIP_BREAKOUT, arg_19_1.id)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnHide(arg_22_0)
	arg_22_0:UnBlurPanel()

	return
end

return var_0_0
