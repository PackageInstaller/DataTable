local var_0_0 = class("ChallengeRogueTeamIllustratedSchoolItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.positionController_ = arg_1_0.controller_:GetController("position")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		JumpTools.OpenPageByJump("/challengeRogueTeamIllustratedTreasure", {
			id = arg_3_0.id_
		})
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.index_ = arg_5_1

	arg_5_0.positionController_:SetSelectedState(tostring(arg_5_1 % 2 == 1))

	arg_5_0.id_ = arg_5_2
	arg_5_0.itemTemp_ = arg_5_3
	arg_5_0.treasureList_ = ChallengeRogueTeamData:GetAllCampTreasureIDByCamp(arg_5_0.itemTemp_, arg_5_0.id_)
	arg_5_0.unlockTresureList_ = ChallengeRogueTeamData:GetUnlockIllustratedTreasureDataByCamp(ChallengeRogueTeamData:GetCacheTemplateID(), arg_5_0.id_)
	arg_5_0.progressText_.text = #arg_5_0.unlockTresureList_ .. "/" .. #arg_5_0.treasureList_
	arg_5_0.nameText_.text = GetTips("ROGUE_TEAM_SCHOOL_NAME_" .. arg_5_0.id_)
	arg_5_0.descText_.text = GetTips("ROGUE_TEAM_SCHOOL_DESCRIPTION_" .. arg_5_0.id_)
	arg_5_0.image_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.CAMP_BIG_ICON_PATH_LIST, ChallengeRogueTeamData:GetCacheTemplateID())[arg_5_0.index_])
end

return var_0_0
