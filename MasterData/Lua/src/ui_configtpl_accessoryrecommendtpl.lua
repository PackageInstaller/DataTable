local this = class("accessoryRecommendTpl")
local _accessoryLevelTpl = L_GameTpl:getAccessoryLevelTpl()
local _accessorySubParameterTpl = L_GameTpl:getAccessorySubParameterTpl()

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getRecommendSort(heroConfigId)
  return self.data[heroConfigId].recommend
end

function this:getRecommendPartBySlot(heroConfigId, slotIndex)
  local res = {}
  for key, value in pairs(self.data) do
    if value.id == heroConfigId then
      for _, id in ipairs(value["recommend" .. slotIndex]) do
        table.insert(res, {accessoryConfigId = id})
      end
    end
  end
  return res
end

function this:getRecommendSetBySlot(heroConfigId)
  local res = {}
  for key, value in pairs(self.data) do
    if value.id == heroConfigId then
      table.insert(res, value.recommendSet1)
      table.insert(res, value.recommendSet2)
      return res
    end
  end
end

return this
