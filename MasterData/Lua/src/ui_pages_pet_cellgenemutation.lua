local module = class("cellGeneMutation", G_UIModuleBase)
local _skillLevelTpl = L_GameTpl:getSkillLevelTpl()
local _skillTpl = L_GameTpl:getSkillTpl()
local _petDnaTpl = L_GameTpl:getDnaTpl()
local rarity = {
  [1] = {
    color = "#8A8A8A",
    decImg = "UI/Icon/PetBoxNew/tex_dna_mutation_icon_star_pz1.png",
    bgImg = "UI/Icon/PetBoxNew/tex_dna_mutation_icon_pz1.png",
    bgColor = "A4A8AC"
  },
  [2] = {
    color = "#8A8A8A",
    decImg = "UI/Icon/PetBoxNew/tex_dna_mutation_icon_star_pz1.png",
    bgImg = "UI/Icon/PetBoxNew/tex_dna_mutation_icon_pz1.png",
    bgColor = "A4A8AC"
  },
  [3] = {
    color = "#6CAADD",
    decImg = "UI/Icon/PetBoxNew/tex_dna_mutation_icon_star_pz2.png",
    bgImg = "UI/Icon/PetBoxNew/tex_dna_mutation_icon_pz2.png",
    bgColor = "8BC1E7"
  },
  [4] = {
    color = "#9B84CB",
    decImg = "UI/Icon/PetBoxNew/tex_dna_mutation_icon_star_pz3.png",
    bgImg = "UI/Icon/PetBoxNew/tex_dna_mutation_icon_pz3.png",
    bgColor = "CC9DFC"
  },
  [5] = {
    color = "#D99738",
    decImg = "UI/Icon/PetBoxNew/tex_dna_mutation_icon_star_pz4.png",
    bgImg = "UI/Icon/PetBoxNew/tex_dna_mutation_icon_pz4.png",
    bgColor = "FFD44A"
  },
  [6] = {
    isGradientColor = true,
    linearColor1 = "#8BB4E7",
    linearColor2 = "#CF88E9",
    decImg = "UI/Icon/PetBoxNew/tex_dna_mutation_icon_star_pz5.png",
    bgImg = "UI/Icon/PetBoxNew/tex_dna_mutation_icon_pz5.png",
    bgColor = "DEE9FF"
  }
}

function module.bind()
  return {
    img_geneBg = "",
    txt_geneName = "",
    txt_geneDesc = "",
    img_dec = "",
    color_bg = nil,
    active_promotion = false
  }
end

function module:preBind(bindData)
  self.geneData = self:formatGeneData(bindData)
end

function module:refresh()
  self:refreshGeneInfo()
end

function module:setGeneInfo(geneData)
  if table.isEmpty(geneData) then
    return
  end
  self.geneData = self:formatGeneData(geneData)
  self:refreshGeneInfo()
end

function module:formatGeneData(geneData)
  if table.isEmpty(geneData) then
    return
  end
  return {
    geneId = geneData.geneId or geneData.gene_id or 0,
    geneGroupId = geneData.geneGroupId or 0,
    genePos = geneData.genePos or geneData.pos or 0,
    skillName = geneData.skillName or "",
    skillDescribe = geneData.skillDescribe or geneData.describe or "",
    dnaRarity = geneData.dnaRarity or geneData.rarity or 0
  }
end

function module:getGeneInfo(geneId)
  if math.isEmpty(geneId) then
    return
  end
  local skillLvCfg = _skillLevelTpl:getTplByIdAndLevel(geneId, 1)
  if skillLvCfg == nil then
    return
  end
  local skillGroupId = tonumber(_skillLevelTpl:getSkillGroupId(skillLvCfg))
  local skillCfg = _skillTpl:getTplById(skillGroupId)
  local dnaTpl = _petDnaTpl:getTplById(skillGroupId)
  if skillCfg == nil or dnaTpl == nil then
    return
  end
  return {
    geneId = geneId,
    geneGroupId = skillGroupId,
    skillName = _skillTpl:getName(skillCfg),
    skillDescribe = _skillLevelTpl:getSkillDescribe(skillLvCfg),
    dnaRarity = _petDnaTpl:getRarity(dnaTpl)
  }
end

function module:resetGeneNameGradient()
  local gradient = self.bindComponents and self.bindComponents.geneNameGradient
  if gradient then
    gradient.enabled = false
  end
end

function module:refreshGeneInfo()
  self:resetGeneNameGradient()
  if table.isEmpty(self.geneData) then
    return
  end
  local geneId = self.geneData.geneId
  local skillName = self.geneData.skillName
  local skillDescribe = self.geneData.skillDescribe
  local dnaRarity = self.geneData.dnaRarity
  if string.isEmpty(skillName) or string.isEmpty(skillDescribe) or math.isEmpty(dnaRarity) then
    local geneInfo = self:getGeneInfo(geneId)
    if geneInfo == nil then
      return
    end
    skillName = geneInfo.skillName
    skillDescribe = geneInfo.skillDescribe
    dnaRarity = geneInfo.dnaRarity
    self.geneData.geneGroupId = geneInfo.geneGroupId
    self.geneData.skillName = skillName
    self.geneData.skillDescribe = skillDescribe
    self.geneData.dnaRarity = dnaRarity
  end
  local rarityCfg = rarity[dnaRarity]
  if rarityCfg == nil then
    return
  end
  self.bind.img_geneBg = rarityCfg.bgImg
  self.bind.txt_geneDesc = skillDescribe
  local _, bgColor = C_ColorUtility.TryParseHtmlString("#" .. rarityCfg.bgColor)
  self.bind.img_dec = rarityCfg.decImg
  self.bind.color_bg = bgColor
  if rarityCfg.isGradientColor then
    local _, topColor = C_ColorUtility.TryParseHtmlString(rarityCfg.linearColor1)
    local _, bottomColor = C_ColorUtility.TryParseHtmlString(rarityCfg.linearColor2)
    local gradient = self.bindComponents and self.bindComponents.geneNameGradient
    if gradient then
      gradient.enabled = true
      gradient.LinearColor1 = topColor
      gradient.LinearColor2 = bottomColor
    end
    self.bind.txt_geneName = skillName
    return
  end
  self.bind.txt_geneName = L_GameUtil.fillColor(skillName, rarityCfg.color)
end

return module
