local var_0_0 = class("CaptureDecoratorEntity", CaptureEntityBase)

function var_0_0.GetType(arg_1_0)
	return CaptureGameConst.EntityType.Decorator
end

function var_0_0.InitGameObject(arg_2_0)
	local var_2_0 = arg_2_0.params_
	local var_2_1 = Asset.Instantiate(string.format("CaptureGame/Decorator/%s", arg_2_0.params_.prefabName))

	var_2_1.transform.parent = CaptureGameMgr:GetGameContext().decoratorRoot
	var_2_1.transform.localScale = Vector3.one

	return var_2_1
end

function var_0_0.Init(arg_3_0)
	arg_3_0.context = {
		entity = arg_3_0.entity,
		tag = arg_3_0.params_.tag,
		transform = arg_3_0.transform_,
		gameObject = arg_3_0.gameObject_
	}

	arg_3_0:OnInit()
	arg_3_0:AddListener()
end

function var_0_0.InitComponents(arg_4_0)
	local var_4_0 = arg_4_0.gameObject_:GetComponent(typeof(BoxCollider))

	if not isNil(var_4_0) and arg_4_0.context.tag and arg_4_0.context.tag ~= "" then
		local var_4_1 = arg_4_0.context.entity.obbCalculator

		var_4_1.hasOBB = true
		var_4_1.bc = var_4_0
		arg_4_0.context.entity.obbCalculator = var_4_1

		arg_4_0.context.entity:AddComponent(CaptureGameConst.ComponentType.TransformComponent)
		arg_4_0.context.entity:AddComponent(CaptureGameConst.ComponentType.OBBComponent)

		if CaptureGameMgr:IsSingleMode() then
			arg_4_0.context.entity:AddComponent(CaptureGameConst.ComponentType.OcculusionComponent)
		end
	else
		arg_4_0.context.entity.obbCalculator.hasOBB = false
	end

	if not CaptureGameMgr:IsSingleMode() and not isNil(var_4_0) then
		var_4_0.enabled = false
	end
end

function var_0_0.OnInit(arg_5_0)
	return
end

function var_0_0.OnScreen(arg_6_0)
	return arg_6_0.context.entity.isOnScreen
end

function var_0_0.IsOcculuded(arg_7_0)
	return arg_7_0.context.entity:IsOcculuded()
end

function var_0_0.GetTag(arg_8_0)
	return arg_8_0.context.tag
end

function var_0_0.AddListener(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.context.entity:Dispose()

	arg_10_0.context.entity = nil

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
