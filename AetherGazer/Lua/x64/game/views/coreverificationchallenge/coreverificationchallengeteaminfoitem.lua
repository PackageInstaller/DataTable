local var_0_0 = class("CoreVerificationChallengeTeamInfoItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()

	arg_1_0.heroHeadItem_ = {}
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.tabController_ = arg_3_0.controller:GetController("state01")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.mainBtn_, nil, function()
		return
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.heroId = arg_6_1
	arg_6_0.icon.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. arg_6_1)
	arg_6_0.name.text = GetI18NText(HeroCfg[arg_6_1].name)
	arg_6_0.type.text = CharactorParamCfg[arg_6_0.heroId].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")

	arg_6_0.tabController_:SetSelectedIndex(arg_6_2 == 1 and 0 or 1)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
