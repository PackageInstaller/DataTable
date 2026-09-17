local this = class("modulePetGeneInfo", G_UIModuleBase)

function this.bind()
  return {
    geneSkillList = {
      moduleName = "pages/Pet/cellPetGene"
    },
    showLockInfo = false,
    lockInfo = "",
    geneName = "",
    geneDesc = "",
    active_tip = false,
    cellPetGene = {
      moduleName = "pages/Pet/cellPetGene"
    }
  }
end

function this.methods()
  return {
    geneSkillList = {
      onClick_Choose = function(self, data)
        self:showTip(data)
        self:refreshGeneSelectState(data)
      end
    }
  }
end

function this:open()
  self.pet = nil
  self.skillData = {}
end

function this:setGuid(guid)
  self.pet = L_PetStore:getPetItem(guid)
  self.bind.geneSkillList:clear()
  local genelist = L_PetStore:getPetSkills(self.pet, true, true, false)
  table.sort(genelist, function(a, b)
    return a.genePos < b.genePos
  end)
  for k, gene in ipairs(genelist) do
    gene.index = k
  end
  self.bind.geneSkillList:insert_array(genelist)
end

function this:showTip(geneData)
  self.bind.active_tip = true
  self.modules.cellPetGene:refreshData(geneData)
  local unlockList = L_PetManager:getGeneUnlockConditions()
  self.bind.geneName = geneData.skillName
  self.bind.geneDesc = geneData.describe
  if geneData.show_lockBg ~= nil then
    self.bind.showLockInfo = geneData.show_lockBg
    if self.bind.showLockInfo == true then
      self.bind.lockInfo = L_WordsTpl:getValue("ui_moduleCanteenFree_03", {
        [0] = unlockList[geneData.genePos]
      })
    end
  end
  L_UI:open("pageBlank", {
    callback = function()
      self.bind.active_tip = false
      self:refreshGeneSelectState()
    end
  })
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

return this
