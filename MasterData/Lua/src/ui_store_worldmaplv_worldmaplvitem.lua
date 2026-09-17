local this = class("worldMapLvItem")

function this:ctor()
  self.mapId = 0
  self.difficulty = 0
  self.needShowLevel = false
  self.reddotFinished = {}
end

return this
