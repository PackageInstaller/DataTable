local var_0_0 = class("BaseGoto")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.template = {}
end

function var_0_0.GetBasePath(arg_2_0)
	return ""
end

function var_0_0.Go(arg_3_0, ...)
	return
end

function var_0_0.InstantiateEntity(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:GetBasePath() .. arg_4_0:GetTemplateName(arg_4_1)

	return (import(var_4_0).New(arg_4_1))
end

function var_0_0.GetTemplateName(arg_5_0, arg_5_1)
	return arg_5_0.template[arg_5_1]
end

function var_0_0.ProcessPlayParams(arg_6_0, arg_6_1)
	if arg_6_1 then
		if arg_6_1.showChar then
			QWorldLuaBridge.HidePlayer(false)
		end

		if arg_6_1.func then
			arg_6_1.func()
		end
	end
end

function var_0_0.SetTagId(arg_7_0, arg_7_1)
	arg_7_0.tagId = arg_7_1
end

function var_0_0.GetTagId(arg_8_0)
	return arg_8_0.tagId
end

return var_0_0
