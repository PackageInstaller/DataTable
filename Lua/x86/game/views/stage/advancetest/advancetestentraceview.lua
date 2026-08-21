local var_0_0 = class("AdvanceTestEntraceView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/AdvancetestingUI/ATestingEntraceUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.itemList_ = {}
	arg_3_0.selectController_ = arg_3_0.controller_:GetController("select")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.maskBtn_, nil, function()
		arg_4_0:Back()
	end)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		JumpTools.GoToSystem("/advanceTestMain", {
			activityID = arg_4_0.selectID_
		})
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.activityIDList_ = AdvanceTestData:GetActivityList()
	arg_7_0.selectID_ = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.activityIDList_) do
		if not arg_7_0.itemList_[iter_7_0] then
			local var_7_0 = Object.Instantiate(arg_7_0.entraceItem_, arg_7_0.btnContent_)
			local var_7_1 = AdvanceTestEntraceItem.New(var_7_0, iter_7_0)

			arg_7_0.itemList_[iter_7_0] = var_7_1

			arg_7_0.itemList_[iter_7_0]:SetClickCallBack(function(arg_8_0)
				arg_7_0:SelectItem(arg_8_0)
			end)
		end

		arg_7_0.itemList_[iter_7_0]:SetData(iter_7_1)
		SetActive(arg_7_0.itemList_[iter_7_0].gameObject_, true)
	end

	for iter_7_2 = #arg_7_0.itemList_, #arg_7_0.activityIDList_ + 1, -1 do
		SetActive(arg_7_0.itemList_[iter_7_2].gameObject_, false)
	end

	if #arg_7_0.activityIDList_ > 3 then
		arg_7_0.scrollView_.enabled = true
	else
		arg_7_0.scrollView_.enabled = false
	end

	arg_7_0:SelectItem(arg_7_0.selectID_)
end

function var_0_0.SelectItem(arg_9_0, arg_9_1)
	arg_9_0.selectID_ = arg_9_1

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.itemList_) do
		iter_9_1:RefreshSelect(arg_9_0.selectID_)
	end

	arg_9_0.selectController_:SetSelectedState(tostring(arg_9_0.selectID_ ~= 0))
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.itemList_ then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0.itemList_) do
			iter_10_1:Dispose()
		end

		arg_10_0.itemList_ = nil
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
