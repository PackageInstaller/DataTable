local var_0_0 = class("ChallengeRogueTeamBagBuffView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.buffList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.buffUIList_, ChallengeRogueTeamBagBuffItem)
	arg_2_0.progressBar_ = arg_2_0.sliderBarGo_:GetComponent("SplineProgressBar")
	arg_2_0.animator_.enabled = false
end

function var_0_0.RefreshUI(arg_3_0)
	local var_3_0 = ChallengeRogueTeamData:UIGetMechanismValue()
	local var_3_1 = ChallengeRogueTeamTools.GetMaxMechanismValue()

	if var_3_1 < var_3_0 then
		var_3_0 = var_3_1
	end

	local var_3_2 = var_3_0 / var_3_1

	arg_3_0.progressBar_:SetValue(var_3_2)
	arg_3_0:PlayEffectAnimator(var_3_2)

	arg_3_0.buffDescText_.text = GetTips("CHALLENGE_ROGUE_TEAM_BUFF_DESC_" .. ChallengeRogueTeamData:GetCacheTemplateID())
	arg_3_0.progressValueText_.text = var_3_0 .. "/" .. var_3_1
	arg_3_0.buffDataList_ = ChallengeRogueTeamData:EffectItemGetDataList(ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM)

	arg_3_0.buffList_:StartScroll(#arg_3_0.buffDataList_)
end

function var_0_0.PlayEffectAnimator(arg_4_0, arg_4_1)
	local var_4_0 = GameSetting.rogue_team_mechanism_offset_value.value[1]

	arg_4_1 = (var_4_0 + (100 - var_4_0) * arg_4_1) / 100

	arg_4_0.animator_:Play("Schedule", 0, arg_4_1)
	arg_4_0.animator_:Update(arg_4_1)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, arg_5_0.buffDataList_[arg_5_1])
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.progressBar_ = nil

	var_0_0.super.Dispose(arg_6_0)

	if arg_6_0.buffList_ then
		arg_6_0.buffList_:Dispose()

		arg_6_0.buffList_ = nil
	end
end

function var_0_0.AddListeners(arg_7_0)
	return
end

return var_0_0
