local this = class("cellNestPlayerPet", G_UIModuleBase)
local _petTpl = L_GameTpl:getPetTpl()

function this.bind()
  return {
    fillHp = nil,
    iconPet = nil,
    activeEmpty = nil,
    activePet = nil
  }
end

function this.methods()
  return {}
end

function this:setData(data)
  self.lastEntityId = self.entityId
  self.entityId = data.entityId
  self.entity = C_EntityManager.GetEntity(self.entityId)
  if self.entity and self.entity.entity then
  else
    return
  end
  if self.entity and self.entity.entity then
    self:showPetIcon()
  end
end

function this:open(options)
  self.isEmpty = true
  self.ani = self.bindComponents.ani
  self.bind.activePet = false
  self.updateHandler = self.updateHandler or Timer.repeated(0.6, self.update, self)
  self:update()
end

function this:update()
  if self.entityId and not self.entity then
    self.entity = C_EntityManager.GetEntity(self.entityId)
    if self.entity and self.entity.entity and self.lastEntityId ~= self.entityId then
      self:showPetIcon()
    end
  end
  if self.entity and self.entity.entity and self.maxHp and self.maxHp ~= 0 then
    local hp = self.entity.entity.data.aliveProperty.hp:ToFloat()
    if hp <= 0 then
      self.entityId = nil
      self.entity = nil
      self:showEmpty()
    else
      self:showPet()
    end
    self.bind.fillHp = hp / self.maxHp
  else
    self:showEmpty()
    self.bind.fillHp = 0
  end
end

function this:showEmpty()
  self.bind.activeEmpty = true
  if self.bind.activePet and not self.isEmpty then
    self.ani:Rewind()
    self.ani:Play("anim_KiboDuelState_out")
    self.isEmpty = true
    Timer.once(0.2, function()
      self.bind.activePet = false
    end)
  end
end

function this:showPetIcon()
  local configId = self.entity.entity.config.id
  local tpl = _petTpl:getTplById(configId)
  local icon = _petTpl:getPetIcon(tpl, self.entity.entity.data.specialParam)
  self.bind.iconPet = icon
  self.maxHp = self.entity.entity.data.aliveProperty.maxHp:ToFloat()
end

function this:showPet()
  self.bind.activeEmpty = false
  self.bind.activePet = true
  if self.lastEntityId ~= self.entityId and not self.isEmpty then
    self.ani:Rewind()
    self.ani:Play("anim_KiboDuelState_change")
    self.lastEntityId = self.entityId
  end
  if self.isEmpty then
    self.ani:Rewind()
    self.ani:Play("anim_KiboDuelState_in")
  end
  if self.lastEntityId ~= self.entityId and not self.isEmpty then
    self.ani:Rewind()
    self.ani:Play("anim_KiboDuelState_change")
  end
  if self.isEmpty then
    self.ani:Rewind()
    self.ani:Play("anim_KiboDuelState_in")
  end
  self.lastEntityId = self.entityId
  self.isEmpty = false
end

function this:close()
  Timer.remove(self.updateHandler)
end

function this:refresh()
end

return this
