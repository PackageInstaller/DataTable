local var_0_0 = class("ChallengeRogueTeamOverStatisticsNewRelicView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.unlockRelicList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.uiUnlockList_, ChallengeRogueTeamOverStatisticsRelicItem)

	arg_1_0:RefreshUI()
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0.unlockRelicList_:Dispose()

	arg_2_0.unlockRelicList_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.RefreshUI(arg_4_0)
	arg_4_0.unlockRelicDataList_ = ChallengeRogueTeamData:GetOverStaticUnlockRelicDataList()

	if arg_4_0.unlockRelicDataList_ and not table.isEmpty(arg_4_0.unlockRelicDataList_) then
		arg_4_0.unlockRelicList_:StartScroll(#arg_4_0.unlockRelicDataList_)
	end
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.unlockRelicDataList_[arg_5_1])
end

return var_0_0
