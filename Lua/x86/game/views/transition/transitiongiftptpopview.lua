local var_0_0 = class("TransitionGiftPtPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_jumps/HeroJumpsUpPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.tryToImproveTransitionGiftPtHandler_ = handler(arg_4_0, arg_4_0.OnTryToImproveTransitionGiftPt)
	arg_4_0.icon_.sprite = ItemTools.getItemLittleSprite(CurrencyIdMapCfg.CURRENCY_TYPE_GOLD.item_id)
	arg_4_0.scrollHelper_ = LuaList.New(function(arg_5_0, arg_5_1)
		arg_4_0:IndexItem(arg_5_0, arg_5_1)
	end, arg_4_0.listGo_, CommonItemView)
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.cost_[arg_6_1]
	local var_6_1 = ""
	local var_6_2 = ItemTools.getItemNum(var_6_0.id)

	function var_6_0.clickFun()
		ShowPopItem(POP_SOURCE_ITEM, {
			var_6_0.id,
			var_6_0._num
		})
	end

	var_6_0.bottomText = {
		var_6_2,
		var_6_0._num
	}
	var_6_0.animatorType = ItemConst.ITEM_ANIMATOR_TYPE.NULL

	arg_6_2:SetData(var_6_0)
end

function var_0_0.AddUIListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.btn_, nil, function()
		if not arg_8_0:CheckEnough(true) then
			return
		end

		if not _G.SkipTip.TransitionGiftPtImproveTip then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EXCLUSIVE_SKILL_POINT_UP_CONFIRMATION"),
				OkCallback = function()
					_G.SkipTip.TransitionGiftPtImproveTip = arg_8_0.TransitionGiftPtImproveTip_

					HeroAction.TryToImproveTransitionGiftPt(arg_8_0.params_.heroID, arg_8_0.params_.index, arg_8_0.addLevel_)
					arg_8_0:Back()
				end,
				CancelCallback = function()
					return
				end,
				ToggleCallback = function(arg_12_0)
					arg_8_0.TransitionGiftPtImproveTip_ = arg_12_0
				end
			})

			return
		end

		HeroAction.TryToImproveTransitionGiftPt(arg_8_0.params_.heroID, arg_8_0.params_.index, arg_8_0.addLevel_)
		arg_8_0:Back()
	end)
	arg_8_0:AddBtnListener(arg_8_0.delBtn_, nil, function()
		arg_8_0.addLevel_ = arg_8_0.addLevel_ - 1

		arg_8_0:RefreshUI()
	end)
	arg_8_0:AddBtnListener(arg_8_0.addBtn_, nil, function()
		arg_8_0.addLevel_ = arg_8_0.addLevel_ + 1

		arg_8_0:RefreshUI()
	end)
	arg_8_0:AddBtnListener(arg_8_0.maskBtn_, nil, function()
		arg_8_0:Back()
	end)
	arg_8_0.slider_.onValueChanged:AddListener(function(arg_16_0)
		arg_8_0:OnSliderValueChanged(arg_16_0)
	end)

	arg_8_0.slider_.wholeNumbers = true
end

function var_0_0.OnEnter(arg_17_0)
	manager.windowBar:SetAsLastSibling()
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)

	arg_17_0.curLevel_ = arg_17_0.params_.giftPt
	arg_17_0.maxLevel_ = arg_17_0:GetMaxLevel()
	arg_17_0.addLevel_ = arg_17_0.params_.isEnter and arg_17_0:CaclCanUpgradeMaxLevel() or arg_17_0.params_.addLevel
	arg_17_0.slider_.value = arg_17_0.addLevel_

	arg_17_0:RegistEventListener(CURRENCY_UPDATE, handler(arg_17_0, arg_17_0.OnGoldChange))
	arg_17_0:RefreshUI()
end

function var_0_0.GetMaxLevel(arg_18_0)
	local var_18_0 = GameSetting.exclusive_skill_talent_num_max.value[1]

	return (math.max(arg_18_0.curLevel_ + 1, var_18_0))
end

function var_0_0.CaclCanUpgradeMaxLevel(arg_19_0)
	local var_19_0 = GameSetting.exclusive_skill_talent_strengthen_cost.value
	local var_19_1 = 1
	local var_19_2 = {}

	for iter_19_0 = var_19_1, arg_19_0.maxLevel_ - arg_19_0.curLevel_ do
		local var_19_3 = var_19_0[iter_19_0 + arg_19_0.curLevel_]

		for iter_19_1, iter_19_2 in ipairs(var_19_3) do
			local var_19_4 = iter_19_2[1]
			local var_19_5 = iter_19_2[2]

			if not var_19_2[var_19_4] then
				var_19_2[var_19_4] = 0
			end

			if var_19_2[var_19_4] + var_19_5 > ItemTools.getItemNum(var_19_4) then
				return math.max(1, iter_19_0 - 1)
			end

			var_19_2[var_19_4] = var_19_2[var_19_4] + var_19_5
		end

		var_19_1 = iter_19_0
	end

	return var_19_1
end

