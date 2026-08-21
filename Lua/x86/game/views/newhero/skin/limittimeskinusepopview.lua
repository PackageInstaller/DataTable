local var_0_0 = class("LimitTimeSkinUsePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Recharge/LimitTimeSkinUsePopUI"
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

	arg_4_0.skinOwnController_ = arg_4_0.skinController_:GetController("owned2")
	arg_4_0.dlcOwnController_ = arg_4_0.dlcController_:GetController("owned2")
	arg_4_0.stateController_ = arg_4_0.controller_:GetController("state")
	arg_4_0.tipsController_ = arg_4_0.controller_:GetController("tips")
	arg_4_0.btnController_ = arg_4_0.controller_:GetController("btn")
	arg_4_0.skinItem_ = CommonItemView.New(arg_4_0.skinItemGo_)
	arg_4_0.dlcItem_ = CommonItemView.New(arg_4_0.dlcItemGo_)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.tipsBtn_, nil, function()
		if arg_5_0:HasOwnAllItem() then
			return
		end

		if arg_5_0.showSkin_ then
			arg_5_0.showSkin_ = false
		else
			arg_5_0.showSkin_ = true
		end

		arg_5_0.tipsController_:SetSelectedState(tostring(arg_5_0.showSkin_))
	end)
	arg_5_0:AddBtnListener(arg_5_0.mask_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.noBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.hadBtn_, nil, function()
		arg_5_0:CheckCanUse()
	end)
	arg_5_0:AddBtnListener(arg_5_0.yesBtn_, nil, function()
		local var_10_0 = {
			item_info = {
				num = 1,
				id = arg_5_0.itemId_,
				time_valid = arg_5_0.timeValid
			},
			use_list = {}
		}

		if not arg_5_0:CheckCanUse() then
			return
		end

		CommonAction.TryToUseItemWitchCallback({
			var_10_0
		}, function(arg_11_0)
			arg_5_0:UseItemSuccess(arg_11_0)
		end)
	end)
end

function var_0_0.UseItemSuccess(arg_12_0, arg_12_1)
	arg_12_0._dropList = arg_12_1.drop_list

	HeroAction.SelectSkin(SkinCfg[arg_12_0.skinId_].hero, arg_12_0.skinId_)
end

function var_0_0.OnSelectSkin(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0.showSkin_ then
		PlayerAction.ChangePosterGirl(SkinCfg[arg_13_0.skinId_].hero)
		HomeSceneSettingAction.SetHomeScene(arg_13_0.dlcId_, true)
	end

	arg_13_0:Back()

	if arg_13_0._dropList then
		getReward(arg_13_0._dropList)
	end

	arg_13_0._dropList = nil
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.itemId_ = arg_14_0.params_.itemData.id
	arg_14_0.timeValid = ItemTools.GetItemExpiredTimeByInfo(arg_14_0.params_.itemData)
	arg_14_0.cfg_ = ItemCfg[arg_14_0.itemId_]
	arg_14_0.reward_ = arg_14_0.cfg_.param
	arg_14_0.dlcId_ = nil
	arg_14_0.skinId_ = nil
	arg_14_0.LimitDlcId_ = nil
	arg_14_0.LimitskinItemId_ = nil

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.reward_) do
		local var_14_0 = ItemCfg[iter_14_1]

		if var_14_0.type == ItemConst.ITEM_TYPE.HERO_SKIN then
			arg_14_0.LimitskinItemId_ = iter_14_1
		elseif var_14_0.type == ItemConst.ITEM_TYPE.SCENE then
			arg_14_0.LimitDlcId_ = iter_14_1
		end
	end

	if arg_14_0.LimitskinItemId_ then
		arg_14_0.LimitskinItemCfg_ = ItemCfg[arg_14_0.LimitskinItemId_]

		if arg_14_0.LimitskinItemCfg_ then
			arg_14_0.skinId_ = arg_14_0.LimitskinItemCfg_.param[1]
			arg_14_0.heroId_ = SkinCfg[arg_14_0.skinId_].hero
		end
	end

	if arg_14_0.LimitDlcId_ then
		arg_14_0.LimitDlcCfg_ = ItemCfg[arg_14_0.LimitDlcId_]

		if arg_14_0.LimitDlcCfg_ then
			arg_14_0.dlcId_ = arg_14_0.LimitDlcCfg_.param[1]
		end
	end

	arg_14_0.showSkin_ = true

	arg_14_0.tipsController_:SetSelectedState(tostring(arg_14_0.showSkin_))
	arg_14_0:UpdateView()
end

