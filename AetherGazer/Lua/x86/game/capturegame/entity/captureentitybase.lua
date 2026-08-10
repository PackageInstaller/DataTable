local var_0_0 = class("CaptureEntityBase")

function var_0_0.GetType(arg_1_0)
	return CaptureGameConst.EntityType.Unknow
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.params_ = arg_2_1

	arg_2_0:InitEntotyObj()

	arg_2_0.entity = Capture.Runtime.CaptureEntity.New()

	if not isNil(arg_2_0.gameObject_) then
		arg_2_0.entity.obj = arg_2_0.gameObject_
	end

	arg_2_0.entity.entityType = arg_2_0:GetType()

	arg_2_0:Init()
	arg_2_0:InitComponents()
	CaptureGameMgr:GetGameContext():InsertEntity(arg_2_0.entity)
end

function var_0_0.InitGameObject(arg_3_0)
	return nil
end

function var_0_0.InitEntotyObj(arg_4_0)
	arg_4_0.gameObject_ = arg_4_0:InitGameObject()

	if not isNil(arg_4_0.gameObject_) then
		arg_4_0.transform_ = arg_4_0.gameObject_.transform
	end
end

function var_0_0.InitComponents(arg_5_0)
	return
end

function var_0_0.Init(arg_6_0)
	return
end

function var_0_0.GetId(arg_7_0)
	return arg_7_0.entity.Identify
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.gameObject_ = nil
	arg_8_0.transform_ = nil
	arg_8_0.entity = nil
end

return var_0_0
