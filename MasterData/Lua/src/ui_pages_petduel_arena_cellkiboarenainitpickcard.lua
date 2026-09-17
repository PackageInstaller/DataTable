local this = class("cellKiboArenaInitPickCard", G_UIModuleBase)
local petTpl = L_GameTpl:getPetTpl()
local elementTypeTpl = L_GameTpl:getElementTypeTpl()
local trialPetTpl = L_GameTpl:getTrialPetTpl()
local templateValueTpl = L_GameTpl:getTemplateValueTpl()

function this.bind()
  return {
    img_bg = "",
    img_petIcon = "",
    img_petIconNew = "",
    active_petIconNew = false,
    img_elementBg = "",
    img_elementIcon = "",
    img_subElementBg = "",
    img_subElementIcon = "",
    active_subElementBg = false,
    costNum = "0",
    txt_petName = "",
    levelText = "",
    keyText = "",
    keyActive = false,
    selectActive = false,
    healingIconActive = false,
    tagList = {
      moduleName = "pages/petDuel/cellKiBoDuelTag"
    },
    shiningActive = false,
    shiningFxActive = false,
    normalGlowActive = true,
    shingGlowActive = false
  }
end

function this.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind.index, self.bind.petInfo.guid)
    end,
    onDragBegin = function(self, screenPos)
      self:emit("onDragBegin", self.bind.index, screenPos)
    end,
    onDrag = function(self, screenPos)
      self:emit("onDrag", self.bind.index, screenPos, self.fingerId)
    end,
    onDragEnd = function(self, screenPos)
      self:emit("onDragEnd", self.bind.index, screenPos)
    end,
    onDown = function(self)
      self:emit("onDown")
    end,
    onUp = function(self)
      self:emit("onUp")
    end
  }
end

function this:open()
end

function this:close()
end

function this:refresh()
  self:setIconData(self.bind.petInfo)
end

function this:setIconData(petInfo)
  if not self.isBind then
    return
  end
  self.bind.petInfo = petInfo or self.bind.petInfo
  if not self.bind.petInfo then
    return
  end
  if self.bind.petInfo.id == self.remId then
    return
  end
  self.remId = self.bind.petInfo.id
  if self.bind.petInfo.is_trial then
    self:refreshSystemPetInfo()
  else
    self:refreshPlayerPetInfo()
  end
end

function this:refreshSystemPetInfo()
  self:setShingGlow(false)
  local trialId = self.bind.petInfo.id
  local trialTpl = trialPetTpl:getTplById(trialId)
  local petId = trialPetTpl:getTrialPet(trialTpl)
  local tpl = petTpl:getTplById(petId)
  self.bind.img_petIcon = petTpl:getKiboCardIcon(tpl)
  local petIconNew = petTpl:getKiboCardIconNew(tpl)
  if petIconNew and #petIconNew ~= 0 then
    self.bind.active_petIconNew = true
    self.bind.img_petIconNew = petIconNew
  else
    self.bind.active_petIconNew = false
  end
  self.bind.txt_petName = C_KiboDuelSystemMgr:GetPetNameByGuid(self.bind.petInfo.guid)
  self:refreshElementInfo(tpl)
  local level = L_PetDuelStore:getTrialPetLevel(trialPetTpl:getTrialPetLevel(trialTpl))
  self.bind.levelText = "Lv " .. tostring(level)
  if self.bind.index and not self.bind.isNext then
    self.bind.keyActive = true
  end
  self.bind.keyText = tostring(self.bind.index)
  self:refreshPetCost(petId)
  self:refreshTagList(petId)
end

function this:refreshElementInfo(petCfg)
  local elementIds = petTpl:getElement(petCfg)
  local eTpl = elementTypeTpl:getTplById(elementIds[1])
  self.bind.img_bg = elementTypeTpl:getKiBoCardElementBg(eTpl, 1)
  self.bind.img_elementBg = elementTypeTpl:getKiBoCardElementBg(eTpl, 2)
  self.bind.img_elementIcon = elementTypeTpl:getKiBoCardIcon(eTpl)
  self.bind.active_subElementBg = false
  if 1 < #elementIds then
    local sub_eTpl = elementTypeTpl:getTplById(elementIds[2])
    self.bind.active_subElementBg = true
    self.bind.img_subElementBg = elementTypeTpl:getKiBoCardElementBg(eTpl, 2)
    self.bind.img_subElementIcon = elementTypeTpl:getKiBoCardIcon(sub_eTpl)
    self.bind.active_subElementBg = true
  end
end

function this:refreshTagList(petId)
  if not self.isBind then
    return
  end
  local tpl = petTpl:getTplById(petId)
  local tags = petTpl:getKiboDuelTag(tpl)
  local data = {}
  for _, id in ipairs(tags) do
    table.insert(data, {tagId = id})
  end
  self.bind.tagList:freshAll(data)
end

function this:refreshPetCost(petId)
  local tempTpl = templateValueTpl:getTplById(petId)
  local cost = templateValueTpl:getPetBaseAttribute(tempTpl)[L_Const.kiBoDuelEnum.petCost]
  if cost ~= nil then
    self.bind.costNum = tostring(cost)
  end
end

function this:refreshPlayerPetInfo()
  local id = self.bind.petInfo.id
  local petData = L_PetStore:getPetItem(id)
  if petData then
    if id ~= self.lastPetGuidId then
      self:setShingGlow(petData:hasFlashGene())
    end
    self.lastPetGuidId = id
    local tpl = petTpl:getTplById(petData.id)
    self.bind.img_petIcon = petTpl:getKiboCardIcon(tpl, petData:isSpecialPet())
    local petIconNew = petTpl:getKiboCardIconNew(tpl, petData:isSpecialPet())
    if petIconNew and #petIconNew ~= 0 then
      self.bind.active_petIconNew = true
      self.bind.img_petIconNew = petIconNew
    else
      self.bind.active_petIconNew = false
    end
    self.bind.txt_petName = C_KiboDuelSystemMgr:GetPetNameByGuid(id)
    self:refreshElementInfo(tpl)
    self.bind.levelText = "Lv." .. tostring(petData.lv)
    if self.bind.index then
      self.bind.keyActive = true
    end
    self.bind.keyText = tostring(self.bind.index)
    self:refreshPetCost(petData.id)
    self:refreshTagList(petData.id)
  else
    self:setShingGlow(false)
  end
end

function this:refreshSelect(index)
  local isSelect = index == self.bind.index
  self.bind.selectActive = isSelect
  self.bind.keyActive = not isSelect
end

function this:setShingGlow(isShining)
  self.bind.shiningActive = isShining
  self.bind.shiningFxActive = isShining
  self.bind.shingGlowActive = isShining
end

return this
