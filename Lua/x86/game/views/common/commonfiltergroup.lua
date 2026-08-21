local var_0_0 = class("CommonFilterGroup", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.items = {}
	arg_1_0.alreadyBuild = false
	arg_1_0.filterContext = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Refresh(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = CommonFilterConst.GetGroupCfg(arg_2_2)

	arg_2_0.titleTxt_.text = GetTips(var_2_0.title)

	local var_2_1 = CommonFilterConst.GetFilterList(arg_2_2)

	if not var_2_1 then
		return
	end

	local var_2_2 = #var_2_1
	local var_2_3 = var_2_0.mode or Filter_Group_Mode.MultiMode

	arg_2_0:BuildLayout(var_2_2, var_2_3)

	for iter_2_0 = 1, var_2_2 do
		local var_2_4 = var_2_1[iter_2_0]

		arg_2_0.items[iter_2_0]:Refresh(arg_2_1, arg_2_2, var_2_4)
	end
end

function var_0_0.BuildLayout(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0.alreadyBuild then
		return
	end

	arg_3_0.alreadyBuild = true

	local var_3_0 = #arg_3_0.items

	for iter_3_0 = 1, var_3_0 do
		arg_3_0.items[iter_3_0]:Dispose()
	end

	arg_3_0.items = {}

	for iter_3_1 = 1, arg_3_1 do
		if arg_3_2 == Filter_Group_Mode.SingleMode then
			local var_3_1 = Object.Instantiate(arg_3_0.singleFilterItemObj_, arg_3_0.singleContent_)
			local var_3_2 = CommonSingleFilterItem.New(var_3_1, arg_3_0.filterContext)

			table.insert(arg_3_0.items, var_3_2)
		else
			local var_3_3 = Object.Instantiate(arg_3_0.commonFilterItemObj_, arg_3_0.content_)
			local var_3_4 = CommonFilterItem.New(var_3_3, arg_3_0.filterContext)

			table.insert(arg_3_0.items, var_3_4)
		end
	end
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddListeners()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_6_0)
	return
end

function var_0_0.Dispose(arg_7_0)
	Object.Destroy(arg_7_0.gameObject_)

	for iter_7_0 = 1, #arg_7_0.items do
		arg_7_0.items[iter_7_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
