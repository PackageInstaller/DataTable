local module = class("cellPetGetGene", G_UIModuleBase)
local petDna = L_GameTpl:getDnaTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {
    id = nil,
    guid = nil,
    rarity = {
      [1] = 1,
      [2] = 1,
      [3] = 2,
      [4] = 3,
      [5] = 4,
      [6] = 5
    }
  }
end

function module.bind()
  return {
    normalName = "",
    shiningName = "",
    purpleName = "",
    goldName = "",
    greyName = "",
    rarity_0 = false,
    rarity_1 = false,
    rarity_2 = false,
    rarity_3 = false,
    rarity_4 = false,
    innateGene_0 = false,
    innateGene_1 = false,
    innateGene_2 = false,
    innateGene_3 = false,
    innateGene_4 = false
  }
end

function module.methods()
  return {
    on_click = function(self)
      if self.action then
        self.action()
      end
    end
  }
end

function module:refresh()
  self:refreshInfoDefault()
end

function module:addAction(data)
  self.action = data
end

function module:refreshInfoDefault()
  if self.bind.type == "hide" then
    return
  end
  local displayName = L_PetStore:getGeneDisplayName(self.bind.skillName, self.bind.genePos, nil, self.bind.geneId)
  self.bind.normalName = displayName
  self.bind.shiningName = displayName
  self.bind.goldName = displayName
  self.bind.purpleName = displayName
  self.bind.greyName = displayName
  if not math.isEmpty(self.bind.geneId) then
    local geneIndex = self.data.rarity[self.bind.rarity] - 1
    local rarityName = string.format("rarity_%d", geneIndex)
    local innateGeneName = string.format("innateGene_%d", geneIndex)
    self.bind[rarityName] = true
    self.bind[innateGeneName] = L_PetStore:isInnateGene(self.bind.genePos, self.bind.geneId)
  end
end

function module:refreshInfo(skillName, geneId, rarity, genePos)
  local displayName = L_PetStore:getGeneDisplayName(skillName, genePos, nil, geneId)
  self.bind.normalName = displayName
  self.bind.shiningName = displayName
  self.bind.goldName = displayName
  self.bind.purpleName = displayName
  self.bind.greyName = displayName
  if not math.isEmpty(geneId) then
    local geneIndex = self.data.rarity[rarity] - 1
    local rarityName = string.format("rarity_%d", geneIndex)
    local innateGeneName = string.format("innateGene_%d", geneIndex)
    self.bind[rarityName] = true
    self.bind[innateGeneName] = L_PetStore:isInnateGene(genePos, geneId)
  end
end

function module:close()
end

return module
