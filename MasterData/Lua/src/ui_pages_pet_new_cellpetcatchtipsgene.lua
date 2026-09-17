local module = class("cellPetCatchTipsGene", G_UIModuleBase)
local petDna = L_GameTpl:getDnaTpl()

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
    }
  }
end

function module.bind()
  return {
    toggle_scanIsLock = false,
    bg = "",
    show_lockBg = false,
    active_specialLevel = false,
    active_levelList = false,
    levelList = {
      moduleName = "pages/Pet/cellDotStarItem"
    },
    active_line = false,
    active_debuffLine = false,
    geneNameText = "",
    show_rarity = false,
    lock_color = C_Color.white,
    color_line = C_Color(1, 1, 1, 0.3),
    showLockInfo = false,
    showDescInfo = false,
    geneDescText = "",
    active_gene = true,
    active_lockLine = false,
    active_isInnate = false,
    innateColor = C_Color.white,
    txtInnateColor = C_Color.white
  }
end

function module.methods()
  return {}
end

function module:refresh()
  self:refreshInfo()
end

function module:refreshInfo()
  if not self.bind.isDetails then
    self.bind.skillName = "? ? ? ? ? ?"
  end
  self.bind.toggle_scanIsLock = math.isEmpty(self.bind.geneId)
  if not self.bind.toggle_scanIsLock then
    local displayName = L_PetStore:getGeneDisplayName(self.bind.skillName, self.bind.genePos, nil, self.bind.geneId)
    local geneNameText = displayName
    local isSpecialGene = self.bind.rarity >= #self.data.rarity
    local isTopGene = self.bind.rarity == #self.data.rarity - 1
    self.bind.show_rarity = isTopGene
    self.bind.bg = self.data.rarity[self.bind.rarity]
    if self.bind.taskLock then
      self.bind.show_lockBg = true
      geneNameText = self.bind.txt_geneLockTip
    end
    if isSpecialGene then
      self.bind.geneNameText = string.format("<color=#4c5e87>%s</color>", geneNameText)
      self.bind.lock_color = C_Color(0.3, 0.369, 0.53, 0.5)
      self.bind.active_line = true
      self.bind.active_debuffLine = false
      self.bind.innateColor = C_Color(0.234375, 0.3671875, 0.4179687, 0.3)
      local _, txtColor = C_ColorUtility.TryParseHtmlString("#4c5e87")
      self.bind.txtInnateColor = txtColor
    elseif isTopGene then
      self.bind.geneNameText = string.format("<color=#FFD65B>%s</color>", geneNameText)
      self.bind.lock_color = C_Color(0.9843137, 0.8666667, 0.5843138, 0.7)
      self.bind.innateColor = C_Color(0, 0, 0, 0.3)
      local _, txtColor = C_ColorUtility.TryParseHtmlString("#FFD65B")
      self.bind.txtInnateColor = txtColor
    else
      self.bind.geneNameText = string.format("<color=#FFFFFF>%s</color>", geneNameText)
      self.bind.lock_color = C_Color(1, 1, 1, 0.7)
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
      if 0 < self.star then
        local data = {}
        for i = 1, self.star do
          table.insert(data, {})
        end
        self.bind.levelList:insert_array(data)
        self.bind.active_line = true
        self.bind.active_debuffLine = false
      else
        self.bind.active_line = false
        self.bind.active_debuffLine = true
      end
    end
  end
  if self.bind.isDetails and not self.bind.taskLock then
    self.bind.showDescInfo = true
    self.bind.geneDescText = self.bind.describe
  else
    self.bind.showDescInfo = false
  end
end

return module
