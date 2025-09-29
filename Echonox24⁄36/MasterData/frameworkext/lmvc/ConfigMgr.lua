module("frameworkext.lmvc.config.ConfigMgr", package.seeall)

local var_0_0 = class("ConfigMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._configDict = {}
	arg_1_0._requestorDict = {}
	arg_1_0._pathPrefix = nil
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._pathPrefix = arg_2_1
end

function var_0_0.loadConfigs(arg_3_0, arg_3_1)
	local var_3_0 = #arg_3_1

	for iter_3_0 = 1, var_3_0 do
		local var_3_1 = arg_3_0._pathPrefix .. arg_3_1[iter_3_0]
		local var_3_2 = require(var_3_1)

		arg_3_0:_addConfig(arg_3_1[iter_3_0], var_3_2)
	end
end

function var_0_0._addConfig(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0._requestorDict[arg_4_1]

	if var_4_0 then
		local var_4_1 = #var_4_0

		for iter_4_0 = 1, var_4_1 do
			var_4_0[iter_4_0]:handleConfig(arg_4_1, arg_4_2)
		end
	else
		arg_4_0._configDict[arg_4_1] = arg_4_2
	end
end

function var_0_0.requestConfig(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._configDict[arg_5_1] then
		local var_5_0 = arg_5_0._configDict[arg_5_1]

		arg_5_2:handleConfig(arg_5_1, var_5_0)
	else
		local var_5_1 = arg_5_0._pathPrefix .. arg_5_1
		local var_5_2 = require(var_5_1)

		arg_5_0._configDict[arg_5_1] = var_5_2

		arg_5_2:handleConfig(arg_5_1, var_5_2)
	end
end

function var_0_0.clear(arg_6_0)
	arg_6_0._configDict = nil
	arg_6_0._requestorDict = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
