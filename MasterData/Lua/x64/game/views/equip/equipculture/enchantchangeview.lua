local EnchantChangeView = class("EnchantChangeView", (import("game.views.equip.equipCulture.EquipBaseView")))

function EnchantChangeView:UIName()
	return "Widget/System/Hero_equip/Develop/HeroEquipEnchant"
end

function EnchantChangeView:UIParent()
	return manager.ui.uiMain.transform
end

function EnchantChangeView:Init()
	self:InitUI()
	self:AddUIListener()
	EnchantChangeView.super.Init(self)

	self.max = GameSetting.equip_enchant_save_num.value[1] or 0
	self.isLockedSkill_ = false
	self.lockedIndex_ = nil
	self.standardRatio_ = 0.09270833333333334
end

function EnchantChangeView:InitUI()
	self:BindCfgUI()

	self.skillPreItems_ = {}
	self.items_ = {}
	self.materialIndex = 1
	self.skillPopView_ = EquipNewSkillInfoView.New(self.equipSkillPopGo_)
	self.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
	self.enchantScroller_ = LuaList.New(handler(self, self.indexPreviewItem), self.enchantListGo_, EquipEnchantPreviewItem)
	self.giveupController_ = self.transCon_:GetController("allGiveup")
	self.popController_ = self.transCon_:GetController("pop")

	self:InitFixedSkill()
	self:InitMaterial()
end

function EnchantChangeView:AddUIListener()
	self:AddBtnListener(self.btnEnchant_, nil, function()
		self:OnEnchantClick()
	end)
	self:AddBtnListener(self.btnGiveUp_, nil, function()
		if self.enchantPreviewList and #self.enchantPreviewList > 0 then
			EquipAction.QueryEquipGiveUpAllEnchant(self.equipId, self.enchatPos)
		end
	end)
	self:AddBtnListener(self.btnHidePopMask_, nil, function()
		self:HidePop()
	end)
	self:AddBtnListener(self.btnAccess_, nil, function()
		ShowPopItem(POP_SOURCE_ITEM, {
			self.materials_[self.materialIndex].id,
			(ItemTools.getItemNum(self.materials_[self.materialIndex].id))
		})
	end)
	self:AddBtnListener(self.btnCheckSkill_, nil, function()
		JumpTools.OpenPageByJump("totalEnchantSkillPop", {
			proxy = self.heroViewDataProxy_,
			heroId = self.heroID_,
			equipId = self.equipId
		})
	end)
	self:AddBtnListener(self.btnDirectionalSkill_, nil, function()
		if self.isLockedSkill_ then
			self:OnLockClick(self.lockedIndex_)
		end

		JumpTools.OpenPageByJump("equipDirectionalEnchant", {
			heroId = self.heroID_,
			equipId = self.equipId,
			enchantPos = self.enchatPos
		})
	end)
end

function EnchantChangeView:OnEnter()
	self.equipId = self.params_.equipId
	self.enchatPos = self.params_.enchatPos
	self.equipData = EquipData:GetEquipData(self.equipId)
	self.heroID_ = self.equipData:GetEquipHero()
	self.heroViewDataProxy_ = self.params_.proxy or HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)

	self:RefreshSkillData()
	self:RefreshSelect()
	self:RefreshUI()
	self:ShowBar()
	self:RegistEventListener(CURRENCY_UPDATE, handler(self, self.OnGoldChange))
	self:RegistEventListener(MATERIAL_MODIFY, handler(self, self.OnMaterialModify))
	self:RegistEventListener(DIRECTIONAL_ENCHANT_SUCCESS, handler(self, self.OnEnchantSkillChange))
end

function EnchantChangeView:ShowBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
end

function EnchantChangeView:OnTop()
	self:ShowBar()
end

function EnchantChangeView:RefreshSkillData()
	self.skillList_ = EquipTools.RefreshSkillData(self.equipData, self.heroID_, self.heroViewDataProxy_)
end

function EnchantChangeView:InitFixedSkill()
	self.fixedSkills = {}

	for iter_16_0 = 1, 2 do
		local var_16_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_16_0, self["enchantSkill_" .. iter_16_0])

		var_16_0.selectController_ = var_16_0.transCon_:GetController("select")
		var_16_0.lockController_ = var_16_0.transCon_:GetController("lock")
		var_16_0.nullController_ = var_16_0.transCon_:GetController("null")
		var_16_0.recommendController_ = var_16_0.transCon_:GetController("recommend")

		self:AddBtnListener(var_16_0.btnLock_, nil, function()
			self:OnLockClick(iter_16_0)
		end)
		self:AddBtnListener(var_16_0.btnInfo_, nil, function()
			if var_16_0.isSkill then
				self:OnSkillClick(var_16_0, self.skillList_[var_16_0.id], iter_16_0)
			end
		end)
		table.insert(self.fixedSkills, var_16_0)
	end
