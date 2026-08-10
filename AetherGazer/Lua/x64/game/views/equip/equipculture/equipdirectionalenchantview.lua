local var_0_0 = class("EquipDirectionalEnchantView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_equip/Develop/HeroEquipDirectionalEnchant"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.titleHieght_ = 75
	arg_3_0.itemHeight_ = 188

	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.enchantList_ = EquipSkillCfg.get_id_list_by_skill_type[EquipConst.EQUIP_ATTRIBUTE_TYPE.ENCHANT]
	arg_4_0.attackScrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexAttackItem), arg_4_0.skillListGo_1, DirectionalSkillItem)
	arg_4_0.defenceScrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexDefenceItem), arg_4_0.skillListGo_2, DirectionalSkillItem)
	arg_4_0.subScrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexSubItem), arg_4_0.skillListGo_3, DirectionalSkillItem)
	arg_4_0.scrollRectList_ = {
		arg_4_0.attackScrollHelper_,
		arg_4_0.defenceScrollHelper_,
		arg_4_0.subScrollHelper_
	}
	arg_4_0.selectController_ = arg_4_0.transCon_:GetController("select")
	arg_4_0.confirmController_ = arg_4_0.transCon_:GetController("confirm")
end

function var_0_0.InitPreview(arg_5_0)
	arg_5_0.skillList_ = {
		{},
		{},
		{}
	}
	arg_5_0.skillLine_ = {}

	local var_5_0 = arg_5_0.fixedSkillInfo_[arg_5_0.selectFixedIndex_]

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.enchantList_) do
		local var_5_1 = EquipSkillCfg[iter_5_1]
		local var_5_2 = arg_5_0.skillData_[iter_5_1]
		local var_5_3 = var_5_2 and var_5_2.num or 1

		if var_5_2 and (not var_5_0 or var_5_0 and var_5_0.skillId ~= iter_5_1) then
			var_5_3 = var_5_3 + 1
		end

		local var_5_4 = arg_5_0.heroId_ and var_5_3 <= EquipSkillCfg[iter_5_1].lvmax and HeroData:GetRecommendEquipSkill(arg_5_0.heroId_, iter_5_1) or 0

		table.insert(arg_5_0.skillList_[var_5_1.type], {
			id = iter_5_1,
			num = var_5_3,
			recommendLevel = var_5_4
		})
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_0.skillList_) do
		table.sort(iter_5_3, function(arg_6_0, arg_6_1)
			if arg_6_0.recommendLevel == arg_6_1.recommendLevel then
				return arg_6_0.id < arg_6_1.id
			else
				return arg_6_0.recommendLevel > arg_6_1.recommendLevel
			end
		end)
	end

	for iter_5_4, iter_5_5 in ipairs(arg_5_0.skillList_) do
		arg_5_0.skillLine_[iter_5_4] = math.ceil(#iter_5_5 / 2)
	end

	local var_5_5

	var_5_5 = FrameTimer.New(function()
		for iter_7_0 = 1, 3 do
			local var_7_0 = arg_5_0["skillRect_" .. iter_7_0].transform

			SetActive(var_7_0.gameObject, true)

			local var_7_1 = arg_5_0["skillListGo_" .. iter_7_0].transform
			local var_7_2 = arg_5_0.skillLine_[iter_7_0]
			local var_7_3 = arg_5_0.titleHieght_ + arg_5_0.itemHeight_ * var_7_2

			var_7_0:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, var_7_3)
			var_7_1:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, arg_5_0.itemHeight_ * var_7_2)
			var_7_0:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, arg_5_0.content_.rect.width)
		end

		arg_5_0.attackScrollHelper_:StartScroll(#arg_5_0.skillList_[1])
		arg_5_0.defenceScrollHelper_:StartScroll(#arg_5_0.skillList_[2])
		arg_5_0.subScrollHelper_:StartScroll(#arg_5_0.skillList_[3])
		var_5_5:Stop()
	end, 1, 1)

	var_5_5:Start()
end

function var_0_0.IndexAttackItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.skillList_[1][arg_8_1]

	arg_8_0:CheckSkillItem(var_8_0.id, arg_8_2)
	arg_8_2:RefreshData(var_8_0, arg_8_0.heroId_)
	arg_8_2:RegisterClickFunc(handler(arg_8_0, arg_8_0.OnClickSkillItem))
end

function var_0_0.IndexDefenceItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.skillList_[2][arg_9_1]

	arg_9_0:CheckSkillItem(var_9_0.id, arg_9_2)
	arg_9_2:RefreshData(var_9_0, arg_9_0.heroId_)
	arg_9_2:RegisterClickFunc(handler(arg_9_0, arg_9_0.OnClickSkillItem))
end

function var_0_0.IndexSubItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.skillList_[3][arg_10_1]

	arg_10_0:CheckSkillItem(var_10_0.id, arg_10_2)
	arg_10_2:RefreshData(var_10_0, arg_10_0.heroId_)
	arg_10_2:RegisterClickFunc(handler(arg_10_0, arg_10_0.OnClickSkillItem))
end

function var_0_0.InitFixedSkill(arg_11_0)
	arg_11_0.fixedSkills = {}

	for iter_11_0 = 1, 2 do
		local var_11_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_11_0, arg_11_0["enchantSkill_" .. iter_11_0])

		var_11_0.nullController_ = var_11_0.transCon_:GetController("null")
		var_11_0.recommendController_ = var_11_0.transCon_:GetController("recommend")

		arg_11_0:AddBtnListener(var_11_0.btnInfo_, nil, function()
			if iter_11_0 == 2 and arg_11_0.fixedSkillInfo_[1] == nil then
				return
			end

			arg_11_0:OnChangeFixedSkill(iter_11_0)
		end)

		local var_11_1 = arg_11_0.fixedSkillInfo_[iter_11_0]

		if var_11_1 then
			var_11_0.nullController_:SetSelectedState("skill")

			local var_11_2 = EquipSkillCfg[var_11_1.skillId]

			var_11_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. var_11_2.icon)
			var_11_0.name_.text = GetI18NText(var_11_2.name)
			var_11_0.num_.text = var_11_1.numText
			var_11_0.desc_.text = var_11_1.descText
		else
			var_11_0.nullController_:SetSelectedState("null")
		end

		table.insert(arg_11_0.fixedSkills, var_11_0)
	end
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.heroId_ = arg_13_0.params_.heroId
	arg_13_0.equipId_ = arg_13_0.params_.equipId
	arg_13_0.enchantPos_ = arg_13_0.params_.enchantPos
	arg_13_0.equip_ = EquipData:GetEquipData(arg_13_0.equipId_)
	arg_13_0.heroViewDataProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	arg_13_0.skillData_ = EquipTools.RefreshSkillData(arg_13_0.equip_, arg_13_0.heroId_, arg_13_0.heroViewDataProxy_)
	arg_13_0.fixedSkillInfo_ = arg_13_0:RreshFixedSkill()
	arg_13_0.selectFixedIndex_ = 1
	arg_13_0.skillItemList_ = {}
	arg_13_0.skillCanClick_ = {}

	arg_13_0:InitPreview()
	arg_13_0:InitFixedSkill()
	arg_13_0:RegistEventListener(DIRECTIONAL_ENCHANT_SUCCESS, handler(arg_13_0, arg_13_0.OnEnchantSkillChange))
	arg_13_0.selectController_:SetSelectedState(arg_13_0.selectFixedIndex_)
	arg_13_0.confirmController_:SetSelectedState("false")

	arg_13_0.scrollRect_.verticalNormalizedPosition = 1
