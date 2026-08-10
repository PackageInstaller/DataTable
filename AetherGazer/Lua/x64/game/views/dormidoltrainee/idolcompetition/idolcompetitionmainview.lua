local var_0_0 = class("IdolCompetitionMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Competition/IdolCompetitionMainUI"
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

	arg_4_0.phaseItemList_ = {
		[3] = {},
		[4] = {},
		[5] = {}
	}

	for iter_4_0 = 1, 4 do
		table.insert(arg_4_0.phaseItemList_[3], IdolCompetitionBattleItem.New(arg_4_0["battle" .. iter_4_0 .. "Go_"]))
	end

	table.insert(arg_4_0.phaseItemList_[4], IdolCompetitionBattleItem.New(arg_4_0.battle5Go_))
	table.insert(arg_4_0.phaseItemList_[4], IdolCompetitionBattleItem.New(arg_4_0.battle6Go_))
	table.insert(arg_4_0.phaseItemList_[5], IdolCompetitionBattleItem.New(arg_4_0.battle7Go_))

	arg_4_0.mainActivityID_ = 0
	arg_4_0.raceActivityList_ = {}
	arg_4_0.raceTime_ = {}
	arg_4_0.secondStartTime_ = 0
	arg_4_0.curRaceIndex_ = 0
	arg_4_0.curRacePhase_ = 0
	arg_4_0.myTakePartIn_ = nil
	arg_4_0.phaseController_ = arg_4_0.mainControllerEx_:GetController("phase")
	arg_4_0.signController_ = arg_4_0.mainControllerEx_:GetController("sign")
	arg_4_0.championsMeController_ = arg_4_0.mainControllerEx_:GetController("championsMe")
	arg_4_0.raceSwitchController_ = arg_4_0.mainControllerEx_:GetController("raceSwitch")
	arg_4_0.race1TagController_ = arg_4_0.mainControllerEx_:GetController("race1Tag")
	arg_4_0.race2TagController_ = arg_4_0.mainControllerEx_:GetController("race2Tag")
	arg_4_0.hideRaceController_ = arg_4_0.mainControllerEx_:GetController("hideRace")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("idolCompetitionReward", {
			activity = arg_5_0.mainActivityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.trainBtn_, nil, function()
		JumpTools.OpenPageByJump("/idolTraineeTrain")
	end)
	arg_5_0:AddBtnListener(arg_5_0.signBtn_, nil, function()
		JumpTools.OpenPageByJump("/idolCompetitionSign", {
			activity = arg_5_0.raceActivityList_[arg_5_0.curRaceIndex_],
			index = arg_5_0.curRaceIndex_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.race1Btn_, nil, function()
		if arg_5_0.curRaceIndex_ ~= 1 then
			IdolCompetitionData:TryToRequestNewPhaseData(arg_5_0.raceActivityList_[1], function()
				arg_5_0:RefreshPage(1)
			end)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.race2Btn_, nil, function()
		if arg_5_0.curRaceIndex_ ~= 2 then
			IdolCompetitionData:TryToRequestNewPhaseData(arg_5_0.raceActivityList_[2], function()
				arg_5_0:RefreshPage(2)
			end)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.championsBtn_, nil, function()
		if curRacePhase_ == 5 then
			JumpTools.OpenPageByJump("idolCompetitionResult", {
				index = 1,
				phase = 5,
				activity = arg_5_0.raceActivityList_[arg_5_0.curRaceIndex_]
			})
		end
	end)
end

local var_0_1 = {
	"CamShootAtPos1",
	"CamShootAtPos2",
	"CamShootAtPos3",
	"CamShootAtPos4",
	"CamShootAtPos5"
}

function var_0_0.RestoreVCam(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(var_0_1) do
		IdolTraineeCampBridge.SetVCamActive(iter_14_1, false)
	end

	if IdolTraineeCampBridge.cinemachineBrain.IsBlending then
		arg_14_0:StartWaitCamBlend()
	end
end

function var_0_0.StartWaitCamBlend(arg_15_0, arg_15_1)
	arg_15_0:StopWaitCamBlend()
	SetActive(arg_15_0.gameObject_, false)

	arg_15_0.timer = Timer.New(function()
		if not IdolTraineeCampBridge.cinemachineBrain.IsBlending then
			arg_15_0:StopWaitCamBlend()
			SetActive(arg_15_0.gameObject_, true)

			if arg_15_1 then
				arg_15_1()
			end
		end
	end, 0.34, -1)

	arg_15_0.timer:Start()
end

function var_0_0.StopWaitCamBlend(arg_17_0)
	if arg_17_0.timer then
		arg_17_0.timer:Stop()

		arg_17_0.timer = nil
	end
end

function var_0_0.OnEnter(arg_18_0)
	arg_18_0:RestoreVCam()
	IdolTraineeCampBridge.SetVCamActive("CamShootAtCompetitionPos", true)
	IdolTraineeCampBridge.RemoveTrainingCharacter()

	arg_18_0.mainActivityID_ = 2932801
	arg_18_0.raceActivityList_ = ActivityCfg[arg_18_0.mainActivityID_].sub_activity_list

	local var_18_0 = ActivityData:GetActivityData(arg_18_0.raceActivityList_[2])

	if var_18_0 then
		arg_18_0.secondStartTime_ = var_18_0.startTime
	end

	for iter_18_0 = 1, 2 do
		arg_18_0.raceTime_[iter_18_0] = IdolCompetitionData:GetRaceRefreshTime(arg_18_0.raceActivityList_[iter_18_0])

		local var_18_1 = IdolCompetitionData:GetRacePhase(arg_18_0.raceActivityList_[iter_18_0])

		if not var_18_1 then
			arg_18_0["race" .. iter_18_0 .. "TagController_"]:SetSelectedState("coming")
		elseif var_18_1 == 1 then
			arg_18_0["race" .. iter_18_0 .. "TagController_"]:SetSelectedState("sign")
		elseif var_18_1 < 5 then
			arg_18_0["race" .. iter_18_0 .. "TagController_"]:SetSelectedState("race")
		else
			arg_18_0["race" .. iter_18_0 .. "TagController_"]:SetSelectedState("end")
		end
	end

	local var_18_2 = IdolCompetitionData:GetRacePhase(arg_18_0.raceActivityList_[2])

	if var_18_2 and var_18_2 >= 1 then
		IdolCompetitionData:TryToRequestNewPhaseData(arg_18_0.raceActivityList_[2], function()
			arg_18_0:RefreshPage(2)
			arg_18_0:AddTimer()
		end)
	else
		IdolCompetitionData:TryToRequestNewPhaseData(arg_18_0.raceActivityList_[1], function()
			arg_18_0:RefreshPage(1)
			arg_18_0:AddTimer()
		end)
	end

	arg_18_0:RegistEventListener(IDOL_COMPETITION_RACE_PHASE_UPDATE, handler(arg_18_0, arg_18_0.OnRacePhaseUpdate))
	manager.redPoint:bindUIandKey(arg_18_0.signBtn_.transform, RedPointConst.ACTIVITY_IDOL_COMPETITION_SIGN)
	manager.redPoint:bindUIandKey(arg_18_0.taskBtn_.transform, RedPointConst.ACTIVITY_IDOL_COMPETITION_REWARD)
end

function var_0_0.OnTop(arg_21_0)
	arg_21_0:RefreshBar()
end

function var_0_0.RefreshBar(arg_22_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		ActivityTools.JumpBackToActivityMainViewByActivityID(arg_22_0.mainActivityID_)
	end)
	manager.windowBar:RegistHomeCallBack(function()
		BackHomeTools:BackHomeGotoMain()
	end)
	manager.windowBar:SetGameHelpKey("IDOL_COMPETITION_MAIN_DESC")
end

function var_0_0.AddTimer(arg_25_0)
	arg_25_0:StopTimer()

	if arg_25_0.raceTime_[arg_25_0.curRaceIndex_] and manager.time:GetServerTime() <= arg_25_0.raceTime_[arg_25_0.curRaceIndex_][1] then
		arg_25_0.signTimeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_25_0.raceTime_[arg_25_0.curRaceIndex_][1]) .. GetTips("IDOL_COMPETITION_SIGN_TIME_TEXT")
	end

	if arg_25_0.raceTime_[1] and manager.time:GetServerTime() <= arg_25_0.raceTime_[1][1] then
		arg_25_0.sign1TimeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_25_0.raceTime_[1][1]) .. GetTips("IDOL_COMPETITION_SIGN_TIME_TEXT")
	end

	if arg_25_0.raceTime_[2] and manager.time:GetServerTime() <= arg_25_0.raceTime_[2][1] then
		arg_25_0.sign2TimeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_25_0.raceTime_[2][1]) .. GetTips("IDOL_COMPETITION_SIGN_TIME_TEXT")
	end

	if manager.time:GetServerTime() <= arg_25_0.secondStartTime_ then
		arg_25_0.sign2StartText_.text = manager.time:GetLostTimeStrWith2Unit(arg_25_0.secondStartTime_) .. GetTips("IDOL_COMPETITION_START_TIME_TEXT")
	end

	arg_25_0.remainTimer_ = Timer.New(function()
		if arg_25_0.raceTime_[arg_25_0.curRaceIndex_] and manager.time:GetServerTime() <= arg_25_0.raceTime_[arg_25_0.curRaceIndex_][1] then
			arg_25_0.signTimeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_25_0.raceTime_[arg_25_0.curRaceIndex_][1]) .. GetTips("IDOL_COMPETITION_SIGN_TIME_TEXT")
		end

		if arg_25_0.raceTime_[1] and manager.time:GetServerTime() <= arg_25_0.raceTime_[1][1] then
			arg_25_0.sign1TimeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_25_0.raceTime_[1][1]) .. GetTips("IDOL_COMPETITION_SIGN_TIME_TEXT")
		end

		if arg_25_0.raceTime_[2] and manager.time:GetServerTime() <= arg_25_0.raceTime_[2][1] then
			arg_25_0.sign2TimeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_25_0.raceTime_[2][1]) .. GetTips("IDOL_COMPETITION_SIGN_TIME_TEXT")
		end

		if manager.time:GetServerTime() <= arg_25_0.secondStartTime_ then
			arg_25_0.sign2StartText_.text = manager.time:GetLostTimeStrWith2Unit(arg_25_0.secondStartTime_) .. GetTips("IDOL_COMPETITION_START_TIME_TEXT")
		end
	end, 1, -1)

	arg_25_0.remainTimer_:Start()
