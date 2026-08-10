local var_0_0 = class("ActivitySkinDrawEntraceViewOld", ReduxView)

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

	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.listGo_, ActivitySkinDrawEntraceItemOld)
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

function var_0_0.RefreshList(arg_7_0)
	arg_7_0.list_ = ActivitySkinDrawDataOld:GetActivityList() or {}

	arg_7_0.scrollHelper_:StartScroll(#arg_7_0.list_)
end

function var_0_0.RefreshScrollView(arg_8_0)
	if #arg_8_0.list_ <= 0 then
		SetActive(arg_8_0.gameObject_, false)

		return
	end

	SetActive(arg_8_0.gameObject_, true)

	if #arg_8_0.list_ > 1 then
		arg_8_0.scrollView_.enabled = true
	else
		arg_8_0.scrollView_.verticalNormalizedPosition = 0
		arg_8_0.scrollView_.enabled = false
	end
end

function var_0_0.OnSkinDrawUpdate(arg_9_0, arg_9_1)
	if ActivityTemplateConst.ACTIVITY_SKIN_DRAW ~= ActivityTools.GetActivityType(arg_9_1) or isNil(arg_9_0.gameObject_) then
		return
	end

	arg_9_0:RefreshList()
	arg_9_0:RefreshScrollView()
end

function var_0_0.OnExit(arg_10_0)
	manager.notify:RemoveListener(ACTIVITY_SKIN_DRAW_UPDATE, handler(arg_10_0, arg_10_0.OnSkinDrawUpdate))

	for iter_10_0, iter_10_1 in pairs(arg_10_0.scrollHelper_:GetItemList()) do
		iter_10_1:OnExit()
	end
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()
	arg_11_0.scrollHelper_:Dispose()
end

return var_0_0
