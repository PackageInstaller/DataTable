module("frameworkext.ecs.ECSEntity", package.seeall)

local var_0_0 = class("ECSEntity")

function var_0_0.ctor(arg_1_0)
	arg_1_0._comopnents = {}
end

function var_0_0.addComponent(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.__cname
	local var_2_1 = arg_2_0:getComponent(arg_2_1)

	if not var_2_1 then
		var_2_1 = arg_2_1.New()
		var_2_1.entity = arg_2_0

		table.insert(arg_2_0._comopnents, var_2_1)
		var_2_1:onInit()
	end

	return var_2_1
end

function var_0_0.getAllComponents(arg_3_0)
	return arg_3_0._comopnents
end

function var_0_0.getComponent(arg_4_0, arg_4_1)
	local var_4_0 = #arg_4_0._comopnents
	local var_4_1 = arg_4_1.__cname

	for iter_4_0 = 1, var_4_0 do
		if iskindof(arg_4_0._comopnents[iter_4_0], var_4_1) then
			return arg_4_0._comopnents[iter_4_0]
		end
	end

	return nil
end

function var_0_0.removeComponent(arg_5_0, arg_5_1)
	local var_5_0 = 0
	local var_5_1
	local var_5_2 = #arg_5_0._comopnents
	local var_5_3 = arg_5_1.__cname

	for iter_5_0 = 1, var_5_2 do
		if iskindof(arg_5_0._comopnents[iter_5_0], var_5_3) then
			var_5_0 = iter_5_0
			var_5_1 = arg_5_0._comopnents[iter_5_0]

			break
		end
	end

	if var_5_1 then
		table.remove(arg_5_0._comopnents, var_5_0)
		var_5_1:onDestroy()
	end
end

function var_0_0.destroy(arg_6_0)
	local var_6_0 = #arg_6_0._comopnents

	for iter_6_0 = 1, var_6_0 do
		arg_6_0._comopnents[iter_6_0]:onDestroy()
	end

	arg_6_0._comopnents = nil
end

return var_0_0
