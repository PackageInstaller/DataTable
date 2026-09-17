local this = class("homeTechnologyLevelTpl")

function this:init(config)
  self.data = config
  self:initDataByIndex()
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTechnologyCount(tpl)
  return tpl.technologyCount
end

function this:getCategory(tpl)
  return tpl.category
end

function this:getId(tpl)
  return tpl.id
end

function this:getCategoryLevel(tpl)
  return tpl.categoryLevel
end

function this:getTechnologyExp(tpl)
  return tpl.technologyExp
end

function this:initDataByIndex()
  self.levelData = {}
  self.categoryType2MaxCategoryLevel = {}
  for i, v in pairs(self.data) do
    self.levelData[v.category * 1000 + v.categoryLevel] = v
    if self.categoryType2MaxCategoryLevel[v.category] == nil then
      self.categoryType2MaxCategoryLevel[v.category] = v.categoryLevel
    end
    self.categoryType2MaxCategoryLevel[v.category] = self.categoryType2MaxCategoryLevel[v.category] > v.categoryLevel and self.categoryType2MaxCategoryLevel[v.category] or v.categoryLevel
  end
end

function this:getLevelInfo(category, level)
  return self.levelData[category * 1000 + level]
end

function this:getCategoryMaxLevelByCategoryType(categoryType)
  return self.categoryType2MaxCategoryLevel[categoryType]
end

return this
