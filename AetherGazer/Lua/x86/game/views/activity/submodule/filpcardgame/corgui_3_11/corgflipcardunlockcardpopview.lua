local var_0_0 = class("CORGflipCardUnlockCardPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return XH3rdFlipCardTool:GetUnlockPopUI()
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

	arg_4_0.cardItemList_ = {}
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.activityID_ = XH3rdFlipCardData:GetActivityID()
	arg_5_0.cardList_ = XH3rdFlipCardData:GetNewCardList()

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.cardItemList_) do
		SetActive(iter_6_1.gameObject_, false)
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.cardList_) do
		if not arg_6_0.cardItemList_[iter_6_2] then
			local var_6_0 = Object.Instantiate(arg_6_0.cardItem_, arg_6_0.cardContent_)

			arg_6_0.cardItemList_[iter_6_2] = CORGFlipCardItem.New(var_6_0)
		end

		arg_6_0.cardItemList_[iter_6_2]:SetData(iter_6_2, iter_6_3)
		SetActive(arg_6_0.cardItemList_[iter_6_2].gameObject_, true)
	end

	arg_6_0.fromNumText_.text = #XH3rdFlipCardData:GetUnlockCardList()
	arg_6_0.toNumText_.text = #XH3rdFlipCardData:GetUnlockCardList() + #XH3rdFlipCardData:GetNewCardList()
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.backBtn_, nil, function()
		XH3rdFlipCardAction:sendViewCardRequest(arg_7_0.activityID_, arg_7_0.cardList_)
		arg_7_0:Back()
	end)
end

function var_0_0.Dispose(arg_9_0)
	if arg_9_0.cardItemList_ then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.cardItemList_) do
			iter_9_1:Dispose()
		end

		arg_9_0.cardItemList_ = nil
	end

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.OnExit(arg_10_0)
	return
end

return var_0_0
