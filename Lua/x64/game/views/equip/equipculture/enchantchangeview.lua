local var_0_0 = import("game.views.equip.equipCulture.EquipBaseView")
local var_0_1 = class("EnchantChangeView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Hero_equip/Develop/HeroEquipEnchant"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_1.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
	var_0_1.super.Init(arg_3_0)

	arg_3_0.max = GameSetting.equip_enchant_save_num.value[1] or 0
	arg_3_0.isLockedSkill_ = false
	arg_3_0.lockedIndex_ = nil
	arg_3_0.standardRatio_ = 0.09270833333333334
end

function var_0_1.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.skillPreItems_ = {}
	arg_4_0.items_ = {}
	arg_4_0.materialIndex = 1
	arg_4_0.skillPopView_ = EquipNewSkillInfoView.New(arg_4_0.equipSkillPopGo_)
	arg_4_0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
	arg_4_0.enchantScroller_ = LuaList.New(handler(arg_4_0, arg_4_0.indexPreviewItem), arg_4_0.enchantListGo_, EquipEnchantPreviewItem)
	arg_4_0.giveupController_ = arg_4_0.transCon_:GetController("allGiveup")
	arg_4_0.popController_ = arg_4_0.transCon_:GetController("pop")

	arg_4_0:InitFixedSkill()
	arg_4_0:InitMaterial()
end

function var_0_1.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnEnchant_, nil, function()
		arg_5_0:OnEnchantClick()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnGiveUp_, nil, function()
		if arg_5_0.enchantPreviewList and #arg_5_0.enchantPreviewList > 0 then
			EquipAction.QueryEquipGiveUpAllEnchant(arg_5_0.equipId, arg_5_0.enchatPos)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnHidePopMask_, nil, function()
		arg_5_0:HidePop()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnAccess_, nil, function()
		local var_9_0 = arg_5_0.materials_[arg_5_0.materialIndex]
		local var_9_1 = var_9_0.id
		local var_9_2 = ItemTools.getItemNum(var_9_0.id)

		ShowPopItem(POP_SOURCE_ITEM, {
			var_9_1,
			var_9_2
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnCheckSkill_, nil, function()
		JumpTools.OpenPageByJump("totalEnchantSkillPop", {
			proxy = arg_5_0.heroViewDataProxy_,
			heroId = arg_5_0.heroID_,
			equipId = arg_5_0.equipId
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnDirectionalSkill_, nil, function()
		if arg_5_0.isLockedSkill_ then
			arg_5_0:OnLockClick(arg_5_0.lockedIndex_)
		end

		JumpTools.OpenPageByJump("equipDirectionalEnchant", {
			heroId = arg_5_0.heroID_,
			equipId = arg_5_0.equipId,
			enchantPos = arg_5_0.enchatPos
		})
	end)
end

function var_0_1.OnEnter(arg_12_0)
	arg_12_0.equipId = arg_12_0.params_.equipId
	arg_12_0.enchatPos = arg_12_0.params_.enchatPos
	arg_12_0.equipData = EquipData:GetEquipData(arg_12_0.equipId)
	arg_12_0.heroID_ = arg_12_0.equipData:GetEquipHero()
	arg_12_0.heroViewDataProxy_ = arg_12_0.params_.proxy or HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)

	arg_12_0:RefreshSkillData()
	arg_12_0:RefreshSelect()
	arg_12_0:RefreshUI()
	arg_12_0:ShowBar()
	arg_12_0:RegistEventListener(CURRENCY_UPDATE, handler(arg_12_0, arg_12_0.OnGoldChange))
	arg_12_0:RegistEventListener(MATERIAL_MODIFY, handler(arg_12_0, arg_12_0.OnMaterialModify))
	arg_12_0:RegistEventListener(DIRECTIONAL_ENCHANT_SUCCESS, handler(arg_12_0, arg_12_0.OnEnchantSkillChange))
end

function var_0_1.ShowBar(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
end

function var_0_1.OnTop(arg_14_0)
	arg_14_0:ShowBar()
end

function var_0_1.RefreshSkillData(arg_15_0)
	arg_15_0.skillList_ = EquipTools.RefreshSkillData(arg_15_0.equipData, arg_15_0.heroID_, arg_15_0.heroViewDataProxy_)
end

function var_0_1.InitFixedSkill(arg_16_0)
	arg_16_0.fixedSkills = {}

	for iter_16_0 = 1, 2 do
		local var_16_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_16_0, arg_16_0["enchantSkill_" .. iter_16_0])

		var_16_0.selectController_ = var_16_0.transCon_:GetController("select")
		var_16_0.lockController_ = var_16_0.transCon_:GetController("lock")
		var_16_0.nullController_ = var_16_0.transCon_:GetController("null")
		var_16_0.recommendController_ = var_16_0.transCon_:GetController("recommend")

		arg_16_0:AddBtnListener(var_16_0.btnLock_, nil, function()
			arg_16_0:OnLockClick(iter_16_0)
		end)
		arg_16_0:AddBtnListener(var_16_0.btnInfo_, nil, function()
			if var_16_0.isSkill then
				arg_16_0:OnSkillClick(var_16_0, arg_16_0.skillList_[var_16_0.id], iter_16_0)
			end
		end)
		table.insert(arg_16_0.fixedSkills, var_16_0)
	end
end

function var_0_1.InitMaterial(arg_19_0)
	arg_19_0.materials_ = EquipData:GetEnchantMaterial()
	arg_19_0.showLockMaterials_ = EquipData:GetLockEnchantMaterial()
	arg_19_0.materialGoList_ = {}

	for iter_19_0 = 1, #arg_19_0.materials_ do
		local var_19_0 = CommonItemView.New(arg_19_0["material_" .. iter_19_0])
		local var_19_1 = clone(ItemTemplateData)

		var_19_1.id = arg_19_0.materials_[iter_19_0].id
		var_19_1.number = nil

		function var_19_1.clickFun()
			if arg_19_0.isLockedSkill_ then
				-- block empty
			else
				arg_19_0:OnMarerialChange(iter_19_0)
			end
		end

		var_19_0:SetData(var_19_1)

		arg_19_0.materialGoList_[iter_19_0] = var_19_0
	end
end

function var_0_1.RefreshSelect(arg_21_0)
	local var_21_0 = EquipData:GetIsSetLockView(arg_21_0.equipId, arg_21_0.enchatPos)

	arg_21_0.fixedSkills[1].lockController_:SetSelectedState(var_21_0 == 1 and "lock" or "unlock")
	arg_21_0.fixedSkills[2].lockController_:SetSelectedState(var_21_0 == 2 and "lock" or "unlock")

	if var_21_0 then
		arg_21_0:OnMarerialChange(3)

		arg_21_0.isLockedSkill_ = true
		arg_21_0.lockedIndex_ = var_21_0

		arg_21_0:RreshMateriaMoney()
	else
		arg_21_0.materialIndex = EquipData:GetSelectEnchantMaterialIndex()

		arg_21_0:OnMarerialChange(arg_21_0.materialIndex)
	end
end

function var_0_1.RefreshUI(arg_22_0)
	arg_22_0:RreshMaterialUI()
	arg_22_0:RreshFixedSkill()
	arg_22_0:RefreshBottom()
end

function var_0_1.RreshMaterialUI(arg_23_0)
	local var_23_0 = arg_23_0.materialGoList_

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		local var_23_1 = arg_23_0.materials_[iter_23_0]
		local var_23_2 = arg_23_0.showLockMaterials_[iter_23_0]
		local var_23_3 = ItemTools.getItemNum(var_23_1.id)
		local var_23_4 = arg_23_0.isLockedSkill_ and var_23_2.number or var_23_1.number

		iter_23_1:RefreshBottomText({
			var_23_3,
			var_23_4
		})
		iter_23_1:RefreshLock(arg_23_0.isLockedSkill_ and not var_23_2.lock or false)
	end
end

function var_0_1.RreshFixedSkill(arg_24_0, arg_24_1)
	local var_24_0 = EquipData:GetEquipData(arg_24_0.equipId).enchant[arg_24_0.enchatPos] or {}

	if arg_24_1 then
		arg_24_0.glowAnim_:Play("glow_bg")
	end

	arg_24_0.fixedSkillIds_ = {}
	arg_24_0.fixedSkillInfo_ = {}

	for iter_24_0 = 1, 2 do
		local var_24_1 = var_24_0[iter_24_0]
		local var_24_2 = arg_24_0.fixedSkills[iter_24_0]

		if var_24_1 then
			var_24_2.id = var_24_1.id

			local var_24_3 = EquipSkillCfg[var_24_1.id]
			local var_24_4 = arg_24_0.skillList_[var_24_1.id] and arg_24_0.skillList_[var_24_1.id].num or var_24_1.num

			arg_24_0.fixedSkillIds_[var_24_1.id] = arg_24_0.fixedSkillIds_[var_24_1.id] and arg_24_0.fixedSkillIds_[var_24_1.id] + 1 or 1

			local var_24_5 = var_24_4 > var_24_3.lvmax and string.format("<color=#FF000B>%s</color>", var_24_4) or var_24_4
			local var_24_6 = string.format("%s/%s", var_24_5, var_24_3.lvmax)

			var_24_2.num_.text = var_24_6

			local var_24_7 = var_24_4 > var_24_3.lvmax and var_24_3.lvmax or var_24_4
			local var_24_8 = var_24_3.upgrade / var_24_3.percent * var_24_7
			local var_24_9 = GetCfgDescriptionWithValue(var_24_3.desc[1], tostring(var_24_8))

			if var_24_3.desc_spec_value ~= nil and var_24_3.desc_spec_value ~= "" then
				var_24_9 = string.gsub(var_24_9, tostring(var_24_8), var_24_3.desc_spec_value[arg_24_0.cfg_.num])
			end

			var_24_2.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. var_24_3.icon)
			var_24_2.name_.text = GetI18NText(var_24_3.name)
			var_24_2.desc_.text = var_24_9

			var_24_2.nullController_:SetSelectedState("skill")

			var_24_2.isSkill = true

			local var_24_10 = arg_24_0.heroID_ and var_24_4 <= var_24_3.lvmax and HeroData:GetRecommendEquipSkill(arg_24_0.heroID_, var_24_1.id) or 0

			var_24_2.recommendController_:SetSelectedState(var_24_10)

			arg_24_0.fixedSkillInfo_[iter_24_0] = {
				skillId = var_24_1.id,
				numText = var_24_6,
				descText = var_24_9,
				recommendLevel = var_24_10
			}
		else
			var_24_2.isSkill = false

			var_24_2.nullController_:SetSelectedState("null")
			var_24_2.recommendController_:SetSelectedState(0)

			arg_24_0.fixedSkillInfo_[iter_24_0] = nil
		end
	end
end

function var_0_1.RefreshBottom(arg_25_0, arg_25_1)
	arg_25_0.enchantPreviewList = EquipData:GetEquipData(arg_25_0.equipId).enchant_preview[arg_25_0.enchatPos]
	arg_25_0.enchantNum_.text = string.format(GetTips("ENCHANT_PREVIEW_NUM"), #arg_25_0.enchantPreviewList, arg_25_0.max)

	arg_25_0.giveupController_:SetSelectedState(#arg_25_0.enchantPreviewList == 0 and "off" or "on")

	if arg_25_1 then
		if arg_25_1.scrollToIndex then
			local var_25_0 = math.max(0, #arg_25_0.enchantPreviewList)

			arg_25_0:ShowGlowAnim(var_25_0)

			arg_25_0.targetIndex_ = var_25_0

			local var_25_1 = math.max(0, var_25_0 - 1)

			arg_25_0.enchantScroller_:ScrollToIndex(var_25_1, true, true)
			arg_25_0.enchantScroller_:Refresh()
		elseif arg_25_1.keepScrollPos then
			arg_25_0.targetIndex_ = 0

			arg_25_0.enchantScroller_:StartScrollByPosition(arg_25_0.max, arg_25_0.enchantScroller_:GetScrolledPosition())
		end
	else
		arg_25_0.targetIndex_ = 0

		arg_25_0.enchantScroller_:StartScroll(arg_25_0.max)
	end
end

function var_0_1.indexPreviewItem(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0.enchantPreviewList[arg_26_1] or {}

	arg_26_2:Refresh(arg_26_0.heroID_, var_26_0, arg_26_0.skillList_, arg_26_0.equipId, arg_26_0.enchatPos, arg_26_1, arg_26_0.fixedSkillIds_, arg_26_0.targetIndex_)
	arg_26_2:RegistSkillClickCallBck(handler(arg_26_0, arg_26_0.OnSkillClick))
end

function var_0_1.ShowGlowAnim(arg_27_0, arg_27_1)
	if arg_27_0.frameTimer_ then
		arg_27_0.frameTimer_:Stop()

		arg_27_0.frameTimer_ = nil
	end

	arg_27_0.frameTimer_ = FrameTimer.New(function()
		local var_28_0 = arg_27_0.enchantScroller_:GetItemByIndex(arg_27_1)

		if var_28_0 ~= nil then
			var_28_0:ShowAnim()
		end

		arg_27_0.frameTimer_:Stop()
	end, 20, 1)

	arg_27_0.frameTimer_:Start()
end

function var_0_1.OnSkillClick(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0.skillPopView_:RefreshData(arg_29_0, arg_29_2, true)

	arg_29_0.selectedSkillItem_ = arg_29_1

	arg_29_0.selectedSkillItem_.selectController_:SetSelectedIndex(1)

	local var_29_0 = arg_29_0.transform:InverseTransformPoint(arg_29_1.transform.position)
	local var_29_1 = var_29_0.x / Screen.width <= arg_29_0.standardRatio_ and var_29_0.x + 500 or var_29_0.x - 500

	arg_29_0.equipSkillPopGo_.transform.localPosition = Vector3(var_29_1, -20, 0)

	arg_29_0.popController_:SetSelectedState("on")
end

function var_0_1.HidePop(arg_30_0)
	if arg_30_0.selectedSkillItem_ then
		arg_30_0.selectedSkillItem_.selectController_:SetSelectedIndex(0)

		arg_30_0.selectedSkillItem_ = nil
	end

	arg_30_0.popController_:SetSelectedState("off")
end

function var_0_1.OnMarerialChange(arg_31_0, arg_31_1)
	if arg_31_0.isLockedSkill_ then
		return
	end

	arg_31_0.materialIndex = arg_31_1

	EquipData:SetSelectEnchantMaterialIndex(arg_31_1)
	arg_31_0:RreshMateriaMoney()

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.materialGoList_) do
		iter_31_1:RefreshSelectState2(iter_31_0 == arg_31_0.materialIndex)
	end
end

function var_0_1.RreshMateriaMoney(arg_32_0)
	local var_32_0 = arg_32_0.isLockedSkill_ and arg_32_0.showLockMaterials_[arg_32_0.materialIndex] or arg_32_0.materials_[arg_32_0.materialIndex]
	local var_32_1 = var_32_0.money
	local var_32_2 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)
	local var_32_3 = tostring(var_32_1)

	if var_32_2 < var_32_1 then
		var_32_3 = "<color='#FF0000'>" .. var_32_3 .. "</color>"
	end

	arg_32_0.costNum_.text = var_32_3

	local var_32_4 = var_32_0.id
	local var_32_5 = ItemCfg[var_32_4]

	if arg_32_0.isLockedSkill_ then
		arg_32_0.materialText_.text = GetTips("EQUIP_SKILL_LOCK_DES")
	else
		arg_32_0.materialText_.text = var_32_5 and ItemTools.getItemDesc(var_32_4) or ""
	end
end

function var_0_1.OnEnchantClick(arg_33_0)
	arg_33_0.enchantPreviewList = EquipData:GetEquipData(arg_33_0.equipId).enchant_preview[arg_33_0.enchatPos]

	if arg_33_0.max <= #arg_33_0.enchantPreviewList then
		ShowTips("EQUIP_ENCHANT_RESULT_NUM_MAX")

		return
	end

	local var_33_0 = arg_33_0.equipId
	local var_33_1 = arg_33_0.enchatPos
	local var_33_2 = arg_33_0.materials_[arg_33_0.materialIndex]
	local var_33_3 = 0

	if arg_33_0.isLockedSkill_ then
		var_33_3 = arg_33_0.lockedIndex_
		var_33_2 = arg_33_0.showLockMaterials_[arg_33_0.materialIndex]
	end

	EquipAction.QueryEquipEnchant(var_33_0, var_33_1, var_33_2, var_33_3)
end

function var_0_1.OnEquipEnchant(arg_34_0)
	arg_34_0:RreshMaterialUI()
	arg_34_0:RreshMateriaMoney()
	arg_34_0:RefreshBottom({
		scrollToIndex = true
	})
end

function var_0_1.OnEquipEnchantConfirm(arg_35_0, arg_35_1)
	arg_35_0:RefreshSkillData()
	arg_35_0:RreshFixedSkill(arg_35_1)

	if arg_35_1 then
		-- block empty
	end

	local var_35_0 = {
		keepScrollPos = true
	}

	arg_35_0:RefreshBottom(var_35_0)
end

function var_0_1.OnEquipEnchantGiveUp(arg_36_0)
	arg_36_0:RefreshBottom()
end

function var_0_1.OnGoldChange(arg_37_0, arg_37_1)
	if arg_37_1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		arg_37_0:RreshMateriaMoney()
	end
end

function var_0_1.OnMaterialModify(arg_38_0, arg_38_1)
	local var_38_0 = 606

	if ItemCfg[arg_38_1].sub_type == var_38_0 then
		arg_38_0:RreshMaterialUI()
	end
end

function var_0_1.OnLockClick(arg_39_0, arg_39_1)
	if arg_39_0.isLockedSkill_ then
		if arg_39_0.lockedIndex_ then
			if arg_39_0.lockedIndex_ == arg_39_1 then
				arg_39_0.fixedSkills[arg_39_0.lockedIndex_].lockController_:SetSelectedState("unlock")

				arg_39_0.isLockedSkill_ = false
				arg_39_0.lockedIndex_ = nil
				arg_39_0.materialIndex = 3

				EquipData:SetEnchatLockIndex(0, 0, 0)
			elseif #arg_39_0.enchantPreviewList > 0 then
				ShowTips(GetTips("EQUIP_SKILL_LOCK_ENCHANT_EMPTY"))
			else
				arg_39_0.fixedSkills[arg_39_0.lockedIndex_].lockController_:SetSelectedState("unlock")
				arg_39_0.fixedSkills[arg_39_1].lockController_:SetSelectedState("lock")

				arg_39_0.lockedIndex_ = arg_39_1

				EquipData:SetEnchatLockIndex(arg_39_0.equipId, arg_39_0.enchatPos, arg_39_0.lockedIndex_)
			end
		end
	elseif #arg_39_0.enchantPreviewList > 0 then
		ShowTips(GetTips("EQUIP_SKILL_LOCK_ENCHANT_EMPTY"))
	else
		arg_39_0.fixedSkills[arg_39_1].lockController_:SetSelectedState("lock")
		arg_39_0:OnMarerialChange(3)

		arg_39_0.isLockedSkill_ = true
		arg_39_0.lockedIndex_ = arg_39_1

		EquipData:SetEnchatLockIndex(arg_39_0.equipId, arg_39_0.enchatPos, arg_39_0.lockedIndex_)
	end

	arg_39_0:RreshMaterialUI()
	arg_39_0:RreshMateriaMoney()
end

function var_0_1.OnEnchantSkillChange(arg_40_0)
	arg_40_0:RefreshSkillData()
	arg_40_0:RreshFixedSkill()
	arg_40_0:RefreshBottom()
end

function var_0_1.OnExit(arg_41_0)
	manager.windowBar:HideBar()
	arg_41_0:HidePop()
	arg_41_0:RemoveAllEventListener()

	arg_41_0.isLockedSkill_ = false
	arg_41_0.lockedIndex_ = nil

	for iter_41_0, iter_41_1 in pairs(arg_41_0.fixedSkills) do
		iter_41_1.lockController_:SetSelectedState("unlock")
	end

	if arg_41_0.frameTimer_ then
		arg_41_0.frameTimer_:Stop()

		arg_41_0.frameTimer_ = nil
	end
end

function var_0_1.Dispose(arg_42_0)
	arg_42_0.enchantScroller_:Dispose()
	arg_42_0.skillPopView_:Dispose()

	for iter_42_0, iter_42_1 in pairs(arg_42_0.materialGoList_) do
		iter_42_1:Dispose()
	end

	var_0_1.super.Dispose(arg_42_0)
end

return var_0_1
