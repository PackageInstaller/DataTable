local var_0_0 = class("HeroClueMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return HeroClueTools.GetMainViewUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	if arg_4_0.InitController then
		arg_4_0:InitController()
	end

	arg_4_0:InitStaticText()
	arg_4_0:InitClueItem()
end

function var_0_0.InitStaticText(arg_5_0)
	if arg_5_0.titleText_ then
		arg_5_0.titleText_.text = HeroClueTools.GetActivityTitle(arg_5_0.params_.activityID)
	end

	if arg_5_0.activityDescText_ then
		arg_5_0.activityDescText_.text = HeroClueTools.GetActivityDesc(arg_5_0.params_.activityID)
	end
end

function var_0_0.InitClueItem(arg_6_0)
	arg_6_0.clueItemList_ = {}

	local var_6_0 = HeroCluePoolCfg.get_id_list_by_activity_id[arg_6_0.params_.activityID][1]
	local var_6_1 = HeroClueCfg.get_id_list_by_clue_pool[var_6_0]
	local var_6_2 = arg_6_0.clueContentTrans_.childCount
	local var_6_3

	for iter_6_0 = 1, var_6_2 do
		local var_6_4 = arg_6_0.clueContentTrans_:GetChild(iter_6_0 - 1).gameObject
		local var_6_5 = var_6_1[iter_6_0]

		arg_6_0.clueItemList_[iter_6_0] = HeroClueTools.GetClueItemClass(arg_6_0.params_.activityID).New(var_6_4, var_6_5, arg_6_0.params_.activityID, iter_6_0)
	end
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.drawBtn_, nil, handler(arg_7_0, arg_7_0.OnClickDraw))
	arg_7_0:AddBtnListener(arg_7_0.rewardBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(arg_7_0.activityID_) then
			return
		end

		local var_8_0 = HeroClueTools.GetPlayTaskActivityID(arg_7_0.activityID_)

		JumpTools.OpenPageByJump("heroClueTask", {
			activityID = var_8_0,
			mainActivityID = arg_7_0.activityID_
		})
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.activityID_ = arg_9_0.params_.activityID
	arg_9_0.cluePoolID_ = HeroCluePoolCfg.get_id_list_by_activity_id[arg_9_0.activityID_][1]
	arg_9_0.clueIdList_ = HeroClueCfg.get_id_list_by_clue_pool[arg_9_0.cluePoolID_]

	for iter_9_0, iter_9_1 in pairs(arg_9_0.clueItemList_) do
		iter_9_1:OnEnter()
	end

	arg_9_0:RefreshUI()
	arg_9_0:BindRedPoint()
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		HeroCluePoolCfg[arg_10_0.cluePoolID_].item_id
	})
	manager.windowBar:SetBarCanClick(HeroCluePoolCfg[arg_10_0.cluePoolID_].item_id, true)
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()

	for iter_11_0, iter_11_1 in pairs(arg_11_0.clueItemList_) do
		iter_11_1:OnExit()
	end

	arg_11_0:UnBindRedPoint()
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.clueItemList_) do
		iter_12_1:Dispose()
	end

	arg_12_0.clueItemList_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.RefreshUI(arg_13_0)
	arg_13_0:RefreshCoin()
	arg_13_0:RefreshClue()
end

function var_0_0.RefreshClue(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.clueItemList_) do
		iter_14_1:RefreshUI()
	end
end

function var_0_0.RefreshCoin(arg_15_0)
	local var_15_0 = HeroCluePoolCfg[arg_15_0.cluePoolID_].item_id

	arg_15_0.coinNum_.text = HeroClueTools.GetCostOfOneDraw()
	arg_15_0.coinIcon_.sprite = ItemTools.getItemSprite(var_15_0)
end

function var_0_0.OnClickDraw(arg_16_0)
	if not ActivityTools.ActivityOpenCheck(arg_16_0.activityID_) then
		return
	end

	local var_16_0 = true
	local var_16_1 = HeroClueData:GetUnlockClueDataDic()

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.clueIdList_) do
		if not var_16_1[iter_16_1] then
			var_16_0 = false

			break
		elseif #HeroClueCfg[iter_16_1].level > var_16_1[iter_16_1].level then
			var_16_0 = false

			break
		end
	end

	local var_16_2 = HeroCluePoolCfg[arg_16_0.cluePoolID_].item_id

	if var_16_0 == true then
		local var_16_3 = GetI18NText(ItemCfg[var_16_2].name)

		ShowTips(GetTipsF("ACTIVITY_HERO_CLUE_ALL_COLLECTED", var_16_3))

		return
	end

	if ItemTools.getItemNum(var_16_2) < 1 then
		local var_16_4 = GetI18NText(ItemCfg[var_16_2].name)

		ShowTips(GetTipsF("ACTIVITY_FLIP_CARD_COIN_NOT_ENOUGH", var_16_4))

		return
	end

	HeroClueAction.Draw(arg_16_0.activityID_, arg_16_0.cluePoolID_, 1)
end

function var_0_0.OnClueDraw(arg_17_0, arg_17_1)
	arg_17_0:RefreshUI()
	JumpTools.OpenPageByJump("heroClueDrawResult", {
		activityID = arg_17_0.activityID_,
		rewardList = arg_17_1
	})
end

function var_0_0.BindRedPoint(arg_18_0)
	local var_18_0 = ActivityCfg[arg_18_0.activityID_].sub_activity_list[2]
	local var_18_1 = string.format("%s_%d", RedPointConst.ACTIVITY_TASK, var_18_0)

	manager.redPoint:bindUIandKey(arg_18_0.rewardBtn_.transform, var_18_1)

	local var_18_2 = string.format("%s_%d", RedPointConst.HERO_CLUE_DRAW, arg_18_0.activityID_)

	manager.redPoint:bindUIandKey(arg_18_0.drawBtn_.transform, var_18_2)
end

function var_0_0.UnBindRedPoint(arg_19_0)
	local var_19_0 = ActivityCfg[arg_19_0.activityID_].sub_activity_list[2]
	local var_19_1 = string.format("%s_%d", RedPointConst.ACTIVITY_TASK, var_19_0)

	manager.redPoint:unbindUIandKey(arg_19_0.rewardBtn_.transform, var_19_1)

	local var_19_2 = string.format("%s_%d", RedPointConst.HERO_CLUE_DRAW, arg_19_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_19_0.drawBtn_.transform, var_19_2)
end

return var_0_0
