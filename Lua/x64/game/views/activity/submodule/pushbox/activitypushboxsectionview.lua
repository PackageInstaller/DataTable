local var_0_0 = class("ActivityPushBoxSectionView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.heroAffixItem_ = {}
	arg_3_0.enemyAffixItem_ = {}
	arg_3_0.statusCon_ = ControllerUtil.GetController(arg_3_0.transform_, "status")
	arg_3_0.levelCon_ = ControllerUtil.GetController(arg_3_0.transform_, "level")
	arg_3_0.typeCon_ = ControllerUtil.GetController(arg_3_0.transform_, "type")
	arg_3_0.costCon_ = ControllerUtil.GetController(arg_3_0.transform_, "cost")
	arg_3_0.boxStateCon_ = ControllerUtil.GetController(arg_3_0.transform_, "boxOrder")
	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.listGo_, CommonItem)
	arg_3_0.boxScrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.BoxIndexItem), arg_3_0.boxListGo_, PushBoxReplayItem)
end

function var_0_0.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:RefreshData(formatReward(arg_4_0.list_[arg_4_1]))
	arg_4_2:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_MERGE_ITEM, {
			arg_5_0.id
		})
	end)
end

function var_0_0.BoxIndexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:RefreshData(arg_6_0.boxList_[arg_6_1])
end

