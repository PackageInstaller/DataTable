local var_0_0 = class("RogueTeamItemInfoSetttingTreasureView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.treasureUIList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.uiList_, RogueTeamItemInfoSettingTreasureItem)
	arg_1_0.suitSkillController_ = arg_1_0.suitSkillControllerEx_:GetController("empty")
	arg_1_0.treasureDataList_ = ChallengeRogueTeamTools.TreasureSort(ChallengeRogueTeamData:TreasureGetList())
	arg_1_0.activeSuitSkillID_ = ChallengeRogueTeamData:SuitSkillGetID()
	arg_1_0.suitSkillView_ = RogueTeamItemInfoSettingSuitSkillItem.New(arg_1_0.suitSkillGo_)

	arg_1_0:RefreshSuitSkillUI()
	arg_1_0.treasureUIList_:StartScroll(#arg_1_0.treasureDataList_)
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0.treasureUIList_:Dispose()

	arg_2_0.treasureUIList_ = nil

	arg_2_0.suitSkillView_:Dispose()

	arg_2_0.suitSkillView_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.RefreshUI(arg_4_0)
	return
end

function var_0_0.RefreshSuitSkillUI(arg_5_0)
	if arg_5_0.activeSuitSkillID_ == 0 then
		arg_5_0.suitSkillController_:SetSelectedState("true")
	else
		arg_5_0.suitSkillController_:SetSelectedState("false")
		arg_5_0.suitSkillView_:SetData(ChallengeRogueTeamTools.GetItemIDByCampID(arg_5_0.activeSuitSkillID_))
	end
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_0.treasureDataList_[arg_6_1])
end

return var_0_0
