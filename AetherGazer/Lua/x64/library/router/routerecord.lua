local var_0_0 = class("RouteRecord")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.name_ = arg_1_1
	arg_1_0.path_ = arg_1_2
	arg_1_0.parent_ = arg_1_3
	arg_1_0.components_ = {}
	arg_1_0.componentNames_ = arg_1_4
	arg_1_0.wraps_ = arg_1_5 or {}
end

function var_0_0.NewComponents(arg_2_0)
	local var_2_0 = arg_2_0.componentNames_

	if var_2_0.__cname then
		arg_2_0.components_.default = var_2_0.New()
	else
		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			arg_2_0.components_[iter_2_0] = iter_2_1.New()
		end
	end
end

function var_0_0.GetName(arg_3_0)
	return arg_3_0.name_
end

function var_0_0.GetPath(arg_4_0)
	return arg_4_0.path_
end

function var_0_0.SetParent(arg_5_0, arg_5_1)
	arg_5_0.parent_ = arg_5_1
end

function var_0_0.GetParent(arg_6_0)
	return arg_6_0.parent_
end

function var_0_0.GetComponent(arg_7_0)
	return arg_7_0.components_
end

function var_0_0.SetParams(arg_8_0, arg_8_1)
	arg_8_0.params_ = arg_8_1
end

function var_0_0.GetParams(arg_9_0)
	return arg_9_0.params_
end

function var_0_0.GetWraps(arg_10_0)
	return arg_10_0.wraps_
end

function var_0_0.Init(arg_11_0, arg_11_1)
	arg_11_0:NewComponents()

	for iter_11_0, iter_11_1 in pairs(arg_11_0.components_) do
		iter_11_1:SyncInit(arg_11_1)
	end
end

function var_0_0.OnTop(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.components_) do
		iter_12_1:OnTop()
	end
end

function var_0_0.OnBehind(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.components_) do
		iter_13_1:OnBehind()
	end
end

function var_0_0.OnUpdate(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.components_) do
		if arg_14_1 then
			iter_14_1:SetParams(arg_14_1)
		end

		iter_14_1:OnUpdate()
	end
end

function var_0_0.Dispose(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.components_) do
		iter_15_1:OnUnload()
	end

	arg_15_0:DestroyComponents()
end

function var_0_0.DestroyComponents(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.components_) do
		arg_16_0.components_[iter_16_0] = nil
	end
end

return var_0_0
