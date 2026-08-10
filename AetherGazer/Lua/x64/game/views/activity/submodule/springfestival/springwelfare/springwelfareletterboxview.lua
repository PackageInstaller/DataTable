local var_0_0 = class("SpringWelfareLetterBoxView", ReduxView)
local var_0_1 = {
	PLAYER = 1,
	SYSTEM = 0
}

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeMailUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.page_ = var_0_1.SYSTEM
	arg_3_0.pageController_ = ControllerUtil.GetController(arg_3_0.transform_, "tap")
	arg_3_0.letterUiList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.letterListGo_, SpringWelfareLetterBoxItem)

	arg_3_0:UpdateLetterList()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.OnTop(arg_6_0)
	SetActive(arg_6_0.gameObject_, true)
end

function var_0_0.OnBehind(arg_7_0)
	SetActive(arg_7_0.gameObject_, false)
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.letterUiList_:Dispose()
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.maskBtn_, nil, function()
		arg_9_0:Back()
	end)
	arg_9_0:AddBtnListener(arg_9_0.systemBtn_, nil, function()
		arg_9_0:SwitchPage(var_0_1.SYSTEM)
	end)
	arg_9_0:AddBtnListener(arg_9_0.playerBtn_, nil, function()
		arg_9_0:SwitchPage(var_0_1.PLAYER)
	end)
end

function var_0_0.RefreshUI(arg_13_0)
	if arg_13_0.page_ == var_0_1.SYSTEM then
		arg_13_0:RefreshSystemLetterUI()
	elseif arg_13_0.page_ == var_0_1.PLAYER then
		arg_13_0:RefreshPlayerLetterUI()
	end

	arg_13_0.letterUiList_:Refresh()
end

function var_0_0.RefreshSystemLetterUI(arg_14_0)
	arg_14_0.letterUiList_:StartScroll(#arg_14_0.systemLetterIdList_)
	arg_14_0.pageController_:SetSelectedState("system")
end

function var_0_0.RefreshPlayerLetterUI(arg_15_0)
	if SpringWelfareData:IsFetched() then
		arg_15_0.letterUiList_:StartScroll(#arg_15_0.playerLetterIdList_)
	else
		arg_15_0.letterUiList_:StartScroll(0)
	end

	arg_15_0.pageController_:SetSelectedState("player")
end

function var_0_0.OnLetterPlayerInfoFetched(arg_16_0)
	arg_16_0:RefreshPlayerLetterUI()
end

function var_0_0.SwitchPage(arg_17_0, arg_17_1)
	if arg_17_0.page_ == arg_17_1 then
		return
	end

	arg_17_0.page_ = arg_17_1

	arg_17_0:RefreshUI()
end

function var_0_0.UpdateLetterList(arg_18_0)
	arg_18_0.systemLetterIdList_ = SpringWelfareData:GetSystemLetterIdList()
	arg_18_0.playerLetterIdList_ = SpringWelfareData:GetPlayerLetterIdList()
end

function var_0_0.IndexSystemLetter(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.systemLetterIdList_[arg_19_1]

	arg_19_2:SetLetterServerId(var_19_0)
	arg_19_2:RefreshUI()
end

function var_0_0.IndexPlayerLetter(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0.playerLetterIdList_[arg_20_1]

	arg_20_2:SetLetterServerId(var_20_0)
	arg_20_2:RefreshUI()
end

function var_0_0.IndexItem(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0.page_ == var_0_1.SYSTEM then
		arg_21_0:IndexSystemLetter(arg_21_1, arg_21_2)
	elseif arg_21_0.page_ == var_0_1.PLAYER then
		arg_21_0:IndexPlayerLetter(arg_21_1, arg_21_2)
	end
end

function var_0_0.OnNewDay(arg_22_0)
	arg_22_0:UpdateLetterList()
	arg_22_0:RefreshUI()
end

function var_0_0.OnActivitySpringWelfareInit(arg_23_0)
	arg_23_0:OnNewDay()
end

function var_0_0.OnFriendsListChange(arg_24_0)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0.letterUiList_:GetItemList()) do
		iter_24_1:OnFriendsListChange()
	end
end

function var_0_0.GetActivityID(arg_25_0)
	return arg_25_0.params_.activityId
end

return var_0_0
