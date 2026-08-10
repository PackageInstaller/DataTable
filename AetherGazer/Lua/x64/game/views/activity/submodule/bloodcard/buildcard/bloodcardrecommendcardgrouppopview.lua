local var_0_0 = class("BloodCardRecommendCardGroupPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_BloodCardUI/BloodCardBuildSelectDeckUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.selectController_ = arg_3_0.controller_:GetController("select")
	arg_3_0.groupList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexCardGroup), arg_3_0.groupUIList_, BloodCardRecommendCardGroupItem)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		BloodCardData:SetRecommendCardSetID(arg_4_0.selectID_)
		arg_4_0:Back()
	end)
	arg_4_0:AddBtnListener(arg_4_0.bgBtn_, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.recommendCardGroupIDList_ = BloodCardGameRecommendCardSetCfg.all
	arg_7_0.selectTabIndex_ = arg_7_0.params_.selectTabIndex

	arg_7_0:SelectItem(BloodCardGameRecommendCardSetCfg.all[1])
	arg_7_0.groupList_:StartScroll(#arg_7_0.recommendCardGroupIDList_)
end

function var_0_0.IndexCardGroup(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:SetData(arg_8_0.recommendCardGroupIDList_[arg_8_1])
	arg_8_2:SetClickCallBack(function(arg_9_0)
		arg_8_0:SelectItem(arg_9_0)
	end)
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_BLOOD_CARD_GAME_RECOMMEND_RULE")
end

function var_0_0.SelectItem(arg_11_0, arg_11_1)
	arg_11_0.selectID_ = arg_11_1

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.groupList_:GetItemList()) do
		iter_11_1:RefreshSelect(arg_11_0.selectID_)
	end

	if arg_11_1 and arg_11_1 ~= 0 then
		arg_11_0.descText_.text = BloodCardGameRecommendCardSetCfg[arg_11_1].desc
	end

	arg_11_0.selectController_:SetSelectedState(tostring(arg_11_0.selectID_ ~= 0))
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.groupList_ then
		arg_12_0.groupList_:Dispose()
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
