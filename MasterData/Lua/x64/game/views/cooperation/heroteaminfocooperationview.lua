local HeroTeamInfoCooperationView = class("HeroTeamInfoCooperationView", ReduxView)

function HeroTeamInfoCooperationView:UIName()
	return "UI/Cooperation/HeroTeamInfoCooperationUI"
end

function HeroTeamInfoCooperationView:UIParent()
	return manager.ui.uiMain.transform
end

function HeroTeamInfoCooperationView:Init()
	self:InitUI()
	self:AddListeners()
end

function HeroTeamInfoCooperationView:InitUI()
	self:BindCfgUI()

	self.contorller_ = ControllerUtil.GetController(self.joinBtn_.transform, "upgradeBtn")
	self.heroAvatarView_ = HeroAvatarView.New(self, self.displayGo_)
	self.heroHeadList_ = LuaList.New(handler(self, self.HeadRenderer), self.uiListGo_, HeroTeamHeadItem)
	self.filterView_ = HeroListFilterWithTrialView.New(self.filterGo_)

	self.filterView_:SetExtraSorter(function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		local var_5_0 = self:CheckInTeam(arg_5_0.id, arg_5_0.trialID)

		if var_5_0 ~= self:CheckInTeam(arg_5_1.id, arg_5_1.trialID) then
			return true, var_5_0
		end

		if arg_5_0.trialID ~= 0 or arg_5_1.trialID ~= 0 then
			if arg_5_0.trialID ~= 0 and arg_5_1.trialID ~= 0 then
				if arg_5_2 == 0 and arg_5_0.star ~= arg_5_1.star then
					if self.curOrder_ == "desc" then
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
	self.filterView_:SetListChangeHandler(handler(self, self.OnListChange))
end

function HeroTeamInfoCooperationView:AddListeners()
	self:AddBtnListener(self.joinBtn_, nil, function()
		self:OnJoinClick()
	end)
end

function HeroTeamInfoCooperationView:OnJoinClick()
	local var_8_0 = self.selectID_
	local var_8_1 = 1

	if self.selectTrialID_ ~= 0 then
		var_8_0 = self.selectTrialID_
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

function HeroTeamInfoCooperationView:OnListChange(arg_9_1)
	self.heroDataList_ = arg_9_1

	self.heroHeadList_:StartScroll(#self.heroDataList_)

	if #self.heroDataList_ > 0 then
		self:SelectHero(self.heroDataList_[1].id, self.heroDataList_[1].trialID)
	end
end

function HeroTeamInfoCooperationView:OnEnter()
	manager.ui:SetMainCamera("hero")

	self.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.COOPERATION)

	if self.params_.isEnter then
		if self.filterView_ then
			self.filterView_:Reset()
		end

		self.params_.isEnter = false
	end

	manager.windowBar:SwitchBar({
		BACK_BAR
	})

	self.room = CooperationData:GetRoomData()

	if self.heroAvatarView_ then
		self.heroAvatarView_:OnEnter()
	end

	local var_10_0 = CooperationTools.GetCooperationTeamHeroList(self.room.type, self.room.dest, self.room.activity_id)

	if self.room then
		self.selectID_, self.selectTrialID_ = self.room:GetSelfHero()
	else
		self.selectTrialID_ = var_10_0[1].trialID
		self.selectID_ = var_10_0[1].id
	end

	self.filterView_:SetHeroDataList(var_10_0)
	self:SelectHero(self.selectID_, self.selectTrialID_)
	self.heroHeadList_:StartScroll(#self.heroDataList_, table.keyof(self.heroDataList_, self.selectID_))
end

function HeroTeamInfoCooperationView:OnExit()
	if self.heroAvatarView_ then
		self.heroAvatarView_:OnExit()
	end

	if #self.heroDataList_ <= 0 then
		HeroData:ResetSortValue()
		self.filterView_:Reset()
	end
end

function HeroTeamInfoCooperationView:UpdateHeroView()
	local var_12_0 = self.selectTrialID_ and self.selectTrialID_ ~= 0 and HeroStandardSystemCfg[self.selectTrialID_].skin_id or HeroTools.HeroUsingSkinInfo(self.selectID_).id

	self.fightPowerText_.text = self.selectTrialID_ and self.selectTrialID_ ~= 0 and getHeroPower(self.selectTrialID_, true) or getHeroPower(self.selectID_, false)

	self.heroAvatarView_:SetSkinId(var_12_0)

	self.nameText_.text = GetI18NText(HeroCfg[self.selectID_].name)
	self.subNameText_.text = HeroTools.GetHeroName(self.selectID_)
end

function HeroTeamInfoCooperationView:HeadRenderer(arg_13_1, arg_13_2)
	local var_13_0 = self.heroDataList_[arg_13_1].id
	local var_13_1 = self.heroDataList_[arg_13_1].trialID

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

	arg_13_2:SetSelected(arg_13_2.heroId_ == self.selectID_ and arg_13_2.trialID_ == self.selectTrialID_)
	arg_13_2:SetInTeamFlag(self:CheckInTeam(var_13_0, var_13_1), false)
	arg_13_2:RegisterClickListener(function()
		self:SelectHero(arg_13_2.heroId_, arg_13_2.trialID_)
	end)
end

function HeroTeamInfoCooperationView:SelectHero(arg_15_1, arg_15_2)
	self.selectID_ = arg_15_1
	self.selectTrialID_ = arg_15_2

	for iter_15_0, iter_15_1 in pairs(self.heroHeadList_:GetItemList()) do
		iter_15_1:SetSelected(iter_15_1.heroId_ == arg_15_1 and iter_15_1.trialID_ == arg_15_2)
	end

	if HeroData:GetHeroData(arg_15_1) then
		self.heroViewProxy_:GetHeroAllAttribute(arg_15_1)
	end

	self:UpdateHeroView()
	self:RefreshJoinBtn()
end

function HeroTeamInfoCooperationView:RefreshJoinBtn()
	if self:CheckRepeatHero(self.selectID_, self.selectTrialID_) then
		self.joinBtn_.interactable = false
		self.joinText_.text = string.format("<color=#222222>%s</color>", GetTips("COOPERATION_TEAM_REPEAT_HERO"))

		self.contorller_:SetSelectedState("1")
	else
		self.joinBtn_.interactable = true
		self.joinText_.text = string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER"))

		self.contorller_:SetSelectedState("0")
	end
end

function HeroTeamInfoCooperationView:CheckRepeatHero(arg_17_1)
	local var_17_0 = CooperationData:GetRoomData()

	if not var_17_0 then
		return false
	end

	for iter_17_0, iter_17_1 in ipairs((var_17_0:GetRoomPlayerIdList())) do
		local var_17_1 = var_17_0:GetRoomPlayerData(iter_17_1)

		if var_17_1.is_ready == 1 then
			for iter_17_2, iter_17_3 in ipairs(var_17_1.heroList) do
				if arg_17_1 == iter_17_3.id then
					return true
				end
			end
		end
	end

	return false
end

function HeroTeamInfoCooperationView:CheckInTeam(arg_18_1, arg_18_2)
	local var_18_0 = CooperationData:GetRoomData()

	if not var_18_0 then
		return false
	end

	local var_18_1, var_18_2 = var_18_0:GetSelfHero()

	return arg_18_1 == var_18_1 and arg_18_2 == var_18_2
end

function HeroTeamInfoCooperationView:Dispose()
	if self.filterView_ then
		self.filterView_:Dispose()

		self.filterView_ = nil
	end

	if self.heroHeadList_ then
		self.heroHeadList_:Dispose()

		self.heroHeadList_ = nil
	end

	if self.heroAvatarView_ then
		self.heroAvatarView_:Dispose()

		self.heroAvatarView_ = nil
	end

	HeroTeamInfoCooperationView.super.Dispose(self)
end

function HeroTeamInfoCooperationView:OnHeroSort(arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	self.filterView_:RefreshSort(arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
end

function HeroTeamInfoCooperationView:OnCooperationRoomInit()
	self.heroHeadList_:Refresh()
	self:RefreshJoinBtn()
end

function HeroTeamInfoCooperationView:OnCooperationRoomUpdate()
	self.heroHeadList_:Refresh()
	self:RefreshJoinBtn()
end

return HeroTeamInfoCooperationView
