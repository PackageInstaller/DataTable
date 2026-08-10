local var_0_0 = class("HeroTeamInfoCooperationView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Cooperation/HeroTeamInfoCooperationUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.contorller_ = ControllerUtil.GetController(arg_4_0.joinBtn_.transform, "upgradeBtn")
	arg_4_0.heroAvatarView_ = HeroAvatarView.New(arg_4_0, arg_4_0.displayGo_)
	arg_4_0.heroHeadList_ = LuaList.New(handler(arg_4_0, arg_4_0.HeadRenderer), arg_4_0.uiListGo_, HeroTeamHeadItem)
	arg_4_0.filterView_ = HeroListFilterWithTrialView.New(arg_4_0.filterGo_)

	arg_4_0.filterView_:SetExtraSorter(function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		local var_5_0 = arg_4_0:CheckInTeam(arg_5_0.id, arg_5_0.trialID)

		if var_5_0 ~= arg_4_0:CheckInTeam(arg_5_1.id, arg_5_1.trialID) then
			return true, var_5_0
		end

		if arg_5_0.trialID ~= 0 or arg_5_1.trialID ~= 0 then
			if arg_5_0.trialID ~= 0 and arg_5_1.trialID ~= 0 then
				if arg_5_2 == 0 and arg_5_0.star ~= arg_5_1.star then
					if arg_4_0.curOrder_ == "desc" then
						return true, arg_5_0.star > arg_5_1.star
					else
						return true, arg_5_0.star < arg_5_1.star
					end
				end

				local var_5_1 = getHeroPower(arg_5_0.trialID, true)
				local var_5_2 = getHeroPower(arg_5_1.trialID, true)

				if var_5_1 ~= var_5_2 then
					if arg_5_3 == "desc" then
						return true, var_5_2 < var_5_1
					else
						return true, var_5_1 < var_5_2
					end
				else
					return true, arg_5_0.trialID > arg_5_1.trialID
				end
			else
				return true, arg_5_0.trialID > arg_5_1.trialID
			end
		end

		return false, false
	end)
	arg_4_0.filterView_:SetListChangeHandler(handler(arg_4_0, arg_4_0.OnListChange))
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.joinBtn_, nil, function()
		arg_6_0:OnJoinClick()
	end)
end

function var_0_0.OnJoinClick(arg_8_0)
	local var_8_0 = arg_8_0.selectID_
	local var_8_1 = 1

	if arg_8_0.selectTrialID_ ~= 0 then
		var_8_0 = arg_8_0.selectTrialID_
		var_8_1 = 2
	end

	CooperationAction.ChangeHero({
		{
			hero_id = var_8_0,
			hero_type = var_8_1,
			owner_id = BattleTeamData.NO_OWNER
		}
	})
end

