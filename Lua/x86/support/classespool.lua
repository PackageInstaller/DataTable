local var_0_0 = class("ClassesPool")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.classPool_ = {}
	arg_1_0.usingIndex_ = {}
end

function var_0_0.GetOrCreateClass(arg_2_0, arg_2_1, ...)
	local var_2_0 = arg_2_1.__cname

	if not arg_2_0.classPool_[var_2_0] or not arg_2_0.usingIndex_[var_2_0] then
		arg_2_0.classPool_[var_2_0] = {}
		arg_2_0.usingIndex_[var_2_0] = {}
	end

	local var_2_1 = #arg_2_0.classPool_[var_2_0]

	for iter_2_0 = 1, var_2_1 do
		if not arg_2_0.usingIndex_[var_2_0][iter_2_0] then
			arg_2_0.usingIndex_[var_2_0][iter_2_0] = true

			arg_2_0.classPool_[var_2_0][iter_2_0]:Ctor(...)

			return arg_2_0.classPool_[var_2_0][iter_2_0]
		end
	end

	local var_2_2 = var_2_1 + 1

	arg_2_0.classPool_[var_2_0][var_2_2] = arg_2_1.New(...)
	arg_2_0.classPool_[var_2_0][var_2_2].__recycle = var_2_2
	arg_2_0.usingIndex_[var_2_0][var_2_2] = true

	return arg_2_0.classPool_[var_2_0][var_2_2]
end

function var_0_0.ReturnClass(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.class.__cname

	if not arg_3_0.classPool_[var_3_0] or not arg_3_0.usingIndex_[var_3_0] then
		return
	end

	local var_3_1 = arg_3_1.__recycle

	if var_3_1 and var_3_0 then
		arg_3_0.usingIndex_[var_3_0][var_3_1] = false
	end
end

function var_0_0.DisposeOnePool(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.__cname
	local var_4_1 = arg_4_0.classPool_[var_4_0]

	if var_4_1 then
		for iter_4_0, iter_4_1 in pairs(var_4_1) do
			iter_4_1:Dispose()
		end

		arg_4_0.classPool_[var_4_0] = {}
		arg_4_0.usingIndex_[var_4_0] = {}
	end
end

function var_0_0.Dispose(arg_5_0)
	if arg_5_0.classPool_ then
		for iter_5_0, iter_5_1 in pairs(arg_5_0.classPool_) do
			for iter_5_2, iter_5_3 in pairs(iter_5_1) do
				iter_5_3:Dispose()
			end
		end
	end

	arg_5_0.classPool_ = {}
	arg_5_0.usingIndex_ = {}
end

return var_0_0
