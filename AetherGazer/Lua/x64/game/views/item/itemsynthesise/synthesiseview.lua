local var_0_0 = class("SynthesiseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Bag/BagScenepopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.commonItem1_ = CommonItemView.New(arg_4_0.commonItemGo1_)
	arg_4_0.commonItem2_ = CommonItemView.New(arg_4_0.commonItemGo2_)
	arg_4_0.useNumTriggerListener_ = arg_4_0.useNumSliderGo_.transform:GetComponent(typeof(EventTriggerListener))
	arg_4_0.controller_ = arg_4_0.controllerEx_:GetController("state")

	arg_4_0.controller_:SetSelectedState("2")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.okBtn_, nil, function()
		local var_8_0 = ItemTools.getItemNum(arg_5_0.sourceId_)
		local var_8_1 = ItemExchangeCfg[arg_5_0.exchangeID_]

		if arg_5_0.haveNum_ < var_8_1.cost[1][2] * arg_5_0.selectNum_ then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")

			return
		end

		CurrencyAction.ExchangeItem(arg_5_0.exchangeID_, arg_5_0.selectNum_, function(arg_9_0)
			manager.notify:Invoke(ON_SYNTHESISE_USE_ITEM_SUCCESS)
			arg_5_0:Back()
			getReward(arg_9_0.reward_list)
		end)
	end)
	arg_5_0.useNumSlider_.onValueChanged:AddListener(function()
		arg_5_0.selectNum_ = arg_5_0.useNumSlider_.value

		if arg_5_0.selectNum_ < 1 then
			arg_5_0.selectNum_ = 1

			arg_5_0:UpdateSliderPositionBySelectNum()
		end

		arg_5_0:UpdateDelAddBtn()
		arg_5_0:UpdateNum()
	end)
	arg_5_0.useNumTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_11_0, arg_11_1)
		arg_5_0:UpdateDelAddBtn()
		arg_5_0:UpdateNum()
		OperationRecorder.Record("bag", "mergeDrag")
	end))
	arg_5_0:AddPressingByTimeListener(arg_5_0.delBtn_.gameObject, 3, 0.5, 0.2, function()
		if arg_5_0.selectNum_ > 1 then
			arg_5_0.selectNum_ = arg_5_0.selectNum_ - 1

			arg_5_0:UpdateSliderPositionBySelectNum()
			arg_5_0:UpdateDelAddBtn()
			arg_5_0:UpdateNum()

			return true
		end

		return false
	end)
	arg_5_0:AddPressingByTimeListener(arg_5_0.addBtn_.gameObject, 3, 0.5, 0.2, function()
		if arg_5_0.selectNum_ < arg_5_0.canUseMaxNum_ then
			arg_5_0.selectNum_ = arg_5_0.selectNum_ + 1

			arg_5_0:UpdateSliderPositionBySelectNum()
			arg_5_0:UpdateDelAddBtn()

			return true
		end

		return false
	end)
end

function var_0_0.UpdateSliderPositionBySelectNum(arg_14_0)
	arg_14_0.useNumSlider_.value = arg_14_0.selectNum_
end

function var_0_0.UpdateDelAddBtn(arg_15_0)
	arg_15_0.okBtn_.enabled = arg_15_0.selectNum_ >= 1
	arg_15_0.delBtn_.interactable = arg_15_0.selectNum_ > 1
	arg_15_0.addBtn_.interactable = arg_15_0.selectNum_ < arg_15_0.canUseMaxNum_
end

function var_0_0.InitData(arg_16_0)
	arg_16_0.exchangeID_ = arg_16_0.params_.id

	local var_16_0 = ItemExchangeCfg[arg_16_0.exchangeID_]

	arg_16_0.sourceId_ = var_16_0.cost[1][1]
	arg_16_0.targetId_ = var_16_0.item_id
	arg_16_0.costNum_ = var_16_0.cost[1][2]
	arg_16_0.sourceCfg_ = ItemCfg[arg_16_0.sourceId_]
	arg_16_0.targetCfg_ = ItemCfg[arg_16_0.targetId_]
	arg_16_0.exchangeRate_ = arg_16_0.costNum_

	local var_16_1 = ItemTools.getItemNum(arg_16_0.sourceId_)

	arg_16_0.haveNum_ = var_16_1

	local var_16_2 = math.floor(var_16_1 / arg_16_0.costNum_)

	if var_16_2 < 1 then
		var_16_2 = 1
	end

	arg_16_0.canUseMaxNum_ = var_16_2
	arg_16_0.selectNum_ = 1
	arg_16_0.useNumSlider_.maxValue = var_16_2
	arg_16_0.useNumSlider_.value = 1
end

function var_0_0.UpdateView(arg_17_0)
	local var_17_0 = clone(ItemTemplateData)

	var_17_0.id = arg_17_0.sourceId_
	var_17_0.number = nil

	function var_17_0.clickFun(arg_18_0)
		ShowPopItem(POP_ITEM, {
			arg_18_0.id,
			arg_18_0.number
		})
	end

	arg_17_0.commonItem1_:SetData(var_17_0)

	arg_17_0.nameText1_.text = ItemTools.getItemName(arg_17_0.sourceCfg_.id)

	local var_17_1 = clone(ItemTemplateData)

	var_17_1.id = arg_17_0.targetId_
	var_17_1.number = nil

	function var_17_1.clickFun(arg_19_0)
		ShowPopItem(POP_ITEM, {
			arg_19_0.id,
			arg_19_0.number
		})
	end

	local var_17_2 = ItemExchangeCfg[arg_17_0.exchangeID_]

	arg_17_0.commonItem2_:SetData(var_17_1)

	arg_17_0.nameText2_.text = ItemTools.getItemName(arg_17_0.targetCfg_.id)

	arg_17_0:UpdateNum()
	arg_17_0:UpdateSliderPositionBySelectNum()
	arg_17_0:UpdateDelAddBtn()
end

function var_0_0.UpdateNum(arg_20_0)
	arg_20_0.useNumText_.text = tostring(arg_20_0.selectNum_) * arg_20_0.exchangeRate_

	local var_20_0 = ItemTools.getItemNum(arg_20_0.sourceId_)

	arg_20_0.commonItem1_:RefreshBottomText({
		var_20_0,
		arg_20_0.costNum_ * arg_20_0.selectNum_
	})

	local var_20_1 = ItemExchangeCfg[arg_20_0.exchangeID_]

	arg_20_0.commonItem2_:RefreshBottomText(var_20_1.num * arg_20_0.selectNum_)
end

function var_0_0.OnEnter(arg_21_0)
	arg_21_0:InitData()
	arg_21_0:UpdateView()

	local var_21_0 = ItemExchangeCfg[arg_21_0.exchangeID_]

	if var_21_0.type == 1 then
		arg_21_0.titleText_.text = GetTips("ITEM_EXCHANGE")
	elseif var_21_0.type == 2 then
		arg_21_0.titleText_.text = GetTips("ITEM_COMPOSE")
	elseif var_21_0.type == 3 then
		arg_21_0.titleText_.text = GetTips("ITEM_DECOMPOSE")
	end
end

function var_0_0.OnExit(arg_22_0)
	arg_22_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0.useNumSlider_.onValueChanged:RemoveAllListeners()
	arg_23_0.useNumTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)

	if arg_23_0.commonItem1_ then
		arg_23_0.commonItem1_:Dispose()

		arg_23_0.commonItem1_ = nil
	end

	if arg_23_0.commonItem2_ then
		arg_23_0.commonItem2_:Dispose()

		arg_23_0.commonItem2_ = nil
	end

	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
