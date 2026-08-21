local var_0_0 = class("CommonSingleFilterItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.filterContext = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.SelectController = arg_3_0.controllerEx_:GetController("select")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.clickBtn_, nil, handler(arg_4_0, arg_4_0.OnBtnClick))
end

function var_0_0.Refresh(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.filter_id = arg_5_1
	arg_5_0.group_id = arg_5_2
	arg_5_0.tagId = arg_5_3

	local var_5_0 = CommonFilterConst.GetFilterTagCfg(arg_5_3)

	if not var_5_0 then
		return
	end

	arg_5_0.isFlag = arg_5_0.filterContext:HasIndexFlag(arg_5_0.group_id, arg_5_3)

	arg_5_0.SelectController:SetSelectedState(arg_5_0.isFlag and "select" or "normal")

	arg_5_0.tagTxt_.text = GetTips(var_5_0.name)
end

function var_0_0.Dispose(arg_6_0)
	Object.Destroy(arg_6_0.gameObject_)
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.OnBtnClick(arg_7_0)
	local var_7_0 = -1

	if arg_7_0.isFlag then
		local var_7_1 = arg_7_0.filterContext:DeSelectTag(arg_7_0.group_id, arg_7_0.tagId)
	else
		local var_7_2 = arg_7_0.filterContext:SelectTag(arg_7_0.group_id, arg_7_0.tagId)
	end

	manager.notify:Invoke("OnCommonFilterItemClick", {
		gId = arg_7_0.group_id,
		tId = arg_7_0.tagId
	})
end

return var_0_0
