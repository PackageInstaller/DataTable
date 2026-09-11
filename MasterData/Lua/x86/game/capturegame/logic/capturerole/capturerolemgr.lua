local CaptureRoleMgr = class("CaptureRoleMgr", CaptureLogicMgrBase)

function CaptureRoleMgr:Ctor()
	self:Init()
end

function CaptureRoleMgr:Init()
	self.context = {
		role = {}
	}
end

function CaptureRoleMgr:InsertNewRole(arg_3_1)
	self.context.role[arg_3_1:GetRoleId()] = arg_3_1
end

function CaptureRoleMgr:RemoveRole(arg_4_1)
	self.context.role[arg_4_1:GetRoleId()] = nil
end

function CaptureRoleMgr:GetEntityBySkinId(arg_5_1)
	return self.context.role[arg_5_1]
end

function CaptureRoleMgr:PlayAnimation(arg_6_1, arg_6_2)
	local var_6_0 = self:GetEntityBySkinId(arg_6_1)

	if var_6_0 then
		var_6_0:PlayAnimation(arg_6_2)
	end
end

function CaptureRoleMgr:Dispose()
	return
end

return CaptureRoleMgr
