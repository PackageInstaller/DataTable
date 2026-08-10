local var_0_0 = class("ItemUseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Bag/BagScenepopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.refreshUIHandler_ = handler(arg_3_0, arg_3_0.RefreshUI)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.commonItem1_ = CommonItemView.New(arg_4_0.commonItemGo1_)
	arg_4_0.useNumTriggerListener_ = arg_4_0.useNumSliderGo_.transform:GetComponent(typeof(EventTriggerListener))
	arg_4_0.controller_ = arg_4_0.controllerEx_:GetController("state")

	arg_4_0.controller_:SetSelectedState("1")

	arg_4_0.titleText_.text = GetTips("ITEM_USE")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.okBtn_, nil, function()
		OperationRecorder.Record(arg_5_0.lastRecord_, "operateUseBtn")

		local var_8_0 = arg_5_0.itemData_.id
		local var_8_1 = ItemTools.getItemNum(var_8_0, arg_5_0.itemData_.timeValid)
		local var_8_2 = arg_5_0.itemData_.timeValid
		local var_8_3 = ItemCfg[var_8_0]
		local var_8_4 = arg_5_0.useNumSlider_.value
		local var_8_5 = arg_5_0:AddVitalityCnt()

		if var_8_5 and not (var_8_4 * var_8_5 + ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) <= ItemCfg[CurrencyConst.CURRENCY_TYPE_VITALITY].max) then
			ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

			return
		end

		if not canAddVitalityByProp(var_8_0) then
			ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

			return
		end

		if var_8_3.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM_MULT or var_8_3.sub_type == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_MULTI then
			JumpTools.OpenPageByJump("optionalItemSelect", {
				popItemInfo = {
					var_8_0,
					ItemTools.getItemNum(var_8_0, arg_5_0.itemData_.timeValid),
					0,
					var_8_2
				},
				selectNum = var_8_4,
				noPop = arg_5_0.params_.noPop
			})

			return
		end

		local var_8_6 = {
			item_info = {
				id = var_8_0,
				num = var_8_4,
				time_valid = var_8_2
			},
			use_list = {}
		}

		CommonAction.TryToUseItemWitchCallback({
			var_8_6
		}, function(arg_9_0)
			arg_5_0:UseItemSuccess(arg_9_0)
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
			local var_13_0 = arg_5_0.useNumSlider_.value
			local var_13_1 = arg_5_0:AddVitalityCnt()

			if var_13_1 and not ((var_13_0 + 1) * var_13_1 + ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) <= ItemCfg[CurrencyConst.CURRENCY_TYPE_VITALITY].max) then
				ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

				return false
			end

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
	arg_16_0.itemData_ = arg_16_0.params_.itemData

	local var_16_0 = arg_16_0:GetMaxNum()

	if var_16_0 < 1 then
		var_16_0 = 1
	end

	arg_16_0.canUseMaxNum_ = var_16_0
	arg_16_0.selectNum_ = 1
	arg_16_0.useNumSlider_.maxValue = var_16_0
	arg_16_0.useNumSlider_.value = 1
end

function var_0_0.UpdateView(arg_17_0)
	local var_17_0 = arg_17_0.itemData_.id
	local var_17_1 = clone(ItemTemplateData)

	var_17_1.id = var_17_0
	var_17_1.number = ItemTools.getItemNum(arg_17_0.itemData_.id, arg_17_0.itemData_.timeValid)

	function var_17_1.clickFun(arg_18_0)
		local var_18_0 = clone(arg_18_0)

		var_18_0.timeValid = arg_17_0.itemData_.timeValid

		ShowPopItem(POP_ITEM, var_18_0)
	end

	arg_17_0.commonItem1_:SetData(var_17_1)

	arg_17_0.nameText1_.text = ItemTools.getItemName(var_17_0)

	arg_17_0:UpdateNum()
	arg_17_0:UpdateSliderPositionBySelectNum()
	arg_17_0:UpdateDelAddBtn()
end

function var_0_0.UpdateNum(arg_19_0)
	arg_19_0.useNumText_.text = tostring(arg_19_0.selectNum_)
end

function var_0_0.OnEnter(arg_20_0)
	arg_20_0:InitData()
	arg_20_0:UpdateView()
	manager.notify:RegistListener(USE_ITEM_SUCCESS, arg_20_0.refreshUIHandler_)
end

