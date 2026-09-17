local this = class("modulePetNewGeneInfo", G_UIModuleBase)
local _petFeedItemTpl = L_GameTpl:getPetFeedItemTpl()
local _petDnaTpl = L_GameTpl:getDnaTpl()
local _petDnaTypeTpl = L_GameTpl:getPetDnaTypeTpl()
local _skillLevelTpl = L_GameTpl:getSkillLevelTpl()
local _skillTpl = L_GameTpl:getSkillTpl()
local _skillSubLogicTpl = L_GameTpl:getSkillsubLogicTpl()
local moduleGeneTipPath = "UI/Pages/PetBox/modulePetBoxGeneTip.prefab"
local moduleGeneTipLuaPath = "ui.pages.pet.new.modulePetBoxGeneTip"
local GENE_TIPS_ROW_COUNT = 2

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {useTipBubble = false}
  self.hideNewTag = false
  self.previewNewTagOnly = false
  self.previewGeneFxPlayedCount = 0
end

function this.bind()
  return {
    geneSkillList = {
      moduleName = "pages/pet/new/cellPetNewGene"
    },
    active_tip = false,
    list_tipGeneList = {
      moduleName = "pages/pet/new/cellPetTipsGene"
    },
    size_scrollGene = C_Vector2(728, 700),
    size_tipBoard = C_Vector2(750, 853),
    go_newDown = false,
    tog_Detail = nil
  }
end

function this.methods()
  return {
    geneSkillList = {
      onClick_Choose = function(self, data)
        if self.chooseGeneCallback then
          self.chooseGeneCallback(data)
          return
        end
        if self.data.useTipBubble then
          if self.bindComponents.rect_nodeTip == nil then
            C_MJLog.LogError("[modulePetNewGeneInfo]rect_nodeTip Binding lost")
            return
          end
          if L_UI:checkPageOpen("pageTipBubble") then
            L_UI:close("pageTipBubble")
            return
          end
          L_UI:open("pageTipBubble", {
            data = {
              moduleGeneTipPath,
              moduleGeneTipLuaPath,
              self.pet,
              self.bindComponents.rect_nodeTip.transform,
              0,
              true,
              1,
              C_Vector2(10, 10),
              C_Vector2(-85.6, -25.7),
              nil,
              false,
              nil,
              {0},
              true
            }
          })
        else
          self:showTip()
        end
      end
    },
    onClick_close = function(self)
      self.bind.active_tip = false
    end,
    onScroll_geneList = function(self)
      self:updateScrollNew()
    end,
    onValueChanged_Detail = function(self, isOn)
      self:showDetail(isOn)
      self:refreshSizeDelta()
      L_PetStore:setShowPetSkillDetail(isOn)
      if self.bindComponents.toggleAnimation then
        self.bindComponents.toggleAnimation:PlayMapChangeAnimation()
      end
      self:fixContentPos()
    end
  }
end

function this:open()
end

function this:fixContentPos()
  if self.bindComponents.tip_content then
    local pos = self.bindComponents.tip_content.anchoredPosition
    pos.y = 0
    self.bindComponents.tip_content.anchoredPosition = pos
  end
end

function this:hide()
  self.bind.active_tip = false
end

function this:updateScrollNew()
  if self.hideNewTag then
    self.bind.go_newDown = false
    return
  end
  local haveNewUp, haveNewBottom = false
  local showMinIndex = math.maxinteger
  local showMaxIndex = math.mininteger
  for i, v in ipairs(self.modules.list_tipGeneList) do
    if not v.bind.empty then
      if v.isBind then
        showMinIndex = math.min(showMinIndex, v.bind.index)
        showMaxIndex = math.max(showMaxIndex, v.bind.index)
      elseif showMinIndex > v.bind.index then
        haveNewUp = true
      elseif showMaxIndex < v.bind.index then
        haveNewBottom = true
      end
    end
  end
  self.bind.go_newDown = haveNewBottom
end

function this:showTip()
  self.bind.active_tip = true
  self:refreshView()
  self.bind.tog_Detail = L_PetStore:isShowPetSkillDetail()
  if self.bind.tog_Detail == true then
    self:showDetail(true)
  end
  self:refreshSizeDelta()
end

function this:setUseTipBubble(_useTipBubble)
  self.data.useTipBubble = _useTipBubble
end

function this:setHideNewTag(hideNewTag)
  self.hideNewTag = hideNewTag == true
end

function this:setPreviewNewTagOnly(previewNewTagOnly)
  self.previewNewTagOnly = previewNewTagOnly == true
end

function this:padGeneTipListRow(geneList)
  local count = #geneList
  if count <= 0 then
    return geneList
  end
  local padCount = (GENE_TIPS_ROW_COUNT - count % GENE_TIPS_ROW_COUNT) % GENE_TIPS_ROW_COUNT
  for _ = 1, padCount do
    table.insert(geneList, {empty = true, content = false})
  end
  return geneList
end