end

function var_0_0.AddUIListeners(arg_14_0)
	arg_14_0:AddBtnListener(arg_14_0.btnGiveUp_, nil, function()
		arg_14_0:Back()
	end)
	arg_14_0:AddBtnListener(arg_14_0.btnNotSelect_, nil, function()
		ShowTips(GetTips("EQUIP_CHOOSE_ORIENTIATION"))
	end)
	arg_14_0:AddBtnListener(arg_14_0.btnConfirm_, nil, function()
		local var_17_0 = ItemTools.getItemNum(arg_14_0.materials_[1])

		if var_17_0 < arg_14_0.materials_[2] then
			ShowPopItem(POP_SOURCE_ITEM, {
				arg_14_0.materials_[1],
				var_17_0
			})

			return
		end

		local var_17_1 = arg_14_0.fixedSkillInfo_[arg_14_0.selectFixedIndex_] and arg_14_0.fixedSkillInfo_[arg_14_0.selectFixedIndex_].skillId
		local var_17_2 = var_17_1 and EquipSkillCfg[var_17_1].name
		local var_17_3 = EquipSkillCfg[arg_14_0.selectSkillId_].name
		local var_17_4 = var_17_2 and string.format(GetTips("EQUIP_DIRECTIONAL_PROMPT_TWO"), GetI18NText(var_17_2), GetI18NText(var_17_3)) or string.format(GetTips("EQUIP_DIRECTIONAL_PROMPT"), GetI18NText(var_17_3))

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = var_17_4,
			OkCallback = function()
				EquipAction.DirectionalEnchant(arg_14_0.equipId_, arg_14_0.enchantPos_, arg_14_0.selectFixedIndex_, arg_14_0.selectSkillId_)
			end
		})
	end)
	arg_14_0:AddBtnListener(arg_14_0.btnCheckSkill_, nil, function()
		JumpTools.OpenPageByJump("totalEnchantSkillPop", {
			proxy = arg_14_0.heroViewDataProxy_,
			heroId = arg_14_0.heroId_,
			equipId = arg_14_0.equipId_
		})
	end)
