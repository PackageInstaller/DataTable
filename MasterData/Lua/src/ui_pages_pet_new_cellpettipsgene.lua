local module = class("cellPetTipsGene", G_UIModuleBase)
local _petDnaTpl = L_GameTpl:getDnaTpl()
local _petFeedItemTpl = L_GameTpl:getPetFeedItemTpl()
local _petDnaType = L_GameTpl:getPetDnaTypeTpl()
local skillLevelTpl = L_GameTpl:getSkillLevelTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {
    id = nil,
    guid = nil,
    rarity = {
      [1] = "UI/Atlas/PetBoxNew/tex_pet_bg_tips_yinzibg1_s.png",
      [2] = "UI/Atlas/PetBoxNew/tex_pet_bg_tips_yinzibg1_s.png",
      [3] = "UI/Atlas/PetBoxNew/tex_pet_bg_tips_yinzibg2_s.png",
      [4] = "UI/Atlas/PetBoxNew/tex_pet_bg_tips_yinzibg3_s.png",
      [5] = "UI/Atlas/PetBoxNew/tex_pet_bg_tips_yinzibg4_s.png",
      [6] = "UI/Atlas/PetBoxNew/tex_pet_bg_tips_yinzibg5.png"
    },
    rarity2 = {
      [1] = "UI/Atlas/PetBoxNew/tex_pet_bg2_tips_yinzibg1_s.png",
      [2] = "UI/Atlas/PetBoxNew/tex_pet_bg2_tips_yinzibg1_s.png",
      [3] = "UI/Atlas/PetBoxNew/tex_pet_bg2_tips_yinzibg2_s.png",
      [4] = "UI/Atlas/PetBoxNew/tex_pet_bg2_tips_yinzibg3_s.png",
      [5] = "UI/Atlas/PetBoxNew/tex_pet_bg2_tips_yinzibg4_s.png",
      [6] = "UI/Atlas/PetBoxNew/tex_pet_bg2_tips_yinzibg5.png"
    }
  }
end

function module.bind()
  return {
    bg = "",
    show_lockBg = false,
    active_specialLevel = false,
    active_levelList = false,
    levelList = {
      moduleName = "pages/Pet/cellDotStarItem"
    },
    active_line = true,
    active_debuffLine = false,
    geneNameText = "",
    show_rarity = false,
    lock_color = C_Color.white,
    color_line = C_Color(1, 1, 1, 0.3),
    showLockInfo = false,
    lockInfo = "",
    geneDescText = "",
    dnaTypeImg = "",
    dnaTypeColor = C_Color.white,
    dnaTypeBgColor = C_Color.white,
    active_isTalent = false,
    innateColor = C_Color.white,
    txtInnateColor = C_Color.white,
    empty = false,
    content = true
  }
end

function module.methods()
  return {}
end

function module:refresh()
  self:refreshInfo()
end

