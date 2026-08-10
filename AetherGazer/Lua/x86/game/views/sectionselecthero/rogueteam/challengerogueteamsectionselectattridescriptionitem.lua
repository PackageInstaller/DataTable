local var_0_0 = class("ChallengeRogueTeamSectionSelectAttriDescriptionItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.activeController_ = arg_3_0.controller_:GetController("bg")
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.attriID_ = arg_4_2
	arg_4_0.attriIcon_.sprite = HeroTools.GetSkillAttributeIcon(arg_4_0.attriID_)

	local var_4_0 = ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.TEAM_ATTRIBUTE_BUFF_LIST, ChallengeRogueTeamData:GetCacheTemplateID())[arg_4_1]
	local var_4_1 = AffixTypeCfg[var_4_0].description[1]
	local var_4_2 = GetCfgDescription(var_4_1, arg_4_3, 1, 3, true, true)

	arg_4_0.desc_.text = var_4_2

	if arg_4_3 and arg_4_3 ~= 0 then
		arg_4_0.activeController_:SetSelectedState("on")
	else
		arg_4_0.activeController_:SetSelectedState("off")
	end

	arg_4_0.attriName_.text = GetTips(HeroConst.HERO_ATTACK_TYPE_STR[arg_4_2])
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
	Object.Destroy(arg_5_0.gameObject_)

	arg_5_0.transform_ = nil
	arg_5_0.gameObject_ = nil
end

return var_0_0
