local var_0_0 = class("BehaviourBase")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.name_ = arg_1_1
	arg_1_0.depends_ = arg_1_2
	arg_1_0.priority_ = arg_1_3 or 0
	arg_1_0.refCnt_ = 0
end

function var_0_0.GetName(arg_2_0)
	return arg_2_0.name_
end

function var_0_0.GetDepends(arg_3_0)
	return arg_3_0.depends_
end

function var_0_0.GetPriority(arg_4_0)
	return arg_4_0.priority_
end

function var_0_0.GetTarget(arg_5_0)
	return arg_5_0.target_
end

function var_0_0.Reset(arg_6_0)
	return
end

function var_0_0.ExportMethods_(arg_7_0, arg_7_1)
	arg_7_0.exportedMethods_ = arg_7_1

	local var_7_0 = arg_7_0.target_
	local var_7_1 = arg_7_0

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		if not var_7_0[iter_7_1] then
			local var_7_2 = var_7_1[iter_7_1]

			var_7_0[iter_7_1] = function(arg_8_0, ...)
				return var_7_2(var_7_1, ...)
			end
		end
	end

	return arg_7_0
end

function var_0_0.Bind_(arg_9_0, arg_9_1)
	arg_9_0.target_ = arg_9_1

	if arg_9_0.depends_ then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.depends_) do
			arg_9_1:AddBehaviour(iter_9_1)
		end
	end

	arg_9_0:OnBind_(arg_9_1)
end

function var_0_0.AddRef_(arg_10_0, arg_10_1)
	arg_10_0.refCnt_ = arg_10_0.refCnt_ + 1

	if arg_10_0.refCnt_ == 1 then
		arg_10_0:Bind_(arg_10_1)
		arg_10_0.target_:AddBehaviour_(arg_10_0.name_, arg_10_0)
	end
end

function var_0_0.Unbind_(arg_11_0)
	local var_11_0 = arg_11_0.target_

	if arg_11_0.exportedMethods_ then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0.exportedMethods_) do
			var_11_0[iter_11_1] = nil
		end
	end

	arg_11_0:OnUnbind_()

	if arg_11_0.depends_ then
		for iter_11_2, iter_11_3 in ipairs(arg_11_0.depends_) do
			var_11_0:RemoveBehaviour(iter_11_3)
		end
	end
end

function var_0_0.SubRef_(arg_12_0)
	arg_12_0.refCnt_ = arg_12_0.refCnt_ - 1

	if arg_12_0.refCnt_ <= 0 then
		arg_12_0:Unbind_()
		arg_12_0.target_:RemoveBehaviour_(arg_12_0.name_)
	end
end

function var_0_0.OnBind_(arg_13_0)
	return
end

function var_0_0.OnUnbind_(arg_14_0)
	return
end

return var_0_0
