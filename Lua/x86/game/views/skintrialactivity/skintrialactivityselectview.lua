local var_0_0 = class("SkinTrialActivitySelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/OsirisUI/OsirisSkinTrialUI_101"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.activityID_ = arg_3_0.params_.activityID
	arg_3_0.skinTrialID_ = arg_3_0.params_.skinTrialID
	arg_3_0.popType_ = POP_ITEM
	arg_3_0.receivedControllerList_ = {}
	arg_3_0.itemList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.itemListGo_, arg_3_0:GetRewardItem())
	arg_3_0.adaptImg_ = arg_3_0:FindCom("AdaptImage", nil, arg_3_0.skinImageTras_)

	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_4_0.activityID_ = arg_4_0.params_.activityID
	arg_4_0.skinTrialID_ = arg_4_0.params_.skinTrialID

	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
	arg_6_0.itemList_:Dispose()

	arg_6_0.itemList_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.btnBattle_, nil, function()
		SkinTrialData:SaveStageID(arg_7_0.skinTrialID_)

		if not ActivityData:GetActivityData(arg_7_0.activityID_):IsActivitying() then
			ShowTips("TIME_OVER")

			return
		end

		arg_7_0:SaveRoute()
		arg_7_0:Go("/sectionSelectHero", {
			section = ActivitySkinTrialCfg[arg_7_0.skinTrialID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL,
			activityID = arg_7_0.activityID_
		})
	end)
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = arg_9_0.skinTrialID_
	local var_9_1 = SkinTrialTools.GetHeroStandardID(var_9_0)
	local var_9_2 = HeroStandardSystemCfg[var_9_1].skin_id
	local var_9_3 = HeroStandardSystemCfg[var_9_1].hero_id

	arg_9_0.heroNameText_.text = string.format("%s·%s", GetI18NText(HeroCfg[var_9_3].name), GetI18NText(HeroCfg[var_9_3].suffix))

	local var_9_4 = SettingData:GetCurrentLanguage()

	if var_9_4 == "fr" or var_9_4 == "de" then
		arg_9_0.heroNameText_.text = string.format("%s-%s", GetI18NText(HeroCfg[var_9_3].name), GetI18NText(HeroCfg[var_9_3].suffix))
	end

	arg_9_0.skinDescText_.text = GetI18NText(SkinCfg[var_9_2].desc)

	arg_9_0:RefreshRoleImage()
	arg_9_0:RefreshReward()
end

function var_0_0.RefreshRoleImage(arg_10_0)
	local var_10_0 = SkinTrialTools.GetHeroStandardID(arg_10_0.skinTrialID_)
	local var_10_1 = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. SkinCfg[HeroStandardSystemCfg[var_10_0].skin_id].picture_id)

	if var_10_1 ~= nil then
		arg_10_0.skinImage_.sprite = var_10_1

		arg_10_0.adaptImg_:AdaptImg()
	end
end

function var_0_0.RefreshReward(arg_11_0)
	local var_11_0 = ActivitySkinTrialCfg[arg_11_0.skinTrialID_].stage_id
	local var_11_1 = BattleSkinTrialStageCfg[var_11_0].drop_lib_id

	arg_11_0.rewardCfg_ = getRewardFromDropCfg(var_11_1, true)

	arg_11_0.itemList_:StartScroll(#arg_11_0.rewardCfg_)
end

function var_0_0.IndexItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.rewardCfg_[arg_12_1]
	local var_12_1 = arg_12_0:GetCommonItem(arg_12_2)

	var_12_1:RefreshData(rewardToItemTemplate(var_12_0))
	var_12_1:RegistCallBack(function(arg_13_0)
		if arg_12_0.clickCallback_ then
			if arg_12_0.clickCallback_() then
				ShowPopItem(arg_12_0.popType_, arg_13_0)
			end
		else
			ShowPopItem(arg_12_0.popType_, arg_13_0)
		end
	end)

	if arg_12_0.receivedControllerList_[arg_12_1] == nil then
		arg_12_0.receivedControllerList_[arg_12_1] = ControllerUtil.GetController(var_12_1.transform_, "received")
	end

	if SkinTrialData:IsCompleted(arg_12_0.skinTrialID_) then
		arg_12_0.receivedControllerList_[arg_12_1]:SetSelectedState("true")
	end

	var_12_1:Show(true)
end

function var_0_0.GetRewardItem(arg_14_0)
	return CommonItem
end

function var_0_0.GetCommonItem(arg_15_0, arg_15_1)
	return arg_15_1
end

function var_0_0.SaveRoute(arg_16_0)
	local var_16_0 = {
		name = "skinTrialSelect",
		activityID = arg_16_0.activityID_,
		skinTrialID = arg_16_0.skinTrialID_
	}

	SkinTrialData:SaveRoute(var_16_0)
end

return var_0_0
