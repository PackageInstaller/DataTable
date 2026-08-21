local var_0_0 = class("CommonFilterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Common/Pop/CommonFilterView/CommonFilterView"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()

	arg_3_0.OnCommonFilterItemClick = handler(arg_3_0, arg_3_0.OnItemClick)
	arg_3_0.items = {}
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:RegisteBottomComponent()
end

function var_0_0.AddUIListeners(arg_5_0)
	if arg_5_0.maskBtn_ then
		arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, handler(arg_5_0, arg_5_0.Back))
	end

	if arg_5_0.cancelBtn_ then
		arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, handler(arg_5_0, arg_5_0.Back))
	end

	if arg_5_0.allBtn_ then
		arg_5_0:AddBtnListener(arg_5_0.allBtn_, nil, handler(arg_5_0, arg_5_0.OnBtnAllClick))
	end

	arg_5_0:AddBtnListener(arg_5_0.okBtn_, nil, handler(arg_5_0, arg_5_0.OnBtnOKClick))
end

function var_0_0.BuildContext(arg_6_0)
	arg_6_0.filterContext = CommonFilterData:GetFilterDataCopy(arg_6_0.filter_id)
end

function var_0_0.OnEnter(arg_7_0)
	manager.notify:RegistListener("OnCommonFilterItemClick", arg_7_0.OnCommonFilterItemClick)

	arg_7_0.filter_id = arg_7_0.params_.filterGroup.filter_id
	arg_7_0.filterGroup = arg_7_0.params_.filterGroup.groupList

	if not arg_7_0.filterGroup then
		print("CommonFilterView参数错误")

		return
	end

	arg_7_0:BuildContext()

	arg_7_0.count = #arg_7_0.filterGroup

	arg_7_0:BuildLayout()
	arg_7_0:Refresh()
end

function var_0_0.BuildLayout(arg_8_0)
	local var_8_0 = #arg_8_0.items

	for iter_8_0 = 1, var_8_0 do
		arg_8_0.items[iter_8_0]:Dispose()
	end

	arg_8_0.items = {}

	for iter_8_1 = 1, arg_8_0.count do
		local var_8_1 = Object.Instantiate(arg_8_0.filterGroupObj_, arg_8_0.content_)
		local var_8_2 = CommonFilterGroup.New(var_8_1, arg_8_0.filterContext)

		table.insert(arg_8_0.items, var_8_2)
	end
end

function var_0_0.OnItemClick(arg_9_0, arg_9_1)
	arg_9_0:CheckSingleState(arg_9_1)
	arg_9_0:Refresh()
end

function var_0_0.Refresh(arg_10_0)
	if arg_10_0.AllController then
		arg_10_0.isAll = arg_10_0.filterContext:IsAll(arg_10_0.filter_id)

		arg_10_0.AllController:SetSelectedIndex(arg_10_0.isAll and 1 or 0)
	end

	for iter_10_0 = 1, arg_10_0.count do
		local var_10_0 = arg_10_0.items[iter_10_0]
		local var_10_1 = arg_10_0.filterGroup[iter_10_0]

		var_10_0:Refresh(arg_10_0.filter_id, var_10_1)
	end

	arg_10_0:TryUpdateBottom()
end

function var_0_0.CheckSingleState(arg_11_0, arg_11_1)
	for iter_11_0 = 1, arg_11_0.count do
		local var_11_0 = arg_11_0.filterGroup[iter_11_0]
		local var_11_1 = CommonFilterConst.GetGroupCfg(var_11_0)

		if arg_11_1.gId == var_11_0 and var_11_1.mode == Filter_Group_Mode.SingleMode and not arg_11_0.filterContext:AtLeastOneChooseGroup(var_11_0) then
			if arg_11_1.tId then
				arg_11_0.filterContext:SelectTag(var_11_0, arg_11_1.tId)
			else
				arg_11_0.filterContext:SelectTag(var_11_0, var_11_1.tags[1])
			end
		end
	end
end

function var_0_0.OnExit(arg_12_0)
	manager.notify:RemoveListener("OnCommonFilterItemClick", arg_12_0.OnCommonFilterItemClick)
end

function var_0_0.Dispose(arg_13_0)
	for iter_13_0 = 1, #arg_13_0.items do
		arg_13_0.items[iter_13_0]:Dispose()
	end

	arg_13_0:RemoveAllListeners()
	arg_13_0:DisposeBottomView()
	var_0_0.super.Dispose(arg_13_0)
end

function var_0_0.OnBtnAllClick(arg_14_0)
	if arg_14_0.isAll then
		return
	end

	arg_14_0:Refresh()
end

function var_0_0.OnBtnOKClick(arg_15_0)
	local var_15_0 = CommonFilterData:GetFilterDataCopy(arg_15_0.filter_id)

	if not arg_15_0.filterContext:CheckIsSame(var_15_0) then
		CommonFilterData:ApplyFilterCopy(arg_15_0.filterContext)
		manager.notify:CallUpdateFunc(COMMON_FILTER_OK)
		manager.notify:Invoke(COMMON_FILTER_OK)
	end

	arg_15_0:Back()
end

function var_0_0.RegisteBottomComponent(arg_16_0)
	if arg_16_0.filterBottomObj_ and not arg_16_0.filterBottomView then
		arg_16_0.filterBottomView = CommonFilterBottom.New(arg_16_0.filterBottomObj_)

		arg_16_0.filterBottomView:RegisteClearBtnListener(handler(arg_16_0, arg_16_0.OnClearBtnClick))
	end
end

function var_0_0.OnClearBtnClick(arg_17_0)
	arg_17_0.filterContext:Clear()
	arg_17_0:Refresh()
end

function var_0_0.TryUpdateBottom(arg_18_0)
	arg_18_0:RegisteBottomComponent()

	if arg_18_0.filterBottomView then
		local var_18_0 = {}
		local var_18_1 = {}

		for iter_18_0, iter_18_1 in ipairs(arg_18_0.filterGroup) do
			if CommonFilterConst.GetGroupCfg(iter_18_1).mode ~= Filter_Group_Mode.SingleMode then
				var_18_0[iter_18_1] = arg_18_0.filterContext:GetGroupSelectedTags(iter_18_1)

				for iter_18_2, iter_18_3 in ipairs(var_18_0[iter_18_1]) do
					local var_18_2 = CommonFilterConst.GetFilterTagCfg(iter_18_3)

					table.insert(var_18_1, {
						name = GetTips(var_18_2.name)
					})
				end
			end
		end

		arg_18_0.filterBottomView:Refresh(var_18_1)
	end
end

function var_0_0.DisposeBottomView(arg_19_0)
	if arg_19_0.filterBottomView then
		arg_19_0.filterBottomView:Dispose()

		arg_19_0.filterBottomView = nil
	end
end

return var_0_0
