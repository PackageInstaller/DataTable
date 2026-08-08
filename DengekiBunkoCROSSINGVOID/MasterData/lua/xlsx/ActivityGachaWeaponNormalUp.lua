local raw = {
  [1] = ProtobufI("ActivityGachaWeaponNormalUp", {
    activityId = 14050,
    dropResInfo = {
      [1] = ProtobufI("ActivityGachaWeaponNormalUp.DropInfo", {
        dropWeaponId = 401,
        dropWeaponProbability = 100,
        dropWeaponQuality = 4
      })
    }
  })
}
local indexed = {
  [14050] = 1
}
return {raw, indexed}
