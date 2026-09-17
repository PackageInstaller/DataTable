local this = class("dungeonEntrustTypeTpl")

function this:init(config)
  self.data = config
  self.showData = {}
  for k, v in pairs(self.data) do
    if self:getIfShow(v) then
      table.insert(self.showData, v)
    end
  end
  table.sort(self.showData, function(a, b)
    return a.id < b.id
  end)
end

function this:getTplById(id)
  return self.data[id]
end

function this:getShowData()
  return self.showData
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getIfShow(tpl)
  return tpl.ifShow == 1
end

function this:getIfTimeLimit(tpl)
  return tpl.iftimelimit == 1
end

function this:getBanner(tpl)
  return tpl.banner
end

function this:getSystemUnLockId(tpl)
  return tpl.systemUnLockId
end

function this:getStarRewardIsShow(tpl)
  return tpl.ifShowStarReward
end

return this
