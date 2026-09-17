local this = class("pageGeneReward", G_UIPageBase)

function this.bind()
  return {
    name = "",
    lv = "",
    describe = "",
    show_longGene = false,
    show_shortGene = false,
    geneIcon_long = "",
    geneIcon_short = "",
    longGeneStarList = {
      moduleName = "pages/Pet/cellDotStarItem"
    },
    shortGeneStarList = {
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

function this:close(options)
  this.super.close(self, options)
end

function this:refreshGeneReward(data)
  self.bind.name = data.name
  self.bind.lv = "Lv." .. data.lv
  self.bind.describe = data.describe
  local starLv = tonumber(data.starLv)
  if data.length == 1 then
    self.bind.show_shortGene = true
    self.bind.show_longGene = false
    self.bind.geneIcon_short = data.icon
    self.bind.shortGeneStarList:clear()
    local raw_data = {}
    for i = 1, starLv do
      table.insert(raw_data, {
        rarity = data.rarity
      })
    end
    self.bind.shortGeneStarList:insert_array(raw_data)
  else
    self.bind.show_longGene = true
    self.bind.show_shortGene = false
    self.bind.geneIcon_long = data.icon
    self.bind.longGeneStarList:clear()
    local raw_data = {}
    for i = 1, starLv do
      table.insert(raw_data, {
        rarity = data.rarity
      })
    end
    self.bind.longGeneStarList:insert_array(raw_data)
  end
end

return this
