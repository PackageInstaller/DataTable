local this = class("charPlotTpl")

function this:init(config)
  self.data = {}
  self.oriData = config
  for i, v in pairs(config) do
    if self.data[v.heroId] == nil then
      self.data[v.heroId] = {}
    end
    table.insert(self.data[v.heroId], v)
  end
  for i, charPlots in pairs(self.data) do
    table.sort(charPlots, function(a, b)
      return a.order < b.order
    end)
  end
end

function this:getTplById(id)
  return self.oriData[id]
end

function this:getTplByHeroId(heroId, index)
  if self.data[heroId] then
    return self.data[heroId][index]
  end
  return nil
end

local emptyTable = {}

function this:getChildren(heroId)
  return self.data[heroId] or emptyTable
end

function this:getTitle(tpl)
  return L_Config:provider(tpl.title)
end

function this:getEnglishNum(tpl)
  return tpl.englishNum
end

function this:getUnlockConditionText(tpl, i)
  return L_Config:provider(tpl.unlockConditionText[i])
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getId(tpl)
  return tpl.id
end

function this:getTaskId(tpl)
  return tpl.taskId
end

function this:getPlotId(tpl)
  return tpl.plotId
end

function this:getText(tpl)
  return L_Config:provider(tpl.text)
end

function this:getPic(tpl)
  return L_Config:getPathByHash(tpl.pic)
end

return this
