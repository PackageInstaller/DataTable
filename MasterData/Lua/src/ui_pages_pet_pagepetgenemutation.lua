local this = class("pagePetGeneMutation", G_UIPageBase)
local _skillLevelTpl = L_GameTpl:getSkillLevelTpl()
local _skillTpl = L_GameTpl:getSkillTpl()
local petDnaTpl = L_GameTpl:getDnaTpl()
local _petFeedItemTpl = L_GameTpl:getPetFeedItemTpl()
local ADD_GENE_ANIM_IN = "anim_pagepetgenemutation_addgene_in"
local ADD_GENE_ANIM_OUT = "anim_pagepetgenemutation_addgene_out"
local EXCHANGE_GENE_ANIM_IN = "anim_pagepetgenemutation_exchangegene_in"
local EXCHANGE_GENE_ANIM_KEEP = "anim_pagepetgenemutation_exchangegene_keep"
local EXCHANGE_GENE_ANIM_MUTATION = "anim_pagepetgenemutation_exchangegene_mutation"
local EXCHANGE_GENE_ANIM_SAVE = "anim_pagepetgenemutation_exchangegene_save"
local EXCHANGE_GENE_ANIM_SAVE_IN = "anim_pagepetgenemutation_exchangegene_save_in"
local EXCHANGE_GENE_ANIM_LEVELUP = "anim_pagepetgenemutation_exchangegene_levelup"

function this.bind()
  return {
    go_addMode = false,
    list_AddGene = {
      moduleName = "pages/pet/cellGeneMutation"
    },
    go_exchangeMode = false,
    cellOriGene = {
      moduleName = "pages/pet/cellGeneMutation"
    },
    cellNewGene = {
      moduleName = "pages/pet/cellGeneMutation"
    },
    anim_Mutation = EXCHANGE_GENE_ANIM_IN,
    go_btnQuit = true,
    go_btnConfirm = true,
    go_normalGeneTip = true,
    go_innateGeneTip = false,
    go_btnSave = true,
    go_VxMutation = true,
    go_VxGeneLevelUp = false,
    txt_title = ""
  }
end

