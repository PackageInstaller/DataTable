local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("NewHeroTeamInfoCooperationView", var_0_0)

function var_0_1.ExtraSorter(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = arg_1_0:CheckInTeam(arg_1_1.id, arg_1_1.trialID)

	if var_1_0 ~= arg_1_0:CheckInTeam(arg_1_2.id, arg_1_2.trialID) then
		return true, var_1_0
	end

	if arg_1_1.trialID ~= 0 or arg_1_2.trialID ~= 0 then
		if arg_1_1.trialID ~= 0 and arg_1_2.trialID ~= 0 then
			if arg_1_3 == 0 and arg_1_1.star ~= arg_1_2.star then
				if arg_1_0.curOrder_ == "desc" then
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

function var_0_1.OnJoinClick(arg_2_0)
	local var_2_0 = arg_2_0.selectHeroData_.id
	local var_2_1 = 1

	if arg_2_0.selectHeroData_.trialID ~= 0 then
		var_2_0 = arg_2_0.selectHeroData_.trialID
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

function var_0_1.UpdateBar(arg_3_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_1.ProcessCustomParams(arg_4_0)
	arg_4_0.roomData_ = CooperationData:GetRoomData()
end

function var_0_1.RefreshHeroDataList(arg_5_0)
	local var_5_0, var_5_1 = CooperationTools.GetCooperationTeamHeroList(arg_5_0.roomData_.type, arg_5_0.roomData_.dest, arg_5_0.roomData_.activity_id)

	arg_5_0.allTrialIDList_ = var_5_1

	arg_5_0.heroViewProxy_:SetTempHeroList(arg_5_0.allTrialIDList_)
	arg_5_0.filterView_:SetHeroIdList(var_5_0)
end

function var_0_1.RefreshJoinBtn(arg_6_0)
	arg_6_0.joinBtn_.interactable = true

	if arg_6_0:CheckRepeatHero(arg_6_0.selectHeroData_.id, arg_6_0.selectHeroData_.trialID) then
		arg_6_0.joinBtn_.interactable = false

		arg_6_0.joinBtnController_:SetSelectedState("lock")
	else
		arg_6_0.joinBtn_.interactable = true

		arg_6_0.joinBtnController_:SetSelectedState("change")
	end
end

function var_0_1.CheckRepeatHero(arg_7_0, arg_7_1)
	return CooperationTools.CheckRepeatHero(arg_7_1)
end

function var_0_1.CheckInTeam(arg_8_0, arg_8_1, arg_8_2)
	return CooperationTools.CheckInTeam(arg_8_1, arg_8_2)
end

function var_0_1.OnCooperationRoomInit(arg_9_0)
	arg_9_0.heroHeadList_:Refresh()
	arg_9_0:RefreshJoinBtn()
end

function var_0_1.OnCooperationRoomUpdate(arg_10_0)
	arg_10_0.heroHeadList_:Refresh()
	arg_10_0:RefreshJoinBtn()
end

return var_0_1
