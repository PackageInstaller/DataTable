local NewHeroChipView = class("NewHeroChipView", ReduxView)

function NewHeroChipView:UIName()
	return "Widget/System/Hero_chip/HeroChipEditUI"
end

function NewHeroChipView:UIParent()
	return manager.ui.uiMain.transform
end

function NewHeroChipView:Init()
	self:BindCfgUI()

	self.chipClickCallBack_ = handler(self, self.OnChipClick)
	self.chipListList_ = {}
	self.chipControllers_ = {}

	for iter_3_0 = 1, 4 do
		self.chipListList_[iter_3_0] = NewHeroChipListItem.New(self["chiplistGo_" .. iter_3_0], self.chipItemGo_)

		self.chipListList_[iter_3_0]:SetChipClickCallBack(self.chipClickCallBack_)

		self.chipControllers_[iter_3_0] = self["chipCon_" .. iter_3_0]:GetController("state")
	end

	self.chipTypeController_ = self.typeTrans_:GetComponent("ControllerExCollection"):GetController("type")
	self.conditionController_ = self.conditionTrans_:GetComponent("ControllerExCollection"):GetController("clear")
	self.enoughController_ = self.gameObject_.transform:GetComponent("ControllerExCollection"):GetController("enough")
	self.btnController_ = self.btnTrans_:GetComponent("ControllerExCollection"):GetController("btnState")

	self:AddListeners()
end

function NewHeroChipView:OnChipClick(arg_4_1)
	self.curChipID_ = arg_4_1

	self:RefreshUI(false)
end

function NewHeroChipView:OnTop()
	self:RefreshChipInfo()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_CHIP_COST
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_CHIP_COST, true)
end

function NewHeroChipView:OnChipStatusUpdate()
	self:RefreshUI(false)
end

function NewHeroChipView:OnEnter()
	self.heroID_ = self.params_.heroID
	self.curHeroChipInfo_ = {}

	for iter_7_0, iter_7_1 in pairs(ChipTools.GetHeroChipIDList(self.heroID_)) do
		if self.curHeroChipInfo_[ChipCfg[iter_7_1].role_type_id] then
			table.insert(self.curHeroChipInfo_[ChipCfg[iter_7_1].role_type_id], iter_7_1)
		else
			self.curHeroChipInfo_[ChipCfg[iter_7_1].role_type_id] = {
				iter_7_1
			}
		end
	end

	self.curType_ = self.params_.type
	self.curChipID_ = self.params_.chipID > 0 and self.params_.chipID or self.curHeroChipInfo_[self.curType_][1]

	self:RefreshUI(true)
end

function NewHeroChipView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		6,
		1
	}, false)
	manager.heroRaiseTrack:SetModelState(HeroTools.HeroUsingSkinInfo(self.params_.heroID).id)
end

function NewHeroChipView:OnExit()
	manager.windowBar:HideBar()
end

function NewHeroChipView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.btnController_.selectedIndex == 0 or self.btnController_.selectedIndex == 3 then
			ChipAction.EnabledHeroChip(self.heroID_, self.curChipID_, ChipCfg[self.curChipID_].role_type_id)
		elseif self.btnController_.selectedIndex == 1 then
			ChipAction.EnabledHeroChip(self.heroID_, 0, ChipCfg[self.curChipID_].role_type_id)
		elseif self.btnController_.selectedIndex == 2 then
			ChipAction.UnlockHeroChip(self.curChipID_)
		end
	end)
end

function NewHeroChipView:RefreshUI(arg_12_1)
	local var_12_0 = ChipData:GetEnableHeroChipIdByHeroId(self.heroID_)

	if arg_12_1 then
		for iter_12_0, iter_12_1 in pairs(self.curHeroChipInfo_) do
			self.curHeroChipInfo_[iter_12_0] = ChipTools.SortChipList(var_12_0[iter_12_0], self.curHeroChipInfo_[iter_12_0], nil, true)
		end
	end

	for iter_12_2 = 1, 4 do
		if self.curHeroChipInfo_[iter_12_2] then
			self.chipListList_[iter_12_2]:SetIsShow(true)
			self.chipListList_[iter_12_2]:SetData(self.heroID_, self.curHeroChipInfo_[iter_12_2], self.curChipID_)
			self.chipControllers_[iter_12_2]:SetSelectedState(var_12_0[iter_12_2] > 0 and "equip" or "normal")
		else
			self.chipListList_[iter_12_2]:SetIsShow(false)
			self.chipControllers_[iter_12_2]:SetSelectedState("lock")
		end
	end

	self:RefreshChipInfo()
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.chipContent_)
end