end

function var_0_0.OnTop(arg_20_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_20_0:RefreshMaterial()
end

function var_0_0.RefreshMaterial(arg_21_0)
	arg_21_0.materialText_.text = GetTips("EQUIP_DIRECTIONAL_DESC")

	local var_21_0 = GameSetting.equip_enchant_directional_cost and GameSetting.equip_enchant_directional_cost.value or {}

	arg_21_0.materials_ = EquipMaterialCfg[var_21_0[1]].item_list[1]

	local var_21_1 = ItemTools.getItemNum(arg_21_0.materials_[1])
	local var_21_2 = arg_21_0.materials_[2]

	if not arg_21_0.materialItem_ then
		arg_21_0.materialItem_ = CommonItemView.New(arg_21_0.material_1)

		local var_21_3 = clone(ItemTemplateData)

		var_21_3.id = arg_21_0.materials_[1]
		var_21_3.hideBottomRightTextFlag = true

		function var_21_3.clickFun()
			ShowPopItem(POP_SOURCE_ITEM, {
				arg_21_0.materials_[1],
				var_21_1
			})
		end

		arg_21_0.materialItem_:SetData(var_21_3)
	end

	arg_21_0.materialItem_:RefreshBottomText({
		var_21_1,
		var_21_2
	})
end

function var_0_0.OnChangeFixedSkill(arg_23_0, arg_23_1)
	if arg_23_0.selectFixedIndex_ == arg_23_1 then
		return
	end

	arg_23_0.selectController_:SetSelectedState(arg_23_1)

	arg_23_0.selectFixedIndex_ = arg_23_1

	local var_23_0 = arg_23_0.fixedSkillInfo_[arg_23_0.selectFixedIndex_]

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.skillItemList_) do
		local var_23_1 = iter_23_1:GetItemInfo()
		local var_23_2 = arg_23_0.skillData_[var_23_1.id]
		local var_23_3 = var_23_2 and var_23_2.num or 1

		if var_23_2 and (not var_23_0 or var_23_0 and var_23_0.skillId ~= var_23_1.id) then
			var_23_3 = var_23_3 + 1
		end

		local var_23_4 = {
			id = var_23_1.id,
			num = var_23_3,
			recommendLevel = var_23_1.recommendLevel
		}

		iter_23_1:RefreshData(var_23_4, arg_23_0.heroId_)
	end

	arg_23_0:ClearSelect()

	arg_23_0.scrollRect_.verticalNormalizedPosition = 1

	manager.notify:Invoke(DIRECTIONAL_ENCHANT_SLOT_CHANGE)
