local raw = {
  [1] = ProtobufI("UniqueWeaponAscend", {
    quality = 3,
    phase = 1,
    levelLimit = 50,
    phaseExp = 1,
    cultivation = 270.0
  }),
  [2] = ProtobufI("UniqueWeaponAscend", {
    quality = 3,
    phase = 2,
    levelLimit = 52,
    phaseExp = 1,
    cultivation = 300.0
  }),
  [3] = ProtobufI("UniqueWeaponAscend", {
    quality = 3,
    phase = 3,
    levelLimit = 54,
    phaseExp = 1,
    cultivation = 340.0
  }),
  [4] = ProtobufI("UniqueWeaponAscend", {
    quality = 3,
    phase = 4,
    levelLimit = 56,
    phaseExp = 1,
    cultivation = 380.0
  }),
  [5] = ProtobufI("UniqueWeaponAscend", {
    quality = 3,
    phase = 5,
    levelLimit = 58,
    phaseExp = 1,
    cultivation = 410.0
  }),
  [6] = ProtobufI("UniqueWeaponAscend", {
    quality = 3,
    phase = 6,
    levelLimit = 60,
    phaseExp = 1,
    cultivation = 450.0
  }),
  [7] = ProtobufI("UniqueWeaponAscend", {
    quality = 4,
    phase = 1,
    levelLimit = 60,
    phaseExp = 1,
    cultivation = 360.0
  }),
  [8] = ProtobufI("UniqueWeaponAscend", {
    quality = 4,
    phase = 2,
    levelLimit = 62,
    phaseExp = 1,
    cultivation = 430.0
  }),
  [9] = ProtobufI("UniqueWeaponAscend", {
    quality = 4,
    phase = 3,
    levelLimit = 64,
    phaseExp = 1,
    cultivation = 500.0
  }),
  [10] = ProtobufI("UniqueWeaponAscend", {
    quality = 4,
    phase = 4,
    levelLimit = 66,
    phaseExp = 1,
    cultivation = 580.0
  }),
  [11] = ProtobufI("UniqueWeaponAscend", {
    quality = 4,
    phase = 5,
    levelLimit = 68,
    phaseExp = 1,
    cultivation = 650.0
  }),
  [12] = ProtobufI("UniqueWeaponAscend", {
    quality = 4,
    phase = 6,
    levelLimit = 70,
    phaseExp = 1,
    cultivation = 720.0
  })
}
local indexed = {
  [3] = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6
  },
  [4] = {
    [1] = 7,
    [2] = 8,
    [3] = 9,
    [4] = 10,
    [5] = 11,
    [6] = 12
  }
}
return {raw, indexed}
