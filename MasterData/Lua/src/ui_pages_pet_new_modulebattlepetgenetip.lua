local this = class("moduleBattlePetGeneTip", G_UIModuleBase)
local _enemyTpl = L_GameTpl:getEnemyTpl()
local _petTpl = L_GameTpl:getPetTpl()

function this.bind()
  return {
    active_tip = false,
    list_tipGeneList = {
      moduleName = "pages/pet/new/cellPetCatchTipsGene"
    },
    name = "",
    lv = "",
    show_empty = false,
    active_switchBtn = false,
    modulePetBoxRating = {
      moduleName = "pages/pet/new/modulePetBoxRating"
    }
  }
end

function this.methods()
  return {
    onClick_btn = function(self)
      self:emit("onClick")
    end
  }
end

function this:open()
  self.monsterEntity = nil
  self.index = 0
  self.bind.active_tip = false
  self.grade = nil
  self.geneData = nil
end

function this:show()
  if not table.isEmpty(self.petInfo) then
    self:setSelectMonster()
  end
end

function this:close()
end

function this:hide()
  self.bind.active_tip = false
end

function this:setSelectMonster(showSwitchBtn)
  if table.isEmpty(self.petInfo) then
    return
  end
  self.showSwitchBtn = showSwitchBtn
  self.index = AzurWorld.PetCatchManagerMgr:GetCatchCurSelectIndex()
  self.monsterEntity = AzurWorld.PetCatchManagerMgr:GetSelectMonsterList()[self.index]
  if not self.monsterEntity.entity:CanBeChosen() then
    self:hide()
    return
  end
  local level = self.monsterEntity.data.level
  local configId = self.monsterEntity.data.configId
  local tpl = _enemyTpl:getTplById(configId)
  local petCatalogData = L_CatalogStore:getPetCatalogByPetId(_enemyTpl:getPetId(tpl)) or {}
  self.taskLevel = petCatalogData.lv or 1
  local catchPetId
  if tpl then
    catchPetId = _enemyTpl:getPetId(tpl)
    local petTpl = _petTpl:getTplById(catchPetId)
    if petTpl then
      self.bind.name = _petTpl:getName(petTpl)
    end
  end
  self.bind.lv = string.format("Lv.%d", level)
  print("当前怪物Index:" .. self.index)
  for i, v in pairs(self.petInfo) do
    if self.monsterEntity.data.UUID == v.uuid then
      self.grade = v.grade
      self.geneData = v.geneInfos
      self.geneSize = v.geneSize
      self.rank = v.rank
      break
    end
  end
  if self.geneData == nil or self.grade == nil then
    return
  end
  self.parseGeneData = {}
  local scanLevel = L_PetManager:judgeShowScanPet()
  if 4 < scanLevel then
    local catchPetCfg = catchPetId and _petTpl:getTplById(catchPetId)
    local catchPetRare = catchPetCfg and catchPetCfg.petrare or 0
    local catchPetStage = catchPetCfg and _petTpl:getPetStage(catchPetCfg) or 1
    self.modules.modulePetBoxRating:setGrade(self.grade, catchPetStage, catchPetRare)
  elseif 1 < scanLevel then
    self.modules.modulePetBoxRating:setLockGrade(self.rank)
  else
    self.modules.modulePetBoxRating:setLockGradeAndRank()
  end
  for i = 1, self.geneSize do
    table.insert(self.parseGeneData, {})
  end
  local index = 1
  for i, v in pairs(self.geneData) do
    self.parseGeneData[index] = L_PetManager:parseGeneInfo(v.geneId)
    index = index + 1
  end
  self:showTip()
end

function this:showTip()
  self.bind.active_tip = true
  self:refreshView()
end

function this:refreshView()
  if table.isEmpty(self.parseGeneData) then
    self.bind.show_empty = true
    self.bind.active_switchBtn = false
    return
  end
  self.bind.active_switchBtn = self.showSwitchBtn
  print(self.showSwitchBtn)
  self.bind.list_tipGeneList:clear()
  local genelist = self.parseGeneData
  table.sort(genelist, function(a, b)
    if math.isEmpty(a.rarity) then
      return false
    end
    if math.isEmpty(b.rarity) then
      return true
    end
    return a.rarity < b.rarity
  end)
  local scanLevel = L_PetManager:judgeShowScanPet()
  if 2 < scanLevel then
    local showGene = 3 < scanLevel
    for k, gene in ipairs(genelist) do
      local showGeneDetails = 4 < scanLevel
      gene.index = k
      gene.geneId = showGene and gene.geneId or nil
      gene.rarity = showGene and gene.rarity or nil
      gene.isDetails = showGeneDetails
      gene.petLv = self.monsterEntity.data.level
      gene.taskLock = showGeneDetails and (gene.index == 3 and self.taskLevel <= 5 or gene.index == 4 and self.taskLevel < 10)
      if showGeneDetails then
        if gene.index == 3 and self.taskLevel <= 5 then
          gene.txt_geneLockTip = L_WordsTpl:getValue("notice_lens_dna_info_third")
        elseif gene.index == 4 and self.taskLevel < 10 then
          gene.txt_geneLockTip = L_WordsTpl:getValue("notice_lens_dna_info_forth")
        end
      end
    end
    self.bind.list_tipGeneList:insert_array(genelist)
    self.bind.show_empty = table.isEmpty(genelist) and true or false
  end
end

function this:setPetData(data, isDetails)
  self.petInfo = data
  self.isDetails = isDetails
end

return this
