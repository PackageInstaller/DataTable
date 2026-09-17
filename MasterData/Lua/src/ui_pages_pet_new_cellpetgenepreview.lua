local module = class("cellPetGenePreview", G_UIModuleBase)
local _skillLevelTpl = L_GameTpl:getSkillLevelTpl()

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
      [5] = "",
      [6] = ""
    },
    rarityColor = {
      [1] = "#898E93",
      [2] = "#898E93",
      [3] = "#6CAADD",
      [4] = "#A394C4",
      [5] = "#D99738",
      [6] = "#A493B9"
    }
  }
end

function module.bind()
  return {
    selected = false,
    bg = "",
    show_lockBg = false,
    color_lockBg = C_Color(1, 1, 1, 0.7),
    active_goldNode = false,
    active_specialNode = false,
    active_specialLevel = false,
    active_levelList = false,
    levelList = {
      moduleName = "pages/Pet/cellDotStarItem"
    },
    active_line = true,
    active_debuffLine = false,
    color_line = C_Color(1, 1, 1, 0.3),
    geneNameText = "",
    show_rarity = false,
    active_newTag = false,
    active_mutationTag = false,
    dnaTypeImg = "",
    dnaTypeColor = C_Color.white,
    dnaTypeBgColor = C_Color.white,
    txt_geneDesc = "",
    active_isInnate = false,
    innateColor = C_Color.white,
    txtInnateColor = C_Color.white
  }
end

function module.methods()
  return {
    onClick_Choose = function(self)
      self:emit("onClick_Choose", self.bind)
    end
  }
end

function module:refresh()
  self:refreshInfo()
end

function module:refreshData(data)
  self.bind.geneId = data.geneId
  self.bind.lock = data.lock
  self.bind.gene_skill = data.gene_skill
  self.bind.pos = data.pos
  self.bind.gene_name = data.gene_name
  self.bind.rarity = data.rarity
  self.bind.geneLv = data.geneLv
  self.bind.describe = data.describe
  self.bind.rectPos = nil
  self.bind.petId = data.petId
  self:refreshInfo()
end

function module:refreshDataWithSkillId(skillId)
  local skillIdInfo = skillId
  local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
  local skillTpl = L_GameTpl:getSkillTpl()
  local petDna = L_GameTpl:getDnaTpl()
  local petDnaType = L_GameTpl:getPetDnaTypeTpl()
  local tpl = skillLevelTpl:getTplByIdAndLevel(skillId, 1)
  local nameTpl = skillTpl:getTplById(tonumber(skillLevelTpl:getSkillGroupId(tpl)))
  local dnaTpl = petDna:getTplById(tonumber(skillLevelTpl:getSkillGroupId(tpl)))
  local dnaRarity = petDna:getRarity(dnaTpl)
  local skillName = skillTpl:getName(nameTpl)
  local skillDescribe = skillLevelTpl:getSkillDescribe(tpl)
  local dnaType = petDna:getDnaType(dnaTpl)
  local dnaTypeTpl = petDnaType:getTplById(dnaType)
  local dnaTypeIcon = petDnaType:getIcon(dnaTypeTpl)
  local data = {
    geneId = skillId,
    describe = skillDescribe,
    skillName = skillName,
    rarity = dnaRarity,
    dnaTypeIcon = dnaTypeIcon
  }
  self.bind.geneId = data.geneId
  self.bind.skillName = data.skillName
  self.bind.rarity = data.rarity
  self.bind.dnaTypeIcon = data.dnaTypeIcon
  self.bind.describe = data.describe
  self:refreshInfo()
end

function module:setSelected(isSelected)
  self.bind.selected = isSelected
end

function module:getGeneDesc()
  if not string.isEmpty(self.bind.describe) then
    return self.bind.describe
  end
  if math.isEmpty(self.bind.geneId) then
    return ""
  end
  local skillLevelTpl = _skillLevelTpl:getTplByIdAndLevel(self.bind.geneId, 1)
  return skillLevelTpl and _skillLevelTpl:getSkillDescribe(skillLevelTpl) or ""
end