function this:refreshView()
  if table.isEmpty(self.pet) then
    return
  end
  self:fixContentPos()
  self.bind.geneSkillList:clear()
  self.bind.list_tipGeneList:clear()
  local genelist = L_PetStore:getPetSkills(self.pet, true, true, false)
  local genelist2 = L_PetStore:getPetSkills(self.pet, true, true, false)
  table.sort(genelist, function(a, b)
    return a.genePos < b.genePos
  end)
  self:appendPreviewGeneList(genelist)
  for k, gene in ipairs(genelist) do
    gene.index = k
    if self.hideNewTag then
      gene.hideNewTag = true
      gene.active_newTag = false
    elseif self.previewNewTagOnly and not gene.isPreviewNewGene then
      gene.hideNewTag = true
      gene.active_newTag = false
    end
  end
  table.sort(genelist2, function(a, b)
    return a.genePos < b.genePos
  end)
  self:appendPreviewGeneList(genelist2)
  for k, gene in ipairs(genelist2) do
    gene.index = k
  end
  self.geneData = genelist
  self.bind.geneSkillList:insert_array(genelist)
  self:padGeneTipListRow(genelist2)
  self.bind.list_tipGeneList:insert_array(genelist2)
  self.previewGeneFxPlayedCount = #(self.preUseGeneFruitInfoList or {})
end

function this:setGuid(guid)
  self.pet = L_PetStore:getPetItem(guid)
  self.previewGeneFxPlayedCount = 0
  if self.bind.active_tip == true then
    self:showTip()
  else
    self:refreshView()
  end
end

function this:setPreUseGeneFruitInfoList(preUseGeneFruitInfoList)
  self.preUseGeneFruitInfoList = preUseGeneFruitInfoList or {}
  local previewCount = #self.preUseGeneFruitInfoList
  if previewCount <= 0 then
    self.previewGeneFxPlayedCount = 0
  elseif previewCount < (self.previewGeneFxPlayedCount or 0) then
    self.previewGeneFxPlayedCount = previewCount
  end
  self:refreshView()
end

function this:setChooseGeneCallback(callback)
  self.chooseGeneCallback = callback
end

function this:appendPreviewGeneList(geneList)
  if table.isEmpty(self.preUseGeneFruitInfoList) then
    return
  end
  local maxGenePos = 0
  for _, gene in ipairs(geneList) do
    maxGenePos = math.max(maxGenePos, gene.genePos or 0)
  end
  local playedPreviewFxCount = self.previewGeneFxPlayedCount or 0
  local previewIndex = 0
  for _, preUseGeneFruitInfo in ipairs(self.preUseGeneFruitInfoList) do
    previewIndex = previewIndex + 1
    local previewGene = self:getPreviewGeneData(preUseGeneFruitInfo.itemId, maxGenePos + 1)
    if previewGene then
      previewGene.playPreviewFx = playedPreviewFxCount < previewIndex
      table.insert(geneList, previewGene)
      maxGenePos = maxGenePos + 1
    end
  end
end

function this:getPreviewGeneData(itemId, genePos)
  local petFeedItemTpl = _petFeedItemTpl:getTplById(itemId)
  if not petFeedItemTpl then
    return
  end
  local geneId = _petFeedItemTpl:getDnaParam(petFeedItemTpl)
  local skillLevelTpl = _skillLevelTpl:getTplByIdAndLevel(geneId, 1)
  if not skillLevelTpl then
    return
  end
  local skillGroupId = tonumber(_skillLevelTpl:getSkillGroupId(skillLevelTpl))
  local skillTpl = _skillTpl:getTplById(skillGroupId)
  local dnaTpl = _petDnaTpl:getTplById(skillGroupId)
  local dnaType = _petDnaTpl:getDnaType(dnaTpl)
  local dnaTypeTpl = _petDnaTypeTpl:getTplById(dnaType)
  local skillPowerType = _skillLevelTpl:getSkillPowerType(skillLevelTpl)
  return {
    index = geneId,
    geneId = geneId,
    skillLv = "Lv.1",
    skillLevelShow = true,
    levelLabel = false,
    itemIcon = _skillTpl:getIcon(skillTpl),
    describe = _skillLevelTpl:getSkillDescribe(skillLevelTpl),
    skillName = _skillTpl:getName(skillTpl),
    starLv = 1,
    rarity = _petDnaTpl:getRarity(dnaTpl),
    genePos = genePos,
    show_lockBg = false,
    petId = self.pet.guid,
    dnaType = dnaType,
    dnaTypeName = _petDnaTypeTpl:getName(dnaTypeTpl),
    dnaTypeIcon = _petDnaTypeTpl:getIcon(dnaTypeTpl),
    skillLevelTpl = skillLevelTpl,
    skillPowerName = _skillLevelTpl:getSkillPowerName(skillLevelTpl),
    skillPower = _skillLevelTpl:getSkillPower(skillLevelTpl),
    name = skillPowerType,
    selected = true,
    active_newTag = true,
    isPreviewNewGene = true
  }
end

function this:refreshGeneSelectState(data)
  for i = 1, #self.bind.geneSkillList do
    if table.isEmpty(data) then
      self.bind.geneSkillList:change(i, {selected = false})
    elseif i == data.index then
      self.bind.geneSkillList:change(i, {selected = true})
    else
      self.bind.geneSkillList:change(i, {selected = false})
    end
  end
end

function this:refreshSizeDelta()
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.geneList)
  self.bind.size_tipBoard = C_Vector2(750, math.min(self.bindComponents.geneList.sizeDelta.y, 700) + 86)
  self.bind.size_scrollGene = C_Vector2(728, math.min(self.bindComponents.geneList.sizeDelta.y, 700))
  self.bindComponents.scrollView_content.enabled = self.bindComponents.geneList.sizeDelta.y > 700
end

function this:showDetail(isOn)
  for i, v in pairs(self.modules.list_tipGeneList) do
    if not v.bind.empty then
      v:showDetail(isOn)
    end
  end
end

return this