function var_0_0.AddUIListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.battleBtn_, nil, function()
		if not arg_7_0:CheckTime() then
			return
		end

		if arg_7_0.cfg_.cost > ActivityPushBoxData:GetFatigue(arg_7_0.mainActivityID_) then
			ShowTips("ORDER_FATIGUE_NOT_ENOUGH")

			return
		end

		JumpTools.OpenPageByJump("/sectionSelectHero", {
			section = arg_7_0.cfg_.param,
			sectionType = BattleConst.STAGE_TYPE_NEW.PUSH_BOX_BATTLE,
			activityID = arg_7_0.mainActivityID_,
			dest_id = arg_7_0.id_
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.boxBtn_, nil, function()
		if not arg_7_0:CheckTime() then
			return
		end

		JumpTools.OpenPageByJump("/pushBox", {
			map_id = arg_7_0.cfg_.param,
			activityID = arg_7_0.mainActivityID_,
			id = arg_7_0.id_
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.boxTypeBtn_, nil, function()
		arg_7_0.boxType_ = 1 - arg_7_0.boxType_

		arg_7_0:RefreshBoxType()
	end)
end

function var_0_0.OnEnter(arg_11_0)
	return
end

function var_0_0.SetData(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.id_ = arg_12_1
	arg_12_0.isClose_ = arg_12_2
	arg_12_0.cfg_ = ActivityCelebrationOrderCfg[arg_12_0.id_]

	arg_12_0:RefreshData()
	arg_12_0:RefreshUI()
end

function var_0_0.RefreshData(arg_13_0)
	arg_13_0.activityID_ = arg_13_0.cfg_.activity_id
	arg_13_0.mainActivityID_ = arg_13_0.cfg_.main_activity
	arg_13_0.activityData_ = ActivityData:GetActivityData(arg_13_0.activityID_)
	arg_13_0.startTime_ = arg_13_0.activityData_.startTime
	arg_13_0.stopTime_ = arg_13_0.activityData_.stopTime
end

function var_0_0.RefreshUI(arg_14_0)
	if arg_14_0.cfg_.type == PushBoxConst.EVENT_TYPE.BATTLE then
		arg_14_0:RefreshBattle()
	elseif arg_14_0.cfg_.type == PushBoxConst.EVENT_TYPE.PUSH_BOX then
		arg_14_0:RefreshBox()
	end

	arg_14_0:RefreshReward()
end

function var_0_0.RefreshBattle(arg_15_0)
	arg_15_0.battleDesc_.text = arg_15_0.cfg_.order_desc
	arg_15_0.battleTitle_.text = arg_15_0.cfg_.order_title

	local var_15_0 = arg_15_0.cfg_.cost

	arg_15_0.battleCost_.text = var_15_0

	local var_15_1 = PushBoxTool:GetFatigueID(arg_15_0.activityID_)

	arg_15_0.battleIcon_.sprite = ItemTools.getItemLittleSprite(var_15_1)

	local var_15_2 = ActivityPushBoxData:GetFatigue(arg_15_0.mainActivityID_)

	arg_15_0.costCon_:SetSelectedState(var_15_0 <= var_15_2 and "true" or "false")

	local var_15_3 = getHeroAffixs(arg_15_0.cfg_.affix_list)
	local var_15_4 = getMosterAffix(arg_15_0.cfg_.affix_list)

	for iter_15_0, iter_15_1 in ipairs(var_15_3) do
		if not arg_15_0.heroAffixItem_[iter_15_0] then
			arg_15_0.heroAffixItem_[iter_15_0] = PushBoxAffixItem.New(arg_15_0.affixGo_, arg_15_0.heroAffixContent_)
		end

		arg_15_0.heroAffixItem_[iter_15_0]:SetData(iter_15_1)
	end

	for iter_15_2 = #var_15_3 + 1, #arg_15_0.heroAffixItem_ do
		arg_15_0.heroAffixItem_[iter_15_2]:SetActive(false)
	end

	for iter_15_3, iter_15_4 in ipairs(var_15_4) do
		if not arg_15_0.enemyAffixItem_[iter_15_3] then
			arg_15_0.enemyAffixItem_[iter_15_3] = PushBoxAffixItem.New(arg_15_0.affixGo_, arg_15_0.enemyAffixContent_)
		end

		arg_15_0.enemyAffixItem_[iter_15_3]:SetData(iter_15_4)
	end

	for iter_15_5 = #var_15_4 + 1, #arg_15_0.enemyAffixItem_ do
		arg_15_0.enemyAffixItem_[iter_15_5]:SetActive(false)
	end

	arg_15_0.statusCon_:SetSelectedState("normal")
	arg_15_0.typeCon_:SetSelectedState("challenge")
	arg_15_0.levelCon_:SetSelectedState(arg_15_0.cfg_.hard)
	arg_15_0.boxStateCon_:SetSelectedState("normal")
end

function var_0_0.RefreshBox(arg_16_0)
	arg_16_0.boxType_ = 1
	arg_16_0.boxDesc_.text = arg_16_0.cfg_.order_desc
	arg_16_0.boxTitle_.text = arg_16_0.cfg_.order_title

	arg_16_0:RefreshTime()
	arg_16_0:RefreshHistory()
	arg_16_0:RefreshBoxType()
	arg_16_0.typeCon_:SetSelectedState("box")
	arg_16_0.statusCon_:SetSelectedState(arg_16_0.isClose_ and "complete" or "normal")
end

function var_0_0.RefreshTime(arg_17_0)
	arg_17_0:StopTimer()

	if ActivityPushBoxData:GetNextID(arg_17_0.mainActivityID_, arg_17_0.id_) == 0 then
		SetActive(arg_17_0.timeGo_, false)

		return
	end

	SetActive(arg_17_0.timeGo_, true)

	local var_17_0 = manager.time:GetServerTime()
	local var_17_1 = manager.time:GetNextFreshTime()

	arg_17_0.countDownTxt_.text = manager.time:DescCDTime(var_17_1 - var_17_0)
	arg_17_0.timer_ = Timer.New(function()
		var_17_0 = manager.time:GetServerTime()
		arg_17_0.countDownTxt_.text = manager.time:DescCDTime(var_17_1 - var_17_0)
	end, 1, -1)

	arg_17_0.timer_:Start()
end

function var_0_0.StopTimer(arg_19_0)
	if arg_19_0.timer_ then
		arg_19_0.timer_:Stop()

		arg_19_0.timer_ = nil
	end
end

function var_0_0.RefreshHistory(arg_20_0)
	arg_20_0.boxList_ = ActivityPushBoxData:GetFinishList(arg_20_0.mainActivityID_)

	table.sort(arg_20_0.boxList_, function(arg_21_0, arg_21_1)
		return arg_21_0 < arg_21_1
	end)
	arg_20_0.boxScrollHelper_:StartScroll(#arg_20_0.boxList_)
end

function var_0_0.RefreshBoxType(arg_22_0)
	arg_22_0.boxStateCon_:SetSelectedState(arg_22_0.boxType_ == 1 and "normal" or "pastRecords")
end

function var_0_0.RefreshReward(arg_23_0)
	arg_23_0.list_ = arg_23_0.cfg_.award_list

	arg_23_0.scrollHelper_:StartScroll(#arg_23_0.list_)
end

function var_0_0.CheckTime(arg_24_0)
	local var_24_0 = manager.time:GetServerTime()

	if var_24_0 < arg_24_0.startTime_ then
		ShowTips("SOLO_NOT_OPEN")

		return false
	end

	if var_24_0 >= arg_24_0.stopTime_ then
		ShowTips("TIME_OVER")

		return false
	end

	return true
end

function var_0_0.Show(arg_25_0, arg_25_1)
	SetActive(arg_25_0.gameObject_, arg_25_1)
end

function var_0_0.OnExit(arg_26_0)
	arg_26_0:StopTimer()

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.scrollHelper_:GetItemList()) do
		iter_26_1:OnExit()
	end

	for iter_26_2, iter_26_3 in ipairs(arg_26_0.boxScrollHelper_:GetItemList()) do
		iter_26_3:OnExit()
	end

	for iter_26_4, iter_26_5 in ipairs(arg_26_0.heroAffixItem_) do
		iter_26_5:OnExit()
	end

	for iter_26_6, iter_26_7 in ipairs(arg_26_0.enemyAffixItem_) do
		iter_26_7:OnExit()
	end
end

function var_0_0.Dispose(arg_27_0)
	arg_27_0:RemoveAllListeners()

	for iter_27_0, iter_27_1 in ipairs(arg_27_0.scrollHelper_:GetItemList()) do
		iter_27_1:Dispose()
	end

	arg_27_0.scrollHelper_:Dispose()

	for iter_27_2, iter_27_3 in ipairs(arg_27_0.boxScrollHelper_:GetItemList()) do
		iter_27_3:Dispose()
	end

	arg_27_0.boxScrollHelper_:Dispose()

	for iter_27_4, iter_27_5 in ipairs(arg_27_0.heroAffixItem_) do
		iter_27_5:Dispose()
	end

	for iter_27_6, iter_27_7 in ipairs(arg_27_0.enemyAffixItem_) do
		iter_27_7:Dispose()
	end

	arg_27_0.super.Dispose(arg_27_0)
end

return var_0_0
