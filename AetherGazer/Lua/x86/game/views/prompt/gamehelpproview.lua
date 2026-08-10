local var_0_0 = class("GameHelpProView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Common/Pop/UIfunctionpopup04"
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

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.m_list, GameHelpProItem)
	arg_4_0.dotList_ = LuaList.New(handler(arg_4_0, arg_4_0.DotIndexItem), arg_4_0.m_dotList, GameHelpProDotItem)
	arg_4_0.hideBgController_ = arg_4_0.m_controller:GetController("hideBg")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0.list_:SetPageChangeHandler(handler(arg_5_0, arg_5_0.OnPageChange))
	arg_5_0:AddBtnListener(arg_5_0.m_preBtn, nil, function()
		arg_5_0.list_:SwitchToPage(arg_5_0.pageIndex_ - 1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_nextBtn, nil, function()
		arg_5_0.list_:SwitchToPage(arg_5_0.pageIndex_ + 1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_closeBtn, nil, function()
		if arg_5_0.exitCallback then
			arg_5_0.exitCallback()
		end

		arg_5_0:Back()
	end)
end

function var_0_0.OnPageChange(arg_9_0, arg_9_1)
	arg_9_0.pageIndex_ = arg_9_1

	SetActive(arg_9_0.m_preBtn.gameObject, arg_9_1 > 1)
	SetActive(arg_9_0.m_nextBtn.gameObject, arg_9_1 < #arg_9_0.pages)
	arg_9_0.dotList_:ScrollToIndex(arg_9_1)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.noCache = arg_10_0.params_.noCache or false
	arg_10_0.pages = arg_10_0.params_.pages or {}
	arg_10_0.isPrefab_ = arg_10_0.params_.isPrefab or false
	arg_10_0.hideBg_ = arg_10_0.params_.hideBg or false
	arg_10_0.hideHomeBtn = arg_10_0.params_.hideHomeBtn or nil
	arg_10_0.exitCallback = arg_10_0.params_.exitCallback or nil

	local var_10_0 = arg_10_0.params_.startIndex or 1

	arg_10_0.list_:StartScroll(#arg_10_0.pages, var_10_0, true, false)
	arg_10_0.dotList_:StartScroll(#arg_10_0.pages, var_10_0, true, false)
	arg_10_0:OnPageChange(var_10_0)
	arg_10_0.hideBgController_:SetSelectedState(tostring(arg_10_0.hideBg_))

	arg_10_0.params_.startIndex = nil
	arg_10_0.onExitHandle_ = arg_10_0.params_.exitHandle
end

function var_0_0.indexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.pages[arg_11_1]
	local var_11_1 = #arg_11_0.pages

	arg_11_2:SetData(arg_11_1, var_11_0, arg_11_0.isPrefab_)
end

function var_0_0.DotIndexItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:SetData(arg_12_0.pageIndex_ == arg_12_1)
end

function var_0_0.OnExit(arg_13_0)
	local var_13_0 = arg_13_0:GetStayTime()

	OperationRecorder.RecordStayView("STAY_VIEW_GAME_HELP", var_13_0, 50103)

	local var_13_1 = arg_13_0.onExitHandle_

	arg_13_0.onExitHandle_ = nil

	if var_13_1 then
		var_13_1()
	end
end

function var_0_0.Cacheable(arg_14_0)
	return not arg_14_0.noCache
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.list_:Dispose()
	arg_15_0.dotList_:Dispose()
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
