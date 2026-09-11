local CaptureDecoratorEntity = class("CaptureDecoratorEntity", CaptureEntityBase)

function CaptureDecoratorEntity:GetType()
	return CaptureGameConst.EntityType.Decorator
end

function CaptureDecoratorEntity:InitGameObject()
	local var_2_1 = Asset.Instantiate(string.format("CaptureGame/Decorator/%s", self.params_.prefabName))

	var_2_1.transform.parent = CaptureGameMgr:GetGameContext().decoratorRoot
	var_2_1.transform.localScale = Vector3.one

	return var_2_1
end

function CaptureDecoratorEntity:Init()
	self.context = {
		entity = self.entity,
		tag = self.params_.tag,
		transform = self.transform_,
		gameObject = self.gameObject_
	}

	self:OnInit()
	self:AddListener()
end

function CaptureDecoratorEntity:InitComponents()
	local var_4_0 = self.gameObject_:GetComponent(typeof(BoxCollider))

	if not isNil(var_4_0) and self.context.tag and self.context.tag ~= "" then
		self.context.entity.obbCalculator.hasOBB = true
		self.context.entity.obbCalculator.bc = var_4_0
		self.context.entity.obbCalculator = self.context.entity.obbCalculator

		self.context.entity:AddComponent(CaptureGameConst.ComponentType.TransformComponent)
		self.context.entity:AddComponent(CaptureGameConst.ComponentType.OBBComponent)

		if CaptureGameMgr:IsSingleMode() then
			self.context.entity:AddComponent(CaptureGameConst.ComponentType.OcculusionComponent)
		end
	else
		self.context.entity.obbCalculator.hasOBB = false
	end

	if not CaptureGameMgr:IsSingleMode() and not isNil(var_4_0) then
		var_4_0.enabled = false
	end
end

function CaptureDecoratorEntity:OnInit()
	return
end

function CaptureDecoratorEntity:OnScreen()
	return self.context.entity.isOnScreen
end

function CaptureDecoratorEntity:IsOcculuded()
	return self.context.entity:IsOcculuded()
end

function CaptureDecoratorEntity:GetTag()
	return self.context.tag
end

function CaptureDecoratorEntity:AddListener()
	return
end

function CaptureDecoratorEntity:Dispose()
	self.context.entity:Dispose()

	self.context.entity = nil

	CaptureDecoratorEntity.super.Dispose(self)
end

return CaptureDecoratorEntity
