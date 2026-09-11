local AbyssTeamInfoView = class("AbyssTeamInfoView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function AbyssTeamInfoView:Init()
	AbyssTeamInfoView.super.Init(self)
	self.filterView_:SetExtraSorter(handler(self, self.LockSorter))
end

function AbyssTeamInfoView:OnEnter()
	self.abandonList_ = AbyssTools.GetGlobalBanHeroList()
	self.lockList_ = AbyssTools.GetLayerLockHeroList(self.params_.reserveParams.customData.layer)

	AbyssTeamInfoView.super.OnEnter(self)
end

function AbyssTeamInfoView:HeadRenderer(arg_3_1, arg_3_2)
	AbyssTeamInfoView.super.HeadRenderer(self, arg_3_1, arg_3_2)

	local var_3_0, var_3_1, var_3_2 = self:IsInTeam(self.heroDataList_[arg_3_1].id, self.heroDataList_[arg_3_1].trialID)

	if AbyssData:IsHeroInLockList(self.heroDataList_[arg_3_1].id, self.abandonList_) > 0 then
		arg_3_2:SetHeroLock(true)
		arg_3_2:SetHeroLockType("abyss_abandon")
	elseif AbyssData:IsHeroInLockList(self.heroDataList_[arg_3_1].id, self.lockList_) > 0 then
		arg_3_2:SetHeroLock(true)
		arg_3_2:SetHeroLockType("abyss_lock")
	else
		arg_3_2:SetHeroLock(false)
	end

	arg_3_2.lockImage_:SetNativeSize()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_2.lockContainer_)
	arg_3_2:SetInTeamFlag(var_3_0)
end

function AbyssTeamInfoView:LockSorter(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = AbyssData:IsHeroInLockList(arg_4_1.id, self.lockList_) > 0 and 1 or 0
	local var_4_1 = AbyssData:IsHeroInLockList(arg_4_2.id, self.lockList_) > 0 and 1 or 0
	local var_4_2 = AbyssData:IsHeroInAbandonList(arg_4_1.id, self.abandonList_) > 0 and 1 or 0
	local var_4_3 = AbyssData:IsHeroInAbandonList(arg_4_2.id, self.abandonList_) > 0 and 1 or 0

	if var_4_2 ~= var_4_3 then
		return true, var_4_2 < var_4_3
	end

	if var_4_0 ~= var_4_1 then
		return true, var_4_0 < var_4_1
	end
end

function AbyssTeamInfoView:RefreshJoinBtn()
	AbyssTeamInfoView.super.RefreshJoinBtn(self)

	if AbyssData:IsHeroInAbandonList(self.selectID_, self.abandonList_) > 0 then
		self.joinBtn_.interactable = false

		self.joinBtnController_:SetSelectedState("lock")
	end

	if AbyssData:IsHeroInLockList(self.selectID_, self.lockList_) > 0 then
		self.joinBtn_.interactable = false

		self.joinBtnController_:SetSelectedState("lock")
	end
end

return AbyssTeamInfoView
