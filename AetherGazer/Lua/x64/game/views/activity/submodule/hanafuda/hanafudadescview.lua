local var_0_0 = class("HanafudaDescView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionHanafudaUI/JapanRegionHanafudaScorePopUI"
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

	arg_4_0.pageController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "page")
	arg_4_0.rulePageController_ = ControllerUtil.GetController(arg_4_0.ruleTrs_, "description")
	arg_4_0.uiList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.combineList_, HanafudaCombineItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.ruleBtn_, nil, function()
		arg_5_0.pageController_:SetSelectedState("1")
	end)
	arg_5_0:AddBtnListener(arg_5_0.combineBtn_, nil, function()
		arg_5_0.pageController_:SetSelectedState("2")
		arg_5_0.uiList_:StartScroll(#arg_5_0.combineCfgList_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.nextBtn_, nil, function()
		if arg_5_0.descIndex == 4 then
			return
		end

		arg_5_0.descIndex = arg_5_0.descIndex + 1

		arg_5_0:RefreshDesc()
	end)
	arg_5_0:AddBtnListener(arg_5_0.forwardBtn_, nil, function()
		if arg_5_0.descIndex == 1 then
			return
		end

		arg_5_0.descIndex = arg_5_0.descIndex - 1

		arg_5_0:RefreshDesc()
	end)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.callback_ = arg_11_0.params_.callback
	arg_11_0.combineCfgList_ = HanafudaData:GetCombineList()
	arg_11_0.descIndex = 1

	arg_11_0:RefreshDesc()
	arg_11_0:RefreshLiner()
end

function var_0_0.RefreshDesc(arg_12_0)
	SetActive(arg_12_0.forwardBtn_.gameObject, arg_12_0.descIndex ~= 1)
	SetActive(arg_12_0.nextBtn_.gameObject, arg_12_0.descIndex ~= 4)
	arg_12_0.rulePageController_:SetSelectedState(arg_12_0.descIndex)
	arg_12_0.selectItem_.transform:SetSiblingIndex(arg_12_0.descIndex - 1)
end

function var_0_0.IndexItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:SetData(arg_13_1, arg_13_0.combineCfgList_[arg_13_1])
end

function var_0_0.RefreshLiner(arg_14_0)
	arg_14_0:SetBarPosition(0)

	local var_14_0 = arg_14_0.sliderBg_.transform.childCount
	local var_14_1 = 4
	local var_14_2 = var_14_1 < var_14_0 and var_14_0 or var_14_1

	for iter_14_0 = 1, var_14_2 do
		if iter_14_0 <= var_14_0 then
			local var_14_3 = arg_14_0.sliderBg_.transform:GetChild(iter_14_0 - 1)

			if iter_14_0 <= var_14_1 then
				SetActive(var_14_3.gameObject, true)
			else
				SetActive(var_14_3.gameObject, false)
			end
		else
			local var_14_4 = Object.Instantiate(arg_14_0.barTemp_, arg_14_0.sliderBg_.transform)

			SetActive(var_14_4, true)
		end
	end
end

function var_0_0.SetBarPosition(arg_15_0, arg_15_1)
	arg_15_0.selectItem_.transform:SetSiblingIndex(arg_15_1)
end

function var_0_0.OnExit(arg_16_0)
	if arg_16_0.callback_ then
		arg_16_0.callback_()
	end
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.uiList_ then
		arg_17_0.uiList_:Dispose()

		arg_17_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
