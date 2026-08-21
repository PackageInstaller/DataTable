local var_0_0 = class("StrongholdMainView", ReduxView)

function var_0_0.UIBackCount(arg_1_0)
	return 2
end

function var_0_0.UIName(arg_2_0)
	return "UI/VersionUI/XuHeng3rdUI/Stronghold/StrongholdMainUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.difficultyList = LuaList.New(handler(arg_5_0, arg_5_0.IndexItem), arg_5_0.m_difficultyList, StrongholdMainDifficultyItem)
	arg_5_0.itemClickHandler = handler(arg_5_0, arg_5_0.OnItemClick)
	arg_5_0.matchTime = 0
	arg_5_0.colorController = ControllerUtil.GetController(arg_5_0.transform_, "color")
	arg_5_0.matchController = ControllerUtil.GetController(arg_5_0.transform_, "match")

	arg_5_0.matchController:SetSelectedIndex(0)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(nil, arg_6_0.m_createRoomBtn, function()
		if not ActivityTools.GetActivityIsOpenWithTip(arg_6_0.selectId) then
			return
		end

		if CooperationData:GetRoomData() then
			CooperationTools.GotoCooperation()
		else
			if CooperationData:GetIsMatching() then
				ShowTips("ERROR_COORDINATOR_ALREADY_IN_MATCH")

				return
			end

			local var_7_0 = CooperationData:GetCooperationHero(BattleConst.STAGE_TYPE_NEW.STRONGHOLD, arg_6_0.selectId, arg_6_0.selectId)

			CooperationAction.CreateRoom(arg_6_0.selectId, BattleConst.STAGE_TYPE_NEW.STRONGHOLD, {
				var_7_0
			}, arg_6_0.selectId)
		end
	end)
	arg_6_0:AddBtnListener(nil, arg_6_0.m_quickJoinBtn, function()
		if CooperationData:GetIsMatching() then
			CooperationAction.CancelMatching()
		else
			if not ActivityTools.GetActivityIsOpenWithTip(arg_6_0.selectId) then
				return
			end

			local var_8_0 = CooperationData:GetCooperationHero(BattleConst.STAGE_TYPE_NEW.STRONGHOLD, arg_6_0.selectId, arg_6_0.selectId)

			CooperationAction.StartMatching(arg_6_0.selectId, BattleConst.STAGE_TYPE_NEW.STRONGHOLD, {
				var_8_0
			}, arg_6_0.selectId)
		end
	end)
	arg_6_0:AddBtnListener(nil, arg_6_0.m_inviteBtn, function()
		JumpTools.OpenPageByJump("cooperationApply", {
			selectIndex = BattleConst.STAGE_TYPE_NEW.STRONGHOLD
		})
	end)
	arg_6_0:AddBtnListener(nil, arg_6_0.m_taskBtn, function()
		JumpTools.OpenPageByJump("/strongholdOperate", {
			selectIndex = 1,
			activity_id = arg_6_0.activity_id
		})
	end)
	arg_6_0:AddBtnListener(nil, arg_6_0.m_skillBtn, function()
		JumpTools.OpenPageByJump("/strongholdOperate", {
			selectIndex = 2,
			activity_id = arg_6_0.activity_id
		})
	end)
	arg_6_0:AddBtnListener(nil, arg_6_0.m_increaseBtn, function()
		JumpTools.OpenPageByJump("/strongholdOperate", {
			selectIndex = 3,
			activity_id = arg_6_0.activity_id
		})
	end)
	arg_6_0:AddBtnListener(nil, arg_6_0.m_rewardBtn, function()
		JumpTools.OpenPageByJump("/strongholdOperate", {
			selectIndex = 4,
			activity_id = arg_6_0.activity_id
		})
	end)
	arg_6_0:AddBtnListener(nil, arg_6_0.m_atlasBtn, function()
		JumpTools.OpenPageByJump("strongholdAtlas", {
			activity_id = arg_6_0.activity_id
		})
	end)
	arg_6_0:AddBtnListener(nil, arg_6_0.m_teachBtn, function()
		arg_6_0:Go("/sectionSelectHeroTeach", {
			section = BattleConst.COOPERATION_STRONGHOLD_TEACH_STAGE_ID,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING
		})
	end)
	arg_6_0:AddBtnListener(nil, arg_6_0.m_operateBtn, function()
		JumpTools.OpenPageByJump("strongholdOperate", {
			selectIndex = 1,
			activity_id = arg_6_0.activity_id
		})
	end)
end

