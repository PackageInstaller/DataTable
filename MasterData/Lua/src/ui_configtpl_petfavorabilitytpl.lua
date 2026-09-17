local this = class("petFavorabilityTpl")
local maxLv = 0

function this:init(config)
  self.data = config
  for lv, v in pairs(self.data) do
    maxLv = math.max(maxLv, lv)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getUpgradeExp(curLv)
  return self.data[curLv] and self.data[curLv].exp or 0
end

function this:getIsMaxLv(curLv)
  return curLv >= maxLv
end

function this:getMaxLv()
  return maxLv
end

function this:getDesc(curLv)
  return self.data[curLv] and L_Config:provider(self.data[curLv].desc) or ""
end

function this:getLvEffect(curLv)
  return self.data[curLv] and self.data[curLv].levelEffect or 0
end

return this
