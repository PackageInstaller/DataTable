local this = class("modulePetBoxGeneTip", G_UIModuleBase)
local GENE_TIPS_ROW_COUNT = 2

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    list_tipGeneList = {
      moduleName = "pages/pet/new/cellPetTipsGene"
    }
  }
end

function this.methods()
  return {}
end

function this:open(guid)
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

function this:Init(pet)
  self.pet = pet
  if table.isEmpty(self.pet) then
    return
  end
  self.bind.list_tipGeneList:clear()
  local genelist = L_PetStore:getPetSkills(self.pet, true, true, false)
  table.sort(genelist, function(a, b)
    return a.genePos < b.genePos
  end)
  for k, gene in ipairs(genelist) do
    gene.index = k
    gene.useStyle2 = true
  end
  self:padGeneTipListRow(genelist)
  self.bind.list_tipGeneList:insert_array(genelist)
end

return this
