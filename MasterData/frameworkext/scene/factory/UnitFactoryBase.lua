module("frameworkext.scene.factory.UnitFactoryBase", package.seeall)

local var_0_0 = class("UnitFactoryBase", SceneComponentBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._units = {}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._container = arg_2_0._scene:getContainer()
end

function var_0_0.removeAll(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0._units) do
		local var_3_0 = iter_3_1

		for iter_3_2, iter_3_3 in pairs(var_3_0) do
			goutil.destroy(iter_3_3.go)

			var_3_0[iter_3_2] = nil
		end
	end
end

function var_0_0.addUnit(arg_4_0, arg_4_1)
	goutil.addChildToParent(arg_4_1.go, arg_4_0._container)

	local var_4_0 = arg_4_1.go.tag
	local var_4_1 = arg_4_0._units[var_4_0]

	if not var_4_1 then
		var_4_1 = {}
		arg_4_0._units[var_4_0] = var_4_1
	end

	var_4_1[arg_4_1.id] = arg_4_1
end

function var_0_0.getUnits(arg_5_0, arg_5_1)
	return arg_5_0._units[arg_5_1]
end

function var_0_0.getUnit(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0._units[arg_6_1]

	if var_6_0 then
		return var_6_0[arg_6_2]
	end

	return nil
end

function var_0_0.removeUnit(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._units[arg_7_1]

	if var_7_0 then
		local var_7_1 = var_7_0[arg_7_2]

		if var_7_1 then
			var_7_0[arg_7_2] = nil

			goutil.destroy(var_7_1.go)
		end
	end
end

return var_0_0
