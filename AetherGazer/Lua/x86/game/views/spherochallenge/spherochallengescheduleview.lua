local var_0_0 = class("SPHeroChallengeScheduleView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SPHeroChallenge/SPHeroChallengeScheduleUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.curScheduleScroll = LuaList.New(handler(arg_5_0, arg_5_0.indexSchedule), arg_5_0.uilistGo_, SPHeroChallengeScheduleStartItem)
	arg_5_0.awardItme = CommonItemView.New(arg_5_0.commonitemGo_1)
	arg_5_0.btnController = arg_5_0.controller:GetController("state")
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.data = SPHeroChallengeData:GetCurActivityInfo()
	arg_6_0.scheduleStart = false

	arg_6_0:RegisterEvents()
	arg_6_0:InitCanChooseScheduleList()
	arg_6_0:RefreshCanChooseScheduleList()
	arg_6_0:RefreshHadChossScheduleList()
	arg_6_0:RefreshDailyAwardInfo()
end

function var_0_0.OnTop(arg_7_0)
	arg_7_0:RefreshBar()
	arg_7_0:BindRedPonit()
end

function var_0_0.BindRedPonit(arg_8_0)
	return
end

function var_0_0.UnBindRedPonit(arg_9_0)
	return
end

function var_0_0.RefreshBar(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
	arg_11_0:UnBindRedPonit()
	arg_11_0:RemoveAllEventListener()
end

function var_0_0.AddUIListener(arg_12_0)
	arg_12_0:AddBtnListenerScale(arg_12_0.autoBtn_, nil, function()
		if not arg_12_0.scheduleStart then
			SPHeroChallengeTools:AutoChooseSchedule()
		end
	end)
	arg_12_0:AddBtnListenerScale(arg_12_0.confirmBtn_, nil, function()
		if arg_12_0.hadChooseList and not arg_12_0.scheduleStart then
			local var_14_0 = arg_12_0.data:GetScheduleDailyList()

			for iter_14_0, iter_14_1 in ipairs(var_14_0) do
				if iter_14_1 == 0 then
					ShowTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_EMPTY")

					return
				end
			end

			if #var_14_0 < SpHeroChallengeConst.scheduleNum then
				ShowTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_EMPTY")

				return
			end

			SPHeroChallengeAction:ConfirmScheduleList(var_14_0)
		end
	end)
end

function var_0_0.RegisterEvents(arg_15_0)
	arg_15_0:RegistEventListener(SP_HERO_CHALLENGE_SCHEDULE_CONFIRM, function()
		JumpTools.OpenPageByJump("/spHeroChallengeMainView")
		ShowTips("ACTIVITY_HERO_CHALLENGE_SET_SCHEDULE_SUCCESS")
	end)
	arg_15_0:RegistEventListener(SP_HERO_CHALLENGE_SCHEDULE_CHANGE, function(arg_17_0)
		if arg_17_0 then
			arg_15_0:RefreshCanChooseScheduleList()
			arg_15_0:RefreshSingleScheduleState(arg_17_0)
		end
	end)
end

function var_0_0.Dispose(arg_18_0)
	if arg_18_0.scheduleTypePool then
		for iter_18_0, iter_18_1 in pairs(arg_18_0.scheduleTypePool) do
			iter_18_1:Dispose()
		end

		arg_18_0.scheduleTypePool = nil
	end

	if arg_18_0.curScheduleScroll then
		arg_18_0.curScheduleScroll:Dispose()
	end

	if arg_18_0.awardItme then
		arg_18_0.awardItme:Dispose()
	end

	var_0_0.super.Dispose(arg_18_0)
end

function var_0_0.InitCanChooseScheduleList(arg_19_0)
	if not arg_19_0.initFlag then
		arg_19_0.initFlag = true
		arg_19_0.schedulePool = {}
		arg_19_0.scheduleTypePool = {}

		local var_19_0 = ActivityHeroChallengeScheduleCfg.get_id_list_by_type

		for iter_19_0, iter_19_1 in ipairs(var_19_0) do
			arg_19_0.scheduleTypePool[iter_19_0] = SPHeroChallengeScheduleTypeItem.New(arg_19_0.typegroupGo_, arg_19_0.contentTrs_, iter_19_0)
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_0.contentTrs_)
	end
end

function var_0_0.RefreshHadChossScheduleList(arg_20_0)
	local var_20_0 = arg_20_0.data:GetScheduleDailyList()

	arg_20_0.hadChooseList = {}

	for iter_20_0 = 1, SpHeroChallengeConst.scheduleNum do
		local var_20_1 = arg_20_0.data:GetStartListScheduleInfoByList(iter_20_0)

		if var_20_0[iter_20_0] and var_20_0[iter_20_0] ~= 0 then
			arg_20_0.hadChooseList[iter_20_0] = {
				scheduleID = var_20_0[iter_20_0],
				index = iter_20_0,
				isFinish = var_20_1 and var_20_1.isFinish
			}
		else
			arg_20_0.hadChooseList[iter_20_0] = {
				index = iter_20_0
			}
		end
	end

	arg_20_0.curScheduleScroll:StartScroll(#arg_20_0.hadChooseList)
	arg_20_0:RefreshConfirmBtnState()
end

function var_0_0.RefreshDailyAwardInfo(arg_21_0)
	local var_21_0 = SPHeroChallengeData:GetActivityID()
	local var_21_1 = ActivityHeroChallengeCfg[var_21_0].daily_award[1]
	local var_21_2 = {
		id = var_21_1[1],
		number = var_21_1[2],
		clickFun = function(arg_22_0)
			ShowPopItem(POP_ITEM, {
				arg_22_0.id
			})
		end
	}

	arg_21_0.awardItme:SetData(var_21_2)
end

function var_0_0.RefreshCanChooseScheduleList(arg_23_0)
	if arg_23_0.scheduleTypePool then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0.scheduleTypePool) do
			iter_23_1:RefreshUI()
		end
	end
end

function var_0_0.indexSchedule(arg_24_0, arg_24_1, arg_24_2)
	if not arg_24_0.scheduleStart then
		arg_24_2:RefreshUI(arg_24_0.hadChooseList[arg_24_1])
		arg_24_2:RegisterCancelCallBack(function()
			arg_24_0:RefreshSingleScheduleState(arg_24_1)
		end)
	end
end

function var_0_0.RefreshConfirmBtnState(arg_26_0)
	local var_26_0 = arg_26_0.data:GetScheduleDailyList()
	local var_26_1 = true

	for iter_26_0 = 1, SpHeroChallengeConst.scheduleNum do
		if var_26_0 and var_26_0[iter_26_0] and var_26_0[iter_26_0] ~= 0 then
			-- block empty
		else
			var_26_1 = false

			break
		end
	end

	if var_26_1 then
		arg_26_0.btnController:SetSelectedState("normal")
	else
		arg_26_0.btnController:SetSelectedState("unusable")
	end
end

function var_0_0.RefreshSingleScheduleState(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0.data:GetScheduleDailyList()
	local var_27_1 = arg_27_0.curScheduleScroll:GetItemByIndex(arg_27_1)
	local var_27_2 = {}

	if var_27_0[arg_27_1] and var_27_0[arg_27_1] ~= 0 then
		var_27_2 = {
			scheduleID = var_27_0[arg_27_1],
			index = arg_27_1
		}
	else
		var_27_2 = {
			index = arg_27_1
		}
	end

	var_27_1:RefreshUI(var_27_2)
	arg_27_0:RefreshConfirmBtnState()
end

return var_0_0