end

function EnchantChangeView:InitMaterial()
	self.materials_ = EquipData:GetEnchantMaterial()
	self.showLockMaterials_ = EquipData:GetLockEnchantMaterial()
	self.materialGoList_ = {}

	for iter_19_0 = 1, #self.materials_ do
		local var_19_0 = CommonItemView.New(self["material_" .. iter_19_0])
		local var_19_1 = clone(ItemTemplateData)

		var_19_1.id = self.materials_[iter_19_0].id
		var_19_1.number = nil

		function var_19_1.clickFun()
			if self.isLockedSkill_ then
				-- block empty
			else
				self:OnMarerialChange(iter_19_0)
			end
		end

		var_19_0:SetData(var_19_1)

		self.materialGoList_[iter_19_0] = var_19_0
	end
end

function EnchantChangeView:RefreshSelect()
	local var_21_0 = EquipData:GetIsSetLockView(self.equipId, self.enchatPos)

	self.fixedSkills[1].lockController_:SetSelectedState(var_21_0 == 1 and "lock" or "unlock")
	self.fixedSkills[2].lockController_:SetSelectedState(var_21_0 == 2 and "lock" or "unlock")

	if var_21_0 then
		self:OnMarerialChange(3)

		self.isLockedSkill_ = true
		self.lockedIndex_ = var_21_0

		self:RreshMateriaMoney()
	else
		self.materialIndex = EquipData:GetSelectEnchantMaterialIndex()

		self:OnMarerialChange(self.materialIndex)
	end
end

function EnchantChangeView:RefreshUI()
	self:RreshMaterialUI()
	self:RreshFixedSkill()
	self:RefreshBottom()
end

function EnchantChangeView:RreshMaterialUI()
	for iter_23_0, iter_23_1 in ipairs(self.materialGoList_) do
		local var_23_0 = self.showLockMaterials_[iter_23_0]
		local var_23_1 = ItemTools.getItemNum(self.materials_[iter_23_0].id)

		iter_23_1:RefreshBottomText({
			var_23_1,
			(self.isLockedSkill_ or nil) and (var_23_0.number or self.materials_[iter_23_0].number)
		})
		iter_23_1:RefreshLock(self.isLockedSkill_ and not var_23_0.lock or false)
	end
end

function EnchantChangeView:RreshFixedSkill(arg_24_1)
	local var_24_0 = EquipData:GetEquipData(self.equipId).enchant[self.enchatPos] or {}

	if arg_24_1 then
		self.glowAnim_:Play("glow_bg")
	end

	self.fixedSkillIds_ = {}
	self.fixedSkillInfo_ = {}

	for iter_24_0 = 1, 2 do
		local var_24_1 = var_24_0[iter_24_0]
		local var_24_2 = self.fixedSkills[iter_24_0]

		if var_24_0[iter_24_0] then
			var_24_2.id = var_24_1.id

			local var_24_3 = EquipSkillCfg[var_24_1.id]
			local var_24_4

			if self.skillList_[var_24_1.id] then
				var_24_4 = self.skillList_[var_24_1.id].num or var_24_1.num
			end

			if self.fixedSkillIds_[var_24_1.id] then
				self.fixedSkillIds_[var_24_1.id] = self.fixedSkillIds_[var_24_1.id] + 1 or 1
			end

			local var_24_5 = string.format("%s/%s", var_24_4 > var_24_3.lvmax and string.format("<color=#FF000B>%s</color>", var_24_4) or var_24_4, var_24_3.lvmax)

			var_24_2.num_.text = var_24_5

			local var_24_6 = var_24_3.upgrade / var_24_3.percent * ((var_24_4 > var_24_3.lvmax or nil) and (var_24_3.lvmax or var_24_4))
			local var_24_7 = GetCfgDescriptionWithValue(var_24_3.desc[1], tostring(var_24_3.upgrade / var_24_3.percent * ((var_24_4 > var_24_3.lvmax or nil) and (var_24_3.lvmax or var_24_4))))

			if var_24_3.desc_spec_value ~= nil and var_24_3.desc_spec_value ~= "" then
				var_24_7 = string.gsub(var_24_7, tostring(var_24_6), var_24_3.desc_spec_value[self.cfg_.num])
			end

			var_24_2.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. var_24_3.icon)
			var_24_2.name_.text = GetI18NText(var_24_3.name)
			var_24_2.desc_.text = var_24_7

			var_24_2.nullController_:SetSelectedState("skill")

			var_24_2.isSkill = true

			local var_24_8 = self.heroID_ and var_24_4 <= var_24_3.lvmax and HeroData:GetRecommendEquipSkill(self.heroID_, var_24_1.id) or 0

			var_24_2.recommendController_:SetSelectedState(var_24_8)

			self.fixedSkillInfo_[iter_24_0] = {
				skillId = var_24_1.id,
				numText = var_24_5,
				descText = var_24_7,
				recommendLevel = var_24_8
			}
		else
			var_24_2.isSkill = false

			var_24_2.nullController_:SetSelectedState("null")
			var_24_2.recommendController_:SetSelectedState(0)

			self.fixedSkillInfo_[iter_24_0] = nil
		end
	end