end

function var_0_0.StopTimer(arg_27_0)
	if arg_27_0.remainTimer_ then
		arg_27_0.remainTimer_:Stop()

		arg_27_0.remainTimer_ = nil
	end
end

function var_0_0.RefreshPage(arg_28_0, arg_28_1)
	arg_28_0.curRaceIndex_ = arg_28_1
	arg_28_0.curRacePhase_ = IdolCompetitionData:GetRacePhase(arg_28_0.raceActivityList_[arg_28_0.curRaceIndex_])
	arg_28_0.myTakePartIn_ = IdolCompetitionData:CheckMeTakePartIn(arg_28_0.raceActivityList_[arg_28_0.curRaceIndex_])

	arg_28_0.raceSwitchController_:SetSelectedState(tostring(arg_28_1))
	arg_28_0.phaseController_:SetSelectedState(tostring(arg_28_0.curRacePhase_))
	arg_28_0.signController_:SetSelectedState(tostring(arg_28_0.myTakePartIn_))

	if not arg_28_0.myTakePartIn_ and arg_28_0.curRacePhase_ > 1 then
		arg_28_0.hideRaceController_:SetSelectedState("NotSignedUp")
		SetActive(arg_28_0.myphaseGo_, false)

		return
	else
		arg_28_0.hideRaceController_:SetSelectedState("normal")
	end

	if arg_28_0.raceTime_[arg_28_0.curRaceIndex_] then
		arg_28_0.phase1TimeText_.text = manager.time:STimeDescS(arg_28_0.raceTime_[arg_28_0.curRaceIndex_][2], "!%m/%d %H:%M")
		arg_28_0.phase2TimeText_.text = manager.time:STimeDescS(arg_28_0.raceTime_[arg_28_0.curRaceIndex_][3], "!%m/%d %H:%M")
		arg_28_0.phase3TimeText_.text = manager.time:STimeDescS(arg_28_0.raceTime_[arg_28_0.curRaceIndex_][4], "!%m/%d %H:%M")
	end

	local var_28_0 = 3

	for iter_28_0, iter_28_1 in pairs(arg_28_0.phaseItemList_) do
		for iter_28_2, iter_28_3 in ipairs(iter_28_1) do
			local var_28_1
			local var_28_2
			local var_28_3
			local var_28_4
			local var_28_5

			if iter_28_0 <= arg_28_0.curRacePhase_ + 1 then
				var_28_1, var_28_2, var_28_3, var_28_4, var_28_5 = IdolCompetitionData:GetBattleInfo(arg_28_0.raceActivityList_[arg_28_0.curRaceIndex_], iter_28_0, iter_28_2)

				if var_28_1 and iter_28_0 > 3 then
					local var_28_6, var_28_7, var_28_8, var_28_9, var_28_10 = IdolCompetitionData:GetBattleInfo(arg_28_0.raceActivityList_[arg_28_0.curRaceIndex_], iter_28_0 - 1, iter_28_2 * 2 - 1)

					if var_28_7 then
						var_28_3 = var_28_10 == 1 and var_28_8 or var_28_9
					end

					local var_28_11, var_28_12, var_28_13, var_28_14, var_28_15 = IdolCompetitionData:GetBattleInfo(arg_28_0.raceActivityList_[arg_28_0.curRaceIndex_], iter_28_0 - 1, iter_28_2 * 2)

					if var_28_12 then
						var_28_4 = var_28_15 == 1 and var_28_13 or var_28_14
						var_28_1 = false
						var_28_2 = false
					end
				end
			else
				var_28_1 = true
			end

			iter_28_3:SetData(var_28_1, var_28_2, var_28_3, var_28_4, var_28_5, arg_28_0.raceActivityList_[arg_28_0.curRaceIndex_], function()
				if var_28_1 then
					return
				end

				if not var_28_2 then
					ShowTips("IDOL_COMPETITION_STAGE_WAITING")

					return
				end

				JumpTools.OpenPageByJump("idolCompetitionResult", {
					activity = arg_28_0.raceActivityList_[arg_28_0.curRaceIndex_],
					phase = iter_28_0,
					index = iter_28_2
				})
			end)

			if (var_28_3 == USER_ID or var_28_4 == USER_ID) and var_28_0 < iter_28_0 then
				var_28_0 = iter_28_0
			end

			if not var_28_1 and var_28_2 then
				if iter_28_0 == arg_28_0.curRacePhase_ and getData("IdolCompetition", "battle_line_anim_" .. arg_28_0.raceActivityList_[arg_28_0.curRaceIndex_] .. "_" .. iter_28_0 .. "_" .. iter_28_2) ~= 1 then
					saveData("IdolCompetition", "battle_line_anim_" .. arg_28_0.raceActivityList_[arg_28_0.curRaceIndex_] .. "_" .. iter_28_0 .. "_" .. iter_28_2, 1)

					if var_28_5 == 1 then
						iter_28_3.line1Ani_:Play("line_up", -1, 0)
					elseif var_28_5 == 2 then
						iter_28_3.line2Ani_:Play("line_up", -1, 0)
					end
				elseif var_28_5 == 1 then
					iter_28_3.line1Ani_:Play("line_up", -1, 1)
				elseif var_28_5 == 2 then
					iter_28_3.line2Ani_:Play("line_up", -1, 1)
				end
			end

			if not var_28_1 then
				if iter_28_0 == arg_28_0.curRacePhase_ + 1 and getData("IdolCompetition", "battle_player_anim_" .. arg_28_0.raceActivityList_[arg_28_0.curRaceIndex_] .. "_" .. iter_28_0 .. "_" .. iter_28_2) ~= 1 then
					saveData("IdolCompetition", "battle_player_anim_" .. arg_28_0.raceActivityList_[arg_28_0.curRaceIndex_] .. "_" .. iter_28_0 .. "_" .. iter_28_2, 1)
					iter_28_3.p1Ani_:Play("itemCompetitor", -1, 0)
					iter_28_3.p2Ani_:Play("itemCompetitor", -1, 0)
				else
					iter_28_3.p1Ani_:Play("itemCompetitor", -1, 1)
					iter_28_3.p2Ani_:Play("itemCompetitor", -1, 1)
				end
			end
		end
	end

	if arg_28_0.myTakePartIn_ and arg_28_0.curRacePhase_ > 1 then
		SetActive(arg_28_0.myphaseGo_, true)

		arg_28_0.myphaseText_.text = GetTips("IDOL_COMPETITION_PLAYER_PHASE_" .. var_28_0)
	else
		SetActive(arg_28_0.myphaseGo_, false)
	end

	arg_28_0.championsMeController_:SetSelectedState("false")

	if arg_28_0.curRacePhase_ == 5 then
		local var_28_16, var_28_17, var_28_18, var_28_19, var_28_20 = IdolCompetitionData:GetBattleInfo(arg_28_0.raceActivityList_[arg_28_0.curRaceIndex_], 5, 1)
		local var_28_21 = var_28_20 == 1 and var_28_18 or var_28_19
		local var_28_22 = IdolCompetitionData:GetRacePlayerInfo(arg_28_0.raceActivityList_[arg_28_0.curRaceIndex_], var_28_21)

		if var_28_21 == USER_ID then
			arg_28_0.championsMeController_:SetSelectedState("true")

			arg_28_0.myphaseText_.text = GetTips("IDOL_COMPETITION_PLAYER_PHASE_CHAMPION")
		end

		if var_28_22.npc == 0 then
			arg_28_0.championsImg_.sprite = ItemTools.getItemSprite(var_28_22.head)
		else
			arg_28_0.championsImg_.spriteSync = "TextureConfig/BackHouseUI/IdolCompetitionNpcHead/" .. var_28_22.head
		end

		arg_28_0.championsText_.text = var_28_22.name

		if getData("IdolCompetition", "battle_king_anim_" .. arg_28_0.raceActivityList_[arg_28_0.curRaceIndex_]) ~= 1 then
			saveData("IdolCompetition", "battle_king_anim_" .. arg_28_0.raceActivityList_[arg_28_0.curRaceIndex_], 1)
			arg_28_0.kingAni_:Play("itemCompetitor_king_first", -1, 0)
		else
			arg_28_0.kingAni_:Play("New State")
		end
	end
