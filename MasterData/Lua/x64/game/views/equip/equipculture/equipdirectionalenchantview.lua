local EquipDirectionalEnchantView = class("EquipDirectionalEnchantView", ReduxView)

function EquipDirectionalEnchantView:UIName()
	return "Widget/System/Hero_equip/Develop/HeroEquipDirectionalEnchant"
end

function EquipDirectionalEnchantView:UIParent()
	return manager.ui.uiMain.transform
end

function EquipDirectionalEnchantView:Init()
	self.titleHieght_ = 75
	self.itemHeight_ = 188

	self:InitUI()
	self:AddUIListeners()
end

function EquipDirectionalEnchantView:InitUI()
	self:BindCfgUI()

	self.enchantList_ = EquipSkillCfg.get_id_list_by_skill_type[EquipConst.EQUIP_ATTRIBUTE_TYPE.ENCHANT]
	self.attackScrollHelper_ = LuaList.New(handler(self, self.IndexAttackItem), self.skillListGo_1, DirectionalSkillItem)
	self.defenceScrollHelper_ = LuaList.New(handler(self, self.IndexDefenceItem), self.skillListGo_2, DirectionalSkillItem)
	self.subScrollHelper_ = LuaList.New(handler(self, self.IndexSubItem), self.skillListGo_3, DirectionalSkillItem)
	self.scrollRectList_ = {
		self.attackScrollHelper_,
		self.defenceScrollHelper_,
		self.subScrollHelper_
	}
	self.selectController_ = self.transCon_:GetController("select")
	self.confirmController_ = self.transCon_:GetController("confirm")
end

function EquipDirectionalEnchantView:InitPreview()
	self.skillList_ = {
		{},
		{},
		{}
	}
	self.skillLine_ = {}

	local var_5_0 = self.fixedSkillInfo_[self.selectFixedIndex_]

	for iter_5_0, iter_5_1 in ipairs(self.enchantList_) do
		local var_5_1 = EquipSkillCfg[iter_5_1]
		local var_5_2 = self.skillData_[iter_5_1]
		local var_5_3

		if self.skillData_[iter_5_1] then
			var_5_3 = var_5_2.num or 1

			if var_5_2 and (not var_5_0 or var_5_0 and var_5_0.skillId ~= iter_5_1) then
				var_5_3 = var_5_3 + 1
			end
		end

		local var_5_4 = self.heroId_ and var_5_3 <= EquipSkillCfg[iter_5_1].lvmax and HeroData:GetRecommendEquipSkill(self.heroId_, iter_5_1) or 0

		table.insert(self.skillList_[var_5_1.type], {
			id = iter_5_1,
			num = var_5_3,
			recommendLevel = var_5_4
		})
	end

	for iter_5_2, iter_5_3 in ipairs(self.skillList_) do
		table.sort(iter_5_3, function(arg_6_0, arg_6_1)
			if arg_6_0.recommendLevel == arg_6_1.recommendLevel then
				return arg_6_0.id < arg_6_1.id
			else
				return arg_6_0.recommendLevel > arg_6_1.recommendLevel
			end
		end)
	end

	for iter_5_4, iter_5_5 in ipairs(self.skillList_) do
		self.skillLine_[iter_5_4] = math.ceil(#iter_5_5 / 2)
	end

	local var_5_5

	var_5_5 = FrameTimer.New(function()
		for iter_7_0 = 1, 3 do
			SetActive(self["skillRect_" .. iter_7_0].transform.gameObject, true)
			self["skillRect_" .. iter_7_0].transform:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, self.titleHieght_ + self.itemHeight_ * self.skillLine_[iter_7_0])
			self["skillListGo_" .. iter_7_0].transform:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, self.itemHeight_ * self.skillLine_[iter_7_0])
			self["skillRect_" .. iter_7_0].transform:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, self.content_.rect.width)
		end

		self.attackScrollHelper_:StartScroll(#self.skillList_[1])
		self.defenceScrollHelper_:StartScroll(#self.skillList_[2])
		self.subScrollHelper_:StartScroll(#self.skillList_[3])
		var_5_5:Stop()
	end, 1, 1)

	;(nil):Start()
end

function EquipDirectionalEnchantView:IndexAttackItem(arg_8_1, arg_8_2)
	self:CheckSkillItem(self.skillList_[1][arg_8_1].id, arg_8_2)
	arg_8_2:RefreshData(self.skillList_[1][arg_8_1], self.heroId_)
	arg_8_2:RegisterClickFunc(handler(self, self.OnClickSkillItem))
end

function EquipDirectionalEnchantView:IndexDefenceItem(arg_9_1, arg_9_2)
	self:CheckSkillItem(self.skillList_[2][arg_9_1].id, arg_9_2)
	arg_9_2:RefreshData(self.skillList_[2][arg_9_1], self.heroId_)
	arg_9_2:RegisterClickFunc(handler(self, self.OnClickSkillItem))
end

function EquipDirectionalEnchantView:IndexSubItem(arg_10_1, arg_10_2)
	self:CheckSkillItem(self.skillList_[3][arg_10_1].id, arg_10_2)
	arg_10_2:RefreshData(self.skillList_[3][arg_10_1], self.heroId_)
	arg_10_2:RegisterClickFunc(handler(self, self.OnClickSkillItem))
end

function EquipDirectionalEnchantView:InitFixedSkill()
	self.fixedSkills = {}

	for iter_11_0 = 1, 2 do
		local var_11_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_11_0, self["enchantSkill_" .. iter_11_0])

		var_11_0.nullController_ = var_11_0.transCon_:GetController("null")
		var_11_0.recommendController_ = var_11_0.transCon_:GetController("recommend")

		self:AddBtnListener(var_11_0.btnInfo_, nil, function()
			if iter_11_0 == 2 and self.fixedSkillInfo_[1] == nil then
				return
			end

			self:OnChangeFixedSkill(iter_11_0)
		end)

		if self.fixedSkillInfo_[iter_11_0] then
			var_11_0.nullController_:SetSelectedState("skill")

			var_11_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. EquipSkillCfg[self.fixedSkillInfo_[iter_11_0].skillId].icon)
			var_11_0.name_.text = GetI18NText(EquipSkillCfg[self.fixedSkillInfo_[iter_11_0].skillId].name)
			var_11_0.num_.text = self.fixedSkillInfo_[iter_11_0].numText
			var_11_0.desc_.text = self.fixedSkillInfo_[iter_11_0].descText
		else
			var_11_0.nullController_:SetSelectedState("null")
		end

		table.insert(self.fixedSkills, var_11_0)
	end