function var_0_0.RefreshUI(arg_20_0)
	arg_20_0:RefreshCost()
	arg_20_0:RefreshGold()
	arg_20_0:RefreshButton()
	arg_20_0.scrollHelper_:StartScroll(#arg_20_0.cost_)
end

function var_0_0.RefreshCost(arg_21_0)
	arg_21_0.cost_ = {}

	local var_21_0 = {
		all = {}
	}

	if arg_21_0.addLevel_ > 0 then
		local var_21_1 = GameSetting.exclusive_skill_talent_strengthen_cost.value

		for iter_21_0 = arg_21_0.curLevel_ + 1, arg_21_0.curLevel_ + arg_21_0.addLevel_ do
			local var_21_2 = var_21_1[iter_21_0]

			for iter_21_1, iter_21_2 in ipairs(var_21_2) do
				local var_21_3 = iter_21_2[1]
				local var_21_4 = iter_21_2[2]

				if not var_21_0[var_21_3] then
					var_21_0[var_21_3] = 0

					table.insert(var_21_0.all, var_21_3)
				end

				var_21_0[var_21_3] = var_21_0[var_21_3] + var_21_4
			end
		end

		arg_21_0.goldNeed_ = var_21_0[CurrencyConst.CURRENCY_TYPE_GOLD]
	else
		arg_21_0.goldNeed_ = 0
	end

	table.sort(var_21_0.all, function(arg_22_0, arg_22_1)
		return arg_22_1 < arg_22_0
	end)

	for iter_21_3, iter_21_4 in ipairs(var_21_0.all) do
		if iter_21_4 ~= CurrencyIdMapCfg.CURRENCY_TYPE_GOLD.item_id then
			local var_21_5 = clone(ItemTemplateData)

			var_21_5.id = iter_21_4
			var_21_5._num = var_21_0[iter_21_4]
			var_21_5.number = nil

			table.insert(arg_21_0.cost_, var_21_5)
		end
	end
end

function var_0_0.CheckEnough(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0.cost_) do
		local var_23_0 = iter_23_1.id
		local var_23_1 = iter_23_1._num

		if var_23_1 > ItemTools.getItemNum(var_23_0) then
			if arg_23_1 then
				ShowPopItem(POP_SOURCE_ITEM, {
					var_23_0,
					var_23_1
				})
				ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")
			end

			return false
		end
	end

	return checkGold(arg_23_0.goldNeed_, arg_23_1)
end

function var_0_0.RefreshGold(arg_24_0)
	if not checkGold(arg_24_0.goldNeed_, false) then
		arg_24_0.gold_.text = "<color=#CF3232>" .. arg_24_0.goldNeed_ .. "</color>"
	else
		arg_24_0.gold_.text = arg_24_0.goldNeed_
	end
end

function var_0_0.RefreshSlider(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if arg_25_2 == arg_25_3 then
		arg_25_0.slider_.minValue = 0
		arg_25_0.slider_.maxValue = 1
		arg_25_0.slider_.value = 1
		arg_25_0.slider_.interactable = false
	else
		arg_25_0.slider_.minValue = arg_25_2 - 1
		arg_25_0.slider_.maxValue = arg_25_3
		arg_25_0.slider_.value = arg_25_1
		arg_25_0.slider_.interactable = true
	end
end

function var_0_0.GetValidRange(arg_26_0)
	return 1, arg_26_0.maxLevel_ - arg_26_0.curLevel_
end

function var_0_0.RefreshButton(arg_27_0)
	arg_27_0.delBtn_.interactable = arg_27_0.addLevel_ > 1
	arg_27_0.addBtn_.interactable = arg_27_0.curLevel_ + arg_27_0.addLevel_ < arg_27_0.maxLevel_

	local var_27_0, var_27_1 = arg_27_0:GetValidRange()

	arg_27_0:RefreshSlider(arg_27_0.addLevel_, var_27_0, var_27_1)

	arg_27_0.numTxt1_.text = "+" .. arg_27_0.addLevel_
	arg_27_0.numTxt2_.text = "+" .. arg_27_0.addLevel_
	arg_27_0.enhanceCnt_.text = table.concat({
		GetTips("COMMON_ENHANCE_NUMBER"),
		":",
		arg_27_0.addLevel_
	})
end

function var_0_0.OnSliderValueChanged(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1
	local var_28_1, var_28_2 = arg_28_0:GetValidRange()

	if var_28_2 < var_28_0 then
		var_28_0 = var_28_2
	end

	if var_28_0 < var_28_1 then
		var_28_0 = var_28_1
	end

	if var_28_0 == arg_28_0.addLevel_ then
		arg_28_0:RefreshButton()
	else
		arg_28_0.addLevel_ = var_28_0

		arg_28_0:RefreshUI()
	end
end

function var_0_0.OnGoldChange(arg_29_0)
	arg_29_0.maxLevel_ = arg_29_0:GetMaxLevel()

	arg_29_0:RefreshUI()
end

function var_0_0.OnTryToImproveTransitionGiftPt(arg_30_0)
	if arg_30_0.level_ >= GameSetting.exclusive_skill_talent_num_max.value[1] then
		arg_30_0:Back()
	else
		arg_30_0.level_ = arg_30_0.level_ + 1

		arg_30_0:RefreshUI()
	end
end

function var_0_0.OnExit(arg_31_0)
	arg_31_0.params_.addLevel = arg_31_0.addLevel_
	arg_31_0.params_.isEnter = false

	arg_31_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_32_0)
	arg_32_0:RemoveAllEventListener()
	arg_32_0:RemoveAllListeners()

	if arg_32_0.scrollHelper_ then
		arg_32_0.scrollHelper_:Dispose()

		arg_32_0.scrollHelper_ = nil
	end

	var_0_0.super.Dispose(arg_32_0)
end

return var_0_0