end

function var_0_0.OnRacePhaseUpdate(arg_30_0)
	if arg_30_0.curRaceIndex_ == 0 then
		return
	end

	local var_30_0 = manager.time:GetServerTime() < arg_30_0.secondStartTime_ and 1 or 2

	IdolCompetitionData:TryToRequestNewPhaseData(arg_30_0.raceActivityList_[var_30_0], function()
		arg_30_0:RefreshPage(var_30_0)

		arg_30_0.raceTime_[var_30_0] = IdolCompetitionData:GetRaceRefreshTime(arg_30_0.raceActivityList_[var_30_0])

		local var_31_0 = IdolCompetitionData:GetRacePhase(arg_30_0.raceActivityList_[var_30_0])

		if not var_31_0 then
			arg_30_0["race" .. var_30_0 .. "TagController_"]:SetSelectedState("coming")
		elseif var_31_0 == 1 then
			arg_30_0["race" .. var_30_0 .. "TagController_"]:SetSelectedState("sign")
		elseif var_31_0 < 5 then
			arg_30_0["race" .. var_30_0 .. "TagController_"]:SetSelectedState("race")
		else
			arg_30_0["race" .. var_30_0 .. "TagController_"]:SetSelectedState("end")
		end
	end)
end

function var_0_0.OnExit(arg_32_0)
	manager.windowBar:HideBar()
	arg_32_0:RemoveAllEventListener()
	arg_32_0:StopWaitCamBlend()
	arg_32_0:StopTimer()
	manager.redPoint:unbindUIandKey(arg_32_0.signBtn_.transform, RedPointConst.ACTIVITY_IDOL_COMPETITION_SIGN)
	manager.redPoint:unbindUIandKey(arg_32_0.taskBtn_.transform, RedPointConst.ACTIVITY_IDOL_COMPETITION_REWARD)
end

function var_0_0.Dispose(arg_33_0)
	arg_33_0:StopWaitCamBlend()

	for iter_33_0, iter_33_1 in pairs(arg_33_0.phaseItemList_) do
		for iter_33_2, iter_33_3 in ipairs(iter_33_1) do
			if iter_33_3 then
				iter_33_3:Dispose()
			end
		end

		iter_33_1 = nil
	end

	var_0_0.super.Dispose(arg_33_0)
end

return var_0_0
