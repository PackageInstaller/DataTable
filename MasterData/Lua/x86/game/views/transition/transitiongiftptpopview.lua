local TransitionGiftPtPopView = class("TransitionGiftPtPopView", ReduxView)

function TransitionGiftPtPopView:UIName()
	return "Widget/System/Hero_jumps/HeroJumpsUpPop"
end

function TransitionGiftPtPopView:UIParent()
	return manager.ui.uiPop.transform
end

function TransitionGiftPtPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function TransitionGiftPtPopView:InitUI()
	self:BindCfgUI()

	self.tryToImproveTransitionGiftPtHandler_ = handler(self, self.OnTryToImproveTransitionGiftPt)
	self.icon_.sprite = ItemTools.getItemLittleSprite(CurrencyIdMapCfg.CURRENCY_TYPE_GOLD.item_id)
	self.scrollHelper_ = LuaList.New(function(arg_5_0, arg_5_1)
		self:IndexItem(arg_5_0, arg_5_1)
	end, self.listGo_, CommonItemView)
end

function TransitionGiftPtPopView:IndexItem(arg_6_1, arg_6_2)
	local var_6_0 = self.cost_[arg_6_1]

	self.cost_[arg_6_1].clickFun = function()
		ShowPopItem(POP_SOURCE_ITEM, {
			var_6_0.id,
			var_6_0._num
		})
	end
	self.cost_[arg_6_1].bottomText = {
		ItemTools.getItemNum(self.cost_[arg_6_1].id),
		self.cost_[arg_6_1]._num
	}
	self.cost_[arg_6_1].animatorType = ItemConst.ITEM_ANIMATOR_TYPE.NULL

	arg_6_2:SetData(self.cost_[arg_6_1])
end

function TransitionGiftPtPopView:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if not self:CheckEnough(true) then
			return
		end

		if not _G.SkipTip.TransitionGiftPtImproveTip then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EXCLUSIVE_SKILL_POINT_UP_CONFIRMATION"),
				OkCallback = function()
					_G.SkipTip.TransitionGiftPtImproveTip = self.TransitionGiftPtImproveTip_

					HeroAction.TryToImproveTransitionGiftPt(self.params_.heroID, self.params_.index, self.addLevel_)
					self:Back()
				end,
				CancelCallback = function()
					return
				end,
				ToggleCallback = function(arg_12_0)
					self.TransitionGiftPtImproveTip_ = arg_12_0
				end
			})

			return
		end

		HeroAction.TryToImproveTransitionGiftPt(self.params_.heroID, self.params_.index, self.addLevel_)
		self:Back()
	end)
	self:AddBtnListener(self.delBtn_, nil, function()
		self.addLevel_ = self.addLevel_ - 1

		self:RefreshUI()
	end)
	self:AddBtnListener(self.addBtn_, nil, function()
		self.addLevel_ = self.addLevel_ + 1

		self:RefreshUI()
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self.slider_.onValueChanged:AddListener(function(arg_16_0)
		self:OnSliderValueChanged(arg_16_0)
	end)

	self.slider_.wholeNumbers = true
end

function TransitionGiftPtPopView:OnEnter()
	manager.windowBar:SetAsLastSibling()
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)

	self.curLevel_ = self.params_.giftPt
	self.maxLevel_ = self:GetMaxLevel()
	self.addLevel_ = self.params_.isEnter and self:CaclCanUpgradeMaxLevel() or self.params_.addLevel
	self.slider_.value = self.addLevel_

	self:RegistEventListener(CURRENCY_UPDATE, handler(self, self.OnGoldChange))
	self:RefreshUI()
end

function TransitionGiftPtPopView:GetMaxLevel()
	return (math.max(self.curLevel_ + 1, GameSetting.exclusive_skill_talent_num_max.value[1]))
end

function TransitionGiftPtPopView:CaclCanUpgradeMaxLevel()
	local var_19_0 = 1
	local var_19_1 = {}

	for iter_19_0 = 1, self.maxLevel_ - self.curLevel_ do
		for iter_19_1, iter_19_2 in ipairs(GameSetting.exclusive_skill_talent_strengthen_cost.value[iter_19_0 + self.curLevel_]) do
			var_19_1[iter_19_2[1]] = var_19_1[iter_19_2[1]] or 0

			if var_19_1[iter_19_2[1]] + iter_19_2[2] > ItemTools.getItemNum(iter_19_2[1]) then
				return math.max(1, iter_19_0 - 1)
			end

			var_19_1[iter_19_2[1]] = var_19_1[iter_19_2[1]] + iter_19_2[2]
		end

		var_19_0 = iter_19_0
	end

	return var_19_0
end

