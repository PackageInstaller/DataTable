_class("MaterialAnimationComponent", Object)
MaterialAnimationComponent = MaterialAnimationComponent

function MaterialAnimationComponent:Constructor(entity)
  local world = entity:GetOwnerWorld()
  self._isDevelopEnv = world:IsDevelopEnv()
  self._MaterialAnimationContainer = nil
  self._ownContainer = false
  self._MaterialAnimation = nil
  self._attachmentMaterialAnimation = nil
  self._otherMaterialAnimationContainer = {}
  self._subMaterialAnimations = {}
  self.linkMaterialAnimEntityArray = {}
end

function MaterialAnimationComponent:SetMaterialAnimationController(csMaterialAnimation)
  self._MaterialAnimation = csMaterialAnimation
end

function MaterialAnimationComponent:SetAttachmentMaterialAnimation(csAttachMatAni)
  self._attachmentMaterialAnimation = csAttachMatAni
  if self._MaterialAnimationContainer then
    self._attachmentMaterialAnimation:AddClips(self._MaterialAnimationContainer.Obj)
  end
end

function MaterialAnimationComponent:LoadContainer(container)
  self._MaterialAnimationContainer = container
  self._MaterialAnimation:AddClips(self._MaterialAnimationContainer.Obj)
end

function MaterialAnimationComponent:AddContainer(container)
  table.insert(self._otherMaterialAnimationContainer, container)
  self._MaterialAnimation:AddClips(container.Obj)
end

function MaterialAnimationComponent:Dispose()
  if self._ownContainer then
    self._MaterialAnimationContainer:Dispose()
    for i, container in ipairs(self._otherMaterialAnimationContainer) do
      container:Dispose()
    end
  end
end

function MaterialAnimationComponent:MaterialAnimation()
  return self._MaterialAnimation
end

function MaterialAnimationComponent:PlayAlpha()
  self:Play("common_alpha")
end

function MaterialAnimationComponent:IsPlayingAlpha()
  return self._MaterialAnimation:IsPlaying("common_alpha")
end

function MaterialAnimationComponent:PlayAlphaLoop()
  self:Play("common_alpha_loop")
end

function MaterialAnimationComponent:IsPlayingAlphaLoop()
  return self._MaterialAnimation:IsPlaying("common_alpha_loop")
end

function MaterialAnimationComponent:PlayAtkup()
  self:Play("common_atkup")
end

function MaterialAnimationComponent:IsPlayingAtkup()
  return self._MaterialAnimation:IsPlaying("common_atkup")
end

function MaterialAnimationComponent:PlayBlood()
  self:Play("common_blood")
end

function MaterialAnimationComponent:IsPlayingBlood()
  return self._MaterialAnimation:IsPlaying("common_blood")
end

function MaterialAnimationComponent:PlayCure()
  self:Play("common_cure")
end

function MaterialAnimationComponent:IsPlayingCure()
  return self._MaterialAnimation:IsPlaying("common_cure")
end

function MaterialAnimationComponent:PlayDefup()
  self:Play("common_defup")
end

function MaterialAnimationComponent:IsPlayingDefup()
  return self._MaterialAnimation:IsPlaying("common_defup")
end

function MaterialAnimationComponent:PlayFire()
  self:Play("common_fire")
end

function MaterialAnimationComponent:PlayHit()
  self:Play("common_hit")
end

function MaterialAnimationComponent:PlayInvalid()
  self:Play("common_invalid")
end

function MaterialAnimationComponent:StopInvalid()
  self:StopMaterialAnim("common_invalid")
end

function MaterialAnimationComponent:IsPlayingCommonInvalid()
  return self._MaterialAnimation:IsPlaying("common_invalid")
end

function MaterialAnimationComponent:PlayPoison()
  self:Play("common_poison")
end

function MaterialAnimationComponent:PlaySelect()
  self:Play("common_select")
end

function MaterialAnimationComponent:IsPlayingSelect()
  return self._MaterialAnimation:IsPlaying("common_select")
end

function MaterialAnimationComponent:PlaySelectAlpha()
  self:Play("common_select_alpha")
end

function MaterialAnimationComponent:IsPlayingSelectAlpha()
  return self._MaterialAnimation:IsPlaying("common_select_alpha")
end

function MaterialAnimationComponent:PlayShadoweff()
  self:Play("common_shadoweff")
end

function MaterialAnimationComponent:PlayShield()
  self:Play("common_shield")
end

function MaterialAnimationComponent:PlayDeathFire()
  self:Play("Monster_Death_Fire")
end

function MaterialAnimationComponent:PlayDeathForest()
  self:Play("Monster_Death_Forest")
end

function MaterialAnimationComponent:PlayDeathLight()
  self:Play("Monster_Death_Flash")
end

function MaterialAnimationComponent:PlayImmuneAD()
  self:Play("common_immune_ad")
end

function MaterialAnimationComponent:PlayImmuneAP()
  self:Play("common_immune_ap")
end

function MaterialAnimationComponent:PlayCurePre()
  self:Play("common_cure_pre")