end

function EquipDirectionalEnchantView:OnEnter()
	self.heroId_ = self.params_.heroId
	self.equipId_ = self.params_.equipId
	self.enchantPos_ = self.params_.enchantPos
	self.equip_ = EquipData:GetEquipData(self.equipId_)
	self.heroViewDataProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	self.skillData_ = EquipTools.RefreshSkillData(self.equip_, self.heroId_, self.heroViewDataProxy_)
	self.fixedSkillInfo_ = self:RreshFixedSkill()
	self.selectFixedIndex_ = 1
	self.skillItemList_ = {}
	self.skillCanClick_ = {}

	self:InitPreview()
	self:InitFixedSkill()
	self:RegistEventListener(DIRECTIONAL_ENCHANT_SUCCESS, handler(self, self.OnEnchantSkillChange))
	self.selectController_:SetSelectedState(self.selectFixedIndex_)
	self.confirmController_:SetSelectedState("false")

	self.scrollRect_.verticalNormalizedPosition = 1
end

function EquipDirectionalEnchantView:AddUIListeners()
	self:AddBtnListener(self.btnGiveUp_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.btnNotSelect_, nil, function()
		ShowTips(GetTips("EQUIP_CHOOSE_ORIENTIATION"))
	end)
	self:AddBtnListener(self.btnConfirm_, nil, function()
		local var_17_0 = ItemTools.getItemNum(self.materials_[1])

		if var_17_0 < self.materials_[2] then
			ShowPopItem(POP_SOURCE_ITEM, {
				self.materials_[1],
				var_17_0
			})

			return
		end

		local var_17_1 = self.fixedSkillInfo_[self.selectFixedIndex_] and self.fixedSkillInfo_[self.selectFixedIndex_].skillId
		local var_17_2 = EquipSkillCfg[self.selectSkillId_].name
		local var_17_3 = var_17_1 and EquipSkillCfg[var_17_1].name and string.format(GetTips("EQUIP_DIRECTIONAL_PROMPT_TWO"), GetI18NText(var_17_1 and EquipSkillCfg[var_17_1].name), GetI18NText(var_17_2)) or string.format(GetTips("EQUIP_DIRECTIONAL_PROMPT"), GetI18NText(var_17_2))

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = var_17_3,
			OkCallback = function()
				EquipAction.DirectionalEnchant(self.equipId_, self.enchantPos_, self.selectFixedIndex_, self.selectSkillId_)
			end
		})
	end)
	self:AddBtnListener(self.btnCheckSkill_, nil, function()
		JumpTools.OpenPageByJump("totalEnchantSkillPop", {
			proxy = self.heroViewDataProxy_,
			heroId = self.heroId_,
			equipId = self.equipId_
		})
	end)
end

function EquipDirectionalEnchantView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:RefreshMaterial()
end

function EquipDirectionalEnchantView:RefreshMaterial()
	self.materialText_.text = GetTips("EQUIP_DIRECTIONAL_DESC")
	self.materials_ = EquipMaterialCfg[((GameSetting.equip_enchant_directional_cost or nil) and (GameSetting.equip_enchant_directional_cost.value or {}))[1]].item_list[1]

	local var_21_0 = ItemTools.getItemNum(self.materials_[1])

	if not self.materialItem_ then
		self.materialItem_ = CommonItemView.New(self.material_1)

		local var_21_1 = clone(ItemTemplateData)

		var_21_1.id = self.materials_[1]
		var_21_1.hideBottomRightTextFlag = true

		function var_21_1.clickFun()
			ShowPopItem(POP_SOURCE_ITEM, {
				self.materials_[1],
				var_21_0
			})
		end

		self.materialItem_:SetData(var_21_1)
	end

	self.materialItem_:RefreshBottomText({
		var_21_0,
		self.materials_[2]
	})
