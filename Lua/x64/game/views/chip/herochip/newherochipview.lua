local var_0_0 = class("NewHeroChipView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_chip/HeroChipEditUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.chipClickCallBack_ = handler(arg_3_0, arg_3_0.OnChipClick)
	arg_3_0.chipListList_ = {}
	arg_3_0.chipControllers_ = {}

	for iter_3_0 = 1, 4 do
		arg_3_0.chipListList_[iter_3_0] = NewHeroChipListItem.New(arg_3_0["chiplistGo_" .. iter_3_0], arg_3_0.chipItemGo_)

		arg_3_0.chipListList_[iter_3_0]:SetChipClickCallBack(arg_3_0.chipClickCallBack_)

		arg_3_0.chipControllers_[iter_3_0] = arg_3_0["chipCon_" .. iter_3_0]:GetController("state")
	end

	arg_3_0.chipTypeController_ = arg_3_0.typeTrans_:GetComponent("ControllerExCollection"):GetController("type")
	arg_3_0.conditionController_ = arg_3_0.conditionTrans_:GetComponent("ControllerExCollection"):GetController("clear")
	arg_3_0.enoughController_ = arg_3_0.gameObject_.transform:GetComponent("ControllerExCollection"):GetController("enough")
	arg_3_0.btnController_ = arg_3_0.btnTrans_:GetComponent("ControllerExCollection"):GetController("btnState")

	arg_3_0:AddListeners()
end

function var_0_0.OnChipClick(arg_4_0, arg_4_1)
	arg_4_0.curChipID_ = arg_4_1

	arg_4_0:RefreshUI(false)
end

function var_0_0.OnTop(arg_5_0)
	arg_5_0:RefreshChipInfo()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_CHIP_COST
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_CHIP_COST, true)
end

function var_0_0.OnChipStatusUpdate(arg_6_0)
	arg_6_0:RefreshUI(false)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.heroID_ = arg_7_0.params_.heroID
	arg_7_0.curHeroChipInfo_ = {}

	for iter_7_0, iter_7_1 in pairs(ChipTools.GetHeroChipIDList(arg_7_0.heroID_)) do
		local var_7_0 = ChipCfg[iter_7_1].role_type_id

		if arg_7_0.curHeroChipInfo_[var_7_0] then
			table.insert(arg_7_0.curHeroChipInfo_[var_7_0], iter_7_1)
		else
			arg_7_0.curHeroChipInfo_[var_7_0] = {
				iter_7_1
			}
		end
	end

	arg_7_0.curType_ = arg_7_0.params_.type

	if arg_7_0.params_.chipID > 0 then
		arg_7_0.curChipID_ = arg_7_0.params_.chipID
	else
		arg_7_0.curChipID_ = arg_7_0.curHeroChipInfo_[arg_7_0.curType_][1]
	end

	arg_7_0:RefreshUI(true)
end

function var_0_0.CameraEnter(arg_8_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		6,
		1
	}, false)

	local var_8_0 = HeroTools.HeroUsingSkinInfo(arg_8_0.params_.heroID).id

	manager.heroRaiseTrack:SetModelState(var_8_0)
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.AddListeners(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.btn_, nil, function()
		local var_11_0 = ChipCfg[arg_10_0.curChipID_].role_type_id

		if arg_10_0.btnController_.selectedIndex == 0 or arg_10_0.btnController_.selectedIndex == 3 then
			ChipAction.EnabledHeroChip(arg_10_0.heroID_, arg_10_0.curChipID_, var_11_0)
		elseif arg_10_0.btnController_.selectedIndex == 1 then
			ChipAction.EnabledHeroChip(arg_10_0.heroID_, 0, var_11_0)
		elseif arg_10_0.btnController_.selectedIndex == 2 then
			ChipAction.UnlockHeroChip(arg_10_0.curChipID_)
		end
	end)
end