function var_0_0.HasOwnAllItem(arg_15_0)
	local var_15_0 = false
	local var_15_1 = false

	if arg_15_0.skinId_ and arg_15_0.dlcId_ then
		local var_15_2 = HeroTools.GetHasOwnedSkin(arg_15_0.skinId_)

		if HomeSceneSettingData:IsHaveScene(arg_15_0.dlcId_) and var_15_2 then
			return true
		end
	elseif not arg_15_0.skinId_ and arg_15_0.dlcId_ then
		if HomeSceneSettingData:IsHaveScene(arg_15_0.dlcId_) then
			return true
		end
	elseif arg_15_0.skinId_ and not arg_15_0.dlcId_ and HeroTools.GetHasOwnedSkin(arg_15_0.skinId_) then
		return true
	end

	return false
end

function var_0_0.CheckCanUse(arg_16_0)
	if HeroData:GetHeroData(arg_16_0.heroId_).unlock == 0 then
		ShowTips("ERROR_HERO_NOT_UNLOCK")

		return false
	end

	return true
end

function var_0_0.UpdateItemView(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = clone(ItemTemplateData)

	var_17_0.id = arg_17_2
	var_17_0.number = nil

	arg_17_1:SetData(var_17_0)
end

function var_0_0.UpdateView(arg_18_0)
	if arg_18_0.skinId_ then
		arg_18_0:UpdateItemView(arg_18_0.skinItem_, arg_18_0.skinId_)
	end

	if arg_18_0.dlcId_ then
		arg_18_0:UpdateItemView(arg_18_0.dlcItem_, arg_18_0.dlcId_)
	end

	SetActive(arg_18_0.tipsBtnGo_, not arg_18_0:HasOwnAllItem())

	if arg_18_0:HasOwnAllItem() then
		arg_18_0.showSkin_ = false
	end

	arg_18_0.skinImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_18_0.skinId_)
	arg_18_0.titleText_.text = SkinCfg[arg_18_0.skinId_].name
	arg_18_0.leftTimeText_.text = arg_18_0.LimitskinItemCfg_.time[2][1] .. GetTips("DAY")

	if arg_18_0.skinId_ and arg_18_0.dlcId_ then
		arg_18_0.stateController_:SetSelectedState("all")
	elseif arg_18_0.skinId_ and not arg_18_0.dlcId_ then
		arg_18_0.stateController_:SetSelectedState("skin")
	elseif not arg_18_0.skinId_ and arg_18_0.dlcId_ then
		arg_18_0.stateController_:SetSelectedState("dlc")
	end

	local var_18_0 = false

	if arg_18_0.dlcId_ then
		var_18_0 = HomeSceneSettingData:IsHaveScene(arg_18_0.dlcId_)
	end

	local var_18_1 = false

	if arg_18_0.skinId_ then
		var_18_1 = HeroTools.GetHasOwnedSkin(arg_18_0.skinId_)
	end

	if var_18_1 then
		arg_18_0.skinOwnController_:SetSelectedState("on")
	else
		arg_18_0.skinOwnController_:SetSelectedState("off")
	end

	if var_18_0 then
		arg_18_0.dlcOwnController_:SetSelectedState("on")
	else
		arg_18_0.dlcOwnController_:SetSelectedState("off")
	end

	local var_18_2 = HeroTools.GetHeroFullName(arg_18_0.heroId_)
	local var_18_3 = GetI18NText(ItemCfg[arg_18_0.itemId_].name)
	local var_18_4 = GetI18NText(SkinCfg[arg_18_0.skinId_].name)

	if arg_18_0.dlcId_ then
		local var_18_5 = GetI18NText(HomeSceneSettingCfg[arg_18_0.dlcId_].title)
		local var_18_6 = GetI18NText(arg_18_0.LimitskinItemCfg_.name)
		local var_18_7 = GetI18NText(arg_18_0.LimitDlcCfg_.name)

		if not var_18_1 and not var_18_0 then
			arg_18_0.descText_.text = string.format(GetTips("SKIN_LIMIT_TIME_DESC_1"), var_18_3, var_18_2, var_18_4, var_18_5)
		elseif var_18_1 and not var_18_0 then
			arg_18_0.descText_.text = string.format(GetTips("SKIN_LIMIT_TIME_DESC_2"), var_18_3, var_18_2, var_18_4, var_18_5, var_18_2, var_18_4, var_18_6)
		elseif not var_18_1 and var_18_0 then
			arg_18_0.descText_.text = string.format(GetTips("SKIN_LIMIT_TIME_DESC_3"), var_18_3, var_18_2, var_18_4, var_18_2, var_18_4, var_18_5, var_18_7)
		else
			arg_18_0.descText_.text = string.format(GetTips("SKIN_LIMIT_TIME_DESC_4"), var_18_3, var_18_3)
		end
	elseif not var_18_1 then
		arg_18_0.descText_.text = string.format(GetTips("SKIN_LIMIT_TIME_DESC_5"), var_18_3, var_18_2, var_18_4)
	else
		arg_18_0.descText_.text = string.format(GetTips("SKIN_LIMIT_TIME_DESC_4"), var_18_3, var_18_3)
	end
end

function var_0_0.OnExit(arg_19_0)
	var_0_0.super.OnExit(arg_19_0)
end

return var_0_0
