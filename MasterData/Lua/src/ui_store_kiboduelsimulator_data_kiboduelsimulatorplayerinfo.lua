local this = class("kiboDuelSimulatorPlayerInfo")

function this:ctor(side)
  self.side = side
  self.playerEntityId = nil
  self.skillList = {}
  self:initKiboList()
end

function this:initKiboList()
  self.kiboList = {}
  for i = 1, 8 do
    local kiboDuelSimulatorItem = require(L_R.store .. "kiboDuelSimulator.data.kiboDuelSimulatorItem").new()
    self.kiboList[i] = kiboDuelSimulatorItem
  end
end

return this
