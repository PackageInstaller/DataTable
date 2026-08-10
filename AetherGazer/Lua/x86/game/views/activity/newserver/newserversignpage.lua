local var_0_0 = class("NewServerSignPage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/System/NewServer/NewServerSigninUI")
	local var_1_1 = Object.Instantiate(var_1_0, arg_1_1)

	arg_1_0.gameObject_ = var_1_1
	arg_1_0.transform_ = var_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.itemList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uiListGo_, NewServerSignItem)
end

function var_0_0.UpdateBar(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.SetActive(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.activityID_ = arg_6_1
	arg_6_0.index_ = NewServerData:GetSignIndex()
	arg_6_0.rewards_ = NewServerCfg[arg_6_0.activityID_] and NewServerCfg[arg_6_0.activityID_].sign_reward or {}

	arg_6_0.itemList_:StartScroll(#arg_6_0.rewards_)
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.rewards_[arg_7_1]

	arg_7_2:SetData(arg_7_1, var_7_0)
	arg_7_2:RegistCallBack(handler(arg_7_0, arg_7_0.OnItemClick))
end

function var_0_0.OnItemClick(arg_8_0, arg_8_1)
	if not ActivityTools.ActivityOpenCheck(arg_8_0.activityID_) then
		return
	end

	NewServerAction.QuerySign(arg_8_1)
end

function var_0_0.Dispose(arg_9_0)
	if arg_9_0.itemList_ then
		arg_9_0.itemList_:Dispose()

		arg_9_0.itemList_ = nil
	end

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.RefreshTime(arg_10_0)
	if arg_10_0.index_ ~= NewServerData:GetSignIndex() then
		local var_10_0 = arg_10_0.itemList_:GetItemList()

		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			iter_10_1:Refresh()
		end
	end
end

function var_0_0.OnNewServerSign(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.itemList_:GetItemList()

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if iter_11_1.index_ == arg_11_1 then
			iter_11_1:OnSign()
		end
	end
end

return var_0_0
