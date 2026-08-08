local raw = {
  [1] = ProtobufI("GachaType", {
    id = 1,
    cost = ProtobufI("STResource", {
      type = 11,
      id = 60001,
      count = 1
    }),
    costSub = ProtobufI("STResource", {type = 5, count = 150}),
    dropIdForce = {
      [1] = "FirstGacha_01"
    },
    dropId = "Gacha_01",
    maxCountPerDay = 9999,
    dropFloorChannel = 3,
    windowName = "GachaNormal",
    gachaFreeInterval = 86400,
    actorDropCount = 10,
    purpleActorParam = 101,
    orangeActorParam = 102,
    notGetOrangeDecrease = 44,
    notGetOrangeMin = -50,
    notGetOrangeMax = 118,
    costBackUp = ProtobufI("STResource", {})
  }),
  [2] = ProtobufI("GachaType", {
    id = 2,
    type = 2,
    cost = ProtobufI("STResource", {
      type = 11,
      id = 60002,
      count = 1
    }),
    costSub = ProtobufI("STResource", {type = 5, count = 150}),
    dropIdForce = {},
    maxCountPerDay = 9999,
    windowName = "GachaPeriodic",
    actorDropCount = 10,
    purpleActorParam = 101,
    orangeActorParam = 102,
    limitOrangeProbability = 1800,
    notGetOrangeDecrease = 44,
    notGetOrangeMin = -50,
    notGetOrangeMax = 118,
    limitConventionDropParam = 14,
    costBackUp = ProtobufI("STResource", {})
  }),
  [3] = ProtobufI("GachaType", {
    id = 5,
    type = 1,
    cost = ProtobufI("STResource", {}),
    costSub = ProtobufI("STResource", {}),
    safeCount = 10,
    maxCountOnce = 100,
    dropIdForce = {},
    maxCountPerDay = 9999,
    dropFloorChannel = 5,
    windowName = "GachaChips",
    costBackUp = ProtobufI("STResource", {})
  }),
  [4] = ProtobufI("GachaType", {
    id = 6,
    type = 3,
    cost = ProtobufI("STResource", {type = 10, count = 200}),
    costSub = ProtobufI("STResource", {}),
    dropIdForce = {},
    dropId = "Gacha_06",
    maxCountPerDay = 9999,
    costBackUp = ProtobufI("STResource", {})
  }),
  [5] = ProtobufI("GachaType", {
    id = 7,
    type = 4,
    cost = ProtobufI("STResource", {
      type = 11,
      id = 60003,
      count = 1
    }),
    costSub = ProtobufI("STResource", {type = 5, count = 150}),
    dropIdForce = {},
    maxCountPerDay = 9999,
    actorDropCount = 10,
    purpleActorParam = 101,
    orangeActorParam = 102,
    notGetOrangeDecrease = 44,
    notGetOrangeMin = -50,
    notGetOrangeMax = 118,
    costBackUp = ProtobufI("STResource", {})
  }),
  [6] = ProtobufI("GachaType", {
    id = 10,
    type = 5,
    cost = ProtobufI("STResource", {
      type = 11,
      id = 60001,
      count = 1
    }),
    costSub = ProtobufI("STResource", {type = 5, count = 150}),
    maxCountOnce = 100,
    dropIdForce = {},
    dropId = "Gacha_10",
    maxCountPerDay = 9999,
    costBackUp = ProtobufI("STResource", {
      type = 11,
      id = 61000,
      count = 1
    })
  })
}
local indexed = {
  [1] = 1,
  [2] = 2,
  [5] = 3,
  [6] = 4,
  [7] = 5,
  [10] = 6
}
return {raw, indexed}