function var_0_0.OnTop(arg_17_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INVITE_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_STRONGHOLD_DES")
end

function var_0_0.OnEnter(arg_18_0)
	arg_18_0.activity_id = ActivityConst.ACTIVITY_STRONGHOLD

	local var_18_0 = ActivityCfg[arg_18_0.activity_id].sub_activity_list

	arg_18_0.stronghold_stage_activity_list = {}

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		if ActivityTemplateConst.STRONGHOLD_STAGE == ActivityCfg[iter_18_1].activity_template then
			table.insert(arg_18_0.stronghold_stage_activity_list, iter_18_1)
		end
	end

	if arg_18_0.selectId == nil then
		arg_18_0.selectId = arg_18_0.stronghold_stage_activity_list[1]
	end

	if arg_18_0.selectId == 182203 then
		arg_18_0.colorController:SetSelectedIndex(1)
	else
		arg_18_0.colorController:SetSelectedIndex(0)
	end

	arg_18_0.difficultyList:StartScroll(#arg_18_0.stronghold_stage_activity_list)

	local var_18_1, var_18_2 = StrongholdData:GetStrongholdLevelAndIncreasePoint(arg_18_0.activity_id)

	arg_18_0.m_lvLab.text = var_18_1

	arg_18_0:RefreshUI()

	if arg_18_0.timer_ == nil then
		arg_18_0.timer_ = Timer.New(function()
			arg_18_0:RefreshTime()
		end, 1, -1)
	end

	arg_18_0.timer_:Start()
	arg_18_0:RefreshTime()
	manager.redPoint:bindUIandKey(arg_18_0.m_taskBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_TASK, arg_18_0.activity_id))
	manager.redPoint:bindUIandKey(arg_18_0.m_increaseBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_INCREASE, arg_18_0.activity_id))
	manager.redPoint:bindUIandKey(arg_18_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_REWARD, arg_18_0.activity_id))
	manager.redPoint:bindUIandKey(arg_18_0.m_operateBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD, arg_18_0.activity_id))
	manager.redPoint:bindUIandKey(arg_18_0.m_inviteBtn.transform, RedPointConst.COOPERATION_INVIT)
end

function var_0_0.RefreshUI(arg_20_0)
	local var_20_0 = CooperationData:GetIsMatching()

	arg_20_0.m_matchingLab.text = var_20_0 and GetTips("COOPERATION_CANCEL_MATCH") or GetTips("COOPERATION_START_MATCH")
	arg_20_0.matchTime = 0
	arg_20_0.m_matchingTime.text = ""

	arg_20_0.matchController:SetSelectedIndex(var_20_0 and 1 or 0)
end

function var_0_0.OnExit(arg_21_0)
	manager.windowBar:HideBar()

	if CooperationData:GetIsMatching() then
		CooperationAction.CancelMatching()
	end

	if arg_21_0.timer_ then
		arg_21_0.timer_:Stop()

		arg_21_0.timer_ = nil
	end

	manager.redPoint:unbindUIandKey(arg_21_0.m_taskBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_TASK, arg_21_0.activity_id))
	manager.redPoint:unbindUIandKey(arg_21_0.m_increaseBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_INCREASE, arg_21_0.activity_id))
	manager.redPoint:unbindUIandKey(arg_21_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_REWARD, arg_21_0.activity_id))
	manager.redPoint:unbindUIandKey(arg_21_0.m_operateBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD, arg_21_0.activity_id))
	manager.redPoint:unbindUIandKey(arg_21_0.m_inviteBtn.transform, RedPointConst.COOPERATION_INVIT)
	arg_21_0.matchController:SetSelectedIndex(0)
end

function var_0_0.RefreshTime(arg_22_0)
	local var_22_0 = ActivityData:GetActivityData(arg_22_0.activity_id)

	if var_22_0 and var_22_0:IsActivitying() then
		local var_22_1 = var_22_0.stopTime

		arg_22_0.m_timeLab.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr(var_22_1)
	else
		arg_22_0.m_timeLab.text = GetTips("TIME_OUT")
	end

	local var_22_2 = arg_22_0.difficultyList:GetItemList()

	for iter_22_0, iter_22_1 in pairs(var_22_2) do
		iter_22_1:RefreshTime()
	end

	if CooperationData:GetIsMatching() then
		arg_22_0.matchTime = arg_22_0.matchTime + 1
		arg_22_0.m_matchingTime.text = string.format(GetTips("COOPERATION_MATCHING"), arg_22_0.matchTime)
	end
end

function var_0_0.IndexItem(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0.stronghold_stage_activity_list[arg_23_1]

	arg_23_2:SetData(arg_23_0.activity_id, var_23_0)
	arg_23_2:SetSelect(arg_23_0.selectId)
	arg_23_2:RegistCallBack(arg_23_0.itemClickHandler)
end

function var_0_0.OnItemClick(arg_24_0, arg_24_1)
	arg_24_0.selectId = arg_24_1

	arg_24_0.difficultyList:Refresh()

	if arg_24_1 == 182203 then
		arg_24_0.colorController:SetSelectedIndex(1)
	else
		arg_24_0.colorController:SetSelectedIndex(0)
	end
end

function var_0_0.Dispose(arg_25_0)
	arg_25_0.difficultyList:Dispose()
	var_0_0.super.Dispose(arg_25_0)
end

function var_0_0.OnCooperationIsMatchingChange(arg_26_0)
	arg_26_0:RefreshUI()
end

function var_0_0.OnStrongholdUpgradeIncrease(arg_27_0)
	arg_27_0.difficultyList:Refresh()
end

return var_0_0