function module:refreshInfo()
  if self.bind.empty then
    return
  end
  local displayName = L_PetStore:getGeneDisplayName(self.bind.skillName, self.bind.genePos, nil, self.bind.geneId)
  self.bind.geneNameText = displayName
  self.bind.dnaTypeImg = self.bind.dnaTypeIcon
  if not math.isEmpty(self.bind.geneId) then
    local innateGeneResult = L_PetStore:isInnateGene(self.bind.genePos, self.bind.geneId)
    self.bind.active_isTalent = innateGeneResult
    local isSpecialGene = self.bind.rarity >= #self.data.rarity
    local isTopGene = self.bind.rarity == #self.data.rarity - 1
    self.bind.show_rarity = isTopGene
    if self.bind.useStyle2 then
      self.bind.bg = self.data.rarity2[self.bind.rarity]
    else
      self.bind.bg = self.data.rarity[self.bind.rarity]
    end
    if isSpecialGene then
      self.bind.geneNameText = string.format("<color=#4c5e87>%s</color>", displayName)
      self.bind.lock_color = C_Color(0.3, 0.369, 0.53, 0.5)
      self.bind.dnaTypeColor = C_Color(1, 1, 1, 1)
      self.bind.dnaTypeBgColor = C_Color(0.234375, 0.3671875, 0.4179687, 0.3)
      self.bind.innateColor = C_Color(0.234375, 0.3671875, 0.4179687, 0.3)
      local _, txtColor = C_ColorUtility.TryParseHtmlString("#4c5e87")
      self.bind.txtInnateColor = txtColor
      self.bind.active_line = true
      self.bind.active_debuffLine = false
    elseif isTopGene then
      self.bind.geneNameText = string.format("<color=#FFD65B>%s</color>", displayName)
      self.bind.lock_color = C_Color(0.9843137, 0.8666667, 0.5843138, 0.7)
      self.bind.dnaTypeColor = C_Color(1, 0.8359375, 0.3554687, 1)
      self.bind.dnaTypeBgColor = C_Color(0, 0, 0, 0.3)
      self.bind.innateColor = C_Color(0, 0, 0, 0.3)
      local _, txtColor = C_ColorUtility.TryParseHtmlString("#FFD65B")
      self.bind.txtInnateColor = txtColor
    else
      self.bind.geneNameText = string.format("<color=#FFFFFF>%s</color>", displayName)
      self.bind.lock_color = C_Color(1, 1, 1, 0.7)
      self.bind.dnaTypeColor = C_Color(1, 1, 1, 1)
      self.bind.dnaTypeBgColor = C_Color(0, 0, 0, 0.1)
      self.bind.innateColor = C_Color(0, 0, 0, 0.1)
      local _, txtColor = C_ColorUtility.TryParseHtmlString("#FFFFFF")
      self.bind.txtInnateColor = txtColor
    end
    if isSpecialGene then
      self.bind.color_line = C_Color(0.7, 0.9, 0.97, 0.3)
    else
      self.bind.color_line = C_Color(1, 1, 1, 0.3)
    end
    self.bind.active_levelList = not isSpecialGene
    self.bind.active_specialLevel = isSpecialGene
    if not isSpecialGene then
      self.bind.levelList:clear()
      self.star = self.bind.rarity - 2
      local data = {}
      if 0 < self.star then
        for i = 1, self.star do
          table.insert(data, {start_color = 1})
        end
      else
        table.insert(data, {start_color = 0.5})
      end
      self.bind.active_line = true
      self.bind.active_debuffLine = false
      self.bind.levelList:insert_array(data)
    end
  end
  self.bind.geneDescText = self.bind.describe
  self.bind.showLockInfo = self.bind.show_lockBg
  local unlockList = L_PetManager:getGeneUnlockConditions()
  if self.bind.showLockInfo == true then
    self.bind.lockInfo = L_WordsTpl:getValue("ui_moduleCanteenFree_03", {
      [0] = unlockList[self.bind.genePos]
    })
  end
end

function module:showDetail(isOn)
  if self.bind.skillLevelTpl == nil then
    return
  end
  if isOn then
    self.bind.geneDescText = skillLevelTpl:getSkillDetailDescribe(self.bind.skillLevelTpl)
  else
    self.bind.geneDescText = skillLevelTpl:getSkillDescribe(self.bind.skillLevelTpl)
  end
end

function module:setIsKiboArenaTip(isKiboArena)
  self.isKiboArena = isKiboArena
  if isKiboArena then
    local displayName = L_PetStore:getGeneDisplayName(self.bind.skillName, self.bind.genePos, nil, self.bind.geneId)
    local isSpecialGene = self.bind.rarity >= #self.data.rarity
    if isSpecialGene then
      self.bind.geneNameText = string.format("<color=#FFFFFF>%s</color>", displayName)
    end
  end
end

function module:setData(itemId)
  local petFeedTpl = _petFeedItemTpl:getTplById(itemId)
  self.bind.geneId = _petFeedItemTpl:getDnaParam(petFeedTpl)
  local geneTpl = _petDnaTpl:getTplById(self.bind.geneId)
  self.bind.skillName = _petDnaTpl:getName(geneTpl)
  local type = _petDnaTpl:getDnaType(geneTpl)
  self.bind.dnaTypeIcon = _petDnaType:getIcon(_petDnaType:getTplById(type))
  self.bind.rarity = _petDnaTpl:getRarity(geneTpl)
  local skilltpl = skillLevelTpl:getTplByIdAndLevel(self.bind.geneId, 1)
  self.bind.describe = skillLevelTpl:getSkillDescribe(skilltpl)
  self:refreshInfo()
  self:showDetail(true)
end

return module
