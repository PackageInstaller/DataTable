local var_0_0 = class("FishingGivePageView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.friendInfoOfFriendId_ = {}

	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.uilistGo_, FishingGiveItemView)
end

function var_0_0.indexItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.friendRequestDataList_[arg_4_1].friendId

	if not arg_4_0.friendInfoOfFriendId_[var_4_0] then
		arg_4_0.friendInfoOfFriendId_[var_4_0] = FriendsData:GetInfoByID(var_4_0)
	end

	arg_4_2:SetData(arg_4_0.friendRequestDataList_[arg_4_1], arg_4_0.friendInfoOfFriendId_[var_4_0])
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.AddEventListeners(arg_6_0)
	arg_6_0:RegistEventListener(FRIENDS_REQUEST_FISH_INFO_CHANGE, function()
		arg_6_0.friendRequestDataList_ = FishingData:GetFriendRequestFishInfo()

		arg_6_0:UpdateView()
	end)
end

function var_0_0.OnTop(arg_8_0)
	arg_8_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_9_0)
	return
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.uiList_:StartScroll(0)
	arg_10_0:AddEventListeners()
	FishingAction.GetFriendNeedFish(ActivityConst.SUMMER_FISHING)
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0:RemoveAllEventListener()
end

function var_0_0.UpdateView(arg_12_0)
	arg_12_0.uiList_:StartScroll(#arg_12_0.friendRequestDataList_)
end

function var_0_0.OnMainHomeViewTop(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.uiList_ then
		arg_14_0.uiList_:Dispose()

		arg_14_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
