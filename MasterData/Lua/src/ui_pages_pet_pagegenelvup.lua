local this = class("pageGeneLvUp", G_UIPageBase)

function this.bind()
  return {
    name = "",
    lv = "",
    describe = "",
    name_new = "",
    lv_new = "",
    describe_new = "",
    show_longGene = false,
    show_shortGene = false,
    show_longGene_new = false,
    show_shortGene_new = false,
    pre_shortGene_icon = "",
    new_shortGene_icon = "",
    pre_longGene_icon = "",
    new_longGene_icon = "",
    pre_longGeneStarList = {
      moduleName = "pages/Pet/cellDotStarItem"
    },
    pre_shortGeneStarList = {
      moduleName = "pages/Pet/cellDotStarItem"
    },
    new_longGeneStarList = {
      moduleName = "pages/Pet/cellDotStarItem"
    },
    new_shortGeneStarList = {
      moduleName = "pages/Pet/cellDotStarItem"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  if options ~= nil then
    self:refreshGeneReward(options.gene)
  end
end

function this:close()
end

function this:refreshGeneReward(data)
  self.bind.name = data.name
  self.bind.name_new = data.name
  self.bind.lv_new = "Lv." .. data.lv
  self.bind.describe_new = data.describe
  local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
  local tpl = skillLevelTpl:getTplByIdAndLevel(data.geneId, data.lv - 1)
  local oldDescribe = skillLevelTpl:getSkillDescribe(tpl)
  self.bind.lv = "Lv." .. data.lv - 1
  self.bind.describe = oldDescribe
  local starLv = tonumber(data.starLv)
  if data.length == 1 then
    self.bind.show_shortGene = true
    self.bind.show_longGene = false
    self.bind.pre_shortGene_icon = data.icon
    self.bind.new_shortGene_icon = data.icon
    self.bind.show_shortGene_new = true
    self.bind.show_longGene_new = false
    self.bind.pre_shortGeneStarList:clear()
    self.bind.new_shortGeneStarList:clear()
    local raw_data = {}
    for i = 1, starLv do
      table.insert(raw_data, {
        rarity = data.rarity
      })
    end
    self.bind.new_shortGeneStarList:insert_array(raw_data)
    table.remove(raw_data, 1)
    self.bind.pre_shortGeneStarList:insert_array(raw_data)
  else
    self.bind.show_longGene = true
    self.bind.show_shortGene = false
    self.bind.pre_longGene_icon = data.icon
    self.bind.new_longGene_icon = data.icon
    self.bind.show_longGene_new = true
    self.bind.show_shortGene_new = false
    self.bind.pre_longGeneStarList:clear()
    self.bind.new_longGeneStarList:clear()
    local raw_data = {}
    for i = 1, starLv do
      table.insert(raw_data, {
        rarity = data.rarity
      })
    end
    self.bind.new_longGeneStarList:insert_array(raw_data)
    table.remove(raw_data, 1)
    self.bind.pre_longGeneStarList:insert_array(raw_data)
  end
end

return this
