local SynthesiseView = class("SynthesiseView", ReduxView)

function SynthesiseView:UIName()
	return "Widget/System/Bag/BagScenepopUI"
end

function SynthesiseView:UIParent()
	return manager.ui.uiPop.transform
end

function SynthesiseView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SynthesiseView:InitUI()
	self:BindCfgUI()

	self.commonItem1_ = CommonItemView.New(self.commonItemGo1_)
	self.commonItem2_ = CommonItemView.New(self.commonItemGo2_)
	self.useNumTriggerListener_ = self.useNumSliderGo_.transform:GetComponent(typeof(EventTriggerListener))
	self.controller_ = self.controllerEx_:GetController("state")

	self.controller_:SetSelectedState("2")
end

function SynthesiseView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		local var_8_0 = ItemTools.getItemNum(self.sourceId_)

		if self.haveNum_ < ItemExchangeCfg[self.exchangeID_].cost[1][2] * self.selectNum_ then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")

			return
		end

		CurrencyAction.ExchangeItem(self.exchangeID_, self.selectNum_, function(arg_9_0)
			manager.notify:Invoke(ON_SYNTHESISE_USE_ITEM_SUCCESS)
			self:Back()
			getReward(arg_9_0.reward_list)
		end)
	end)
	self.useNumSlider_.onValueChanged:AddListener(function()
		self.selectNum_ = self.useNumSlider_.value

		if self.selectNum_ < 1 then
			self.selectNum_ = 1

			self:UpdateSliderPositionBySelectNum()
		end

		self:UpdateDelAddBtn()
		self:UpdateNum()
	end)
	self.useNumTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_11_0, arg_11_1)
		self:UpdateDelAddBtn()
		self:UpdateNum()
		OperationRecorder.Record("bag", "mergeDrag")
	end))
	self:AddPressingByTimeListener(self.delBtn_.gameObject, 3, 0.5, 0.2, function()
		if self.selectNum_ > 1 then
			self.selectNum_ = self.selectNum_ - 1

			self:UpdateSliderPositionBySelectNum()
			self:UpdateDelAddBtn()
			self:UpdateNum()

			return true
		end

		return false
	end)
	self:AddPressingByTimeListener(self.addBtn_.gameObject, 3, 0.5, 0.2, function()
		if self.selectNum_ < self.canUseMaxNum_ then
			self.selectNum_ = self.selectNum_ + 1

			self:UpdateSliderPositionBySelectNum()
			self:UpdateDelAddBtn()

			return true
		end

		return false
	end)
end

function SynthesiseView:UpdateSliderPositionBySelectNum()
	self.useNumSlider_.value = self.selectNum_
end

function SynthesiseView:UpdateDelAddBtn()
	self.okBtn_.enabled = self.selectNum_ >= 1
	self.delBtn_.interactable = self.selectNum_ > 1
	self.addBtn_.interactable = self.selectNum_ < self.canUseMaxNum_
end

function SynthesiseView:InitData()
	self.exchangeID_ = self.params_.id
	self.sourceId_ = ItemExchangeCfg[self.exchangeID_].cost[1][1]
	self.targetId_ = ItemExchangeCfg[self.exchangeID_].item_id
	self.costNum_ = ItemExchangeCfg[self.exchangeID_].cost[1][2]
	self.sourceCfg_ = ItemCfg[self.sourceId_]
	self.targetCfg_ = ItemCfg[self.targetId_]
	self.exchangeRate_ = self.costNum_

	local var_16_0 = ItemTools.getItemNum(self.sourceId_)

	self.haveNum_ = var_16_0

	local var_16_1 = math.floor(var_16_0 / self.costNum_)

	if var_16_1 < 1 then
		var_16_1 = 1
	end

	self.canUseMaxNum_ = var_16_1
	self.selectNum_ = 1
	self.useNumSlider_.maxValue = var_16_1
	self.useNumSlider_.value = 1
end

function SynthesiseView:UpdateView()
	local var_17_0 = clone(ItemTemplateData)

	var_17_0.id = self.sourceId_
	var_17_0.number = nil

	function var_17_0:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	self.commonItem1_:SetData(var_17_0)

	self.nameText1_.text = ItemTools.getItemName(self.sourceCfg_.id)

	local var_17_1 = clone(ItemTemplateData)

	var_17_1.id = self.targetId_
	var_17_1.number = nil

	function var_17_1:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	self.commonItem2_:SetData(var_17_1)

	self.nameText2_.text = ItemTools.getItemName(self.targetCfg_.id)

	self:UpdateNum()
	self:UpdateSliderPositionBySelectNum()
	self:UpdateDelAddBtn()
end

function SynthesiseView:UpdateNum()
	self.useNumText_.text = tostring(self.selectNum_) * self.exchangeRate_

	self.commonItem1_:RefreshBottomText({
		ItemTools.getItemNum(self.sourceId_),
		self.costNum_ * self.selectNum_
	})
	self.commonItem2_:RefreshBottomText(ItemExchangeCfg[self.exchangeID_].num * self.selectNum_)
end

function SynthesiseView:OnEnter()
	self:InitData()
	self:UpdateView()

	if ItemExchangeCfg[self.exchangeID_].type == 1 then
		self.titleText_.text = GetTips("ITEM_EXCHANGE")
	elseif ItemExchangeCfg[self.exchangeID_].type == 2 then
		self.titleText_.text = GetTips("ITEM_COMPOSE")
	elseif ItemExchangeCfg[self.exchangeID_].type == 3 then
		self.titleText_.text = GetTips("ITEM_DECOMPOSE")
	end
end

function SynthesiseView:OnExit()
	self:RemoveAllEventListener()
end

function SynthesiseView:Dispose()
	self.useNumSlider_.onValueChanged:RemoveAllListeners()
	self.useNumTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)

	if self.commonItem1_ then
		self.commonItem1_:Dispose()

		self.commonItem1_ = nil
	end

	if self.commonItem2_ then
		self.commonItem2_:Dispose()

		self.commonItem2_ = nil
	end

	SynthesiseView.super.Dispose(self)
end

return SynthesiseView
