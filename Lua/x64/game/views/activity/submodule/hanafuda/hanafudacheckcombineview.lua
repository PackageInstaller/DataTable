local var_0_0 = class("HanafudaCheckCombineView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionHanafudaUI/JapanRegionHanafudaCheckUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.uiList = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.uiListGo_, HanafudaCardView)
	arg_4_0.uiCombineList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexCombineItem), arg_4_0.combineList_, HanafudaCombineItem)
	arg_4_0.titleController_ = ControllerUtil.GetController(arg_4_0.transform_, "title")
	arg_4_0.stateController_ = ControllerUtil.GetController(arg_4_0.transform_, "changeBtn")
	arg_4_0.btnController_ = ControllerUtil.GetController(arg_4_0.changeBtn_.transform, "btn")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.changeBtn_, nil, function()
		if arg_5_0.state == 1 then
			arg_5_0.state = 2
		else
			arg_5_0.state = 1
		end

		arg_5_0:RefreshState()
	end)
end

function var_0_0.IndexCombineItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:SetData(arg_8_1, arg_8_0.cardCombineDataList_[arg_8_1], arg_8_0.playerType_)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.playerType_ = arg_9_0.params_.playerType
	arg_9_0.callback_ = arg_9_0.params_.callback
	arg_9_0.state = 1

	arg_9_0:RefreshState()

	if arg_9_0.playerType_ == HanafudaData.CARD_PLACE_TYPE.PLAYERCOMBINE then
		arg_9_0.titleController_:SetSelectedState("player")

		arg_9_0.scoreText_.text = HanafudaData:GetScoreByType(HanafudaData.CARD_PLACE_TYPE.PLAYER)
	else
		arg_9_0.titleController_:SetSelectedState("enemy")

		arg_9_0.scoreText_.text = HanafudaData:GetScoreByType(HanafudaData.CARD_PLACE_TYPE.ENEMY)
	end
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_1, arg_10_0.cardDataList_[arg_10_1])
end

function var_0_0.RefreshState(arg_11_0)
	if arg_11_0.state == 1 then
		arg_11_0.stateController_:SetSelectedState("list")
		arg_11_0.btnController_:SetSelectedState("combination")

		arg_11_0.cardDataList_ = HanafudaData:GetCardsListByType(arg_11_0.playerType_)

		arg_11_0.uiList:StartScroll(#arg_11_0.cardDataList_)
	elseif arg_11_0.state == 2 then
		arg_11_0.stateController_:SetSelectedState("combination")
		arg_11_0.btnController_:SetSelectedState("deck")

		arg_11_0.cardCombineDataList_ = HanafudaData:GetCombineList()

		arg_11_0.uiCombineList_:StartScroll(#arg_11_0.cardCombineDataList_)
	end
end

function var_0_0.OnExit(arg_12_0)
	if arg_12_0.callback_ then
		arg_12_0.callback_()
	end
end

function var_0_0.Dispose(arg_13_0)
	if arg_13_0.uiList then
		arg_13_0.uiList:Dispose()
	end

	if arg_13_0.uiCombineList_ then
		arg_13_0.uiCombineList_:Dispose()
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
