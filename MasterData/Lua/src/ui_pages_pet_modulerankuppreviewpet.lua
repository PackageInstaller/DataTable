local this = class("moduleRankUpPreviewPet", G_UIModuleBase)
local petTpl = L_GameTpl:getPetTpl()

local function getPetPixelIcon(tpl, petConfigId, colorParam)
  if type(colorParam) ~= "table" then
    return petTpl:getPetPixelIcon(tpl, colorParam)
  end
  local isSpecial = 0
  for _, param in ipairs(colorParam) do
    if param[1] == petConfigId then
      isSpecial = param[2] or 0
      break
    end
  end
  return petTpl:getPetPixelIcon(tpl, isSpecial)
end

function this.bind()
  return {
    rankUpNodeActive = true,
    maxRankNodeActive = false,
    lockTipsActive = false,
    tipsActive = true,
    lockText = "",
    currentStageText = "",
    nextStageText = "",
    maxStageText = "",
    tipText = "",
    currentPixelIcon = "",
    nextPixelIcon = "",
    maxPixelIcon = "",
    currentGradeBase = "",
    maxGradeBase = ""
  }
end

function this.methods()
  return {}
end

function this:infoRefresh(petConfigId, isSpecial)
  self.bind.tipText = L_WordsTpl:getValue("ui_pet_rank_tips")
  local tpl = petTpl:getTplById(petConfigId)
  if table.isEmpty(tpl) then
    return
  end
  L_ReddotManager:registerReddot(self.bindComponents.rankUpReddot, string.format(L_ReddotManager.DotDef.PetRankUp, self.petGuid))
  local petRankTpl = L_GameTpl:getPetRankTpl()
  local rankData = petRankTpl:getchildren(petConfigId)
  local nextStageId = rankData.nextPetId
  self.isMaxStage = math.isEmpty(nextStageId)
  self.bind.rankUpNodeActive = not self.isMaxStage
  self.bind.maxRankNodeActive = self.isMaxStage
  self.bind.lockTipsActive = self.isMaxStage
  self.bind.tipsActive = not self.isMaxStage
  local petGradeTpl = L_GameTpl:getPetGradeTpl()
  local gradeTpl = petGradeTpl:getTplById(1)
  if math.isEmpty(nextStageId) then
    self.bind.maxGradeBase = petGradeTpl:getPetPixelBase(gradeTpl)
  else
    self.bind.currentGradeBase = petGradeTpl:getPetPixelBase(gradeTpl)
  end
  if self.isMaxStage then
    self.bind.maxPixelIcon = getPetPixelIcon(tpl, petConfigId, isSpecial)
    self.bind.maxStageText = L_WordsTpl:getValue("ui_pet_stage" .. petTpl:getPetStage(tpl))
    self.bind.lockText = L_WordsTpl:getValue("ui_pet_rank_limit_tips")
  else
    local nextTpl = petTpl:getTplById(nextStageId)
    self.bind.currentPixelIcon = getPetPixelIcon(tpl, petConfigId, isSpecial)
    self.bind.nextPixelIcon = getPetPixelIcon(nextTpl, nextStageId, isSpecial)
    self.bind.currentStageText = L_WordsTpl:getValue("ui_pet_stage" .. petTpl:getPetStage(tpl))
    self.bind.nextStageText = L_WordsTpl:getValue("ui_pet_stage" .. petTpl:getPetStage(nextTpl))
  end
end

return this
