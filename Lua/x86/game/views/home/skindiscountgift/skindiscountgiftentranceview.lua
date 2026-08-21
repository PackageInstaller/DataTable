local var_0_0 = class("SkinDiscountGiftEntranceView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.scrollHelper_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.listGo_, SkinDiscountGiftEntranceItem)
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0:RefreshList()
	arg_2_0:RefreshScrollView()
end

function var_0_0.OnExit(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.scrollHelper_:GetItemList()) do
		iter_3_1:OnExit()
	end
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	arg_4_0.scrollHelper_:Dispose()

	arg_4_0.scrollHelper_ = nil
end

function var_0_0.AddListeners(arg_5_0)
	return
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:Refresh(arg_6_0.list_[arg_6_1])
end

function var_0_0.RefreshList(arg_7_0)
	arg_7_0.list_ = {}

	local var_7_0 = SkinDiscountGiftTools.GetActivityList() or {}

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if SkinDiscountGiftTools.IsShowMain(iter_7_1) then
			table.insert(arg_7_0.list_, iter_7_1)
		end
	end

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

return var_0_0
