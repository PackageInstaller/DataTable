local this = class("modulePetFavorability", G_UIModuleBase)
local petFavorabilityTpl = L_GameTpl:getPetFavorabilityTpl()

function this.bind()
  return {
    favorability_lv = "",
    favorability_cur = "",
    favorability_percent = 0
  }
end

function this.methods()
  return {
    onClick_petFavor = function(self)
      if table.isEmpty(self.pet) then
        return
      end
      L_UI:open("pagePetFavorDetail", {
        petGuid = self.pet.guid
      })
    end
  }
end

function this:setGuid(guid)
  local pet = L_PetStore:getPetItem(guid)
  self.pet = pet
  local curLevel = pet:petFavorLv()
  self.bind.favorability_lv = tostring(pet:petFavorLv())
  local curExp = pet:petFavorVal()
  if math.isEmpty(curLevel) then
    errorf("提示策划用：宠物configId" .. pet.id .. "没有配置好感度,好感度等级为空")
    self.bind.favorability_cur = "0/0"
    self.bind.favorability_percent = 0
    return
  end
  if petFavorabilityTpl:getIsMaxLv(curLevel) then
    self.bind.favorability_cur = L_WordsTpl:getValue("notice_pagePetFavorDetail")
    self.bind.favorability_percent = 1
  else
    self.bind.favorability_cur = string.format("%d/%d", curExp, petFavorabilityTpl:getUpgradeExp(curLevel))
    self.bind.favorability_percent = curExp / petFavorabilityTpl:getUpgradeExp(curLevel)
  end
end

return this