function module:refreshInfo()
  if self.bind.rectPos then
    self.bindComponents.geneTrans.localPosition = self.bind.rectPos
  end
  self.bind.active_isTalent = L_PetStore:isInnateGene(self.bind.genePos, self.bind.geneId)
  local displayName = L_PetStore:getGeneDisplayName(self.bind.skillName, self.bind.genePos, nil, self.bind.geneId)
  self.bind.geneNameText = displayName
  self.bind.dnaTypeImg = self.bind.dnaTypeIcon
  self.bind.txt_geneDesc = self:getGeneDesc()
  if not math.isEmpty(self.bind.geneId) then
    local isSpecialGene = self.bind.rarity >= #self.data.rarity
    local isTopGene = self.bind.rarity >= #self.data.rarity - 1
    self.bind.show_rarity = isTopGene
    if self.bind.show_rarity then
      if isSpecialGene then
        self.bind.color_lockBg = C_Color(0.3, 0.369, 0.53, 0.5)
      else
        self.bind.color_lockBg = C_Color(0.9843137, 0.8666667, 0.5843138, 0.7)
      end
      self.bind.active_goldNode = not isSpecialGene
      self.bind.active_specialNode = isSpecialGene
    else
      self.bind.color_lockBg = C_Color(1, 1, 1, 0.7)
    end
    if isSpecialGene then
      self.bind.color_line = C_Color(0.7058824, 0.8901961, 0.972549, 0.3)
    else
      self.bind.color_line = C_Color(1, 1, 1, 0.3)
    end
    if self.bgRarity ~= self.data.rarity[self.bind.rarity] then
      self.bgRarity = self.data.rarity[self.bind.rarity]
      self.bind.bg = self.data.rarity[self.bind.rarity]
    end
    self.bind.active_levelList = not isSpecialGene
    self.bind.active_specialLevel = isSpecialGene
    if not isSpecialGene then
      self.bind.levelList:clear()
      self.star = self.bind.rarity - 2
      local data = {}
      if self.star > 0 then
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
    local isMutationTag = false
    local isNewTag = self.bind.isPreviewNewGene == true
    local petItem = L_PetStore:getPetItem(self.bind.petId)
    if petItem then
      if petItem:hasMutationGene() and petItem:getMutationInfo().pos == self.bind.genePos then
        isMutationTag = true
      end
      if not isNewTag and L_PetStore:checkIsNewGene(self.bind.petId, self.bind.genePos) then
        isNewTag = true
      end
    end
    if isSpecialGene then
      self.bind.geneNameText = string.format("<color=#4c5e87>%s</color>", displayName)
      self.bind.active_line = true
      self.bind.active_debuffLine = false
      self.bind.dnaTypeColor = C_Color(1, 1, 1, 1)
      self.bind.dnaTypeBgColor = C_Color(0.234375, 0.3671875, 0.4179687, 0.3)
      self.bind.innateColor = C_Color(0.234375, 0.3671875, 0.4179687, 0.3)
      local _, txtColor = C_ColorUtility.TryParseHtmlString("#4c5e87")
      self.bind.txtInnateColor = txtColor
    elseif isTopGene then
      self.bind.geneNameText = string.format("<color=#FFD65B>%s</color>", displayName)
      self.bind.dnaTypeColor = C_Color(1, 0.8359375, 0.3554687, 1)
      self.bind.dnaTypeBgColor = C_Color(0, 0, 0, 0.3)
      self.bind.innateColor = C_Color(0, 0, 0, 0.3)
      local _, txtColor = C_ColorUtility.TryParseHtmlString("#FFD65B")
      self.bind.txtInnateColor = txtColor
    elseif isMutationTag then
      self.bind.geneNameText = L_GameUtil.fillColor(displayName, self.data.rarityColor[self.bind.rarity])
      local _, txtColor = C_ColorUtility.TryParseHtmlString(self.data.rarityColor[self.bind.rarity])
      self.bind.txtInnateColor = txtColor
    end
    if not isSpecialGene and not isTopGene then
      self.bind.dnaTypeColor = C_Color(1, 1, 1, 1)
      self.bind.dnaTypeBgColor = C_Color(0, 0, 0, 0.1)
      self.bind.innateColor = C_Color(0, 0, 0, 0.1)
    end
    self.bind.active_mutationTag = isMutationTag
    self.bind.active_newTag = isNewTag
  end
  self.bind.show_lockBg = self.bind.lock
  if not self.bindComponents.info_layout then
    return
  end
  L_GameUtil.forceRebuildLayout(self.bindComponents.info_layout)
end

function module:showTipBubbleWithCurrentInfo(bubbleDir)
  local skillId = self.bind.geneId
  if skillId == nil or skillId == -1 then
    return
  end
  local openTip = L_UI:getPage("pageTipBubble")
  if openTip ~= nil and (openTip.data or {}).tipBubbleSkillId == skillId then
    L_UI:close("pageTipBubble")
    return
  end
  local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
  local skillTpl = L_GameTpl:getSkillTpl()
  local petDna = L_GameTpl:getDnaTpl()
  local petDnaType = L_GameTpl:getPetDnaTypeTpl()
  local tpl = skillLevelTpl:getTplByIdAndLevel(skillId, 1)
  local nameTpl = skillTpl:getTplById(tonumber(skillLevelTpl:getSkillGroupId(tpl)))
  local dnaTpl = petDna:getTplById(tonumber(skillLevelTpl:getSkillGroupId(tpl)))
  local dnaRarity = petDna:getRarity(dnaTpl)
  local skillName = skillTpl:getName(nameTpl)
  local skillDescribe = skillLevelTpl:getSkillDescribe(tpl)
  local dnaType = petDna:getDnaType(dnaTpl)
  local dnaTypeTpl = petDnaType:getTplById(dnaType)
  local dnaTypeIcon = petDnaType:getIcon(dnaTypeTpl)
  local data = {
    geneId = skillId,
    describe = skillDescribe,
    skillName = skillName,
    dnaTypeIcon = dnaTypeIcon,
    rarity = dnaRarity,
    show_lockBg = false,
    skillLevelTpl = tpl
  }
  local modulePetGeneSkillsTips_Path = "UI/Pages/Nest/modulePetGeneSkillsNestCoopTips.prefab"
  local modulePetGeneSkillsTips = "ui.pages.pet.new.modulePetGeneSkillsNestCoopTips"
  local dataList = {}
  table.insert(dataList, data)
  if bubbleDir == nil then
    bubbleDir = 0
  end
  local inData
  if bubbleDir == 0 then
    inData = {
      modulePetGeneSkillsTips_Path,
      modulePetGeneSkillsTips,
      dataList,
      self.bindComponents.root_rect,
      bubbleDir,
      true,
      1,
      C_Vector2(9, 14),
      C_Vector2(120, 0),
      C_Vector3(0, 0, 0)
    }
  else
    inData = {
      modulePetGeneSkillsTips_Path,
      modulePetGeneSkillsTips,
      dataList,
      self.bindComponents.root_rect,
      bubbleDir,
      true,
      1,
      C_Vector2(9, 14),
      C_Vector2(250, 0),
      C_Vector3(0, 0, 0)
    }
  end
  inData.tipBubbleSkillId = skillId
  inData[14] = true
  inData[15] = 10
  inData[16] = true
  L_UI:open("pageTipBubble", {data = inData})
end

return module