end

function var_0_0.CheckSkillItem(arg_24_0, arg_24_1, arg_24_2)
	for iter_24_0 = 1, 2 do
		if arg_24_0.fixedSkillInfo_[iter_24_0] and arg_24_0.fixedSkillInfo_[iter_24_0].skillId == arg_24_1 then
			arg_24_0.skillItemList_[iter_24_0] = arg_24_2
			arg_24_0.skillCanClick_[iter_24_0] = true
		end
	end
end

function var_0_0.OnClickSkillItem(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_0.selectItem_ then
		arg_25_0.selectItem_:ShowSelect(false)
	end

	arg_25_0.selectItem_ = arg_25_1
	arg_25_0.selectSkillId_ = arg_25_2

	arg_25_0.selectItem_:ShowSelect(true)
	arg_25_0.confirmController_:SetSelectedState("true")
end

function var_0_0.ClearSelect(arg_26_0)
	if arg_26_0.selectItem_ then
		arg_26_0.selectItem_:ShowSelect(false)

		arg_26_0.selectItem_ = nil
		arg_26_0.selectSkillId_ = nil

		arg_26_0.confirmController_:SetSelectedState("false")
	end
end

function var_0_0.OnEnchantSkillChange(arg_27_0)
	arg_27_0:Back()
end

function var_0_0.RreshFixedSkill(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.equip_.enchant[arg_28_0.enchantPos_] or {}
	local var_28_1 = {}

	for iter_28_0 = 1, 2 do
		local var_28_2 = var_28_0[iter_28_0]

		if var_28_2 then
			local var_28_3 = var_28_2.id
			local var_28_4 = EquipSkillCfg[var_28_3]
			local var_28_5 = arg_28_0.skillData_[var_28_3] and arg_28_0.skillData_[var_28_3].num or var_28_2.num
			local var_28_6 = var_28_5 > var_28_4.lvmax and string.format("<color=#FF000B>%s</color>", var_28_5) or var_28_5
			local var_28_7 = string.format("%s/%s", var_28_6, var_28_4.lvmax)
			local var_28_8 = var_28_5 > var_28_4.lvmax and var_28_4.lvmax or var_28_5
			local var_28_9 = var_28_4.upgrade / var_28_4.percent * var_28_8
			local var_28_10 = GetCfgDescriptionWithValue(var_28_4.desc[1], tostring(var_28_9))

			if var_28_4.desc_spec_value ~= nil and var_28_4.desc_spec_value ~= "" then
				var_28_10 = string.gsub(var_28_10, tostring(var_28_9), var_28_4.desc_spec_value[arg_28_0.cfg_.num])
			end

			local var_28_11 = arg_28_0.heroId_ and var_28_5 <= var_28_4.lvmax and HeroData:GetRecommendEquipSkill(arg_28_0.heroId_, var_28_3) or 0

			var_28_1[iter_28_0] = {
				skillId = var_28_3,
				numText = var_28_7,
				descText = var_28_10,
				recommendLevel = var_28_11
			}
		else
			var_28_1[iter_28_0] = nil
		end
	end

	return var_28_1
end

function var_0_0.OnExit(arg_29_0)
	arg_29_0.selectFixedIndex_ = 1

	if arg_29_0.selectItem_ then
		arg_29_0.selectItem_:ShowSelect(false)

		arg_29_0.selectItem_ = nil
	end
end

function var_0_0.Dispose(arg_30_0)
	arg_30_0:RemoveAllListeners()
	arg_30_0.attackScrollHelper_:Dispose()
	arg_30_0.defenceScrollHelper_:Dispose()
	arg_30_0.subScrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_30_0)
end

return var_0_0
