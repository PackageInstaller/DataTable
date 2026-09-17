local this = class("pagePetGeneChange", G_UIPageBase)
local _petFeedItemTpl = L_GameTpl:getPetFeedItemTpl()
local _petDnaTpl = L_GameTpl:getDnaTpl()
local _skillLevelTpl = L_GameTpl:getSkillLevelTpl()
local _skillTpl = L_GameTpl:getSkillTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    modulePetGeneSkillsChangeMode = {
      moduleName = "pages/pet/new/modulePetNewGeneInfo"
    },
    go_selectEmpty = true,
    go_selectGene = false,
    moduleSelectGene = {
      moduleName = "pages/pet/cellGeneMutation"
    },
    moduleChangeGene = {
      moduleName = "pages/pet/cellGeneMutation"
    },
    go_preview = true,
    go_result = false,
    moduleResultOriGene = {
      moduleName = "pages/pet/cellGeneMutation"
    },
    moduleResultNowGene = {
      moduleName = "pages/pet/cellGeneMutation"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_abandon = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_confirm = function(self)
      self:confirmGeneChange()
    end
  }
end

function this:preOpen(options)
  self.options = options or {}
  self:refreshPage()
end

function this:show()
  self:refreshPage()
end

function this:refreshPage()
  self.selectedChangeModeGene = nil
  self.bind.go_preview = true
  self.bind.go_result = false
  self.bind.go_selectEmpty = true
  self.bind.go_selectGene = false
  local modulePetGeneSkillsChangeMode = self.modules and self.modules.modulePetGeneSkillsChangeMode
  if modulePetGeneSkillsChangeMode then
    local function onChooseGene(geneData)
      self:onChooseGene(geneData)
    end
    
    if modulePetGeneSkillsChangeMode.setChooseGeneCallback then
      modulePetGeneSkillsChangeMode:setChooseGeneCallback(onChooseGene)
    else
      modulePetGeneSkillsChangeMode.chooseGeneCallback = onChooseGene
    end
    if modulePetGeneSkillsChangeMode.setHideNewTag then
      modulePetGeneSkillsChangeMode:setHideNewTag(true)
    end
    modulePetGeneSkillsChangeMode:setPreUseGeneFruitInfoList({})
    modulePetGeneSkillsChangeMode:setGuid(self.options and self.options.petGuid)
    modulePetGeneSkillsChangeMode:refreshGeneSelectState()
  end
  self.changeGeneData = self:getChangeGeneShowData()
  self:refreshMutationGeneModule(self.modules and self.modules.moduleChangeGene, self.changeGeneData)
end

function this:onChooseGene(geneData)
  if table.isEmpty(geneData) then
    return
  end
  if L_PetStore:isInnateGene(geneData.genePos, geneData.geneId) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pet_talentdnatips"))
    return
  end
  self.selectedChangeModeGene = table.clone(geneData)
  self.selectedChangeModeGene.selected = true
  self.bind.go_selectGene = true
  self.bind.go_selectEmpty = false
  local modulePetGeneSkillsChangeMode = self.modules and self.modules.modulePetGeneSkillsChangeMode
  if modulePetGeneSkillsChangeMode then
    modulePetGeneSkillsChangeMode:refreshGeneSelectState(geneData)
  end
  self:refreshMutationGeneModule(self.modules and self.modules.moduleSelectGene, self.selectedChangeModeGene)
end

function this:confirmGeneChange()
  if self.isConfirming then
    return
  end
  if table.isEmpty(self.selectedChangeModeGene) or table.isEmpty(self.changeGeneData) then
    return
  end
  local targetRarity = L_PetStore:getShiningPetDnaRarity()
  if L_PetStore:isDeviantGene(self.changeGeneData.geneGroupId) then
    local limitCount = L_GameConstTpl:getData("NESTCOOP_DEVIANT_PETDNA_LIMIT", L_Const.GameTplType.int)
    local petGuid = self.options and self.options.petGuid
    local excludeGenePos = self.selectedChangeModeGene and self.selectedChangeModeGene.genePos
    if limitCount and L_PetStore:checkPetHasDeviantGene(petGuid, limitCount, excludeGenePos) then
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
  local selectedRarity = self.selectedChangeModeGene.dnaRarity or self.selectedChangeModeGene.rarity
  if selectedRarity and selectedRarity == targetRarity then
    L_GameUtil.showCommonTip({
      txtContent = L_WordsTpl:getValue("notice_pet_specialdnatips"),
      confirmCallback = function()
        self:doConfirmGeneChange()
      end
    })
    return
  end
  self:doConfirmGeneChange()
