local var_0_0 = class("RogueTeamItemInfoSetttingRelicView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.relicUIList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.uiList_, RogueTeamItemInfoSettingRelicItem)
	arg_1_0.relicDataList_ = ChallengeRogueTeamData:EffectItemGetDataList(ChallengeRogueTeamConst.ITEM_TYPE.RELIC)

	arg_1_0.relicUIList_:StartScroll(#arg_1_0.relicDataList_)
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0.relicUIList_:Dispose()

	arg_2_0.relicUIList_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.RefreshUI(arg_4_0)
	return
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.relicDataList_[arg_5_1].id

	arg_5_2:SetData(var_5_0)
end

return var_0_0