function NewHeroChipView:RefreshChipInfo()
	local var_13_0 = ChipCfg[self.curChipID_]

	self.nameText_.text = ChipCfg[self.curChipID_].suit_name
	self.iconImage_.sprite = getSpriteViaConfig("ChipSkillIcon", var_13_0.picture_id)

	self.chipTypeController_:SetSelectedState(var_13_0.role_type_id)

	self.desText_.text = var_13_0.desc
	self.typeText_.text = GetTips("CHIP_HERO_TYPE_" .. var_13_0.role_type_id)
	self.grayText_.text = var_13_0.title

	if ChipData:GetIsUnlockHeroChip(self.curChipID_) then
		SetActive(self.conditionTrans_.gameObject, false)
		SetActive(self.costImage_.gameObject, false)

		local var_13_1, var_13_2 = ChipData:GetHeroChipIsEnableByChipId(self.curChipID_)

		if var_13_1 then
			self.btnText_.text = GetTips("CHIP_UNLOAD")

			self.btnController_:SetSelectedState("unequip")
		elseif var_13_2 > 0 then
			self.btnText_.text = GetTips("TIP_CHANGE")

			self.btnController_:SetSelectedState("exchange")
		else
			self.btnText_.text = GetTips("TIP_EQUIP")

			self.btnController_:SetSelectedState("equip")
		end
	else
		if var_13_0.new_condition ~= 0 then
			SetActive(self.conditionTrans_.gameObject, true)
			SetActive(self.costImage_.gameObject, false)

			self.conditionText_.text = ConditionCfg[var_13_0.new_condition].desc

			local var_13_3
			local var_13_4
			local var_13_5

			if var_13_0.spec_char > 0 then
				var_13_3, var_13_4, var_13_5 = IsConditionAchieved(var_13_0.new_condition, {
					heroId = var_13_0.spec_char
				})
			else
				var_13_3, var_13_4, var_13_5 = IsConditionAchieved(var_13_0.new_condition)
			end

			for iter_13_0, iter_13_1 in ipairs(GameSetting.hero_trust_unlock_condition.value) do
				if var_13_0.new_condition == iter_13_1 then
					var_13_4 = var_13_3 and 1 or 0
					var_13_5 = 1
					self.conditionText_.text = HeroCfg[var_13_0.spec_char].name .. "·" .. HeroCfg[var_13_0.spec_char].suffix .. ConditionCfg[var_13_0.new_condition].desc

					break
				end
			end

			if var_13_3 then
				self.conditionController_:SetSelectedState("clear")
			else
				self.conditionController_:SetSelectedState("notclear")

				var_13_4 = string.format("<color=#eb0000>%s</color>", var_13_4)
			end

			self.conditionNumText_.text = var_13_4 .. "/" .. var_13_5
		else
			SetActive(self.conditionTrans_.gameObject, false)
			SetActive(self.costImage_.gameObject, true)

			self.costText_.text = var_13_0.cost_condition[1][2]
			self.costImage_.sprite = ItemTools.getItemSprite(var_13_0.cost_condition[1][1])

			if ItemTools.getItemNum(var_13_0.cost_condition[1][1]) >= var_13_0.cost_condition[1][2] then
				self.enoughController_:SetSelectedState("true")
			else
				self.enoughController_:SetSelectedState("false")
			end
		end

		self.btnText_.text = GetTips("TIP_UNLOCK")

		self.btnController_:SetSelectedState("unlock")
	end
end

function NewHeroChipView:Dispose()
	NewHeroChipView.super.Dispose(self)

	for iter_14_0 = 1, 4 do
		self.chipListList_[iter_14_0]:Dispose()

		self.chipListList_[iter_14_0] = nil
	end

	self.chipListList_ = nil
	self.chipClickCallBack_ = nil
end

return NewHeroChipView
