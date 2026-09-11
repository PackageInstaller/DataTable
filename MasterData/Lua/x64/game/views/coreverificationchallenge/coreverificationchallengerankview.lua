local CoreVerificationChallengeRankView = class("CoreVerificationChallengeRankView", ReduxView)

function CoreVerificationChallengeRankView:UIName()
	return "Widget/System/Core_verification_new/Core_verification_RankUI"
end

function CoreVerificationChallengeRankView:UIParent()
	return manager.ui.uiMain.transform
end

function CoreVerificationChallengeRankView:Init()
	self:BindCfgUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddUIListener()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, CoreVerificationRankItem)
end

function CoreVerificationChallengeRankView:AddUIListener()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationReward", {
			isRank = true
		})
	end)
	self:AddToggleListener(self.rankDropdown_, function(arg_6_0)
		if self.curPage_ == arg_6_0 + 1 then
			return
		end

		self:SwitchPage(arg_6_0 + 1)
	end)
end

function CoreVerificationChallengeRankView:IndexItem(arg_7_1, arg_7_2)
	local var_7_0 = CoreVerificationChallengeTools.GetModeIndex(CoreVerificationChallengeTools.GetModeActivityIdByRankId(self.activityID))

	if CoreVerificationChallengeTools.IsLastRankActivity(self.activityID) then
		arg_7_2:Refresh(self.rankList[arg_7_1], var_7_0)
	else
		arg_7_2:Refresh(self.rankList[arg_7_1], var_7_0)
	end
end

function CoreVerificationChallengeRankView:InitDropdownData()
	self.rankDropdown_.options:Clear()

	for iter_8_0, iter_8_1 in ipairs(CoreVerificationChallengeTools.GetAllRankActivityIds()) do
		self.rankDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetI18NText(ActivityCfg[CoreVerificationChallengeTools.GetModeActivityIdByRankId(iter_8_1)].remark), nil))
	end

	self.rankDropdown_:RefreshShownValue()
end

function CoreVerificationChallengeRankView:OnTop()
	manager.windowBar:SetGameHelpKey("CORE_VERIFICATION_DES")
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function CoreVerificationChallengeRankView:OnBehind()
	manager.windowBar:HideBar()
end

function CoreVerificationChallengeRankView:OnEnter()
	self.activityID = CoreVerificationChallengeTools.GetActivityRankId()
	self.curPage_ = table.indexof(CoreVerificationChallengeTools.GetAllRankActivityIds(), self.activityID) or 1

	self:SwitchPage(self.curPage_)
	self:InitDropdownData()

	self.rankDropdown_.value = self.curPage_ - 1
end

function CoreVerificationChallengeRankView:OnRankUpdate()
	self.nameLabel_.text = GetI18NText(ActivityCfg[self.activityID].remark)
	self.rankData = RankData:GetActivityRank(self.activityID)

	if self.rankData then
		self.rankList = self.rankData.rankList or {}
	end

	self.list_:StartScroll(#self.rankList)

	local var_12_0 = PlayerData:GetPlayerInfo()

	self.commonPortrait_:RenderHead(var_12_0 and var_12_0.portrait)
	self.commonPortrait_:RenderFrame(var_12_0.icon_frame)

	if self.rankData then
		local var_12_1, var_12_2 = self.rankData:GetCurRankDes()

		self.textnumText_.text = var_12_1
		self.textscoreText_.text = var_12_2
	else
		self.textnumText_.text = ""
		self.textscoreText_.text = ""
	end
end

function CoreVerificationChallengeRankView:SwitchPage(arg_13_1)
	self.curPage_ = arg_13_1
	self.activityID = CoreVerificationChallengeTools.GetAllRankActivityIds()[arg_13_1]

	local var_13_0 = RankData:GetActivityRank(self.activityID)

	if var_13_0 then
		self.rankList = var_13_0.rankList or {}
	end

	RankAction.QueryActivityRank(self.activityID)
	self:OnRankUpdate()
end

function CoreVerificationChallengeRankView:OnExit()
	return
end

function CoreVerificationChallengeRankView:Dispose()
	self.commonPortrait_:Dispose()

	self.commonPortrait_ = nil

	CoreVerificationChallengeRankView.super.Dispose(self)

	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end
end

return CoreVerificationChallengeRankView