function TransitionGiftPtPopView:RefreshUI()
	self:RefreshCost()
	self:RefreshGold()
	self:RefreshButton()
	self.scrollHelper_:StartScroll(#self.cost_)
end

function TransitionGiftPtPopView:RefreshCost()
	self.cost_ = {}

	local var_21_0 = {
		all = {}
	}

	if self.addLevel_ > 0 then
		for iter_21_0 = self.curLevel_ + 1, self.curLevel_ + self.addLevel_ do
			for iter_21_1, iter_21_2 in ipairs(GameSetting.exclusive_skill_talent_strengthen_cost.value[iter_21_0]) do
				if not var_21_0[iter_21_2[1]] then
					var_21_0[iter_21_2[1]] = 0

					table.insert(var_21_0.all, iter_21_2[1])
				end

				var_21_0[iter_21_2[1]] = var_21_0[iter_21_2[1]] + iter_21_2[2]
			end
		end

		self.goldNeed_ = var_21_0[CurrencyConst.CURRENCY_TYPE_GOLD]
	else
		self.goldNeed_ = 0
	end

	table.sort(var_21_0.all, function(arg_22_0, arg_22_1)
		return arg_22_1 < arg_22_0
	end)

	for iter_21_3, iter_21_4 in ipairs(var_21_0.all) do
		if iter_21_4 ~= CurrencyIdMapCfg.CURRENCY_TYPE_GOLD.item_id then
			local var_21_1 = clone(ItemTemplateData)

			var_21_1.id = iter_21_4
			var_21_1._num = var_21_0[iter_21_4]
			var_21_1.number = nil

			table.insert(self.cost_, var_21_1)
		end
	end
end

function TransitionGiftPtPopView:CheckEnough(arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(self.cost_) do
		if iter_23_1._num > ItemTools.getItemNum(iter_23_1.id) then
			if arg_23_1 then
				ShowPopItem(POP_SOURCE_ITEM, {
					iter_23_1.id,
					iter_23_1._num
				})
				ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")
			end

			return false
		end
	end

	return checkGold(self.goldNeed_, arg_23_1)
end

function TransitionGiftPtPopView:RefreshGold()
	self.gold_.text = not checkGold(self.goldNeed_, false) and "<color=#CF3232>" .. self.goldNeed_ .. "</color>" or self.goldNeed_
end

function TransitionGiftPtPopView:RefreshSlider(arg_25_1, arg_25_2, arg_25_3)
	if arg_25_2 == arg_25_3 then
		self.slider_.minValue = 0
		self.slider_.maxValue = 1
		self.slider_.value = 1
		self.slider_.interactable = false
	else
		self.slider_.minValue = arg_25_2 - 1
		self.slider_.maxValue = arg_25_3
		self.slider_.value = arg_25_1
		self.slider_.interactable = true
	end
end

function TransitionGiftPtPopView:GetValidRange()
	return 1, self.maxLevel_ - self.curLevel_
end

function TransitionGiftPtPopView:RefreshButton()
	self.delBtn_.interactable = self.addLevel_ > 1
	self.addBtn_.interactable = self.curLevel_ + self.addLevel_ < self.maxLevel_

	local var_27_0, var_27_1 = self:GetValidRange()

	self:RefreshSlider(self.addLevel_, var_27_0, var_27_1)

	self.numTxt1_.text = "+" .. self.addLevel_
	self.numTxt2_.text = "+" .. self.addLevel_
	self.enhanceCnt_.text = table.concat({
		GetTips("COMMON_ENHANCE_NUMBER"),
		":",
		self.addLevel_
	})
end

function TransitionGiftPtPopView:OnSliderValueChanged(arg_28_1)
	local var_28_0 = arg_28_1
	local var_28_1, var_28_2 = self:GetValidRange()

	if var_28_2 < var_28_0 then
		var_28_0 = var_28_2
	end

	if var_28_0 < var_28_1 then
		var_28_0 = var_28_1
	end

	if var_28_0 == self.addLevel_ then
		self:RefreshButton()
	else
		self.addLevel_ = var_28_0

		self:RefreshUI()
	end
end

function TransitionGiftPtPopView:OnGoldChange()
	self.maxLevel_ = self:GetMaxLevel()

	self:RefreshUI()
end

function TransitionGiftPtPopView:OnTryToImproveTransitionGiftPt()
	if self.level_ >= GameSetting.exclusive_skill_talent_num_max.value[1] then
		self:Back()
	else
		self.level_ = self.level_ + 1

		self:RefreshUI()
	end
end

function TransitionGiftPtPopView:OnExit()
	self.params_.addLevel = self.addLevel_
	self.params_.isEnter = false

	self:RemoveAllEventListener()
end

function TransitionGiftPtPopView:Dispose()
	self:RemoveAllEventListener()
	self:RemoveAllListeners()

	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()

		self.scrollHelper_ = nil
	end

	TransitionGiftPtPopView.super.Dispose(self)
end

return TransitionGiftPtPopView
