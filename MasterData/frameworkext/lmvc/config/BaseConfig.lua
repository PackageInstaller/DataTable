module("frameworkext.lmvc.config.BaseConfig", package.seeall)

local var_0_0 = class("BaseConfig")

function var_0_0.ctor(arg_1_0)
	arg_1_0._dict = {}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.getNames(arg_3_0)
	return nil
end

function var_0_0.handleConfig(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._dict[arg_4_1] = arg_4_2
end

return var_0_0
