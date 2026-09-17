local this = class("moduleNestSwapSummon", G_UIModuleBase)
local _petTpl = L_GameTpl:getPetTpl()

function this.bind()
  return {
    fillHp = nil,
    txt_index = nil,
    iconPet = nil,
    activeNum = nil
  }
end

function this.methods()
  return {
    onClick = function(self)
      self:onClick()
    end
  }
end

function this:open(options)
  self.ani = self.bindComponents.ani
  self.guid = self.bind.guid
  self.entityId = self.bind.entityId
  self.entity = C_EntityManager.GetEntity(self.entityId)
  if self.entity and self.entity.entity then
    self.maxHp = self.entity.entity.data.aliveProperty.maxHp:ToFloat()
  end
  local petData = CS.Lens.Gameplay.KiboDuel.KiboDuelSystemManager.kiboDuelStore:GetNestPet(self.guid)
  local configId = petData.configId
  local tpl = _petTpl:getTplById(configId)
  local icon = _petTpl:getPetIcon(tpl, petData:IsSpecialPet())
  self.bind.iconPet = icon
  self.updateHandler = self.updateHandler or Timer.repeated(1, self.update, self)
  self:update()
  self.onEndSwapHandler = self.onEndSwapHandler or handler(self, self.onSwapEnd)
  C_KiboDuelSystemMgr:UnregisterEvent(C_EKiboDuelEvent.ClickConfirmSwapSummon, self.onEndSwapHandler)
  C_KiboDuelSystemMgr:RegisterEvent(C_EKiboDuelEvent.ClickConfirmSwapSummon, self.onEndSwapHandler)
  self.bind.activeNum = L_DeviceTpl:getIsPc()
end

function this:update()
  if self.entity and self.entity.entity and self.maxHp and self.maxHp ~= 0 then
    local hp = self.entity.entity.data.aliveProperty.hp:ToFloat()
    self.bind.fillHp = hp / self.maxHp
  else
    self.bind.fillHp = 0
  end
end

function this:close()
  C_KiboDuelSystemMgr:UnregisterEvent(C_EKiboDuelEvent.ClickConfirmSwapSummon, self.onEndSwapHandler)
  Timer.remove(self.updateHandler)
end

function this:onClick()
  self:emit("onClick", self.guid)
end

function this:onSwapEnd(e, varList)
  local guid = varList:GetUlong(0)
  if guid == self.guid then
    self.ani:Rewind()
    self.ani:Play("anim_KiboDuelInsideCard_selected")
  end
end

function this:refresh()
end

return this
