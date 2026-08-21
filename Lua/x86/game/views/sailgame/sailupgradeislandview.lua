local var_0_0 = class("SailUpgradeIslandView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyageIslandUpgradeUI"
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

	arg_4_0.statusController_ = ControllerUtil.GetController(arg_4_0.transform_, "status")
	arg_4_0.premissItemList_ = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.upgradeBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if not arg_5_0.isEnough_ then
			ShowTips("ACTIVITY_SKADI_SEA_MATERIAL_NUM_NOT_ENOUGH")

			return
		end

		if not arg_5_0.isComplete_ then
			ShowTips("ACTIVITY_SKADI_SEA_ISLAND_UPGRADE_NOT_ENOUGH")

			return
		end

		SailGameAction.UpgradeIsland(arg_5_0.activityID_)
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = arg_8_0.params_.activityID

	arg_8_0:RefreshUI()
end

function var_0_0.Dispose(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.premissItemList_) do
		iter_9_1:Dispose()
	end

	arg_9_0.premissItemList = nil

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = #SailGameIslandLevelCfg.get_id_list_by_activity_id[arg_10_0.activityID_]

	arg_10_0.curLevel_ = SailGameData:GetIslandLevel(arg_10_0.activityID_)
	arg_10_0.nextLevel_ = arg_10_0.curLevel_ + 1

	if var_10_0 > arg_10_0.curLevel_ then
		arg_10_0.nextLevelText_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_ISLAND_UPGRADE_TIP"), NumberTools.IntToRomam(arg_10_0.nextLevel_))

		local var_10_1 = SailGameIslandLevelCfg.get_id_list_by_activity_id[arg_10_0.activityID_][arg_10_0.nextLevel_]

		arg_10_0.nextLevelCfg_ = SailGameIslandLevelCfg[var_10_1]

		arg_10_0:RefreshPremiss()
		arg_10_0:RefreshCost()
		arg_10_0:RefreshStatus()
	end
end

function var_0_0.RefreshPremiss(arg_11_0)
	arg_11_0.premissIDList_ = arg_11_0.nextLevelCfg_.unlock_level_need

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.premissIDList_) do
		if not arg_11_0.premissItemList_[iter_11_0] then
			arg_11_0.premissItemList_[iter_11_0] = SailUpgradeIslandPremissItem.New(arg_11_0.premissTemplateGo_, arg_11_0.premissContentTrans_)
		end

		arg_11_0.premissItemList_[iter_11_0]:SetData(iter_11_1, arg_11_0.activityID_)
	end

	for iter_11_2 = #arg_11_0.premissIDList_ + 1, #arg_11_0.premissItemList_ do
		arg_11_0.premissItemList_[iter_11_2]:SetActive(false)
	end

	arg_11_0.isComplete_ = true

	for iter_11_3, iter_11_4 in ipairs(arg_11_0.premissItemList_) do
		if not iter_11_4:IsComplete() then
			arg_11_0.isComplete_ = false

			break
		end
	end
end

function var_0_0.IndexItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:SetData(arg_12_0.premissIDList_[arg_12_1], arg_12_0.activityID_)
end

function var_0_0.RefreshCost(arg_13_0)
	local var_13_0 = arg_13_0.nextLevelCfg_.cost[1]
	local var_13_1 = var_13_0[1]
	local var_13_2 = ItemTools.getItemNum(var_13_1)
	local var_13_3 = var_13_0[2]

	arg_13_0.isEnough_ = var_13_3 <= var_13_2
	arg_13_0.costNumText_.text = var_13_3
	arg_13_0.costIcon_.sprite = ItemTools.getItemSprite(var_13_1)
end

function var_0_0.RefreshStatus(arg_14_0)
	if arg_14_0.isEnough_ then
		if arg_14_0.isComplete_ then
			arg_14_0.statusController_:SetSelectedState("enough")
		else
			arg_14_0.statusController_:SetSelectedState("uncomplete")
		end
	else
		arg_14_0.statusController_:SetSelectedState("not_enough")
	end
end

function var_0_0.OnIslandUpgrade(arg_15_0)
	ShowTips("ACTIVITY_SKADI_SEA_ISLAND_UPGRADE_SUCCESS")
	arg_15_0:Back()
end

return var_0_0
