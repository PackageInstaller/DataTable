local var_0_0 = class("ChallengeRogueTeamSuitSkillTabItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.index_ = arg_1_3
	arg_1_0.selectController_ = arg_1_0.controller_:GetController("select")
	arg_1_0.isSuitSkillController_ = arg_1_0.controller_:GetController("isSuitSkillIcon")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_DISCARD_SUIT_SKILL, arg_3_0.index_)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.campId_ = arg_5_1

	if arg_5_1 == 0 then
		arg_5_0.num_.text = #ChallengeRogueTeamData:TreasureGetList()

		arg_5_0.isSuitSkillController_:SetSelectedState("true")
	else
		arg_5_0.num_.text = #ChallengeRogueTeamData:TreasureGetListByCampList({
			arg_5_1
		})

		arg_5_0.isSuitSkillController_:SetSelectedState("false")

		arg_5_0.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetCampIcon(arg_5_1))
	end

	arg_5_0:Show(true)
end

function var_0_0.RefreshSelect(arg_6_0, arg_6_1)
	arg_6_0.selectController_:SetSelectedState(tostring(arg_6_0.campId_ == arg_6_1))
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

return var_0_0
