local var_0_0 = class("ChallengeRogueTeamBagTreasureItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.selectController_ = arg_1_0.controller_:GetController("select")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		if arg_2_0.callback_ then
			arg_2_0.callback_(arg_2_0.index_)
		end
	end)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.index_ = arg_5_1
	arg_5_0.campId_ = arg_5_2

	if arg_5_0.campId_ ~= 0 then
		arg_5_0.campSkillID_ = ChallengeRogueTeamData:GetCampUltimateByCamp(RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].item_temp, arg_5_0.campId_)
		arg_5_0.icon_.sprite = getSprite("Atlas/Activity_RoulikeAtlas", ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.CAMP_ICON_PATH_LIST, ChallengeRogueTeamData:GetCacheTemplateID())[arg_5_0.index_ - 1])
		arg_5_0.iconSelect_.sprite = getSprite("Atlas/Activity_RoulikeAtlas", ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.CAMP_ICON_PATH_LIST, ChallengeRogueTeamData:GetCacheTemplateID())[arg_5_0.index_ - 1])
	end

	if arg_5_2 == 0 then
		arg_5_0.num_.text = #ChallengeRogueTeamData:TreasureGetList()
	else
		arg_5_0.num_.text = #ChallengeRogueTeamData:TreasureGetListByCampList({
			arg_5_2
		})
	end

	arg_5_0:RefreshSelect(arg_5_3)
end

function var_0_0.SetCallBack(arg_6_0, arg_6_1)
	arg_6_0.callback_ = arg_6_1
end

function var_0_0.RefreshSelect(arg_7_0, arg_7_1)
	arg_7_0.selectController_:SetSelectedState(tostring(arg_7_0.index_ == arg_7_1))
end

return var_0_0
