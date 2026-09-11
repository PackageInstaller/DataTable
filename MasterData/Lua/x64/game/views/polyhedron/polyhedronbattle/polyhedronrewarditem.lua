local PolyhedronRewardItem = class("PolyhedronRewardItem", ReduxView)

function PolyhedronRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PolyhedronRewardItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronRewardItem:InitUI()
	self:BindCfgUI()

	self.typeController = ControllerUtil.GetController(self.transform_, "type")
	self.selectController = ControllerUtil.GetController(self.transform_, "select")
	self.artifactFrameController = ControllerUtil.GetController(self.transform_, "artifactFrame")
	self.shopControlle = ControllerUtil.GetController(self.transform_, "shop")
	self.shopDiscountControlle = ControllerUtil.GetController(self.transform_, "shopDiscount")
	self.attackTypeController = ControllerUtil.GetController(self.transform_, "attackType")
end

function PolyhedronRewardItem:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		if self.clickFunc then
			self.clickFunc(self.index)
		end
	end)
	self.m_eventTrigger:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function()
		if self.clickFunc then
			self.clickFunc(self.index)
		end
	end))
	self:AddBtnListener(self.checkBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			title = " ",
			content = self.desc
		})
	end)
end

function PolyhedronRewardItem:SetData(arg_8_1, arg_8_2, arg_8_3)
	self.index = arg_8_3
	self.data = arg_8_2
	self.polyhedronInfo = arg_8_1

	self:RefreshUI()
end

function PolyhedronRewardItem:RefreshUI()
	if self.data.class == PolyhedronConst.ITEM_TYPE.ARTIFACT then
		self.typeController:SetSelectedState("Artifact")

		self.m_name.text = getAffixName({
			PolyhedronArtifactCfg[self.data.params[1]].affix_id,
			1
		})
		self.desc = getAffixDesc({
			PolyhedronArtifactCfg[self.data.params[1]].affix_id,
			1
		})
		self.m_desLab.text = self.desc
		self.m_ArtifactIcon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.ARTIFACT_ICON_PATH .. PolyhedronArtifactCfg[self.data.params[1]].icon)

		if PolyhedronArtifactCfg[self.data.params[1]].exclusive_hero_id ~= 0 then
			self.artifactFrameController:SetSelectedIndex(1)
		else
			self.artifactFrameController:SetSelectedIndex(0)
		end
	elseif self.data.class == PolyhedronConst.ITEM_TYPE.ARTIFACT_UP_LEVEL then
		self.typeController:SetSelectedState("ArtifactLv")

		local var_9_0 = PolyhedronArtifactCfg[self.data.params[1]]
		local var_9_1 = self.polyhedronInfo:GetArtifact(self.data.params[1])
		local var_9_2

		if var_9_1 then
			var_9_2 = var_9_1.level or 1
		end

		local var_9_3 = var_9_2 + 1

		self.m_curLv.text = "LV." .. var_9_2
		self.m_nextLv.text = "LV." .. var_9_3
		self.m_name.text = getAffixName({
			var_9_0.affix_id,
			1
		})
		self.desc = PolyhedronTools.getAffixUpLvDes(var_9_0.affix_id, var_9_2, var_9_3)
		self.m_desLab.text = self.desc
		self.m_ArtifactIcon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.ARTIFACT_ICON_PATH .. var_9_0.icon)

		if var_9_0.exclusive_hero_id ~= 0 then
			self.artifactFrameController:SetSelectedIndex(1)
		else
			self.artifactFrameController:SetSelectedIndex(0)
		end
	elseif self.data.class == PolyhedronConst.ITEM_TYPE.BUFF then
		self.typeController:SetSelectedState("buff")

		self.m_name.text = GetI18NText(PolyhedronEffectCfg[self.data.params[1]].name)
		self.desc = GetI18NText(PolyhedronEffectCfg[self.data.params[1]].desc)
		self.m_desLab.text = self.desc

		self.artifactFrameController:SetSelectedIndex(0)

		self.m_effectIcon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.EFFECT_ATTRIBUTE_ICON_PATH .. PolyhedronEffectCfg[self.data.params[1]].icon)
	elseif self.data.class == PolyhedronConst.ITEM_TYPE.COIN then
		self.typeController:SetSelectedState("coin")

		local var_9_5 = self.polyhedronInfo:GetPolyhedronCoinId()

		self.m_name.text = ItemTools.getItemName(var_9_5)
		self.desc = string.format(GetTips("MATRIX_GET"), self.data.params[2], ItemTools.getItemName(var_9_5))
		self.m_desLab.text = self.desc

		self.artifactFrameController:SetSelectedIndex(0)
	elseif self.data.class == PolyhedronConst.ITEM_TYPE.HERO then
		self.typeController:SetSelectedState("hero")

		local var_9_7 = self.data.params[1]
		local var_9_8 = HeroCfg[self.data.params[1]]

		self.m_heroName.text = GetI18NText(HeroCfg[self.data.params[1]].name)
		self.m_heroIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. PolyhedronData:GetHeroUsingSkinInfo(var_9_7).id)
		self.m_heroDes2.text = HeroTools.GetChargeTextByType(var_9_8.mechanism_type[1])

		if #var_9_8.ATK_attribute > 1 then
			self.attackTypeController:SetSelectedState(-1)
		else
			self.attackTypeController:SetSelectedState(var_9_8.ATK_attribute[1])
		end

		self.m_heroDes1.text = GetI18NText(HeroStandardSystemCfg[PolyhedronHeroCfg[var_9_7].standard_id].hero_desc)
		self.m_campIcon.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[var_9_8.race].icon)

		self.artifactFrameController:SetSelectedIndex(0)
	elseif self.data.class == PolyhedronConst.ITEM_TYPE.BLOOD then
		self.typeController:SetSelectedState("blood")

		local var_9_9 = self.data.params[1]

		if self.data.params[1] > 1000 then
			var_9_9 = 1000
		end

		self.m_name.text = ""
		self.desc = string.format(GetTips("POLYHEDRON_HP_REWARD_TIP"), math.floor(var_9_9 / 10) .. "%")
		self.m_desLab.text = self.desc

		self.artifactFrameController:SetSelectedIndex(0)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_desTrs)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_desContentTrs)
end

function PolyhedronRewardItem:SetSelected(arg_10_1)
	self.selectController:SetSelectedIndex(arg_10_1 == self.index and 1 or 0)
end

function PolyhedronRewardItem:RegistCallBack(arg_11_1)
	self.clickFunc = arg_11_1
end

function PolyhedronRewardItem:Dispose()
	self.m_eventTrigger:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerClick)
	PolyhedronRewardItem.super.Dispose(self)
end

return PolyhedronRewardItem
