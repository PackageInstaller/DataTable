local var_0_0 = class("FishingIllustratedView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Fishing/FishingIllustratedUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0.PrefabList_ = {
		"UI/Fishing/Pages/FishingIllustratedPageUI",
		"UI/Fishing/Pages/FishingGroupPageUI"
	}
	arg_4_0.Classes_ = {
		FishingIllustratedPageView,
		FishingGroupPageView
	}
	arg_4_0.pages_ = {}

	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.toggles_ = {
		arg_5_0.toggle1_,
		arg_5_0.toggle2_
	}
end

function var_0_0.AddUIListener(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.toggles_) do
		arg_6_0:AddToggleListener(iter_6_1, function(arg_7_0)
			if arg_7_0 then
				arg_6_0:SwitchToPage(iter_6_0)
			end
		end)
	end

	arg_6_0:AddBtnListener(arg_6_0.closeBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.AddEventListeners(arg_10_0)
	return
end

function var_0_0.OnTop(arg_11_0)
	arg_11_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_12_0)
	return
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.enteredPage_ = {}

	arg_13_0:AddEventListeners()

	for iter_13_0, iter_13_1 in pairs(arg_13_0.pages_) do
		arg_13_0:CheckPageEnter(iter_13_0)
	end

	arg_13_0:SwitchToPage(arg_13_0.params_.page or 1)
	manager.redPoint:bindUIandKey(arg_13_0.groupRedPointContainer_, RedPointConst.FISHING_GROUP_REWARD, {
		x = 0,
		y = 0
	})
end

function var_0_0.CheckPageEnter(arg_14_0, arg_14_1)
	if not arg_14_0.enteredPage_[arg_14_1] then
		arg_14_0.pages_[arg_14_1]:OnEnter()

		arg_14_0.enteredPage_[arg_14_1] = true
	end
end

function var_0_0.OnExit(arg_15_0)
	manager.redPoint:unbindUIandKey(arg_15_0.groupRedPointContainer_, RedPointConst.FISHING_GROUP_REWARD)
	arg_15_0:RemoveAllEventListener()
end

function var_0_0.SwitchToPage(arg_16_0, arg_16_1)
	if arg_16_1 == arg_16_0.curPageIndex_ then
		return
	end

	if arg_16_0.pages_[arg_16_0.curPageIndex_] then
		SetActive(arg_16_0.pages_[arg_16_0.curPageIndex_].gameObject_, false)
	end

	arg_16_0.curPageIndex_ = arg_16_1

	if not arg_16_0.pages_[arg_16_1] then
		local var_16_0 = Object.Instantiate(Asset.Load(arg_16_0.PrefabList_[arg_16_1]), arg_16_0.container_)

		arg_16_0.pages_[arg_16_1] = arg_16_0.Classes_[arg_16_1].New(var_16_0)

		arg_16_0:CheckPageEnter(arg_16_1)
	else
		SetActive(arg_16_0.pages_[arg_16_1].gameObject_, true)
	end

	arg_16_0.toggles_[arg_16_1].isOn = true
end

function var_0_0.OnMainHomeViewTop(arg_17_0)
	return
end

function var_0_0.Dispose(arg_18_0)
	if arg_18_0.pages_ then
		for iter_18_0, iter_18_1 in pairs(arg_18_0.pages_) do
			iter_18_1:Dispose()
		end

		arg_18_0.pages_ = nil
	end

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