function var_0_0.OnListChange(arg_9_0, arg_9_1)
	arg_9_0.heroDataList_ = arg_9_1

	arg_9_0.heroHeadList_:StartScroll(#arg_9_0.heroDataList_)

	if #arg_9_0.heroDataList_ > 0 then
		arg_9_0:SelectHero(arg_9_0.heroDataList_[1].id, arg_9_0.heroDataList_[1].trialID)
	end
end

function var_0_0.OnEnter(arg_10_0)
	manager.ui:SetMainCamera("hero")

	arg_10_0.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.COOPERATION)

	if arg_10_0.params_.isEnter then
		if arg_10_0.filterView_ then
			arg_10_0.filterView_:Reset()
		end

		arg_10_0.params_.isEnter = false
	end

	manager.windowBar:SwitchBar({
		BACK_BAR
	})

	arg_10_0.room = CooperationData:GetRoomData()

	if arg_10_0.heroAvatarView_ then
		arg_10_0.heroAvatarView_:OnEnter()
	end

	local var_10_0 = CooperationTools.GetCooperationTeamHeroList(arg_10_0.room.type, arg_10_0.room.dest, arg_10_0.room.activity_id)

	if arg_10_0.room then
		arg_10_0.selectID_, arg_10_0.selectTrialID_ = arg_10_0.room:GetSelfHero()
	else
		local var_10_1 = var_10_0[1]

		arg_10_0.selectID_, arg_10_0.selectTrialID_ = var_10_1.id, var_10_1.trialID
	end

	arg_10_0.filterView_:SetHeroDataList(var_10_0)
	arg_10_0:SelectHero(arg_10_0.selectID_, arg_10_0.selectTrialID_)
	arg_10_0.heroHeadList_:StartScroll(#arg_10_0.heroDataList_, table.keyof(arg_10_0.heroDataList_, arg_10_0.selectID_))
end

function var_0_0.OnExit(arg_11_0)
	if arg_11_0.heroAvatarView_ then
		arg_11_0.heroAvatarView_:OnExit()
	end

	if #arg_11_0.heroDataList_ <= 0 then
		HeroData:ResetSortValue()
		arg_11_0.filterView_:Reset()
	end
end

function var_0_0.UpdateHeroView(arg_12_0)
	local var_12_0 = arg_12_0.selectID_
	local var_12_1

	if arg_12_0.selectTrialID_ and arg_12_0.selectTrialID_ ~= 0 then
		var_12_1 = HeroStandardSystemCfg[arg_12_0.selectTrialID_].skin_id
	else
		var_12_1 = HeroTools.HeroUsingSkinInfo(arg_12_0.selectID_).id
	end

	if arg_12_0.selectTrialID_ and arg_12_0.selectTrialID_ ~= 0 then
		arg_12_0.fightPowerText_.text = getHeroPower(arg_12_0.selectTrialID_, true)
	else
		arg_12_0.fightPowerText_.text = getHeroPower(var_12_0, false)
	end

	arg_12_0.heroAvatarView_:SetSkinId(var_12_1)

	local var_12_2 = HeroCfg[var_12_0]

	arg_12_0.nameText_.text = GetI18NText(var_12_2.name)
	arg_12_0.subNameText_.text = HeroTools.GetHeroName(var_12_0)
end

function var_0_0.HeadRenderer(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.heroDataList_[arg_13_1].id
	local var_13_1 = arg_13_0.heroDataList_[arg_13_1].trialID

	arg_13_2:SetRedPointEnable(false)

	arg_13_2.gameObject_.name = tostring(var_13_0)

	if var_13_1 == 0 then
		arg_13_2:SetHeroData(var_13_0, HeroConst.HERO_DATA_TYPE.DEFAULT, {
			tempHeroList = {
				var_13_1
			}
		})
		arg_13_2:SetTrial(false)
	else
		arg_13_2:SetHeroData(var_13_1, HeroConst.HERO_DATA_TYPE.TRIAL, {
			tempHeroList = {
				var_13_1
			}
		})
		arg_13_2:SetTrial(true)
	end

	arg_13_2:SetSelected(arg_13_2.heroId_ == arg_13_0.selectID_ and arg_13_2.trialID_ == arg_13_0.selectTrialID_)

	local var_13_2 = arg_13_0:CheckInTeam(var_13_0, var_13_1)

	arg_13_2:SetInTeamFlag(var_13_2, false)
	arg_13_2:RegisterClickListener(function()
		arg_13_0:SelectHero(arg_13_2.heroId_, arg_13_2.trialID_)
	end)
end

function var_0_0.SelectHero(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.selectID_ = arg_15_1
	arg_15_0.selectTrialID_ = arg_15_2

	for iter_15_0, iter_15_1 in pairs(arg_15_0.heroHeadList_:GetItemList()) do
		iter_15_1:SetSelected(iter_15_1.heroId_ == arg_15_1 and iter_15_1.trialID_ == arg_15_2)
	end

	if HeroData:GetHeroData(arg_15_1) then
		arg_15_0.heroViewProxy_:GetHeroAllAttribute(arg_15_1)
	end

	arg_15_0:UpdateHeroView()
	arg_15_0:RefreshJoinBtn()
end

function var_0_0.RefreshJoinBtn(arg_16_0)
	if arg_16_0:CheckRepeatHero(arg_16_0.selectID_, arg_16_0.selectTrialID_) then
		arg_16_0.joinBtn_.interactable = false
		arg_16_0.joinText_.text = string.format("<color=#222222>%s</color>", GetTips("COOPERATION_TEAM_REPEAT_HERO"))

		arg_16_0.contorller_:SetSelectedState("1")
	else
		arg_16_0.joinBtn_.interactable = true
		arg_16_0.joinText_.text = string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER"))

		arg_16_0.contorller_:SetSelectedState("0")
	end
end

function var_0_0.CheckRepeatHero(arg_17_0, arg_17_1)
	local var_17_0 = CooperationData:GetRoomData()

	if not var_17_0 then
		return false
	end

	local var_17_1 = var_17_0:GetRoomPlayerIdList()

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		local var_17_2 = var_17_0:GetRoomPlayerData(iter_17_1)

		if var_17_2.is_ready == 1 then
			for iter_17_2, iter_17_3 in ipairs(var_17_2.heroList) do
				if arg_17_1 == iter_17_3.id then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.CheckInTeam(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = CooperationData:GetRoomData()

	if not var_18_0 then
		return false
	end

	local var_18_1, var_18_2 = var_18_0:GetSelfHero()

	return arg_18_1 == var_18_1 and arg_18_2 == var_18_2
end

function var_0_0.Dispose(arg_19_0)
	if arg_19_0.filterView_ then
		arg_19_0.filterView_:Dispose()

		arg_19_0.filterView_ = nil
	end

	if arg_19_0.heroHeadList_ then
		arg_19_0.heroHeadList_:Dispose()

		arg_19_0.heroHeadList_ = nil
	end

	if arg_19_0.heroAvatarView_ then
		arg_19_0.heroAvatarView_:Dispose()

		arg_19_0.heroAvatarView_ = nil
	end

	var_0_0.super.Dispose(arg_19_0)
end

function var_0_0.OnHeroSort(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	arg_20_0.filterView_:RefreshSort(arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
end

function var_0_0.OnCooperationRoomInit(arg_21_0)
	arg_21_0.heroHeadList_:Refresh()
	arg_21_0:RefreshJoinBtn()
end

function var_0_0.OnCooperationRoomUpdate(arg_22_0)
	arg_22_0.heroHeadList_:Refresh()
	arg_22_0:RefreshJoinBtn()
end

return var_0_0
