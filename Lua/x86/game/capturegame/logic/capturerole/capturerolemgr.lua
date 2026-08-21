local var_0_0 = class("CaptureRoleMgr", CaptureLogicMgrBase)

function var_0_0.Ctor(arg_1_0)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.context = {
		role = {}
	}
end

function var_0_0.InsertNewRole(arg_3_0, arg_3_1)
	arg_3_0.context.role[arg_3_1:GetRoleId()] = arg_3_1
end

function var_0_0.RemoveRole(arg_4_0, arg_4_1)
	arg_4_0.context.role[arg_4_1:GetRoleId()] = nil
end

function var_0_0.GetEntityBySkinId(arg_5_0, arg_5_1)
	return arg_5_0.context.role[arg_5_1]
end

function var_0_0.PlayAnimation(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:GetEntityBySkinId(arg_6_1)

	if var_6_0 then
		var_6_0:PlayAnimation(arg_6_2)
	end
end

function var_0_0.Dispose(arg_7_0)
	return
end

return var_0_0