end

function EnchantChangeView:RefreshBottom(arg_25_1)
	self.enchantPreviewList = EquipData:GetEquipData(self.equipId).enchant_preview[self.enchatPos]
	self.enchantNum_.text = string.format(GetTips("ENCHANT_PREVIEW_NUM"), #self.enchantPreviewList, self.max)

	self.giveupController_:SetSelectedState(#self.enchantPreviewList == 0 and "off" or "on")

	if arg_25_1 then
		if arg_25_1.scrollToIndex then
			local var_25_0 = math.max(0, #self.enchantPreviewList)

			self:ShowGlowAnim(var_25_0)

			self.targetIndex_ = var_25_0

			self.enchantScroller_:ScrollToIndex(math.max(0, var_25_0 - 1), true, true)
			self.enchantScroller_:Refresh()
		elseif arg_25_1.keepScrollPos then
			self.targetIndex_ = 0

			self.enchantScroller_:StartScrollByPosition(self.max, self.enchantScroller_:GetScrolledPosition())
		end
	else
		self.targetIndex_ = 0

		self.enchantScroller_:StartScroll(self.max)
	end
end

function EnchantChangeView:indexPreviewItem(arg_26_1, arg_26_2)
	arg_26_2:Refresh(self.heroID_, self.enchantPreviewList[arg_26_1] or {}, self.skillList_, self.equipId, self.enchatPos, arg_26_1, self.fixedSkillIds_, self.targetIndex_)
	arg_26_2:RegistSkillClickCallBck(handler(self, self.OnSkillClick))
end

function EnchantChangeView:ShowGlowAnim(arg_27_1)
	if self.frameTimer_ then
		self.frameTimer_:Stop()

		self.frameTimer_ = nil
	end

	self.frameTimer_ = FrameTimer.New(function()
		local var_28_0 = self.enchantScroller_:GetItemByIndex(arg_27_1)

		if var_28_0 ~= nil then
			var_28_0:ShowAnim()
		end

		self.frameTimer_:Stop()
	end, 20, 1)

	self.frameTimer_:Start()
end

function EnchantChangeView:OnSkillClick(arg_29_1, arg_29_2)
	self.skillPopView_:RefreshData(self, arg_29_2, true)

	self.selectedSkillItem_ = arg_29_1

	self.selectedSkillItem_.selectController_:SetSelectedIndex(1)

	local var_29_0 = self.transform:InverseTransformPoint(arg_29_1.transform.position)

	self.equipSkillPopGo_.transform.localPosition = Vector3((var_29_0.x / Screen.width <= self.standardRatio_ or nil) and (var_29_0.x + 500 or var_29_0.x - 500), -20, 0)

	self.popController_:SetSelectedState("on")
end

function EnchantChangeView:HidePop()
	if self.selectedSkillItem_ then
		self.selectedSkillItem_.selectController_:SetSelectedIndex(0)

		self.selectedSkillItem_ = nil
	end

	self.popController_:SetSelectedState("off")
end

function EnchantChangeView:OnMarerialChange(arg_31_1)
	if self.isLockedSkill_ then
		return
	end

	self.materialIndex = arg_31_1

	EquipData:SetSelectEnchantMaterialIndex(arg_31_1)
	self:RreshMateriaMoney()

	for iter_31_0, iter_31_1 in ipairs(self.materialGoList_) do
		iter_31_1:RefreshSelectState2(iter_31_0 == self.materialIndex)
	end
end

function EnchantChangeView:RreshMateriaMoney()
	local var_32_0

	if self.isLockedSkill_ then
		var_32_0 = self.showLockMaterials_[self.materialIndex]

		local var_32_1

		if not self.showLockMaterials_[self.materialIndex] then
			var_32_0 = self.materials_[self.materialIndex]
			var_32_1 = tostring(var_32_0.money)
		end

		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) < var_32_0.money then
			var_32_1 = "<color='#FF0000'>" .. var_32_1 .. "</color>"
		end
	end

	self.costNum_.text = var_32_1
	self.materialText_.text = self.isLockedSkill_ and GetTips("EQUIP_SKILL_LOCK_DES") or ItemCfg[var_32_0.id] and ItemTools.getItemDesc(var_32_0.id) or ""
end

function EnchantChangeView:OnEnchantClick()
	self.enchantPreviewList = EquipData:GetEquipData(self.equipId).enchant_preview[self.enchatPos]

	if self.max <= #self.enchantPreviewList then
		ShowTips("EQUIP_ENCHANT_RESULT_NUM_MAX")

		return
	end

	local var_33_0 = self.materials_[self.materialIndex]
	local var_33_1 = 0

	if self.isLockedSkill_ then
		var_33_1 = self.lockedIndex_
		var_33_0 = self.showLockMaterials_[self.materialIndex] or var_33_0
	end

	EquipAction.QueryEquipEnchant(self.equipId, self.enchatPos, var_33_0, var_33_1)
end

function EnchantChangeView:OnEquipEnchant()
	self:RreshMaterialUI()
	self:RreshMateriaMoney()
	self:RefreshBottom({
		scrollToIndex = true
	})
end

function EnchantChangeView:OnEquipEnchantConfirm(arg_35_1)
	self:RefreshSkillData()
	self:RreshFixedSkill(arg_35_1)

	if arg_35_1 then
		-- block empty
	end

	self:RefreshBottom({
		keepScrollPos = true
	})
end

function EnchantChangeView:OnEquipEnchantGiveUp()
	self:RefreshBottom()
end

function EnchantChangeView:OnGoldChange(arg_37_1)
	if arg_37_1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		self:RreshMateriaMoney()
	end
end

function EnchantChangeView:OnMaterialModify(arg_38_1)
	if ItemCfg[arg_38_1].sub_type == 606 then
		self:RreshMaterialUI()
	end
end

function EnchantChangeView:OnLockClick(arg_39_1)
	if self.isLockedSkill_ then
		if self.lockedIndex_ then
			if self.lockedIndex_ == arg_39_1 then
				self.fixedSkills[self.lockedIndex_].lockController_:SetSelectedState("unlock")

				self.isLockedSkill_ = false
				self.lockedIndex_ = nil
				self.materialIndex = 3

				EquipData:SetEnchatLockIndex(0, 0, 0)
			elseif #self.enchantPreviewList > 0 then
				ShowTips(GetTips("EQUIP_SKILL_LOCK_ENCHANT_EMPTY"))
			else
				self.fixedSkills[self.lockedIndex_].lockController_:SetSelectedState("unlock")
				self.fixedSkills[arg_39_1].lockController_:SetSelectedState("lock")

				self.lockedIndex_ = arg_39_1

				EquipData:SetEnchatLockIndex(self.equipId, self.enchatPos, self.lockedIndex_)
			end
		end
	elseif #self.enchantPreviewList > 0 then
		ShowTips(GetTips("EQUIP_SKILL_LOCK_ENCHANT_EMPTY"))
	else
		self.fixedSkills[arg_39_1].lockController_:SetSelectedState("lock")
		self:OnMarerialChange(3)

		self.isLockedSkill_ = true
		self.lockedIndex_ = arg_39_1

		EquipData:SetEnchatLockIndex(self.equipId, self.enchatPos, self.lockedIndex_)
	end

	self:RreshMaterialUI()
	self:RreshMateriaMoney()
end

function EnchantChangeView:OnEnchantSkillChange()
	self:RefreshSkillData()
	self:RreshFixedSkill()
	self:RefreshBottom()
end

function EnchantChangeView:OnExit()
	manager.windowBar:HideBar()
	self:HidePop()
	self:RemoveAllEventListener()

	self.isLockedSkill_ = false
	self.lockedIndex_ = nil

	for iter_41_0, iter_41_1 in pairs(self.fixedSkills) do
		iter_41_1.lockController_:SetSelectedState("unlock")
	end

	if self.frameTimer_ then
		self.frameTimer_:Stop()

		self.frameTimer_ = nil
	end
end

function EnchantChangeView:Dispose()
	self.enchantScroller_:Dispose()
	self.skillPopView_:Dispose()

	for iter_42_0, iter_42_1 in pairs(self.materialGoList_) do
		iter_42_1:Dispose()
	end

	EnchantChangeView.super.Dispose(self)
end

return EnchantChangeView
