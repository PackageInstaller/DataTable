local var_0_0 = class("ChallengeRogueTeamBagOptionalAffixView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.affixList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexAffixItem), arg_2_0.affixListGo_, ChallengeRogueTeamBagOptionalAffixItem)
end

function var_0_0.OnEnter(arg_3_0, arg_3_1)
	return
end

function var_0_0.IndexAffixItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_1, arg_4_0.affixDataList_[arg_4_1])
end

function var_0_0.RefreshUI(arg_5_0)
	arg_5_0.levelNum_, arg_5_0.affixDataList_ = ChallengeRogueTeamData:GetOptionalAffix()
	arg_5_0.numText_.text = arg_5_0.levelNum_

	arg_5_0.affixList_:StartScroll(#arg_5_0.affixDataList_)
end

function var_0_0.OnExit(arg_6_0)
	return
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)

	if arg_7_0.affixList_ then
		arg_7_0.affixList_:Dispose()

		arg_7_0.affixList_ = nil
	end
end

return var_0_0
