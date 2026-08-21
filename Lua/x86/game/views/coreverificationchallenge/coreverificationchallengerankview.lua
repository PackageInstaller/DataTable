local var_0_0 = class("CoreVerificationChallengeRankView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/Core_verification_RankUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.commonPortrait_ = CommonHeadPortrait.New(arg_3_0.headItem_)

	arg_3_0:AddUIListener()

	arg_3_0.list_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.m_list, CoreVerificationRankItem)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationReward", {
			isRank = true
		})
	end)
	arg_4_0:AddToggleListener(arg_4_0.rankDropdown_, function(arg_6_0)
		if arg_4_0.curPage_ == arg_6_0 + 1 then
			return
		end

		arg_4_0:SwitchPage(arg_6_0 + 1)
	end)
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.rankList[arg_7_1]
	local var_7_1 = CoreVerificationChallengeTools.GetModeIndex(CoreVerificationChallengeTools.GetModeActivityIdByRankId(arg_7_0.activityID))

	if CoreVerificationChallengeTools.IsLastRankActivity(arg_7_0.activityID) then
		arg_7_2:Refresh(var_7_0, var_7_1)
	else
		arg_7_2:Refresh(var_7_0, var_7_1)
	end
end

function var_0_0.InitDropdownData(arg_8_0)
	arg_8_0.rankDropdown_.options:Clear()

	for iter_8_0, iter_8_1 in ipairs(CoreVerificationChallengeTools.GetAllRankActivityIds()) do
		local var_8_0 = ActivityCfg[CoreVerificationChallengeTools.GetModeActivityIdByRankId(iter_8_1)].remark

		arg_8_0.rankDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetI18NText(var_8_0), nil))
	end

	arg_8_0.rankDropdown_:RefreshShownValue()
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SetGameHelpKey("CORE_VERIFICATION_DES")
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function var_0_0.OnBehind(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.activityID = CoreVerificationChallengeTools.GetActivityRankId()
	arg_11_0.curPage_ = table.indexof(CoreVerificationChallengeTools.GetAllRankActivityIds(), arg_11_0.activityID) or 1

	arg_11_0:SwitchPage(arg_11_0.curPage_)
	arg_11_0:InitDropdownData()

	arg_11_0.rankDropdown_.value = arg_11_0.curPage_ - 1
end

function var_0_0.OnRankUpdate(arg_12_0)
	arg_12_0.nameLabel_.text = GetI18NText(ActivityCfg[arg_12_0.activityID].remark)
	arg_12_0.rankData = RankData.GetActivityRank(RankData, arg_12_0.activityID)
	arg_12_0.rankList = arg_12_0.rankData and arg_12_0.rankData.rankList or {}

	arg_12_0.list_:StartScroll(#arg_12_0.rankList)

	local var_12_0 = PlayerData:GetPlayerInfo()

	arg_12_0.commonPortrait_:RenderHead(var_12_0 and var_12_0.portrait)
	arg_12_0.commonPortrait_:RenderFrame(var_12_0.icon_frame)

	if arg_12_0.rankData then
		local var_12_1, var_12_2 = arg_12_0.rankData:GetCurRankDes()

		arg_12_0.textnumText_.text = var_12_1
		arg_12_0.textscoreText_.text = var_12_2
	else
		arg_12_0.textnumText_.text = ""
		arg_12_0.textscoreText_.text = ""
	end
end

function var_0_0.SwitchPage(arg_13_0, arg_13_1)
	arg_13_0.curPage_ = arg_13_1
	arg_13_0.activityID = CoreVerificationChallengeTools.GetAllRankActivityIds()[arg_13_1]

	local var_13_0 = RankData:GetActivityRank(arg_13_0.activityID)

	arg_13_0.rankList = var_13_0 and var_13_0.rankList or {}

	RankAction.QueryActivityRank(arg_13_0.activityID)
	arg_13_0:OnRankUpdate()
end

function var_0_0.OnExit(arg_14_0)
	return
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.commonPortrait_:Dispose()

	arg_15_0.commonPortrait_ = nil

	var_0_0.super.Dispose(arg_15_0)

	if arg_15_0.list_ then
		arg_15_0.list_:Dispose()

		arg_15_0.list_ = nil
	end
end

return var_0_0
