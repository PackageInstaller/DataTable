local this = class("cellMountFeed", G_UIModuleBase)
local _petGradeTpl = L_GameTpl:getPetGradeTpl()

function this.bind()
  return {
    go_active = false,
    module_pixelIcon = {
      moduleName = "pages/pet/modulePetPixelIcon"
    },
    isInBattleTeam = false,
    color_satiety = nil,
    fillAmount_satiety = 0,
    fillAmount_satiety_add = 0,
    txt_satiety = nil,
    module_mountMoveType = {
      moduleName = "pages/mount/moduleMountMoveType"
    },
    module_mountFavorableLvUp = {
      moduleName = "pages/mount/moduleMountFavorableLvUp"
    }
  }
end

function this.methods()
  return {
    onClick = function(self)
      self:emit("onClick_select", self.bind)
    end
  }
end

function this:open()
  self:refresh()
end

function this:refresh()
  if self.isBind then
    self:initCell()
  end
end

function this:initCell()
  if self.bind.isInBattle then
    self.bind.isInBattleTeam = true
  else
    self.bind.isInBattleTeam = false
  end
  local pet = L_PetStore:getPetItem(self.bind.guid)
  local satietyPer = L_SatietyStore:getPetSatietyPercent(self.bind.guid)
  satietyPer = math.clamp(satietyPer, 0.1, 1)
  self:showAddSatiety()
  self.bind.fillAmount_satiety = satietyPer
  self.bind.color_satiety = L_PetConst.SatietyStatusColor[L_SatietyStore:getPetSatietyStatus(self.bind.guid)]
  local moduleIcon = self.modules.module_pixelIcon
  moduleIcon:setGuid(self.bind.guid)
  self:onShowFavorableLvData()
end

function this:setActive(active)
  self.bind.go_active = active
  if not active then
    self:setAddSatiety(0)
    if self.modules and self.modules.module_pixelIcon then
      self.modules.module_pixelIcon:stopPixelGif()
    end
  end
  if active then
    printf("PetGuid = " .. tostring(self.bind.guid))
    if self.modules and self.modules.module_pixelIcon then
      self.modules.module_pixelIcon:playPixelGif()
    end
  end
end

function this:setAddSatiety(addSatiety)
  self._addSatiety = addSatiety
  self:showAddSatiety()
end

function this:showAddSatiety()
  self._addSatiety = self._addSatiety or 0
  local maxPetSatiety = L_SatietyStore:getPetMaxSatiety(self.bind.guid)
  local curSatiety = L_SatietyStore:getPetSatiety(self.bind.guid)
  local nextSatiety = math.min(self._addSatiety + curSatiety, maxPetSatiety)
  self.bind.fillAmount_satiety_add = nextSatiety / maxPetSatiety
  local addChargeStr = ""
  if self._addSatiety > 0 then
    local addCharge = math.min(self._addSatiety, maxPetSatiety - curSatiety)
    addChargeStr = L_GameUtil.fillColor(string.format("(+%d)", addCharge), L_Const.colorHtml.blue013)
  end
  self.bind.txt_satiety = string.format("%d%s/%d", curSatiety, addChargeStr, maxPetSatiety)
end

function this:playFx()
  if not self.isBind then
    return
  end
end

function this:onShowFavorableLvData()
  local moduleMountFavorableLvUp = self.modules.module_mountFavorableLvUp
  local data = {
    petGuid = self.bind.guid
  }
  moduleMountFavorableLvUp:onSetDat(data)
end

return this
