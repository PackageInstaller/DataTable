local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("AbyssTeamInfoView", var_0_0)

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)
	arg_1_0.filterView_:SetExtraSorter(handler(arg_1_0, arg_1_0.LockSorter))
end

function var_0_1.OnEnter(arg_2_0)
	arg_2_0.abandonList_ = AbyssTools.GetGlobalBanHeroList()
	arg_2_0.lockList_ = AbyssTools.GetLayerLockHeroList(arg_2_0.params_.reserveParams.customData.layer)

	var_0_1.super.OnEnter(arg_2_0)
end

function var_0_1.HeadRenderer(arg_3_0, arg_3_1, arg_3_2)
	var_0_1.super.HeadRenderer(arg_3_0, arg_3_1, arg_3_2)

	local var_3_0 = arg_3_0.heroDataList_[arg_3_1].id
	local var_3_1 = arg_3_0.heroDataList_[arg_3_1].trialID
	local var_3_2, var_3_3, var_3_4 = arg_3_0:IsInTeam(var_3_0, var_3_1)
	local var_3_5 = AbyssData:IsHeroInLockList(var_3_0, arg_3_0.lockList_)

	if AbyssData:IsHeroInLockList(var_3_0, arg_3_0.abandonList_) > 0 then
		arg_3_2:SetHeroLock(true)
		arg_3_2:SetHeroLockType("abyss_abandon")
	elseif var_3_5 > 0 then
		arg_3_2:SetHeroLock(true)
		arg_3_2:SetHeroLockType("abyss_lock")
	else
		arg_3_2:SetHeroLock(false)
	end

	arg_3_2.lockImage_:SetNativeSize()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_2.lockContainer_)
	arg_3_2:SetInTeamFlag(var_3_2)
end

function var_0_1.LockSorter(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = AbyssData:IsHeroInLockList(arg_4_1.id, arg_4_0.lockList_) > 0 and 1 or 0
	local var_4_1 = AbyssData:IsHeroInLockList(arg_4_2.id, arg_4_0.lockList_) > 0 and 1 or 0
	local var_4_2 = AbyssData:IsHeroInAbandonList(arg_4_1.id, arg_4_0.abandonList_) > 0 and 1 or 0
	local var_4_3 = AbyssData:IsHeroInAbandonList(arg_4_2.id, arg_4_0.abandonList_) > 0 and 1 or 0

	if var_4_2 ~= var_4_3 then
		return true, var_4_2 < var_4_3
	end

	if var_4_0 ~= var_4_1 then
		return true, var_4_0 < var_4_1
	end
end

function var_0_1.RefreshJoinBtn(arg_5_0)
	var_0_1.super.RefreshJoinBtn(arg_5_0)

	if AbyssData:IsHeroInAbandonList(arg_5_0.selectID_, arg_5_0.abandonList_) > 0 then
		arg_5_0.joinBtn_.interactable = false

		arg_5_0.joinBtnController_:SetSelectedState("lock")
	end

	if AbyssData:IsHeroInLockList(arg_5_0.selectID_, arg_5_0.lockList_) > 0 then
		arg_5_0.joinBtn_.interactable = false

		arg_5_0.joinBtnController_:SetSelectedState("lock")
	end
end

return var_0_1
