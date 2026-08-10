ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("SwimsuitBattleMenuView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_SwimsuitUI/SummerUI_3_4_SwimsuitMenuUI"
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.waterController_ = arg_3_0.waterControllerEx_:GetController("state")
	arg_3_0.battleController_ = arg_3_0.battleControllerEx_:GetController("state")
	arg_3_0.subActivityList_ = ActivityCfg[arg_3_0.activityID_].sub_activity_list
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.waterBtn_, nil, function()
		local var_5_0 = ActivitySummerWaterData:GetActivityID()

		if not ActivityTools.ActivityOpenCheck(arg_4_0.subActivityList_[3]) or not ActivityTools.ActivityOpenCheck(var_5_0) then
			return
		end

		JumpTools.OpenPageByJump("/summerWaterMain", {
			activity = arg_4_0.subActivityList_[3]
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.swimBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(arg_4_0.subActivityList_[1]) then
			return
		end

		JumpTools.OpenPageByJump("/swimsuitBattleMain", {
			activity = arg_4_0.subActivityList_[1]
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.voteBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(arg_4_0.subActivityList_[2]) then
			return
		end

		JumpTools.OpenPageByJump("/swimsuitBattleVote", {
			activity = arg_4_0.subActivityList_[1]
		})

		if manager.redPoint:getTipValue(RedPointConst.ACTIVITY_SWIMSUIT_VOTE_TICKET) == 1 and not SwimsuitBattleData:GetRedPointClickTag() then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_SWIMSUIT_VOTE_TICKET, 0)
			SwimsuitBattleData:SetRedPointClickTag()
		end
	end)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.UpdateBar(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.Show(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)

	if arg_10_1 == true then
		arg_10_0:RefreshUI()
		manager.redPoint:bindUIandKey(arg_10_0.swimBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(arg_10_0.subActivityList_[1]), arg_10_0.subActivityList_[1]))
		manager.redPoint:bindUIandKey(arg_10_0.voteBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(arg_10_0.subActivityList_[2]), arg_10_0.subActivityList_[2]))
		manager.redPoint:bindUIandKey(arg_10_0.waterBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(arg_10_0.subActivityList_[3]), arg_10_0.subActivityList_[3]))
		arg_10_0:RegistEventListener(SWIMSUIT_BATTLE_VOTE_UPDATE, handler(arg_10_0, arg_10_0.OnVoteRoundInfoUpdate))
	else
		manager.redPoint:unbindUIandKey(arg_10_0.swimBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(arg_10_0.subActivityList_[1]), arg_10_0.subActivityList_[1]))
		manager.redPoint:unbindUIandKey(arg_10_0.voteBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(arg_10_0.subActivityList_[2]), arg_10_0.subActivityList_[2]))
		manager.redPoint:unbindUIandKey(arg_10_0.waterBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(arg_10_0.subActivityList_[3]), arg_10_0.subActivityList_[3]))
		arg_10_0:RemoveAllEventListener()
	end
end

function var_0_0.RefreshUI(arg_11_0)
	SwimsuitBattleAction.RequireVoteRoundInfo(arg_11_0.subActivityList_[2])
end

function var_0_0.OnVoteRoundInfoUpdate(arg_12_0)
	arg_12_0.voteRound_ = SwimsuitBattleData:GetCurVoteRound()

	if arg_12_0.voteRound_ == 5 then
		arg_12_0.voteRound_ = 4
	end

	arg_12_0.voteData_ = SwimsuitBattleData:GetSortVoteContestantsData(arg_12_0.voteRound_)

	for iter_12_0 = 1, 3 do
		local var_12_0 = HeroTools.GetHeroFullName(SwimsuitVoteHeroCfg[arg_12_0.voteData_[iter_12_0].ID].hero_id)

		arg_12_0["voteName" .. iter_12_0 .. "Text_"].text = var_12_0
		arg_12_0["voteScore" .. iter_12_0 .. "Text_"].text = arg_12_0.voteData_[iter_12_0].voteNum
	end

	local var_12_1, var_12_2, var_12_3 = SwimsuitBattleData:GetVoteTicketInfo(arg_12_0.subActivityList_[1])
	local var_12_4 = ActivityData:GetActivityData(arg_12_0.subActivityList_[1])

	if not var_12_4 then
		arg_12_0.battleController_:SetSelectedState("lock")
	elseif manager.time:GetServerTime() < var_12_4.startTime then
		arg_12_0.battleController_:SetSelectedState("lock")

		arg_12_0.battleOpenText_.text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr2(var_12_4.startTime))
	elseif manager.time:GetServerTime() >= var_12_4.stopTime then
		arg_12_0.battleController_:SetSelectedState("over")
	else
		arg_12_0.battleController_:SetSelectedState("unlock")

		arg_12_0.swimItemImg_.sprite = ItemTools.getItemSprite(var_12_1)
		arg_12_0.swimItemNum_.text = var_12_2 .. "/" .. var_12_3
	end

	local var_12_5 = ActivityData:GetActivityData(arg_12_0.subActivityList_[3])
	local var_12_6 = ActivitySummerWaterData:GetActivityID()
	local var_12_7

	if var_12_6 then
		var_12_7 = ActivityData:GetActivityData(var_12_6)
	end

	if not var_12_5 then
		arg_12_0.waterController_:SetSelectedState("lock")
	elseif manager.time:GetServerTime() < var_12_5.startTime then
		arg_12_0.waterController_:SetSelectedState("lock")

		arg_12_0.waterOpenText_.text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr2(var_12_5.startTime))
	elseif manager.time:GetServerTime() >= var_12_5.stopTime then
		arg_12_0.waterController_:SetSelectedState("over")
	elseif var_12_7 and manager.time:GetServerTime() < var_12_7.startTime then
		arg_12_0.waterController_:SetSelectedState("lock")

		arg_12_0.waterOpenText_.text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr2(var_12_7.startTime))
	else
		arg_12_0.waterController_:SetSelectedState("unlock")

		local var_12_8 = ActivitySummerWaterData:GetCurrentScheduleCfg()
		local var_12_9 = ActivitySummerWaterData:GetTotalGainCurrenyNum() .. "/" .. var_12_8.voting_ticket_limit

		arg_12_0.waterItemNum_.text = var_12_9
		arg_12_0.waterItemImg_.sprite = ItemTools.getItemSprite(var_12_1)
	end
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:StopTimer()
	arg_13_0:RemoveAllEventListener()
end

function var_0_0.UpdateData(arg_14_0)
	arg_14_0:RefreshUI()
end

return var_0_0
