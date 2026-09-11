local ItemUseView = class("ItemUseView", ReduxView)

function ItemUseView:UIName()
	return "Widget/System/Bag/BagScenepopUI"
end

function ItemUseView:UIParent()
	return manager.ui.uiPop.transform
end

function ItemUseView:Init()
	self:InitUI()
	self:AddUIListener()

	self.refreshUIHandler_ = handler(self, self.RefreshUI)
end

function ItemUseView:InitUI()
	self:BindCfgUI()

	self.commonItem1_ = CommonItemView.New(self.commonItemGo1_)
	self.useNumTriggerListener_ = self.useNumSliderGo_.transform:GetComponent(typeof(EventTriggerListener))
	self.controller_ = self.controllerEx_:GetController("state")

	self.controller_:SetSelectedState("1")

	self.titleText_.text = GetTips("ITEM_USE")
end

function ItemUseView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		OperationRecorder.Record(self.lastRecord_, "operateUseBtn")

		local var_8_0 = ItemTools.getItemNum(self.itemData_.id, self.itemData_.timeValid)
		local var_8_1 = self.useNumSlider_.value
		local var_8_2 = self:AddVitalityCnt()

		if var_8_2 and var_8_1 * var_8_2 + ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) > ItemCfg[CurrencyConst.CURRENCY_TYPE_VITALITY].max then
			ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

			return
		end

		if not canAddVitalityByProp(self.itemData_.id) then
			ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

			return
		end

		local var_8_3

		if ItemCfg[self.itemData_.id].sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM_MULT or ItemCfg[self.itemData_.id].sub_type == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_MULTI then
			JumpTools.OpenPageByJump("optionalItemSelect", {
				popItemInfo = {
					self.itemData_.id,
					ItemTools.getItemNum(self.itemData_.id, self.itemData_.timeValid),
					0,
					self.itemData_.timeValid
				},
				selectNum = var_8_1,
				noPop = self.params_.noPop
			})

			do return end

			var_8_3 = {}
		end

		var_8_3[1] = {
			item_info = {
				id = self.itemData_.id,
				num = var_8_1,
				time_valid = self.itemData_.timeValid
			},
			use_list = {}
		}

		CommonAction.TryToUseItemWitchCallback(var_8_3, function(arg_9_0)
			self:UseItemSuccess(arg_9_0)
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
			local var_13_0 = self.useNumSlider_.value
			local var_13_1 = self:AddVitalityCnt()

			if var_13_1 and (var_13_0 + 1) * var_13_1 + ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) > ItemCfg[CurrencyConst.CURRENCY_TYPE_VITALITY].max then
				ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

				return false
			end

			self.selectNum_ = self.selectNum_ + 1

			self:UpdateSliderPositionBySelectNum()
			self:UpdateDelAddBtn()

			return true
		end

		return false
	end)
end

function ItemUseView:UpdateSliderPositionBySelectNum()
	self.useNumSlider_.value = self.selectNum_
end

function ItemUseView:UpdateDelAddBtn()
	self.okBtn_.enabled = self.selectNum_ >= 1
	self.delBtn_.interactable = self.selectNum_ > 1
	self.addBtn_.interactable = self.selectNum_ < self.canUseMaxNum_
end

function ItemUseView:InitData()
	self.itemData_ = self.params_.itemData

	local var_16_0 = self:GetMaxNum()

	if var_16_0 < 1 then
		var_16_0 = 1
	end

	self.canUseMaxNum_ = var_16_0
	self.selectNum_ = 1
	self.useNumSlider_.maxValue = var_16_0
	self.useNumSlider_.value = 1
end

function ItemUseView:UpdateView()
	local var_17_0 = clone(ItemTemplateData)

	var_17_0.id = self.itemData_.id
	var_17_0.number = ItemTools.getItemNum(self.itemData_.id, self.itemData_.timeValid)

	function var_17_0.clickFun(arg_18_0)
		local var_18_0 = clone(arg_18_0)

		var_18_0.timeValid = self.itemData_.timeValid

		ShowPopItem(POP_ITEM, var_18_0)
	end

	self.commonItem1_:SetData(var_17_0)

	self.nameText1_.text = ItemTools.getItemName(self.itemData_.id)

	self:UpdateNum()
	self:UpdateSliderPositionBySelectNum()
	self:UpdateDelAddBtn()
end

function ItemUseView:UpdateNum()
	self.useNumText_.text = tostring(self.selectNum_)
end

