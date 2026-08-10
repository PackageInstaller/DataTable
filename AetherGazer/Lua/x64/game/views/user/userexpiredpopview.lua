local var_0_0 = class("HeadIconChangeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/UserInfor/UserInfoExpiredUI"
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

	arg_4_0.expiredItemList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.expiredListGo2_, CommonItemView)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.okBtn2_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = clone(ItemTemplateData)
	local var_7_1 = arg_7_0.expiredList_[arg_7_1]

	var_7_0.id = var_7_1.id
	var_7_0.number = var_7_1.num

	arg_7_2:SetData(var_7_0)
end

function var_0_0.OnEnter(arg_8_0)
	PlayerData:DealOverdueFrame()
	PlayerData:DealOverduePortrait()
	PlayerData:DealOverdueChatBubble()
	PlayerData:DealOverdueCardBgList()

	arg_8_0.expiredList_ = arg_8_0.params_.expiredList

	arg_8_0.expiredItemList_:StartScroll(#arg_8_0.expiredList_)

	arg_8_0.descText1_.text = GetTips("DECORATE_ITEM_DUE_TIPS")
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.expiredItemList_ then
		arg_10_0.expiredItemList_:Dispose()
	end

	arg_10_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
