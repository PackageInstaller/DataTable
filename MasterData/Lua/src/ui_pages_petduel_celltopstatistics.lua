local this = class("cellTopStatistics", G_UIModuleBase)
local petTpl = L_GameTpl:getPetTpl()
local elementTpl = L_GameTpl:getElementTypeTpl()
local trialPetTpl = L_GameTpl:getTrialPetTpl()
local playerColor = "#4d9bff"
local enemyColor = "#fe5d5d"

function this.bind()
  return {
    petIcon = "",
    petName = "",
    valueText = "",
    valueSlider = nil,
    img_sliderColor = nil,
    color_slider = nil
  }
end

function this.methods()
  return {}
end

function this:open()
  local color1, color2, color3
  local r, color = C_ColorUtility.TryParseHtmlString(playerColor)
  self.playerColor = color
  r, color = C_ColorUtility.TryParseHtmlString(enemyColor)
  self.enemyColor = color
  r, color1 = C_ColorUtility.TryParseHtmlString("#384ba0")
  r, color2 = C_ColorUtility.TryParseHtmlString("#9b613f")
  r, color3 = C_ColorUtility.TryParseHtmlString("#00735a")
  self.colorP1 = color1
  self.colorP2 = color2
  self.colorP3 = color3
end

function this:refresh()
  if not self.isBind then
    return
  end
  if self.bind.isNest then
    self:refreshNestPetInfo(self.bind)
  elseif self.bind.isPlayer then
    CS.UnityEngine.Profiling.Profiler.BeginSample("setPlayerData")
    self:setPlayerData()
    CS.UnityEngine.Profiling.Profiler.EndSample()
  else
    CS.UnityEngine.Profiling.Profiler.BeginSample("setEnemyData")
    self:setEnemyData()
    CS.UnityEngine.Profiling.Profiler.EndSample()
  end
  local value = L_HeroManager:addComma(math.floor(self.bind.value))
  self.bind.valueText = value
  if self.bind.value == 0 then
    self.bind.valueSlider = 0
  else
    self.bind.valueSlider = self.bind.value / self.bind.maxValue
  end
end

function this:setEnemyData()
  CS.UnityEngine.Profiling.Profiler.BeginSample("setEnemyData")
  local tpl = petTpl:getTplById(self.bind.id)
  local icon = petTpl:getPetIcon(tpl)
  if self.bind.petIcon ~= icon then
    self.bind.petIcon = icon
  end
  self.bind.petName = petTpl:getName(tpl, false)
  self.bind.color_slider = self.enemyColor
  CS.UnityEngine.Profiling.Profiler.EndSample()
end

function this:setPlayerData()
  if self.bind.is_trial then
    self:refreshSystemPetInfo(self.bind)
  else
    self:refreshPlayerPetInfo(self.bind)
  end
  self.bind.color_slider = self.playerColor
end

function this:refreshSystemPetInfo(petInfo)
  local trialId = petInfo.id
  local trialTpl = trialPetTpl:getTplById(trialId)
  local petId = trialPetTpl:getTrialPet(trialTpl)
  local tpl = petTpl:getTplById(petId)
  local icon = petTpl:getPetIcon(tpl)
  if self.bind.petIcon ~= icon then
    self.bind.petIcon = icon
  end
  self.bind.petName = C_KiboDuelSystemMgr:GetPetNameBySlot(petInfo.slotId)
end

function this:refreshPlayerPetInfo(petInfo)
  CS.UnityEngine.Profiling.Profiler.BeginSample("refreshPlayerPetInfo")
  local id = petInfo.id
  local petData = L_PetStore:getPetItem(id)
  if petData then
    local tpl = petTpl:getTplById(petData.id)
    local icon = petTpl:getPetIcon(tpl, petData:isSpecialPet())
    if self.bind.petIcon ~= icon then
      self.bind.petIcon = icon
    end
    self.bind.petName = petTpl:getName(tpl, petData:isSpecialPet())
  end
  CS.UnityEngine.Profiling.Profiler.EndSample()
end

function this:refreshNestPetInfo(petInfo)
  local configId = petInfo.petConfigId
  local tpl = petTpl:getTplById(configId)
  if tpl then
    local icon = petTpl:getPetIcon(tpl, petInfo.special)
    if self.bind.petIcon ~= icon then
      self.bind.petIcon = icon
    end
    self.bind.petName = petTpl:getName(tpl, petInfo.special)
  end
  local color
  if petInfo.nestPos == 1 then
    color = self.colorP1
  elseif petInfo.nestPos == 2 then
    color = self.colorP2
  elseif petInfo.nestPos == 3 then
    color = self.colorP3
  end
  self.bind.color_slider = color
end

return this