function ItemUseView:OnEnter()
	self:InitData()
	self:UpdateView()
	manager.notify:RegistListener(USE_ITEM_SUCCESS, self.refreshUIHandler_)
end

function ItemUseView:OnExit()
	manager.notify:RemoveListener(USE_ITEM_SUCCESS, self.refreshUIHandler_)
	self:RemoveAllEventListener()
end

function ItemUseView:Dispose()
	self.refreshUIHandler_ = nil

	self.useNumSlider_.onValueChanged:RemoveAllListeners()
	self.useNumTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)

	if self.commonItem1_ then
		self.commonItem1_:Dispose()

		self.commonItem1_ = nil
	end

	ItemUseView.super.Dispose(self)
end

function ItemUseView:AddVitalityCnt()
	if ItemCfg[self.itemData_.id].sub_type == ItemConst.ITEM_SUB_TYPE.TIME_LIMIT_ITEM or ItemCfg[self.itemData_.id].sub_type == ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY_TIME_VALID then
		return ItemCfg[self.itemData_.id].param[1][2]
	end

	return false
end

function ItemUseView:GetMaxNum()
	if ItemCfg[self.itemData_.id].sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM or ItemCfg[self.itemData_.id].sub_type == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_ONE then
		return 1
	end

	local var_24_0 = ItemTools.getItemNum(self.itemData_.id, self.itemData_.timeValid)

	if ItemCfg[self.itemData_.id].type == ItemConst.ITEM_TYPE.PROPS and (ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY == ItemCfg[self.itemData_.id].sub_type or ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY_TIME_VALID == ItemCfg[self.itemData_.id].sub_type) then
		return (math.max(math.min(math.floor((999 - ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)) / ItemCfg[self.itemData_.id].param[1][2]), var_24_0), 1))
	end

	return var_24_0
end

function ItemUseView:UseItemSuccess(arg_25_1)
	local var_25_0 = self.itemData_.id
	local var_25_1 = ItemTools.getItemNum(self.itemData_.id, self.itemData_.timeValid)

	if var_25_1 <= 0 then
		self:Back()
	else
		self:InitData()
		self:UpdateView()
	end

	local var_25_2 = arg_25_1.drop_list

	if ItemCfg[var_25_0].type == ItemConst.ITEM_TYPE.SKIN_CHANGE then
		getReward(formatRewardCfgList({
			{
				ItemCfg[var_25_0].param[1],
				1
			}
		}))
	elseif ItemCfg[var_25_0].sub_type == ItemConst.ITEM_SUB_TYPE.BIRTHDAY_ITEM then
		if var_25_1 > 0 then
			self:Back()
		end

		manager.story:StartStory(BirthdayCfg[BirthdayCfg.get_id_list_by_commemorative_props_id[var_25_0][1]].story_id)
	elseif ItemCfg[var_25_0].sub_type == ItemConst.ITEM_SUB_TYPE.STORY_ITEM then
		if var_25_1 > 0 then
			self:Back()
		end

		manager.story:StartStory(ItemCfg[var_25_0].param[1])
	elseif ItemCfg[var_25_0].sub_type == ItemConst.ITEM_SUB_TYPE.BITRHDAY_LETTER then
		if var_25_1 > 0 then
			self:Back()
		end

		local var_25_4 = BirthdayCfg[BirthdayCfg.get_id_list_by_appendix_id[var_25_0][1]].story_id

		manager.story:StartStory(BirthdayCfg[BirthdayCfg.get_id_list_by_appendix_id[var_25_0][1]].story_id)
		IllustratedData:ModifyPlot(var_25_4)
		getReward(var_25_2)
		SDKTools.SendMessageToSDK("birthday_received", {
			story_unlock = 1
		})
	elseif ItemCfg[var_25_0].type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
		ShowTips("EXCHANGE_SUCCESS")
	elseif ItemCfg[var_25_0].sub_type == ItemConst.ITEM_SUB_TYPE.MOON_CAKE_GIFT then
		getReward(var_25_2)
		MoonCakeAction.OnOpenGift(ItemCfg[var_25_0].time[2][1], arg_25_1.drop_list)
	else
		getReward(mergeReward(var_25_2))
	end
end

function ItemUseView:OnTop()
	if ItemTools.getItemNum(self.itemData_.id, self.itemData_.timeValid) <= 0 then
		self:Back()
	end
end

function ItemUseView:RefreshUI()
	self:InitData()
	self:UpdateView()
end

return ItemUseView
