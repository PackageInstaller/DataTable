local var_0_0 = class("SwimsuitBattleResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_SwimsuitUI/SummerUI_3_4_SwimsuitResultUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.voteData_ = {}
	arg_4_0.round_ = 0
	arg_4_0.resultController_ = arg_4_0.mainControllerEx_:GetController("result")
	arg_4_0.winerUIList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexTabItem), arg_4_0.startUIList_, SwimsuitBattleResultItem)
end

function var_0_0.IndexTabItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.voteData_[arg_5_1].ID)
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.retBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.round_ = SwimsuitBattleData:GetCurVoteRound()

	if arg_8_0.round_ == 5 then
		arg_8_0.voteData_ = SwimsuitBattleData:GetWinerListByRound(4)

		arg_8_0.resultController_:SetSelectedState("result")
		arg_8_0.winerUIList_:StartScroll(0)

		arg_8_0.win1Img_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. SwimsuitVoteHeroCfg[arg_8_0.voteData_[1].ID].show_image)
		arg_8_0.win2Img_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. SwimsuitVoteHeroCfg[arg_8_0.voteData_[2].ID].show_image)
		arg_8_0.win3Img_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. SwimsuitVoteHeroCfg[arg_8_0.voteData_[3].ID].show_image)
	else
		arg_8_0.voteData_ = SwimsuitBattleData:GetSortVoteContestantsData(arg_8_0.round_)

		arg_8_0.resultController_:SetSelectedState("start")
		arg_8_0.winerUIList_:StartScroll(#arg_8_0.voteData_)
	end
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()

	if arg_10_0.winerUIList_ then
		arg_10_0.winerUIList_:Dispose()

		arg_10_0.winerUIList_ = nil
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
