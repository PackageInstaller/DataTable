local var_0_0 = class("EntityMgr", CaptureLogicMgrBase)

function var_0_0.Init(arg_1_0)
	arg_1_0.data = {
		entity = {},
		idRef = {}
	}
	arg_1_0.decoratorQuery = {}
	arg_1_0.roleQuery = {}
	arg_1_0.EntityMap = {
		[CaptureGameConst.EntityType.Role] = CaptureRoleEntity,
		[CaptureGameConst.EntityType.PlaceHolder] = CapturePlaceHolderEntity,
		[CaptureGameConst.EntityType.Decorator] = CaptureDecoratorEntity
	}
end

function var_0_0.Start(arg_2_0)
	return
end

function var_0_0.Stop(arg_3_0)
	arg_3_0.decoratorQuery = {}

	arg_3_0:DisposeEntity()
end

function var_0_0.DisposeEntity(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.data.idRef) do
		if iter_4_1 then
			iter_4_1:Dispose()
		end
	end

	arg_4_0.data.idRef = nil
	arg_4_0.data.entity = nil
end

function var_0_0.MakeNewEntity(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.EntityMap[arg_5_1] then
		local var_5_0 = arg_5_0.EntityMap[arg_5_1].New(arg_5_2)

		arg_5_0:InsertEntity(var_5_0:GetType(), var_5_0)

		return var_5_0:GetId()
	end

	return -1
end

function var_0_0.InsertEntity(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_2:GetId()

	arg_6_0.data.entity[arg_6_1] = arg_6_0.data.entity[arg_6_1] or {}
	arg_6_0.data.entity[arg_6_1][var_6_0] = true
	arg_6_0.data.idRef[var_6_0] = arg_6_2

	if arg_6_1 == CaptureGameConst.EntityType.Decorator then
		arg_6_0:InsertDecorator(arg_6_2:GetTag(), var_6_0)
	elseif arg_6_1 == CaptureGameConst.EntityType.Role then
		arg_6_0:InsertRole(arg_6_2)
	end
end

function var_0_0.GetEntity(arg_7_0, arg_7_1)
	return arg_7_0.data.idRef[arg_7_1]
end

function var_0_0.InsertDecorator(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 and arg_8_1 ~= "" then
		arg_8_0.decoratorQuery[arg_8_1] = arg_8_2
	end
end

function var_0_0.QueryDecorator(arg_9_0, arg_9_1)
	if arg_9_0.decoratorQuery[arg_9_1] then
		return arg_9_0:GetEntity(arg_9_0.decoratorQuery[arg_9_1])
	end

	return nil
end

function var_0_0.InsertRole(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:GetRoleId()
	local var_10_1 = arg_10_1:GetId()

	arg_10_0.roleQuery[var_10_0] = var_10_1
end

function var_0_0.QueryRole(arg_11_0, arg_11_1)
	if arg_11_0.roleQuery[arg_11_1] then
		return arg_11_0:GetEntity(arg_11_0.roleQuery[arg_11_1])
	end

	return nil
end

return var_0_0
