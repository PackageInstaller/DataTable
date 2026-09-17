local page = class("pageShowSpecialGene", G_UIPageBase)
local petDnaDropTpl = L_GameTpl:getDnaDropTpl()
local petDnaPoolTpl = L_GameTpl:getDnaPoolTpl()
local petDnaTpl = L_GameTpl:getDnaTpl()
local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
local skillTpl = L_GameTpl:getSkillTpl()

function page:ctor(...)
  page.super.ctor(self, ...)
end

function page.bind()
  return {
    desc = "",
    show_desc = true,
    geneList = {
      moduleName = "pages/Pet/cellPetGene"
    },
    pageTitile = ""
  }
end

function page.methods()
  return {
    geneList = {
      onClick_Choose = function(self, data)
        self.selectedIndex = data.index
        self:setSelectedGene()
      end
    },
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function page:preOpen(options)
  page.super.preOpen(self, options)
  self.bind.pageTitile = L_WordsTpl:getValue("ui_rare_gene_title")
  self.selectedIndex = 1
  self:refreshGeneList(options.rareGene)
  self:setSelectedGene()
end

function page:close(options)
  page.super.close(self, options)
end

function page:setSelectedGene()
  for i = 1, #self.bind.geneList do
    local index = self.bind.geneList:getValue(i, "index")
    local cell = self.bind.geneList:getItemCls(i)
    cell:setRareShowSelected(index == self.selectedIndex)
    if index == self.selectedIndex then
      self.bind.desc = self.bind.geneList:getValue(i, "gene_skill")
    end
  end
end

function page:refreshGeneList(data)
  local geneListData = {}
  for i = 1, #data do
    local tpl = petDnaTpl:getTplById(data[i])
    if tpl then
      local rarity = petDnaTpl:getRarity(tpl)
      local nameTpl = skillTpl:getTplById(data[i])
      local name = skillTpl:getName(nameTpl)
      local petSkillLevelTpl = skillLevelTpl:getTplByIdAndLevel(data[i], 1)
      local petSkillDescribe = skillLevelTpl:getSkillDescribe(petSkillLevelTpl)
      local geneData = {}
      geneData.geneId = data[i]
      geneData.lock = false
      geneData.gene_skill = petSkillDescribe
      geneData.gene_name = name
      geneData.rarity = rarity
      geneData.index = i
      table.insert(geneListData, geneData)
    else
      errorf(string.format("%d  id 在pet_dna找不到", data[i]), 2)
    end
  end
  self.bind.geneList:clear()
  self.bind.geneList:insert_array(geneListData)
end

function page:initPage(id)
  self.bind.show_desc = true
  self.bind.geneList:clear()
  local dnaDropData = petDnaDropTpl:getRareDnaDropGroup(id, 3)
  if table.isEmpty(dnaDropData) then
    return
  end
  local dnaPoolIds = {}
  for i, v in pairs(dnaDropData) do
    local poolId = petDnaDropTpl:getDnaPoolId(v)
    table.insert(dnaPoolIds, poolId)
  end
  local allDna = {}
  for i, v in pairs(dnaPoolIds) do
    local tpl = petDnaPoolTpl:getTplById(v)
    local dnaList = petDnaPoolTpl:getDna(tpl)
    for n, k in pairs(dnaList) do
      table.insert(allDna, k)
    end
  end
  if 0 < #allDna then
    self.bind.show_desc = true
    local data = {}
    for i, v in ipairs(allDna) do
      local gene_tpl = petDnaTpl:getTplById(v)
      local skill_tpl = skillLevelTpl:getTplByIdAndLevel(v, 1)
      local color = petDnaTpl:getType(gene_tpl)
      local dnaRarity = petDnaTpl:getRarity(gene_tpl)
      local skillDescribe = skillLevelTpl:getSkillDescribe(skill_tpl)
      local gene_name = skillLevelTpl:getName(skill_tpl)
      table.insert(data, {
        index = v,
        geneGuid = v,
        describe = skillDescribe,
        gene_name = gene_name,
        geneLv = 1,
        geneColor = color,
        rarity = dnaRarity,
        selected = i == 1
      })
    end
    self.bind.geneList:insert_array(data)
    self.bind.desc = data[1].describe
    self.bind.geneName = data[1].gene_name
  end
end

return page
