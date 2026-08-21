local var_0_0 = class("AutoChessShowCardListPop", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_AutoChess_Main/Unpack/Activity_Unpack_ObtainPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.onelist_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.oneUIList_, AutoChessCardItem)
	arg_4_0.moreList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.moreUIList_, AutoChessCardItem)
	arg_4_0.URFactoryItem_ = AutoChessURFactoryItem.New(arg_4_0.URItemGo_)
	arg_4_0.switchController_ = arg_4_0.controller_:GetController("switch")
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = 0

	if arg_5_0.mode_ == AutoChessCardConst.OPEN_CARD_MODE_MULTI then
		var_5_0 = arg_5_0.mergeCardList_[arg_5_1]

		arg_5_2:SetData(var_5_0, arg_5_0.URFactoryItem_:GetItem(var_5_0))

		local var_5_1 = arg_5_0.mergeCardNumList_[arg_5_0.mergeCardList_[arg_5_1]]

		if var_5_1 > 1 then
			arg_5_2:SetCollapseState(true, var_5_1)
		else
			arg_5_2:SetCollapseState(false)
		end
	else
		var_5_0 = arg_5_0.cardList[arg_5_1]

		arg_5_2:SetData(var_5_0, arg_5_0.URFactoryItem_:GetItem(var_5_0))
		arg_5_2:SetCollapseState(false)
	end

	local var_5_2 = arg_5_0.mergeCardNumList_[var_5_0]

	if AutoChessCardData:GetCardNum(var_5_0) - var_5_2 > 0 then
		arg_5_2:SetNewTagState(false)
	else
		arg_5_2:SetNewTagState(true)
	end
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		if arg_6_0.mode_ == AutoChessCardConst.MIX_CARD_TYPE then
			arg_6_0:Back()
		else
			JumpTools.OpenPageByJump("/autoChessOpenCardMainView")
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.shareBtn_, nil, function()
		manager.share:Share(function()
			SetActive(arg_6_0.shareBtn_, false)
			SetActive(arg_6_0.tipsGo_, false)
		end, function()
			SetActive(arg_6_0.shareBtn_, true)
			SetActive(arg_6_0.tipsGo_, true)
		end)
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_gacha_share",
			activity_id = AutoChessData:GetActivityID(),
			item_list = string.format("[%s]", table.concat(arg_6_0.cardList, ","))
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.closeBtn_, nil, function()
		if arg_6_0.mode_ == AutoChessCardConst.MIX_CARD_TYPE then
			arg_6_0:Back()
		else
			JumpTools.OpenPageByJump("/autoChessOpenCardMainView")
		end
	end)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.cardList = arg_12_0.params_.cardList
	arg_12_0.mode_ = arg_12_0.params_.mode

	table.sort(arg_12_0.cardList, function(arg_13_0, arg_13_1)
		local var_13_0 = AutoChessCardCfg[arg_13_0]
		local var_13_1 = AutoChessCardCfg[arg_13_1]

		if var_13_0.type == var_13_1.type then
			return arg_13_1 < arg_13_0
		end

		return var_13_0.type > var_13_1.type
	end)

	if arg_12_0.mode_ == AutoChessCardConst.OPEN_CARD_MODE_SINGLE then
		arg_12_0.switchController_:SetSelectedIndex(0)
		arg_12_0:MergeCard()
		arg_12_0.onelist_:StartScroll(#arg_12_0.cardList)
	elseif arg_12_0.mode_ == AutoChessCardConst.MIX_CARD_TYPE then
		arg_12_0.switchController_:SetSelectedIndex(0)
		arg_12_0:MergeCard()
		arg_12_0.onelist_:StartScroll(#arg_12_0.cardList)
	else
		arg_12_0.switchController_:SetSelectedIndex(1)
		arg_12_0:MergeCard()
		arg_12_0.moreList_:StartScroll(#arg_12_0.mergeCardList_)
	end
end

function var_0_0.MergeCard(arg_14_0)
	arg_14_0.mergeCardList_ = {}
	arg_14_0.mergeCardNumList_ = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.cardList) do
		if table.indexof(arg_14_0.mergeCardList_, iter_14_1) then
			arg_14_0.mergeCardNumList_[iter_14_1] = arg_14_0.mergeCardNumList_[iter_14_1] + 1
		else
			table.insert(arg_14_0.mergeCardList_, iter_14_1)

			arg_14_0.mergeCardNumList_[iter_14_1] = 1
		end
	end
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.onelist_ then
		arg_15_0.onelist_:Dispose()

		arg_15_0.onelist_ = nil
	end

	if arg_15_0.moreList_ then
		arg_15_0.moreList_:Dispose()

		arg_15_0.moreList_ = nil
	end

	arg_15_0.URFactoryItem_:Dispose()
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