end

function MaterialAnimationComponent:IsPlayingCurePre()
  return self._MaterialAnimation:IsPlaying("common_cure_pre")
end

function MaterialAnimationComponent:PlayN15Cure()
  self:Play("effanim_N15_cure")
end

function MaterialAnimationComponent:IsPlayN15Cure()
  return self._MaterialAnimation:IsPlaying("effanim_N15_cure")
end

function MaterialAnimationComponent:AddLinkMaterialAnimEntity(e)
  table.insert(self.linkMaterialAnimEntityArray, e)
end

function MaterialAnimationComponent:Play(anim)
  if self._MaterialAnimation == nil or tostring(self._MaterialAnimation) == "null" then
    Log.fatal(self._className, "material animation is nil")
    return
  end
  local config = Cfg.cfg_materialanim_layer[anim]
  local success
  if config then
    success = self._MaterialAnimation:Play(anim, config.Layer)
  else
    success = self._MaterialAnimation:Play(anim, 9)
  end
  if not success and self._isDevelopEnv then
    Log.error("MaterialAnimationComponent: failed on playing material animation: ", tostring(anim), " object: ", self._MaterialAnimation.gameObject.name)
  end
  local layerCount = config and config.Layer or 9
  if self._attachmentMaterialAnimation then
    self._attachmentMaterialAnimation:Play(anim, layerCount)
  end
  if #self.linkMaterialAnimEntityArray > 0 then
    for _, e in ipairs(self.linkMaterialAnimEntityArray) do
      local cmpt = e:MaterialAnimationComponent()
      if cmpt then
        cmpt:Play(anim)
      end
    end
  end
end

function MaterialAnimationComponent:PlayLayer(anim, layer)
  self._MaterialAnimation:Play(anim, layer)
  if self._attachmentMaterialAnimation then
    self._attachmentMaterialAnimation:Play(anim, layer)
  end
end

function MaterialAnimationComponent:GetMaterialAnimationLayer(anim)
  local config = Cfg.cfg_materialanim_layer[anim]
  if config then
    return config.Layer
  end
  Log.fatal("Can't find MaterialAnimation AnimName:", anim)
  return nil
end

function MaterialAnimationComponent:PlayDeathWater()
  self:Play("Monster_Death_Water")
end

function MaterialAnimationComponent:StopAll()
  self._MaterialAnimation:StopAll()
  if self._attachmentMaterialAnimation then
    self._attachmentMaterialAnimation:StopAll()
  end
  if #self.linkMaterialAnimEntityArray > 0 then
    for _, e in ipairs(self.linkMaterialAnimEntityArray) do
      local cmpt = e:MaterialAnimationComponent()
      if cmpt then
        cmpt._MaterialAnimation:StopAll()
      end
    end
  end
end

function MaterialAnimationComponent:StopMaterialAnim(anim)
  if self._MaterialAnimation:IsPlaying(anim) then
    local layer = self:GetMaterialAnimationLayer(anim)
    if layer then
      self:StopLayer(layer)
    end
  end
end

function MaterialAnimationComponent:StopLayer(layer)
  self._MaterialAnimation:StopLayer(layer)
  if self._attachmentMaterialAnimation then
    self._attachmentMaterialAnimation:StopLayer(layer)
  end
  if #self.linkMaterialAnimEntityArray > 0 then
    for _, e in ipairs(self.linkMaterialAnimEntityArray) do
      local cmpt = e:MaterialAnimationComponent()
      if cmpt then
        cmpt._MaterialAnimation:StopLayer(layer)
      end
    end
  end
end

function MaterialAnimationComponent:AddSubMaterialAnimation(nodeName, csAttachMatAni)
  self._subMaterialAnimations[nodeName] = csAttachMatAni
end

function MaterialAnimationComponent:GetSubMaterialAnimation(nodeName)
  return self._subMaterialAnimations[nodeName]
end

function MaterialAnimationComponent:SubLoadContainer(nodeName, container)
  self._subMaterialAnimationContainer = container
  local ma = self._subMaterialAnimations[nodeName]
  if ma then
    ma:AddClips(self._subMaterialAnimationContainer.Obj)
  end
end

function MaterialAnimationComponent:SubPlay(nodeName, anim)
  local ma = self:GetSubMaterialAnimation(nodeName)
  if ma == nil or tostring(ma) == "null" then
    return
  end
  local config = Cfg.cfg_materialanim_layer[anim]
  if config then
    ma:Play(anim, config.Layer)
  else
    ma:Play(anim, 9)
  end
end

function MaterialAnimationComponent:StopSubLayer(nodeName, layer)
  local ma = self:GetSubMaterialAnimation(nodeName)
  if ma == nil or tostring(ma) == "null" then
    return
  end
  ma:StopLayer(layer)
end

function MaterialAnimationComponent:StopSubMaterialAnim(nodeName, anim)
  local ma = self:GetSubMaterialAnimation(nodeName)
  if ma == nil or tostring(ma) == "null" then
    return
  end
  if ma:IsPlaying(anim) then
    local layer = self:GetMaterialAnimationLayer(anim)
    layer = layer or 9
    self:StopSubLayer(nodeName, layer)
  end
