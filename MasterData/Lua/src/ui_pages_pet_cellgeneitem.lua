local module = class("cellGeneItem", G_UIModuleBase)
local petDna = L_GameTpl:getDnaTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {
    id = nil,
    guid = nil,
    color = {
      [0] = Unity.Color.grey,
      [1] = CS.UnityEngine.Color(0.8627450980392157, 0.27058823529411763, 0.43137254901960786),
      [2] = CS.UnityEngine.Color(0.01568627450980392, 0.8470588235294118, 0.043137254901960784),
      [3] = CS.UnityEngine.Color(0.9450980392156862, 0.796078431372549, 0.0392156862745098),
      [4] = CS.UnityEngine.Color(0.00392156862745098, 0.5607843137254902, 0.9490196078431372),
      [5] = CS.UnityEngine.Color(0.6980392156862745, 0.5607843137254902, 0.807843137254902)
    }
  }
end

function module.bind()
  return {
    icon = "",
    gene_name = "",
    gene_skill = "",
    isSelected = false,
    color = Unity.Color.grey,
    color_Lsize = Unity.Color.grey,
    shortSize = true,
    longSize = false,
    levelList = {
      moduleName = "pages/Pet/cellDotStarItem"
    },
    long_icon = "",
    long_gene_name = "",
    long_levelList = {
      moduleName = "pages/Pet/cellDotStarItem"
    }
  }
end

function module.methods()
  return {
    onClick_Choose = function(self)
      self:emit("onClick_Choose", self.bind.index, self.bind.geneGuid, self.bindComponents.geneItem.gameObject, self.bindComponents.geneItem.parent)
    end,
    onDrag_End = function(self)
      self:emit("onDrag_End", self.bind.index, self.bind.geneGuid, self.bindComponents.geneItem.gameObject, self.bindComponents.geneItem.parent)
    end
  }
end

function module:open()
  self:refreshInfo()
end

function module:refresh()
end

function module:itemInfo(index)
  local data = {
    icon = self.bind.icon,
    gene_name = self.bind.gene_name,
    gene_skill = self.bind.gene_skill,
    geneGuid = self.bind.geneGuid,
    geneColor = self.bind.geneColor,
    gridSize = self.bind.gridSize,
    geneLv = self.bind.geneLv,
    rarity = self.bind.rarity,
    parentGuid = self.bind.parentGuid,
    index = index or nil
  }
  return data
end

function module:refreshInfo()
  if self.bind.geneColor ~= nil and self.bind.geneColor ~= 0 then
    self.bind.color = self.data.color[self.bind.geneColor]
    self.bind.color_Lsize = self.data.color[self.bind.geneColor]
  end
  self.bind.levelList:clear()
  self.bind.long_levelList:clear()
  if self.bind.geneLv and self.bind.geneLv ~= 0 then
    local data = {}
    for i = 1, self.bind.geneLv do
      table.insert(data, {
        starLv = self.bind.geneLv,
        rarity = self.bind.rarity
      })
    end
    self.bind.levelList:insert_array(data)
    self.bind.long_levelList:insert_array(data)
  end
  self.bind.shortSize = self.bind.gridSize == 1
  self.bind.longSize = self.bind.shortSize == false
  self.bind.long_icon = self.bind.icon
  self.bind.long_gene_name = self.bind.gene_name
  if self.bind.geneColor == 5 then
    local tpl = petDna:getTplById(self.bind.geneGuid)
    local iconRainbow = petDna:getIconRainbow(tpl)
    if self.bind.gridSize == 2 then
      self.bind.long_icon = iconRainbow
    else
      self.bind.icon = iconRainbow
    end
  end
  self.bindComponents.isSelectedTrans.sizeDelta = self.bind.shortSize == true and C_Vector2(140, 142) or C_Vector2(140, 274)
end

function module:close()
end

return module
