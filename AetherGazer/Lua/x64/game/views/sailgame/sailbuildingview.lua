local var_0_0 = class("SailBuildingView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyageBuildingUnlockUI"
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

	arg_4_0.costController_ = ControllerUtil.GetController(arg_4_0.transform_, "cost")
	arg_4_0.unlockController_ = ControllerUtil.GetController(arg_4_0.transform_, "unlock")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.buildBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if not arg_5_0.isEnough_ then
			ShowTips("ACTIVITY_SKADI_SEA_MATERIAL_NUM_NOT_ENOUGH")

			return
		end

		SailGameAction.UnlockBuilding(arg_5_0.activityID_, arg_5_0.id_)
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = arg_8_0.params_.activityID
	arg_8_0.id_ = arg_8_0.params_.ID
	arg_8_0.buildingCfg_ = SailGameBuildingCfg[arg_8_0.id_]
	arg_8_0.unlock_ = SailGameData:GetUnLockBuilding(arg_8_0.activityID_)[arg_8_0.id_]

	arg_8_0.unlockController_:SetSelectedState(arg_8_0.unlock_ and "true" or "false")
	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:RefreshTitle()
	arg_9_0:RefreshReward()
	arg_9_0:RefreshCost()
end

function var_0_0.RefreshTitle(arg_10_0)
	local var_10_0 = SailGameBuildingCfg[arg_10_0.id_]

	if arg_10_0.unlock_ then
		arg_10_0.titleText_.text = var_10_0.name
		arg_10_0.descText_.text = var_10_0.desc
	else
		arg_10_0.titleText_.text = GetTips("ACTIVITY_SKADI_SEA_BUILDING_NOT_FOUND_NAME")
		arg_10_0.descText_.text = GetTips("ACTIVITY_SKADI_SEA_BUILDING_NOT_FOUND_DESCRIBE")

		local var_10_1 = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/" .. var_10_0.picture_unlock)

		if var_10_1 then
			arg_10_0.lockIcon_.sprite = var_10_1
		end
	end

	local var_10_2 = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/" .. var_10_0.picture_pop)

	if var_10_2 then
		arg_10_0.normalIcon_.sprite = var_10_2
	end
end

function var_0_0.RefreshReward(arg_11_0)
	local var_11_0 = arg_11_0.buildingCfg_.token_get[1]
	local var_11_1 = 60 / GameSetting.activity_skadi_sea_building_calculate_time.value[1]

	arg_11_0.rewardNumText_.text = string.format("+%d/%s", var_11_0[2] * var_11_1, GetTips("HOUR"))
	arg_11_0.rewardIcon_.sprite = ItemTools.getItemSprite(var_11_0[1])
end

function var_0_0.RefreshCost(arg_12_0)
	if arg_12_0.unlock_ then
		return
	end

	local var_12_0 = arg_12_0.buildingCfg_.cost[1]
	local var_12_1 = var_12_0[1]
	local var_12_2 = var_12_0[2]
	local var_12_3 = ItemTools.getItemNum(var_12_1)

	arg_12_0.isEnough_ = false

	if var_12_2 <= var_12_3 then
		arg_12_0.isEnough_ = true

		arg_12_0.costController_:SetSelectedState("true")
	else
		arg_12_0.costController_:SetSelectedState("false")
	end

	arg_12_0.costNumText_.text = var_12_2
	arg_12_0.costIcon_.sprite = ItemTools.getItemSprite(var_12_1)
end

function var_0_0.OnBuildingUnlock(arg_13_0)
	ShowTips(string.format(GetTips("ACTIVITY_SKADI_SEA_BUILD_SUCCESS"), arg_13_0.buildingCfg_.name))
	arg_13_0:Back()
end

return var_0_0