end

function Entity:MaterialAnimationComponent()
  return self:GetComponent(self.WEComponentsEnum.MaterialAnimation)
end

function Entity:HasMaterialAnimationComponent()
  return self:HasComponent(self.WEComponentsEnum.MaterialAnimation)
end

function Entity:AddMaterialAnimationComponent(container, csMaterialAnimation)
  assert(container)
  local index = self.WEComponentsEnum.MaterialAnimation
  local component = MaterialAnimationComponent:New(self)
  component:SetMaterialAnimationController(csMaterialAnimation)
  component:LoadContainer(container)
  self:AddComponent(index, component)
end

function Entity:RemoveMaterialAnimationComponent()
  if self:HasMaterialAnimationComponent() then
    self:RemoveComponent(self.WEComponentsEnum.MaterialAnimation)
  end
end

function Entity:StopAnimTransparent()
  if not self:MaterialAnimationComponent() then
    return
  end
  self:MaterialAnimationComponent():StopMaterialAnim("common_alpha_loop")
end

function Entity:NewEnableTransparent()
  if not self:MaterialAnimationComponent() then
    return
  end
  self:MaterialAnimationComponent():PlayAlphaLoop()
end

function Entity:StopAnimFlash()
  if not self:MaterialAnimationComponent() then
    return
  end
  self:MaterialAnimationComponent():StopMaterialAnim("common_select")
end

function Entity:NewEnableFlash()
  if not self:MaterialAnimationComponent() then
    return
  end
  self:MaterialAnimationComponent():PlaySelect()
end

function Entity:StopAnimFlashAlpha()
  if not self:MaterialAnimationComponent() then
    return
  end
  self:MaterialAnimationComponent():StopMaterialAnim("common_select_alpha")
end

function Entity:NewEnableFlashAlpha()
  local matAnimCmpt = self:MaterialAnimationComponent()
  if matAnimCmpt then
    matAnimCmpt:PlaySelectAlpha()
  else
    local hasPstID = self:HasPetPstID()
    if hasPstID then
      Log.fatal("can not select pet as flash target")
    else
    end
  end
end

function Entity:StopGhostAnim()
  local ani = self:MaterialAnimationComponent()
  if ani then
    ani:StopMaterialAnim("common_alpha")
  end
end

function Entity:NewEnableGhost()
  local ani = self:MaterialAnimationComponent()
  if ani and not ani:IsPlayingAlpha() then
    ani:PlayAlpha()
  end
end

function Entity:NewPlayDeadDark()
  local ani = self:MaterialAnimationComponent()
  if ani then
    ani:Play("monster_death_dark")
  end
end

function Entity:NewPlayDeadLight()
  local ani = self:MaterialAnimationComponent()
  if ani then
    ani:Play("monster_death_light")
  end
end

function Entity:PlayMaterialAnim(anim)
  local ani = self:MaterialAnimationComponent()
  if ani then
    ani:Play(anim)
  end
end

function Entity:StopMaterialAnim(anim)
  local ani = self:MaterialAnimationComponent()
  if ani then
    ani:StopMaterialAnim(anim)
  end
end

function Entity:StopMaterialAnimLayer(layer)
  local ani = self:MaterialAnimationComponent()
  if ani then
    ani:StopLayer(layer)
  end
end

function Entity:PlayCurePreMaterialAnim()
  if not self:MaterialAnimationComponent() then
    return
  end
  self:MaterialAnimationComponent():PlayCurePre()
end

function Entity:StopCurePreAnim()
  if not self:MaterialAnimationComponent() then
    return
  end
  if self:MaterialAnimationComponent():IsPlayingCurePre() then
    self:MaterialAnimationComponent():StopMaterialAnim("common_cure_pre")
  end
end

function Entity:PlayN15CureMaterialAnim()
  if not self:MaterialAnimationComponent() then
    return
  end
  self:MaterialAnimationComponent():PlayN15Cure()
end

function Entity:StopN15CureAnim()
  if not self:MaterialAnimationComponent() then
    return
  end
  if self:MaterialAnimationComponent():IsPlayN15Cure() then
    self:MaterialAnimationComponent():StopMaterialAnim("effanim_N15_cure")
  end
end

function Entity:PlaySubMaterialAnim(nodeName, anim)
  local ani = self:MaterialAnimationComponent()
  if ani then
    ani:SubPlay(nodeName, anim)
  end
end

function Entity:StopSubMaterialAnim(nodeName, anim)
  local ani = self:MaterialAnimationComponent()
  if ani then
    ani:StopSubMaterialAnim(nodeName, anim)
  end
end

local MaterialAnimLayer = {
  Death = 2,
  irresistible = 3,
  SkillPreview = 4,
  Shield = 5,
  Hit = 6,
  Dot = 7
}
_enum("MaterialAnimLayer", MaterialAnimLayer)
