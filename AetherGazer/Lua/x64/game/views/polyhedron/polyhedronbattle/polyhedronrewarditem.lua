local var_0_0 = class("PolyhedronRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.typeController = ControllerUtil.GetController(arg_3_0.transform_, "type")
	arg_3_0.selectController = ControllerUtil.GetController(arg_3_0.transform_, "select")
	arg_3_0.artifactFrameController = ControllerUtil.GetController(arg_3_0.transform_, "artifactFrame")
	arg_3_0.shopControlle = ControllerUtil.GetController(arg_3_0.transform_, "shop")
	arg_3_0.shopDiscountControlle = ControllerUtil.GetController(arg_3_0.transform_, "shopDiscount")
	arg_3_0.attackTypeController = ControllerUtil.GetController(arg_3_0.transform_, "attackType")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_btn, nil, function()
		if arg_4_0.clickFunc then
			arg_4_0.clickFunc(arg_4_0.index)
		end
	end)
	arg_4_0.m_eventTrigger:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function()
		if arg_4_0.clickFunc then
			arg_4_0.clickFunc(arg_4_0.index)
		end
	end))
	arg_4_0:AddBtnListener(arg_4_0.checkBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			title = " ",
			content = arg_4_0.desc
		})
	end)
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.index = arg_8_3
	arg_8_0.data = arg_8_2
	arg_8_0.polyhedronInfo = arg_8_1

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = arg_9_0.data.class
	local var_9_1 = arg_9_0.data.params

	if var_9_0 == PolyhedronConst.ITEM_TYPE.ARTIFACT then
		arg_9_0.typeController:SetSelectedState("Artifact")

		local var_9_2 = var_9_1[1]
		local var_9_3 = PolyhedronArtifactCfg[var_9_2]
		local var_9_4 = var_9_3.affix_id

		arg_9_0.m_name.text = getAffixName({
			var_9_4,
			1
		})
		arg_9_0.desc = getAffixDesc({
			var_9_4,
			1
		})
		arg_9_0.m_desLab.text = arg_9_0.desc
		arg_9_0.m_ArtifactIcon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.ARTIFACT_ICON_PATH .. var_9_3.icon)

		if var_9_3.exclusive_hero_id ~= 0 then
			arg_9_0.artifactFrameController:SetSelectedIndex(1)
		else
			arg_9_0.artifactFrameController:SetSelectedIndex(0)
		end
	elseif var_9_0 == PolyhedronConst.ITEM_TYPE.ARTIFACT_UP_LEVEL then
		arg_9_0.typeController:SetSelectedState("ArtifactLv")

		local var_9_5 = var_9_1[1]
		local var_9_6 = PolyhedronArtifactCfg[var_9_5]
		local var_9_7 = arg_9_0.polyhedronInfo:GetArtifact(var_9_5)
		local var_9_8 = var_9_7 and var_9_7.level or 1
		local var_9_9 = var_9_8 + 1

		arg_9_0.m_curLv.text = "LV." .. var_9_8
		arg_9_0.m_nextLv.text = "LV." .. var_9_9

		local var_9_10 = var_9_6.affix_id

		arg_9_0.m_name.text = getAffixName({
			var_9_10,
			1
		})
		arg_9_0.desc = PolyhedronTools.getAffixUpLvDes(var_9_10, var_9_8, var_9_9)
		arg_9_0.m_desLab.text = arg_9_0.desc
		arg_9_0.m_ArtifactIcon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.ARTIFACT_ICON_PATH .. var_9_6.icon)

		if var_9_6.exclusive_hero_id ~= 0 then
			arg_9_0.artifactFrameController:SetSelectedIndex(1)
		else
			arg_9_0.artifactFrameController:SetSelectedIndex(0)
		end
	elseif var_9_0 == PolyhedronConst.ITEM_TYPE.BUFF then
		arg_9_0.typeController:SetSelectedState("buff")

		local var_9_11 = var_9_1[1]
		local var_9_12 = PolyhedronEffectCfg[var_9_11]

		arg_9_0.m_name.text = GetI18NText(var_9_12.name)
		arg_9_0.desc = GetI18NText(var_9_12.desc)
		arg_9_0.m_desLab.text = arg_9_0.desc

		arg_9_0.artifactFrameController:SetSelectedIndex(0)

		arg_9_0.m_effectIcon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.EFFECT_ATTRIBUTE_ICON_PATH .. var_9_12.icon)
	elseif var_9_0 == PolyhedronConst.ITEM_TYPE.COIN then
		arg_9_0.typeController:SetSelectedState("coin")

		local var_9_13 = var_9_1[1]
		local var_9_14 = var_9_1[2]
		local var_9_15 = arg_9_0.polyhedronInfo:GetPolyhedronCoinId()
		local var_9_16 = ItemCfg[var_9_15]

		arg_9_0.m_name.text = ItemTools.getItemName(var_9_15)
		arg_9_0.desc = string.format(GetTips("MATRIX_GET"), var_9_14, ItemTools.getItemName(var_9_15))
		arg_9_0.m_desLab.text = arg_9_0.desc

		arg_9_0.artifactFrameController:SetSelectedIndex(0)
	elseif var_9_0 == PolyhedronConst.ITEM_TYPE.HERO then
		arg_9_0.typeController:SetSelectedState("hero")

		local var_9_17 = var_9_1[1]
		local var_9_18 = HeroCfg[var_9_17]

		arg_9_0.m_heroName.text = GetI18NText(var_9_18.name)

		local var_9_19 = PolyhedronData:GetHeroUsingSkinInfo(var_9_17).id

		arg_9_0.m_heroIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. var_9_19)

		local var_9_20 = var_9_18.mechanism_type[1]

		arg_9_0.m_heroDes2.text = HeroTools.GetChargeTextByType(var_9_20)

		if #var_9_18.ATK_attribute > 1 then
			arg_9_0.attackTypeController:SetSelectedState(-1)
		else
			local var_9_21 = var_9_18.ATK_attribute[1]

			arg_9_0.attackTypeController:SetSelectedState(var_9_21)
		end

		local var_9_22 = PolyhedronHeroCfg[var_9_17].standard_id
		local var_9_23 = HeroStandardSystemCfg[var_9_22]

		arg_9_0.m_heroDes1.text = GetI18NText(var_9_23.hero_desc)

		local var_9_24 = RaceEffectCfg[var_9_18.race]

		arg_9_0.m_campIcon.sprite = getSprite("Atlas/CampItemAtlas", var_9_24.icon)

		arg_9_0.artifactFrameController:SetSelectedIndex(0)
	elseif var_9_0 == PolyhedronConst.ITEM_TYPE.BLOOD then
		arg_9_0.typeController:SetSelectedState("blood")

		local var_9_25 = var_9_1[1]

		if var_9_25 > 1000 then
			var_9_25 = 1000
		end

		arg_9_0.m_name.text = ""
		arg_9_0.desc = string.format(GetTips("POLYHEDRON_HP_REWARD_TIP"), math.floor(var_9_25 / 10) .. "%")
		arg_9_0.m_desLab.text = arg_9_0.desc

		arg_9_0.artifactFrameController:SetSelectedIndex(0)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.m_desTrs)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.m_desContentTrs)
end

function var_0_0.SetSelected(arg_10_0, arg_10_1)
	arg_10_0.selectController:SetSelectedIndex(arg_10_1 == arg_10_0.index and 1 or 0)
end

function var_0_0.RegistCallBack(arg_11_0, arg_11_1)
	arg_11_0.clickFunc = arg_11_1
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.m_eventTrigger:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerClick)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
