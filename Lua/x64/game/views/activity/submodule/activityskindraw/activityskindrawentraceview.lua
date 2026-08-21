local var_0_0 = class("ActivitySkinDrawEntraceView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.listGo_, ActivitySkinDrawEntraceItem)
end

function var_0_0.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:Refresh(arg_4_0.list_[arg_4_1])
end

function var_0_0.AddUIListeners(arg_5_0)
	return
end

function var_0_0.OnEnter(arg_6_0)
	manager.notify:RegistListener(ACTIVITY_SKIN_DRAW_UPDATE, handler(arg_6_0, arg_6_0.OnSkinDrawUpdate))
	arg_6_0:RefreshList()
	arg_6_0:RefreshScrollView()
end

function var_0_0.GetActivityList(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = ActivitySkinDrawData:GetActivityList() or {}
	local var_7_2 = ActivityOathDrawData:GetActivityList() or {}

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		table.insert(var_7_0, iter_7_1)
	end

	for iter_7_2, iter_7_3 in ipairs(var_7_2) do
		table.insert(var_7_0, iter_7_3)
	end

	return var_7_0
end

function var_0_0.RefreshList(arg_8_0)
	arg_8_0.list_ = arg_8_0:GetActivityList()

	arg_8_0.scrollHelper_:StartScroll(#arg_8_0.list_)
end

function var_0_0.RefreshScrollView(arg_9_0)
	if #arg_9_0.list_ <= 0 then
		SetActive(arg_9_0.gameObject_, false)

		return
	end

	SetActive(arg_9_0.gameObject_, true)

	if #arg_9_0.list_ > 1 then
		arg_9_0.scrollView_.enabled = true
	else
		arg_9_0.scrollView_.verticalNormalizedPosition = 0
		arg_9_0.scrollView_.enabled = false
	end
end

function var_0_0.CheckActivityType(arg_10_0, arg_10_1)
	if ActivityTemplateConst.ACTIVITY_SKIN_DRAW == ActivityTools.GetActivityType(arg_10_1) then
		return true
	elseif ActivityTemplateConst.ACTIVITY_OATH_DRAW_MAIN == ActivityTools.GetActivityType(arg_10_1) then
		return true
	end

	return false
end

function var_0_0.OnSkinDrawUpdate(arg_11_0, arg_11_1)
	if not arg_11_0:CheckActivityType(arg_11_1) or isNil(arg_11_0.gameObject_) or arg_11_0.isRefreshed_ then
		return
	end

	arg_11_0.isRefreshed_ = true

	arg_11_0:RefreshList()
	arg_11_0:RefreshScrollView()
end

function var_0_0.OnExit(arg_12_0)
	manager.notify:RemoveListener(ACTIVITY_SKIN_DRAW_UPDATE, handler(arg_12_0, arg_12_0.OnSkinDrawUpdate))

	for iter_12_0, iter_12_1 in pairs(arg_12_0.scrollHelper_:GetItemList()) do
		iter_12_1:OnExit()
	end
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
	arg_13_0:RemoveAllListeners()
	arg_13_0.scrollHelper_:Dispose()
end

return var_0_0
