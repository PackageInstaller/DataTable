local NewHeroTeamInfoCooperationView = class("NewHeroTeamInfoCooperationView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function NewHeroTeamInfoCooperationView:ExtraSorter(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = self:CheckInTeam(arg_1_1.id, arg_1_1.trialID)

	if var_1_0 ~= self:CheckInTeam(arg_1_2.id, arg_1_2.trialID) then
		return true, var_1_0
	end

	if arg_1_1.trialID ~= 0 or arg_1_2.trialID ~= 0 then
		if arg_1_1.trialID ~= 0 and arg_1_2.trialID ~= 0 then
			if arg_1_3 == 0 and arg_1_1.star ~= arg_1_2.star then
				if self.curOrder_ == "desc" then
					return true, arg_1_1.star > arg_1_2.star
				else
					return true, arg_1_1.star < arg_1_2.star
				end
			end

			local var_1_1 = getHeroPower(arg_1_1.trialID, true)
			local var_1_2 = getHeroPower(arg_1_2.trialID, true)

			if var_1_1 ~= var_1_2 then
				if arg_1_4 == "desc" then
					return true, var_1_2 < var_1_1
				else
					return true, var_1_1 < var_1_2
				end
			else
				return true, arg_1_1.trialID > arg_1_2.trialID
			end
		else
			return true, arg_1_1.trialID > arg_1_2.trialID
		end
	end

	return false, false
end

function NewHeroTeamInfoCooperationView:OnJoinClick()
	local var_2_0 = self.selectHeroData_.id
	local var_2_1 = 1

	if self.selectHeroData_.trialID ~= 0 then
		var_2_0 = self.selectHeroData_.trialID
		var_2_1 = 2
	end

	CooperationAction.ChangeHero({
		{
			hero_id = var_2_0,
			hero_type = var_2_1,
			owner_id = BattleTeamData.NO_OWNER
		}
	})
end

function NewHeroTeamInfoCooperationView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function NewHeroTeamInfoCooperationView:ProcessCustomParams()
	self.roomData_ = CooperationData:GetRoomData()
end

function NewHeroTeamInfoCooperationView:RefreshHeroDataList()
	local var_5_0, var_5_1 = CooperationTools.GetCooperationTeamHeroList(self.roomData_.type, self.roomData_.dest, self.roomData_.activity_id)

	self.allTrialIDList_ = var_5_1

	self.heroViewProxy_:SetTempHeroList(self.allTrialIDList_)
	self.filterView_:SetHeroIdList(var_5_0)
end

function NewHeroTeamInfoCooperationView:RefreshJoinBtn()
	self.joinBtn_.interactable = true

	if self:CheckRepeatHero(self.selectHeroData_.id, self.selectHeroData_.trialID) then
		self.joinBtn_.interactable = false

		self.joinBtnController_:SetSelectedState("lock")
	else
		self.joinBtn_.interactable = true

		self.joinBtnController_:SetSelectedState("change")
	end
end

function NewHeroTeamInfoCooperationView:CheckRepeatHero(arg_7_1)
	return CooperationTools.CheckRepeatHero(arg_7_1)
end

function NewHeroTeamInfoCooperationView:CheckInTeam(arg_8_1, arg_8_2)
	return CooperationTools.CheckInTeam(arg_8_1, arg_8_2)
end

function NewHeroTeamInfoCooperationView:OnCooperationRoomInit()
	self.heroHeadList_:Refresh()
	self:RefreshJoinBtn()
end

function NewHeroTeamInfoCooperationView:OnCooperationRoomUpdate()
	self.heroHeadList_:Refresh()
	self:RefreshJoinBtn()
end

return NewHeroTeamInfoCooperationView
