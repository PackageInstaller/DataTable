local EntityMgr = class("EntityMgr", CaptureLogicMgrBase)

function EntityMgr:Init()
	self.data = {
		entity = {},
		idRef = {}
	}
	self.decoratorQuery = {}
	self.roleQuery = {}
	self.EntityMap = {
		[CaptureGameConst.EntityType.Role] = CaptureRoleEntity,
		[CaptureGameConst.EntityType.PlaceHolder] = CapturePlaceHolderEntity,
		[CaptureGameConst.EntityType.Decorator] = CaptureDecoratorEntity
	}
end

function EntityMgr:Start()
	return
end

function EntityMgr:Stop()
	self.decoratorQuery = {}

	self:DisposeEntity()
end

function EntityMgr:DisposeEntity()
	for iter_4_0, iter_4_1 in pairs(self.data.idRef) do
		if iter_4_1 then
			iter_4_1:Dispose()
		end
	end

	self.data.idRef = nil
	self.data.entity = nil
end

function EntityMgr:MakeNewEntity(arg_5_1, arg_5_2)
	if self.EntityMap[arg_5_1] then
		local var_5_0 = self.EntityMap[arg_5_1].New(arg_5_2)

		self:InsertEntity(var_5_0:GetType(), var_5_0)

		return var_5_0:GetId()
	end

	return -1
end

function EntityMgr:InsertEntity(arg_6_1, arg_6_2)
	local var_6_0 = arg_6_2:GetId()

	self.data.entity[arg_6_1] = self.data.entity[arg_6_1] or {}
	self.data.entity[arg_6_1][var_6_0] = true
	self.data.idRef[var_6_0] = arg_6_2

	if arg_6_1 == CaptureGameConst.EntityType.Decorator then
		self:InsertDecorator(arg_6_2:GetTag(), var_6_0)
	elseif arg_6_1 == CaptureGameConst.EntityType.Role then
		self:InsertRole(arg_6_2)
	end
end

function EntityMgr:GetEntity(arg_7_1)
	return self.data.idRef[arg_7_1]
end

function EntityMgr:InsertDecorator(arg_8_1, arg_8_2)
	if arg_8_1 and arg_8_1 ~= "" then
		self.decoratorQuery[arg_8_1] = arg_8_2
	end
end

function EntityMgr:QueryDecorator(arg_9_1)
	if self.decoratorQuery[arg_9_1] then
		return self:GetEntity(self.decoratorQuery[arg_9_1])
	end

	return nil
end

function EntityMgr:InsertRole(arg_10_1)
	self.roleQuery[arg_10_1:GetRoleId()] = arg_10_1:GetId()
end

function EntityMgr:QueryRole(arg_11_1)
	if self.roleQuery[arg_11_1] then
		return self:GetEntity(self.roleQuery[arg_11_1])
	end

	return nil
end

return EntityMgr
