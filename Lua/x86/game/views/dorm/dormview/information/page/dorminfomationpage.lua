local var_0_0 = class("DormInfomationPage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.BuildContext(arg_2_0)
	local var_2_0 = DormInfomationData:GetOpenList()
	local var_2_1 = #var_2_0

	arg_2_0.list = var_2_0
	arg_2_0.modules = {}
end

function var_0_0.BuildView(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.list) do
		if not arg_3_0:CheckIsCommonOverview(arg_3_0:GetTemplateById(iter_3_1)) then
			table.insert(arg_3_0.modules, arg_3_0:InstModule(iter_3_1))
		end
	end
end

function var_0_0.CheckIsCommonOverview(arg_4_0, arg_4_1)
	if arg_4_1 == 2 then
		return true
	end

	return false
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
	arg_5_0:AddListener()
	arg_5_0:BuildContext()
	arg_5_0:BuildView()
end

function var_0_0.GetViewByTemplate(arg_6_0, arg_6_1)
	if arg_6_1 == 1 then
		return DormInfomationCanteenModule
	elseif arg_6_1 == 2 then
		return DormInfomationIdolModule
	elseif arg_6_1 == 3 then
		return DormInfomationFurnitureModule
	elseif arg_6_1 == 4 then
		return DormInfomationModifierModule
	elseif arg_6_1 == 5 then
		return DormInfomationMotionModule
	elseif arg_6_1 == 6 then
		return DormInfomationFurnitureModule
	end
end

function var_0_0.GetTemplateById(arg_7_0, arg_7_1)
	return BackhomeContentNoticeCfg[arg_7_1].template
end

function var_0_0.InstModule(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:GetTemplateById(arg_8_1)
	local var_8_1 = arg_8_0:GetViewByTemplate(var_8_0).New(arg_8_0.container)

	if var_8_1:CanShow(arg_8_1) then
		var_8_1:Show(arg_8_1)
	else
		var_8_1:Hide()
	end

	return var_8_1
end

function var_0_0.Hide(arg_9_0)
	SetActive(arg_9_0.gameObject_, false)
end

function var_0_0.Show(arg_10_0)
	SetActive(arg_10_0.gameObject_, true)
end

function var_0_0.AddListener(arg_11_0)
	return
end

function var_0_0.NeedEmpty(arg_12_0)
	local var_12_0 = false

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.modules) do
		if iter_12_1:CanShow(iter_12_1:GetId()) then
			var_12_0 = true

			break
		end
	end

	return not var_12_0
end

function var_0_0.Dispose(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.modules) do
		iter_13_1:Dispose()
	end

	arg_13_0.modules = nil

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
