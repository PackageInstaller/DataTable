local this = {}

function this:rsp_syncWeapon(info)
  for _, v in ipairs(info.apps) do
    local entity = self:getWeaponItem(v.guid, true)
    entity.guid = v.guid
    entity.lock = v.lock
    entity.wear_hero = v.wear_hero
    entity.app_id = v.app_id
  end
end

return this
