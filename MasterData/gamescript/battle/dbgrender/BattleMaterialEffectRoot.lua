local BattleMaterialEffectRoot, Super = System.NewClass("BattleMaterialEffectRoot")

function BattleMaterialEffectRoot:ctor(entity)
  Super.ctor(self)
  self.entity = entity
  self.spineCom = self.entity.spineComp
  self.coms = {}
  self:InitMatEffectComs()
end

function BattleMaterialEffectRoot:Clear()
  self.entity = nil
  self.spineCom = nil
  self.coms = nil
end

function BattleMaterialEffectRoot:InitMatEffectComs()
  self:_AllSpineExcuteFunc(function(spine)
    self.coms[spine] = BattleMaterialEffect(self.entity, spine)
  end)
end

function BattleMaterialEffectRoot:_AllSpineExcuteFunc(func)
  if self.spineCom == nil then
    return
  end
  local allSpineNodes = self.spineCom:GetAllSpineNodes()
  if not allSpineNodes then
    return
  end
  for _, spine in pairs(allSpineNodes) do
    func(spine)
  end
end

function BattleMaterialEffectRoot:IsInEffect(effectType)
  local spine = self.spineCom:GetSpineNode()
  local com = self.coms[spine]
  if com then
    do return com.IsInEffect, com end
    return com.IsInEffect, com, effectType
  end
  return true
end

function BattleMaterialEffectRoot:PlayMaterialEffect(effectlist)
  self:_AllSpineExcuteFunc(function(spine)
    local com = self.coms[spine]
    if com then
      com:PlayMaterialEffect(effectlist)
    end
  end)
end

function BattleMaterialEffectRoot:ClearMaterialEffect(effectlist, isFriend)
  self:_AllSpineExcuteFunc(function(spine)
    local com = self.coms[spine]
    if com then
      com:ClearMaterialEffect(effectlist, isFriend)
    end
  end)
end

function BattleMaterialEffectRoot:Set24ShaderSwitch(isOpen)
  self:_AllSpineExcuteFunc(function(spine)
    local com = self.coms[spine]
    if com then
      com:Set24ShaderSwitch(isOpen)
    end
  end)
end

function BattleMaterialEffectRoot:Dispose()
  if self.coms == nil then
    return
  end
  for _, com in pairs(self.coms) do
    com:Dispose()
  end
  self:Clear()
end

return BattleMaterialEffectRoot
