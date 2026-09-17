local this = class("modulePetGene", G_UIModuleBase)
local petDna = L_GameTpl:getDnaTpl()
local petSkillLevel = L_GameTpl:getSkillLevelTpl()
local skillTpl = L_GameTpl:getSkillTpl()
local POSITION = {
  [1] = L_Vector3.new(-78.2, 427.3, 0),
  [2] = L_Vector3.new(309.17, 421.9, 0),
  [3] = L_Vector3.new(-72.1, 283.1, 0),
  [4] = L_Vector3.new(249.1, 280, 0),
  [5] = L_Vector3.new(-36.2, 123.6, 0),
  [6] = L_Vector3.new(141.6, 123.8, 0),
  [7] = L_Vector3.new(-167.3, -96.5, 0),
  [8] = L_Vector3.new(62.2, -98.5, 0),
  [9] = L_Vector3.new(-270, -252.9, 0),
  [10] = L_Vector3.new(92, -255.9, 0),
  [11] = L_Vector3.new(-323.4, -405.6, 0),
  [12] = L_Vector3.new(106, -409.5, 0)
}

function this:ctor(...)
  this.super.ctor(self, ...)
  self._screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle
  self.data = {
    geneGrid = {
      [1] = {},
      [2] = {},
      [3] = {},
      [4] = {},
      [5] = {},
      [6] = {}
    },
    initialGrid = {
      gene_name = "",
      gene_skill = "",
      pos = 0,
      lock = false,
      geneId = 0,
      geneColor = 0,
      rarity = 0,
      geneLv = 0,
      gridSize = 0
    },
    geneColor = {
      [1] = "#e98b8b",
      [2] = "#799258",
      [3] = "#d6b16c",
      [4] = "#8fb4e3"
    },
    effectIcon = {
      [1] = "Pages/Pet/tex_pet_frame_reinforce_red",
      [2] = "Pages/Pet/tex_pet_frame_reinforce_green",
      [3] = "Pages/Pet/tex_pet_frame_reinforce_yellow",
      [4] = "Pages/Pet/tex_pet_frame_reinforce_blue",
      [5] = "Pages/Pet/tex_pet_frame_reinforce_multi"
    }
  }
end

function this.bind()
  return {
    geneList = {
      moduleName = "pages/pet/cellPetGene"
    },
    show_desc = false,
    desc = "",
    geneName = "",
    cellPetGeneDetail = {
      moduleName = "pages/pet/cellPetGene"
    },
    decUnlockActive = false,
    decUnlockText = ""
  }
end

function this.methods()
  return {
    geneList = {
      onClick_Choose = function(self, data)
        self:showGeneDetail(data)
      end
    },
    onClick_hideSkillDetail = function(self)
      self.bind.show_desc = false
    end
  }
end

function this:open()
  self.curSelectedGene = nil
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet, self)
  L_PetStore:listenCallFunc(L_PetStore.event.setCurPetId, self.onEvent_setCurPetId, self)
end

function this:close()
  if not table.isEmpty(self.timerGroup) then
    for _, v in pairs(self.timerGroup) do
      Timer.remove(v)
    end
    self.timerGroup = nil
  end
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet)
  L_PetStore:unListenCallFunc(L_PetStore.event.setCurPetId, self.onEvent_setCurPetId)
end

function this:onEvent_refreshPet(pet)
  if pet.guid ~= self.pet.guid then
    return
  end
  self:refreshGeneList(pet)
end

function this:onEvent_setCurPetId(guid)
  if self.pet and self.pet.guid ~= guid then
    self:refreshGeneList(L_PetStore:getPetItem(guid))
  end
end

function this:refreshGeneList(pet)
  if pet == nil then
    return
  end
  self.pet = pet
  self:initPetGene(pet)
end

function this:refreshGeneGrid()
  local geneGrid = self.data.geneGrid
  local data = {}
  for i, v in ipairs(geneGrid) do
    table.insert(data, {
      geneId = v.geneId,
      lock = v.lock,
      pos = v.pos,
      gene_skill = v.gene_skill,
      gene_name = v.gene_name,
      rarity = v.rarity,
      geneLv = v.geneLv,
      geneColor = v.geneColor,
      rectPos = v.rectPos,
      unlockTips = v.unlockTips
    })
  end
  self.bind.geneList:clear()
  self.bind.geneList:insert_array(data)
end