function this.methods()
  return {
    onClick_quit = function(self)
      self:onBtnQuit()
    end,
    onClick_confirm = function(self)
      self:onBtnConfirm()
    end,
    onAnimEnd = function(self)
      self:onAnimEnd()
    end,
    onClick_empty = function(self)
      self:onBtnClose()
    end,
    onClick_changeClose = function(self)
      self:onBtnChangeClose()
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.options = options or {}
  self.petId = self.options.petId or self.options.petGuid
  self.geneId = self.options.geneId or 0
  self.geneFruitInfoList = self.options.geneFruitInfoList
  if self.options.showAdd then
    self.bind.txt_title = L_WordsTpl:getValue("ui_pet_dna_title_02")
  else
    self.bind.txt_title = L_WordsTpl:getValue("ui_pet_dna_title_01")
  end
  if not table.isEmpty(self.geneFruitInfoList) or not math.isEmpty(self.geneId) then
    self.bind.anim_Mutation = ADD_GENE_ANIM_IN
  else
    self.bind.anim_Mutation = self:getExchangeEntryAnim()
  end
end

function this:getExchangeEntryAnim()
  if self.options and self.options.playExchangeSaveIn then
    return EXCHANGE_GENE_ANIM_SAVE_IN
  end
  if self:isInnateGeneMutation() then
    return EXCHANGE_GENE_ANIM_LEVELUP
  end
  return EXCHANGE_GENE_ANIM_IN
end

function this:isInnateGeneMutation()
  if math.isEmpty(self.petId) then
    return false
  end
  local petItem = L_PetStore:getPetItem(self.petId)
  if not petItem then
    return false
  end
  local mutation_info = petItem:getMutationInfo()
  if not mutation_info then
    return false
  end
  for i, gene in pairs(petItem.gene_infos) do
    if gene.pos == mutation_info.pos then
      return L_PetStore:isInnateGene(gene.pos, gene.gene_id)
    end
  end
  return false
end

function this:open()
  if table.isEmpty(self.geneFruitInfoList) and math.isEmpty(self.geneId) and self:isInnateGeneMutation() then
    L_AudioUtil.playSound("Play_SFX_System_UI_QiboDNA_Mutation")
  else
    L_AudioUtil.playSound("Play_SFX_System_UI_QiboDNA_Pop")
  end
  self:initPage()
  self.bindComponents.viewport_interact.enabled = #self.bind.list_AddGene >= 4
end

function this:initPage()
  if not table.isEmpty(self.geneFruitInfoList) then
    self:initAddModeByGeneFruitInfoList(self.geneFruitInfoList)
    return
  end
  if not math.isEmpty(self.geneId) then
    self:initAddMode(self.geneId)
    return
  end
  local petItem = L_PetStore:getPetItem(self.petId)
  local mutation_info = petItem:getMutationInfo()
  local oldInfo
  for i, gene in pairs(petItem.gene_infos) do
    if gene.pos == mutation_info.pos then
      oldInfo = gene
      break
    end
  end
  self.bind.go_addMode = false
  self.bind.go_exchangeMode = true
  self.bind.anim_Mutation = self:getExchangeEntryAnim()
  local isInnateMutation = self:isInnateGeneMutation()
  if isInnateMutation then
    self.bind.go_VxGeneLevelUp = true
    self.bind.go_VxMutation = false
  else
    self.bind.go_VxMutation = true
    self.bind.go_VxGeneLevelUp = false
  end
  if oldInfo then
    local oldGeneData = self:getGeneShowData(oldInfo.gene_id, oldInfo.pos)
    if oldGeneData then
      self.oldGeneRarity = oldGeneData.dnaRarity
      self:refreshGeneModule("cellOriGene", oldGeneData)
    end
  end
  local newGeneData = self:getGeneShowData(mutation_info.gene_id, mutation_info.pos)
  if newGeneData then
    self.newGeneRarity = newGeneData.dnaRarity
    self.mutationGeneId = newGeneData.geneGroupId
    self.mutationGenePos = mutation_info.pos
    self:refreshGeneModule("cellNewGene", newGeneData)
  end
  local cellNewGene = self.modules and self.modules.cellNewGene
  if isInnateMutation then
    self.bind.go_btnQuit = false
    self.bind.go_btnConfirm = false
    self.bind.go_normalGeneTip = false
    self.bind.go_innateGeneTip = true
    self.bind.go_btnSave = false
    if cellNewGene then
      cellNewGene.bind.active_promotion = true
    end
    L_PetStore:req_chooseGeneMutation(self.petId, true, function()
      L_PetStore:call(L_PetStore.event.refreshPetGeneMutation, self.petId)
    end)
    return
  else
    self.bind.go_btnQuit = true
    self.bind.go_btnConfirm = true
    self.bind.go_normalGeneTip = true
    self.bind.go_innateGeneTip = false
    self.bind.go_btnSave = true
    if cellNewGene then
      cellNewGene.bind.active_promotion = false
    end
  end
end

function this:initAddMode(geneId)
  self.bind.go_addMode = true
  self.bind.go_exchangeMode = false
  self.bind.anim_Mutation = ADD_GENE_ANIM_IN
  local listAddGene = self.bind.list_AddGene
  if listAddGene == nil or listAddGene.clear == nil then
    return
  end
  listAddGene:clear()
  local geneData = self:getGeneShowData(geneId)
  if geneData then
    listAddGene:insert_array({geneData})
  end
end

function this:initAddModeByGeneFruitInfoList(geneFruitInfoList)
  self.isGeneFruitAddMode = true
  self.bind.go_addMode = true
  self.bind.go_exchangeMode = false
  self.bind.anim_Mutation = ADD_GENE_ANIM_IN
  local listAddGene = self.bind.list_AddGene
  if listAddGene == nil or listAddGene.clear == nil then
    return
  end
  listAddGene:clear()
  local geneList = {}
  for index, geneInfo in ipairs(geneFruitInfoList) do
    local geneId = self:getGeneIdByGeneInfo(geneInfo)
    local geneData = self:getGeneShowData(geneId, index)
    if geneData then
      table.insert(geneList, geneData)
    end
  end
  if 0 < #geneList then
    listAddGene:insert_array(geneList)
  end
end

function this:getGeneIdByGeneInfo(geneInfo)
  if type(geneInfo) == "number" then
    local petFeedItemTpl = _petFeedItemTpl:getTplById(geneInfo)
    if petFeedItemTpl then
      return _petFeedItemTpl:getDnaParam(petFeedItemTpl)
    end
    return geneInfo
  end
  if type(geneInfo) ~= "table" then
    return
  end
  local itemId = geneInfo.itemId or geneInfo.item_id
  if itemId then
    local petFeedItemTpl = _petFeedItemTpl:getTplById(itemId)
    return petFeedItemTpl and _petFeedItemTpl:getDnaParam(petFeedItemTpl)
  end
  return geneInfo.geneId or geneInfo.gene_id or geneInfo.id
end

function this:getGeneShowData(geneId, genePos)
  if math.isEmpty(geneId) then
    return
  end
  local skillLvCfg = _skillLevelTpl:getTplByIdAndLevel(geneId, 1)
  if skillLvCfg == nil then
    return
  end
  local skillGroupId = tonumber(_skillLevelTpl:getSkillGroupId(skillLvCfg))
  local skillCfg = _skillTpl:getTplById(skillGroupId)
  local dnaTpl = petDnaTpl:getTplById(skillGroupId)
  if skillCfg == nil or dnaTpl == nil then
    return
  end
  return {
    geneId = geneId,
    geneGroupId = skillGroupId,
    genePos = genePos,
    skillName = _skillTpl:getName(skillCfg),
    skillDescribe = _skillLevelTpl:getSkillDescribe(skillLvCfg),
    dnaRarity = petDnaTpl:getRarity(dnaTpl)
  }
end

function this:getGeneRarity(geneId)
  local geneData = self:getGeneShowData(geneId)
  return geneData and geneData.dnaRarity or 0
end

function this:refreshGeneModule(moduleKey, geneData)
  local geneModule = self.modules and self.modules[moduleKey]
  if not geneModule or table.isEmpty(geneData) then
    return
  end
  geneModule:setGeneInfo(geneData)
end

function this:onBtnQuit()
  if self.isGeneFruitAddMode then
    L_UI:close(self.pageName)
    return
  end
  L_GameUtil.showCommonTip({
    txtContent = L_WordsTpl:getValue("notice_pagePetGeneMutation_01"),
    confirmCallback = function()
      L_PetStore:req_chooseGeneMutation(self.petId, false, function()
        L_PetStore:call(L_PetStore.event.refreshPetGeneMutation, self.petId)
        L_AudioUtil.playSound("Play_SFX_System_UI_QiboDNA_Keep")
        self.bind.anim_Mutation = EXCHANGE_GENE_ANIM_KEEP
      end)
    end
  })
end

function this:onBtnConfirm()
  if self.isGeneFruitAddMode then
    L_UI:close(self.pageName)
    return
  end
  local content = L_WordsTpl:getValue("notice_pagePetGeneMutation_02")
  if math.isEmpty(self.geneId) then
    local petItem = L_PetStore:getPetItem(self.petId)
    local mutation_info = petItem:getMutationInfo()
    local oldRarity = 0
    for i, gene in pairs(petItem.gene_infos) do
      if gene.pos == mutation_info.pos then
        oldRarity = self:getGeneRarity(gene.gene_id)
        break
      end
    end
    local newRarity = self:getGeneRarity(mutation_info.gene_id)
    if oldRarity > newRarity then
      content = L_WordsTpl:getValue("notice_dna_mutation_rarity_double_check")
    end
  end
  local targetRarity = L_PetStore:getShiningPetDnaRarity()
  if L_PetStore:isDeviantGene(self.mutationGeneId) then
    local limitCount = L_GameConstTpl:getData("NESTCOOP_DEVIANT_PETDNA_LIMIT", L_Const.GameTplType.int)
    if limitCount and L_PetStore:checkPetHasDeviantGene(self.petId, limitCount, self.mutationGenePos) then
      L_GameUtil.showCommonTip({
        txtContent = L_WordsTpl:getValue("notice_deviantpetdnalimit", {
          [0] = limitCount
        }),
        hideCancel = true,
        confirmCallback = function()
          return
        end
      })
      return
    end
  end
  if self.oldGeneRarity and self.oldGeneRarity == targetRarity then
    L_GameUtil.showCommonTip({
      txtContent = L_WordsTpl:getValue("notice_pet_specialdnatips"),
      confirmCallback = function()
        L_PetStore:req_chooseGeneMutation(self.petId, true, function()
          L_PetStore:call(L_PetStore.event.refreshPetGeneMutation, self.petId)
          L_AudioUtil.playSound("Play_SFX_System_UI_QiboDNA_Mutation")
          self.bind.anim_Mutation = EXCHANGE_GENE_ANIM_MUTATION
        end)
      end
    })
    return
  end
  L_GameUtil.showCommonTip({
    txtContent = content,
    confirmCallback = function()
      L_PetStore:req_chooseGeneMutation(self.petId, true, function()
        L_PetStore:call(L_PetStore.event.refreshPetGeneMutation, self.petId)
        L_AudioUtil.playSound("Play_SFX_System_UI_QiboDNA_Mutation")
        self.bind.anim_Mutation = EXCHANGE_GENE_ANIM_MUTATION
      end)
    end
  })
end

function this:onBtnEmpty()
  L_UI:close(self.pageName)
end

function this:onBtnClose()
  if self.bind.go_addMode then
    self:closeAddModeWithAnim()
    return
  end
end

function this:closeAddModeWithAnim()
  if self.isClosing then
    return
  end
  self.isClosing = true
  self.bind.anim_Mutation = ADD_GENE_ANIM_OUT
end

function this:onBtnChangeClose()
  if self.isClosing then
    return
  end
  self.isClosing = true
  self.bind.anim_Mutation = EXCHANGE_GENE_ANIM_SAVE
end

function this:onAnimEnd()
  local animName = self.bind.anim_Mutation
  if animName == EXCHANGE_GENE_ANIM_IN or animName == EXCHANGE_GENE_ANIM_SAVE_IN or animName == ADD_GENE_ANIM_IN then
    return
  end
  L_UI:close(self.pageName)
end

function this:close(options)
  local closeCallback = self.options and self.options.closeCallback
  if closeCallback then
    closeCallback()
  end
  this.super.close(self, options)
end

return this
