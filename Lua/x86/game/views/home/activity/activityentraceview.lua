local var_0_0 = class("ActivityEntraceView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.itemUiList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.uiListGo_, ActivityEntraceItem)
	arg_1_0.activityOpenHandler_ = handler(arg_1_0, arg_1_0.ActivityOpen)
end

function var_0_0.OnEnter(arg_2_0)
	manager.notify:RegistListener(ACTIVITY_UPDATE, arg_2_0.activityOpenHandler_)
	manager.notify:RegistListener(ACTIVITY_ENTRACE_OPEN, arg_2_0.activityOpenHandler_)
	arg_2_0:InitItemList()
	arg_2_0:AddTimer()
	arg_2_0:RefreshScrollView()
end

function var_0_0.OnExit(arg_3_0)
	manager.notify:RemoveListener(ACTIVITY_UPDATE, arg_3_0.activityOpenHandler_)
	manager.notify:RemoveListener(ACTIVITY_ENTRACE_OPEN, arg_3_0.activityOpenHandler_)
	arg_3_0:StopTimer()

	for iter_3_0, iter_3_1 in pairs(arg_3_0.itemUiList_:GetItemList()) do
		iter_3_1:OnExit()
	end
end

function var_0_0.AddTimer(arg_4_0)
	arg_4_0:StopTimer()

	arg_4_0.activiteTime_ = Timer.New(function()
		for iter_5_0, iter_5_1 in ipairs(arg_4_0.idList_) do
			if ActivityData:GetActivityIsOpen(iter_5_1) == false then
				manager.notify:Invoke(ACTIVITY_ENTRACE_OPEN, iter_5_1)
			end
		end
	end, 1, -1)

	arg_4_0.activiteTime_:Start()
end

function var_0_0.StopTimer(arg_6_0)
	if arg_6_0.activiteTime_ then
		arg_6_0.activiteTime_:Stop()

		arg_6_0.activiteTime_ = nil
	end
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)

	arg_7_0.activityOpenHandler_ = nil

	arg_7_0.itemUiList_:Dispose()

	arg_7_0.itemUiList_ = nil
end

function var_0_0.IndexItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.idList_[arg_8_1]

	arg_8_2:SetData(var_8_0)
end

function var_0_0.InitItemList(arg_9_0)
	arg_9_0.idList_ = {}

	for iter_9_0, iter_9_1 in ipairs(ActivityEntraceCfg.all) do
		if ActivityData:GetActivityIsOpen(iter_9_1) then
			table.insert(arg_9_0.idList_, iter_9_1)
		end
	end

	arg_9_0.itemUiList_:StartScroll(#arg_9_0.idList_)
end

function var_0_0.ActivityOpen(arg_10_0, arg_10_1)
	if ActivityTemplateConst.MAIN_ACTIVITY ~= ActivityTools.GetActivityType(arg_10_1) then
		return
	end

	if not table.indexof(arg_10_0.idList_, arg_10_1) then
		if ActivityEntraceCfg[arg_10_1] == nil then
			return
		end

		if ActivityData:GetActivityIsOpen(arg_10_1) then
			table.insert(arg_10_0.idList_, arg_10_1)
			table.sort(arg_10_0.idList_)
		end
	elseif not ActivityData:GetActivityIsOpen(arg_10_1) then
		table.removebyvalue(arg_10_0.idList_, arg_10_1)
	end

	arg_10_0.itemUiList_:StartScroll(#arg_10_0.idList_)
	arg_10_0:RefreshScrollView()
end

function var_0_0.RefreshScrollView(arg_11_0)
	if #arg_11_0.idList_ > 1 then
		arg_11_0.scrollView_.enabled = true
	else
		arg_11_0.scrollView_.verticalNormalizedPosition = 0
		arg_11_0.scrollView_.enabled = false
	end
end

return var_0_0