end

function this:doConfirmGeneChange()
  local confirmCallback = self.options and self.options.confirmCallback
  if not confirmCallback then
    return
  end
  self.isConfirming = true
  confirmCallback(self.selectedChangeModeGene, self.changeGeneData, function(isSuccess)
    self.isConfirming = false
    if isSuccess == false then
      return
    end
    self:showGeneChangeResult(self.selectedChangeModeGene, self.changeGeneData)
  end)
end

function this:showGeneChangeResult(oriGeneInfo, nowGeneInfo)
  local oriGeneData = self:getMutationGeneShowDataByGeneInfo(oriGeneInfo)
  local genePos = type(oriGeneInfo) == "table" and (oriGeneInfo.genePos or oriGeneInfo.pos) or nil
  local nowGeneId = self:getGeneIdByGeneInfo(nowGeneInfo)
  local nowGeneData = self:getMutationGeneShowData(nowGeneId, genePos)
  if table.isEmpty(oriGeneData) or table.isEmpty(nowGeneData) then
    return
  end
  self.bind.go_preview = false
  self.bind.go_result = true
  self:refreshMutationGeneModule(self.modules and self.modules.moduleResultOriGene, oriGeneData)
  self:refreshMutationGeneModule(self.modules and self.modules.moduleResultNowGene, nowGeneData)
end

function this:getMutationGeneShowDataByGeneInfo(geneInfo)
  if geneInfo == nil or type(geneInfo) == "table" and table.isEmpty(geneInfo) then
    return
  end
  local geneId = self:getGeneIdByGeneInfo(geneInfo)
  local genePos = type(geneInfo) == "table" and (geneInfo.genePos or geneInfo.pos) or nil
  if not math.isEmpty(geneId) then
    return self:getMutationGeneShowData(geneId, genePos)
  end
  if type(geneInfo) ~= "table" then
    return
  end
  return {
    geneId = geneInfo.geneId or geneInfo.gene_id or 0,
    geneGroupId = geneInfo.geneGroupId or 0,
    genePos = genePos,
    skillName = geneInfo.skillName or "",
    skillDescribe = geneInfo.skillDescribe or geneInfo.describe or "",
    dnaRarity = geneInfo.dnaRarity or geneInfo.rarity or 0
  }
end

function this:getChangeGeneShowData()
  local changeGeneInfo = self:getGeneFruitInfoList()[1]
  local geneId = self:getGeneIdByGeneInfo(changeGeneInfo)
  return self:getMutationGeneShowData(geneId)
end

function this:getMutationGeneShowData(geneId, genePos)
  if math.isEmpty(geneId) then
    return
  end
  local skillLevelTpl = _skillLevelTpl:getTplByIdAndLevel(geneId, 1)
  if not skillLevelTpl then
    return
  end
  local skillGroupId = tonumber(_skillLevelTpl:getSkillGroupId(skillLevelTpl))
  local skillTpl = _skillTpl:getTplById(skillGroupId)
  local dnaTpl = _petDnaTpl:getTplById(skillGroupId)
  if not skillTpl or not dnaTpl then
    return
  end
  return {
    geneId = geneId,
    geneGroupId = skillGroupId,
    genePos = genePos,
    skillName = _skillTpl:getName(skillTpl),
    skillDescribe = _skillLevelTpl:getSkillDescribe(skillLevelTpl),
    dnaRarity = _petDnaTpl:getRarity(dnaTpl)
  }
end

function this:refreshMutationGeneModule(geneModule, geneData)
  if not geneModule or table.isEmpty(geneData) then
    return
  end
  geneModule:setGeneInfo(geneData)
end

function this:getGeneFruitInfoList()
  local options = self.options or {}
  if not table.isEmpty(options.geneFruitInfoList) then
    return options.geneFruitInfoList
  end
  if not table.isEmpty(options.preUseGeneFruitInfoList) then
    return options.preUseGeneFruitInfoList
  end
  return {}
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

function this:close()
  if self.options and self.options.closeCallback then
    self.options.closeCallback()
  end
end

return this