end

function EquipDirectionalEnchantView:OnChangeFixedSkill(arg_23_1)
	if self.selectFixedIndex_ == arg_23_1 then
		return
	end

	self.selectController_:SetSelectedState(arg_23_1)

	self.selectFixedIndex_ = arg_23_1

	local var_23_0 = self.fixedSkillInfo_[self.selectFixedIndex_]

	for iter_23_0, iter_23_1 in ipairs(self.skillItemList_) do
		local var_23_1 = iter_23_1:GetItemInfo()
		local var_23_2 = self.skillData_[var_23_1.id]
		local var_23_3

		if self.skillData_[var_23_1.id] then
			var_23_3 = var_23_2.num or 1

			if var_23_2 and (not var_23_0 or var_23_0 and var_23_0.skillId ~= var_23_1.id) then
				var_23_3 = var_23_3 + 1
			end
		end

		iter_23_1:RefreshData({
			id = var_23_1.id,
			num = var_23_3,
			recommendLevel = var_23_1.recommendLevel
		}, self.heroId_)
	end

	self:ClearSelect()

	self.scrollRect_.verticalNormalizedPosition = 1

	manager.notify:Invoke(DIRECTIONAL_ENCHANT_SLOT_CHANGE)
end

function EquipDirectionalEnchantView:CheckSkillItem(arg_24_1, arg_24_2)
	for iter_24_0 = 1, 2 do
		if self.fixedSkillInfo_[iter_24_0] and self.fixedSkillInfo_[iter_24_0].skillId == arg_24_1 then
			self.skillItemList_[iter_24_0] = arg_24_2
			self.skillCanClick_[iter_24_0] = true
		end
	end
end

function EquipDirectionalEnchantView:OnClickSkillItem(arg_25_1, arg_25_2)
	if self.selectItem_ then
		self.selectItem_:ShowSelect(false)
	end

	self.selectItem_ = arg_25_1
	self.selectSkillId_ = arg_25_2

	self.selectItem_:ShowSelect(true)
	self.confirmController_:SetSelectedState("true")
end

function EquipDirectionalEnchantView:ClearSelect()
	if self.selectItem_ then
		self.selectItem_:ShowSelect(false)

		self.selectItem_ = nil
		self.selectSkillId_ = nil

		self.confirmController_:SetSelectedState("false")
	end
end

function EquipDirectionalEnchantView:OnEnchantSkillChange()
	self:Back()
end

function EquipDirectionalEnchantView:RreshFixedSkill(arg_28_1)
	local var_28_0 = self.equip_.enchant[self.enchantPos_] or {}
	local var_28_1 = {}

	for iter_28_0 = 1, 2 do
		if var_28_0[iter_28_0] then
			local var_28_2 = var_28_0[iter_28_0].id
			local var_28_3 = EquipSkillCfg[var_28_0[iter_28_0].id]
			local var_28_4

			if self.skillData_[var_28_0[iter_28_0].id] then
				var_28_4 = self.skillData_[var_28_2].num or var_28_0[iter_28_0].num
			end

			local var_28_5 = string.format("%s/%s", var_28_4 > var_28_3.lvmax and string.format("<color=#FF000B>%s</color>", var_28_4) or var_28_4, var_28_3.lvmax)
			local var_28_6 = var_28_3.upgrade / var_28_3.percent * ((var_28_4 > var_28_3.lvmax or nil) and (var_28_3.lvmax or var_28_4))
			local var_28_7 = GetCfgDescriptionWithValue(var_28_3.desc[1], tostring(var_28_3.upgrade / var_28_3.percent * ((var_28_4 > var_28_3.lvmax or nil) and (var_28_3.lvmax or var_28_4))))

			if var_28_3.desc_spec_value ~= nil and var_28_3.desc_spec_value ~= "" then
				var_28_7 = string.gsub(var_28_7, tostring(var_28_6), var_28_3.desc_spec_value[self.cfg_.num])
			end

			local var_28_8 = self.heroId_ and var_28_4 <= var_28_3.lvmax and HeroData:GetRecommendEquipSkill(self.heroId_, var_28_2) or 0

			var_28_1[iter_28_0] = {
				skillId = var_28_2,
				numText = var_28_5,
				descText = var_28_7,
				recommendLevel = var_28_8
			}
		else
			var_28_1[iter_28_0] = nil
		end
	end

	return var_28_1
end

function EquipDirectionalEnchantView:OnExit()
	self.selectFixedIndex_ = 1

	if self.selectItem_ then
		self.selectItem_:ShowSelect(false)

		self.selectItem_ = nil
	end
end

function EquipDirectionalEnchantView:Dispose()
	self:RemoveAllListeners()
	self.attackScrollHelper_:Dispose()
	self.defenceScrollHelper_:Dispose()
	self.subScrollHelper_:Dispose()
	EquipDirectionalEnchantView.super.Dispose(self)
end

return EquipDirectionalEnchantView
