local this = class("battleTeamItem")

function this:ctor()
  self.index = nil
  self.heroId = nil
  self.lv = 0
  self.petId = nil
  self.control = nil
end

return this