function this:initPetGene(pet, isHideUnlock)
  self.bind.show_desc = false
  self.pet = pet
  self.data.geneGrid = {}
  for i = 1, 12 do
    table.insert(self.data.geneGrid, {
      geneId = 0,
      lock = false,
      pos = i,
      gene_skill = "",
      gene_name = "",
      rarity = 0,
      geneLv = 0,
      geneColor = 0,
      rectPos = POSITION[i]
    })
  end
  self.petGene = {}
  for _, v in pairs(pet.gene_infos) do
    table.insert(self.petGene, v)
  end
  self:convertPetGeneData(self.petGene, pet.gene_state, pet.ur_pos)
  self:refreshGeneGrid()
end

function this:convertPetGeneData(petGene, gene_state, ur_pos)
  local unlockConditions = L_PetManager:getGeneUnlockConditions()
  for i = 1, #petGene do
    local petDnaTpl = petDna:getTplById(petGene[i].gene_id)
    local rarity = petDna:getRarity(petDnaTpl)
    local color = petDna:getType(petDnaTpl)
    local pos = petGene[i].pos
    local petSkillLevelTpl = petSkillLevel:getTplByIdAndLevel(petGene[i].gene_id, 1)
    local petSkillDescribe = petSkillLevel:getSkillDescribe(petSkillLevelTpl)
    local nameTpl = skillTpl:getTplById(petGene[i].gene_id)
    local name = skillTpl:getName(nameTpl)
    local geneData = self.data.geneGrid[pos]
    if geneData then
      geneData.geneId = petGene[i].gene_id
      geneData.lock = self.pet.lv < (unlockConditions[pos] or 0)
      geneData.gene_skill = petSkillDescribe
      geneData.pos = pos
      geneData.gene_name = name
      geneData.rarity = rarity
      geneData.geneLv = petGene[i].gene_lv
      geneData.geneColor = pos == ur_pos and 5 or color
      geneData.unlockTips = L_WordsTpl:getValue("notice_modulePetGene_01", {
        [0] = unlockConditions[pos]
      })
    end
  end
end

function this:showGeneDetail(geneData)
  if math.isEmpty(geneData.geneId) then
    self.bind.show_desc = false
    return
  end
  self.bind.show_desc = true
  self.bind.desc = geneData.gene_skill
  self.bind.geneName = geneData.gene_name
  self.modules.cellPetGeneDetail:refreshData(geneData)
  self.bind.decUnlockText = geneData.unlockTips
  self.bind.decUnlockActive = geneData.lock
end

function this:playMutationAnim()
  if not table.isEmpty(self.mutationIndex) then
    self.timerGroup = {}
    for _, v in ipairs(self.mutationIndex) do
      self.timerGroup[v.index] = Timer.once(0.33, function()
        self.bind.geneList:getItemCls(v.index):playMutationAnim(function()
          self:changeSingleGene(v.index, v.geneId)
        end)
      end, self, self.gameObject)
    end
  end
end

function this:setMutationBeforeGene(mutaionInfo)
  self.mutationIndex = {}
  for _, v in ipairs(mutaionInfo) do
    for i, gene in ipairs(self.bind.geneList) do
      if gene.geneId == v.mutationGeneId then
        table.insert(self.mutationIndex, {
          index = i,
          geneId = v.mutationGeneId
        })
        self:changeSingleGene(i, v.sourceGeneId)
        break
      end
    end
  end
  if #self.mutationIndex > 1 then
    table.sort(self.mutationIndex, function(a, b)
      return a.index < b.index
    end)
  end
end

function this:changeSingleGene(i, geneId)
  local petDnaTpl = petDna:getTplById(geneId)
  local rarity = petDna:getRarity(petDnaTpl)
  local color = petDna:getType(petDnaTpl)
  local petSkillLevelTpl = petSkillLevel:getTplByIdAndLevel(geneId, 1)
  local petSkillDescribe = petSkillLevel:getSkillDescribe(petSkillLevelTpl)
  local nameTpl = skillTpl:getTplById(geneId)
  local name = skillTpl:getName(nameTpl)
  local pos = self.bind.geneList[i].pos
  self.bind.geneList:change(i, {
    geneId = geneId,
    gene_skill = petSkillDescribe,
    gene_name = name,
    rarity = rarity,
    geneColor = pos == self.pet.ur_pos and 5 or color
  })
end

return this