function var_0_0.OnExit(arg_21_0)
	manager.notify:RemoveListener(USE_ITEM_SUCCESS, arg_21_0.refreshUIHandler_)
	arg_21_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0.refreshUIHandler_ = nil

	arg_22_0.useNumSlider_.onValueChanged:RemoveAllListeners()
	arg_22_0.useNumTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)

	if arg_22_0.commonItem1_ then
		arg_22_0.commonItem1_:Dispose()

		arg_22_0.commonItem1_ = nil
	end

	var_0_0.super.Dispose(arg_22_0)
end

function var_0_0.AddVitalityCnt(arg_23_0)
	local var_23_0 = ItemCfg[arg_23_0.itemData_.id]

	if var_23_0.sub_type == ItemConst.ITEM_SUB_TYPE.TIME_LIMIT_ITEM or var_23_0.sub_type == ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY_TIME_VALID then
		return var_23_0.param[1][2]
	end

	return false
end

function var_0_0.GetMaxNum(arg_24_0)
	local var_24_0 = arg_24_0.itemData_.id
	local var_24_1 = arg_24_0.itemData_.timeValid
	local var_24_2 = ItemCfg[var_24_0]

	if var_24_2.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM or var_24_2.sub_type == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_ONE then
		return 1
	end

	local var_24_3 = ItemTools.getItemNum(var_24_0, var_24_1)

	if var_24_2.type == ItemConst.ITEM_TYPE.PROPS and (ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY == var_24_2.sub_type or ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY_TIME_VALID == var_24_2.sub_type) then
		local var_24_4 = var_24_2.param[1][2]
		local var_24_5 = math.floor((999 - ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)) / var_24_4)
		local var_24_6 = math.min(var_24_5, var_24_3)

		return (math.max(var_24_6, 1))
	end

	return var_24_3
end

function var_0_0.UseItemSuccess(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.itemData_.id
	local var_25_1 = arg_25_0.itemData_.timeValid
	local var_25_2 = ItemTools.getItemNum(var_25_0, var_25_1)

	if var_25_2 <= 0 then
		arg_25_0:Back()
	else
		arg_25_0:InitData()
		arg_25_0:UpdateView()
	end

	local var_25_3 = arg_25_1.drop_list

	if ItemCfg[var_25_0].type == ItemConst.ITEM_TYPE.SKIN_CHANGE then
		local var_25_4 = ItemCfg[var_25_0].param[1]
		local var_25_5 = SkinCfg[var_25_4].hero

		getReward(formatRewardCfgList({
			{
				var_25_4,
				1
			}
		}))
	elseif ItemCfg[var_25_0].sub_type == ItemConst.ITEM_SUB_TYPE.BIRTHDAY_ITEM then
		if var_25_2 > 0 then
			arg_25_0:Back()
		end

		local var_25_6 = BirthdayCfg[BirthdayCfg.get_id_list_by_commemorative_props_id[var_25_0][1]].story_id

		manager.story:StartStory(var_25_6)
	elseif ItemCfg[var_25_0].sub_type == ItemConst.ITEM_SUB_TYPE.STORY_ITEM then
		if var_25_2 > 0 then
			arg_25_0:Back()
		end

		local var_25_7 = ItemCfg[var_25_0].param[1]

		manager.story:StartStory(var_25_7)
	elseif ItemCfg[var_25_0].sub_type == ItemConst.ITEM_SUB_TYPE.BITRHDAY_LETTER then
		if var_25_2 > 0 then
			arg_25_0:Back()
		end

		local var_25_8 = BirthdayCfg[BirthdayCfg.get_id_list_by_appendix_id[var_25_0][1]].story_id

		manager.story:StartStory(var_25_8)
		IllustratedData:ModifyPlot(var_25_8)
		getReward(var_25_3)
		SDKTools.SendMessageToSDK("birthday_received", {
			story_unlock = 1
		})
	elseif ItemCfg[var_25_0].type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
		ShowTips("EXCHANGE_SUCCESS")
	elseif ItemCfg[var_25_0].sub_type == ItemConst.ITEM_SUB_TYPE.MOON_CAKE_GIFT then
		getReward(var_25_3)

		local var_25_9 = ItemCfg[var_25_0].time[2][1]

		MoonCakeAction.OnOpenGift(var_25_9, arg_25_1.drop_list)
	else
		getReward(mergeReward(var_25_3))
	end
end

function var_0_0.OnTop(arg_26_0)
	local var_26_0 = arg_26_0.itemData_.id
	local var_26_1 = arg_26_0.itemData_.timeValid

	if ItemTools.getItemNum(var_26_0, var_26_1) <= 0 then
		arg_26_0:Back()
	end
end

function var_0_0.RefreshUI(arg_27_0)
	arg_27_0:InitData()
	arg_27_0:UpdateView()
end

return var_0_0
