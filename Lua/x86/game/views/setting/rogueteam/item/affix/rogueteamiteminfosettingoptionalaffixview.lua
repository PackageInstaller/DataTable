local var_0_0 = class("RogueTeamItemInfoSettingOptionalAffixView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.affixList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexAffixItem), arg_1_0.affixListGo_, ChallengeRogueTeamBagOptionalAffixItem)
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0.affixList_:Dispose()

	arg_2_0.affixList_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.IndexAffixItem(arg_3_0, arg_3_1, arg_3_2)
	arg_3_2:SetData(arg_3_1, arg_3_0.affixDataList_[arg_3_1])
end

function var_0_0.RefreshUI(arg_4_0)
	arg_4_0.levelNum_, arg_4_0.affixDataList_ = ChallengeRogueTeamData:GetOptionalAffix()
	arg_4_0.numText_.text = arg_4_0.levelNum_

	arg_4_0.affixList_:StartScroll(#arg_4_0.affixDataList_)
end

return var_0_0