function var_0_0.RefreshUI(arg_12_0, arg_12_1)
	local var_12_0 = ChipData:GetEnableHeroChipIdByHeroId(arg_12_0.heroID_)

	if arg_12_1 then
		for iter_12_0, iter_12_1 in pairs(arg_12_0.curHeroChipInfo_) do
			arg_12_0.curHeroChipInfo_[iter_12_0] = ChipTools.SortChipList(var_12_0[iter_12_0], arg_12_0.curHeroChipInfo_[iter_12_0], nil, true)
		end
	end

	for iter_12_2 = 1, 4 do
		if arg_12_0.curHeroChipInfo_[iter_12_2] then
			arg_12_0.chipListList_[iter_12_2]:SetIsShow(true)
			arg_12_0.chipListList_[iter_12_2]:SetData(arg_12_0.heroID_, arg_12_0.curHeroChipInfo_[iter_12_2], arg_12_0.curChipID_)
			arg_12_0.chipControllers_[iter_12_2]:SetSelectedState(var_12_0[iter_12_2] > 0 and "equip" or "normal")
		else
			arg_12_0.chipListList_[iter_12_2]:SetIsShow(false)
			arg_12_0.chipControllers_[iter_12_2]:SetSelectedState("lock")
		end
	end

	arg_12_0:RefreshChipInfo()
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.chipContent_)
end

function var_0_0.RefreshChipInfo(arg_13_0)
	local var_13_0 = ChipCfg[arg_13_0.curChipID_]

	arg_13_0.nameText_.text = var_13_0.suit_name
	arg_13_0.iconImage_.sprite = getSpriteViaConfig("ChipSkillIcon", var_13_0.picture_id)

	arg_13_0.chipTypeController_:SetSelectedState(var_13_0.role_type_id)

	arg_13_0.desText_.text = var_13_0.desc
	arg_13_0.typeText_.text = GetTips("CHIP_HERO_TYPE_" .. var_13_0.role_type_id)
	arg_13_0.grayText_.text = var_13_0.title

	if ChipData:GetIsUnlockHeroChip(arg_13_0.curChipID_) then
		SetActive(arg_13_0.conditionTrans_.gameObject, false)
		SetActive(arg_13_0.costImage_.gameObject, false)

		local var_13_1, var_13_2 = ChipData:GetHeroChipIsEnableByChipId(arg_13_0.curChipID_)

		if var_13_1 then
			arg_13_0.btnText_.text = GetTips("CHIP_UNLOAD")

			arg_13_0.btnController_:SetSelectedState("unequip")
		elseif var_13_2 > 0 then
			arg_13_0.btnText_.text = GetTips("TIP_CHANGE")

			arg_13_0.btnController_:SetSelectedState("exchange")
		else
			arg_13_0.btnText_.text = GetTips("TIP_EQUIP")

			arg_13_0.btnController_:SetSelectedState("equip")
		end
	else
		if var_13_0.new_condition ~= 0 then
			SetActive(arg_13_0.conditionTrans_.gameObject, true)
			SetActive(arg_13_0.costImage_.gameObject, false)

			arg_13_0.conditionText_.text = ConditionCfg[var_13_0.new_condition].desc

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
					local var_13_6 = HeroCfg[var_13_0.spec_char].name
					local var_13_7 = HeroCfg[var_13_0.spec_char].suffix

					var_13_4 = var_13_3 and 1 or 0
					var_13_5 = 1
					arg_13_0.conditionText_.text = var_13_6 .. "·" .. var_13_7 .. ConditionCfg[var_13_0.new_condition].desc

					break
				end
			end

			if var_13_3 then
				arg_13_0.conditionController_:SetSelectedState("clear")
			else
				arg_13_0.conditionController_:SetSelectedState("notclear")

				var_13_4 = string.format("<color=#eb0000>%s</color>", var_13_4)
			end

			arg_13_0.conditionNumText_.text = var_13_4 .. "/" .. var_13_5
		else
			SetActive(arg_13_0.conditionTrans_.gameObject, false)
			SetActive(arg_13_0.costImage_.gameObject, true)

			arg_13_0.costText_.text = var_13_0.cost_condition[1][2]

			local var_13_8 = ItemTools.getItemNum(var_13_0.cost_condition[1][1])

			arg_13_0.costImage_.sprite = ItemTools.getItemSprite(var_13_0.cost_condition[1][1])

			if var_13_8 >= var_13_0.cost_condition[1][2] then
				arg_13_0.enoughController_:SetSelectedState("true")
			else
				arg_13_0.enoughController_:SetSelectedState("false")
			end
		end

		arg_13_0.btnText_.text = GetTips("TIP_UNLOCK")

		arg_13_0.btnController_:SetSelectedState("unlock")
	end
end

function var_0_0.Dispose(arg_14_0)
	var_0_0.super.Dispose(arg_14_0)

	for iter_14_0 = 1, 4 do
		arg_14_0.chipListList_[iter_14_0]:Dispose()

		arg_14_0.chipListList_[iter_14_0] = nil
	end

	arg_14_0.chipListList_ = nil
	arg_14_0.chipClickCallBack_ = nil
end

return var_0_0
