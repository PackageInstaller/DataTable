local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    weaponList = {}
  }
end

function this:state()
  return {}
end

function this:getWeaponItem(guid, isCreate)
  local entity = self.data.weaponList[guid]
  if entity == nil and isCreate then
    entity = require(L_R.store .. "weapon.weaponItem").new()
    self.data.weaponList[guid] = entity
    entity.guid = guid
  end
  return entity
end

function this:getHeroWeapon(heroID)
  for i, v in pairs(self.data.weaponList) do
    if v.wear_hero == heroID then
      return v.app_id
    end
  end
end

return this
