_class("HomelandPetComponentFactory", Object)
HomelandPetComponentFactory = HomelandPetComponentFactory

function HomelandPetComponentFactory:Constructor()
  self._components = {}
  self:_Register()
end

function HomelandPetComponentFactory:_RegistorComponent(componentType, component)
  local _component = self._components[componentType]
  if nil ~= _component then
    Log.error("HomelandPetComponent is exist! HomelandPetComponentType:", componentType, ", Component:", _component)
    return
  end
  self._components[componentType] = component
end

function HomelandPetComponentFactory:CreateHomelandPetComponent(componentType, pet, behavior)
  local type = self._components[componentType]
  if not type then
    Log.error("HomelandPetComponent is not exist! HomelandPetComponentType:", componentType)
    return
  end
  local component = type:New(componentType, pet, behavior)
  if not component then
    Log.error("HomelandPetComponent create fail! HomelandPetComponentType:", componentType)
    return
  end
  component:Init()
  return component
end

function HomelandPetComponentFactory:_Register()
  self:_RegistorComponent(HomelandPetComponentType.Move, HomelandPetComponentMove)
  self:_RegistorComponent(HomelandPetComponentType.Bubble, HomelandPetComponentBubble)
  self:_RegistorComponent(HomelandPetComponentType.Animation, HomelandPetComponentPlayAnimation)
  self:_RegistorComponent(HomelandPetComponentType.Face, HomelandPetComponentFace)
  self:_RegistorComponent(HomelandPetComponentType.Soliloquize, HomelandPetComponentSoliloquize)
  self:_RegistorComponent(HomelandPetComponentType.InteractionAnimation, HomelandPetComponentInteractionAnimation)
  self:_RegistorComponent(HomelandPetComponentType.Swim, HomelandPetComponentSwim)
  self:_RegistorComponent(HomelandPetComponentType.ExtraAnimation, HomelandPetComponentExtraAnimation)
end
