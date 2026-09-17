local this = class("weaponItem")

function this:ctor()
  self.guid = 0
  self.lock = false
  self.wear_hero = 0
  self.app_id = 0
end

return this
