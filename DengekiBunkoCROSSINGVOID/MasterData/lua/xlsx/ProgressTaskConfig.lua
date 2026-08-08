local raw = {
  [1] = ProtobufI("ProgressTaskConfig", {
    name = "TaskPresent",
    tabIconAtlasPath = "Welfare",
    tabIconSpriteName = "welfare_9",
    relatedActivityIds = {},
    params = {}
  }),
  [2] = ProtobufI("ProgressTaskConfig", {
    name = "ActorCultivation1",
    tabIconAtlasPath = "Lobby",
    tabIconSpriteName = "welfare/actor_type_1511",
    prefabName = "PTActorCultivation",
    tabLocale = "WelfareTabName_ActorCultivation",
    relatedActivityType = 53,
    relatedActivityIds = {
      [1] = 53003
    },
    params = {
      [1] = "1511.0"
    },
    helpTabName = "ActorCultivation1"
  }),
  [3] = ProtobufI("ProgressTaskConfig", {
    name = "ActorCultivation2",
    tabIconAtlasPath = "Lobby",
    tabIconSpriteName = "welfare/actor_type_1505",
    prefabName = "PTActorCultivation",
    tabLocale = "WelfareTabName_ActorCultivation",
    relatedActivityType = 53,
    relatedActivityIds = {
      [1] = 53004
    },
    params = {
      [1] = "1505.0"
    },
    helpTabName = "ActorCultivation2"
  }),
  [4] = ProtobufI("ProgressTaskConfig", {
    name = "CustomActorCultivation1",
    tabIconAtlasPath = "Welfare",
    tabIconSpriteName = "welfare_18",
    prefabName = "PTCustomActorCultivation",
    tabLocale = "WelfareTabName_ActorCultivation",
    relatedActivityType = 69,
    relatedActivityIds = {},
    params = {},
    helpTabName = "CustomActorCultivation"
  }),
  [5] = ProtobufI("ProgressTaskConfig", {
    name = "CustomActorCultivation2",
    tabIconAtlasPath = "Welfare",
    tabIconSpriteName = "welfare_18",
    prefabName = "PTCustomActorCultivation",
    tabLocale = "WelfareTabName_ActorCultivation",
    relatedActivityType = 69,
    relatedActivityIds = {},
    params = {},
    helpTabName = "CustomActorCultivation"
  }),
  [6] = ProtobufI("ProgressTaskConfig", {
    name = "ActorCultivation3",
    tabIconAtlasPath = "Lobby",
    tabIconSpriteName = "welfare/actor_type_1401",
    prefabName = "PTActorCultivation",
    tabLocale = "WelfareTabName_ActorCultivation",
    relatedActivityType = 53,
    relatedActivityIds = {
      [1] = 53005
    },
    params = {
      [1] = "1401.0"
    },
    helpTabName = "ActorCultivation3"
  }),
  [7] = ProtobufI("ProgressTaskConfig", {
    name = "ActorCultivation4",
    tabIconAtlasPath = "Lobby",
    tabIconSpriteName = "welfare/actor_type_1409",
    prefabName = "PTActorCultivation",
    tabLocale = "WelfareTabName_ActorCultivation",
    relatedActivityType = 53,
    relatedActivityIds = {
      [1] = 53006
    },
    params = {
      [1] = "1409.0"
    },
    helpTabName = "ActorCultivation4"
  }),
  [8] = ProtobufI("ProgressTaskConfig", {
    name = "ActorCultivation5",
    tabIconAtlasPath = "Lobby",
    tabIconSpriteName = "welfare/actor_type_1508",
    prefabName = "PTActorCultivation",
    tabLocale = "WelfareTabName_ActorCultivation",
    relatedActivityType = 53,
    relatedActivityIds = {
      [1] = 53007
    },
    params = {
      [1] = "1508.0"
    },
    helpTabName = "ActorCultivation5"
  }),
  [9] = ProtobufI("ProgressTaskConfig", {
    name = "ActorCultivation6",
    tabIconAtlasPath = "Lobby",
    tabIconSpriteName = "welfare/actor_type_1515",
    prefabName = "PTActorCultivation",
    tabLocale = "WelfareTabName_ActorCultivation",
    relatedActivityType = 53,
    relatedActivityIds = {
      [1] = 53008
    },
    params = {
      [1] = "1515.0"
    },
    helpTabName = "ActorCultivation6"
  }),
  [10] = ProtobufI("ProgressTaskConfig", {
    name = "ActorCultivation7",
    tabIconAtlasPath = "Lobby",
    tabIconSpriteName = "welfare/actor_type_1502",
    prefabName = "PTActorCultivation",
    tabLocale = "WelfareTabName_ActorCultivation",
    relatedActivityType = 53,
    relatedActivityIds = {
      [1] = 53001
    },
    params = {
      [1] = "1502.0"
    },
    helpTabName = "ActorCultivation7"
  }),
  [11] = ProtobufI("ProgressTaskConfig", {
    name = "ActorCultivation8",
    tabIconAtlasPath = "Lobby",
    tabIconSpriteName = "welfare/actor_type_1514",
    prefabName = "PTActorCultivation",
    tabLocale = "WelfareTabName_ActorCultivation",
    relatedActivityType = 53,
    relatedActivityIds = {
      [1] = 53002
    },
    params = {
      [1] = "1514.0"
    },
    helpTabName = "ActorCultivation8"
  })
}
local indexed = {
  ActorCultivation1 = 2,
  ActorCultivation2 = 3,
  ActorCultivation3 = 6,
  ActorCultivation4 = 7,
  ActorCultivation5 = 8,
  ActorCultivation6 = 9,
  ActorCultivation7 = 10,
  ActorCultivation8 = 11,
  CustomActorCultivation1 = 4,
  CustomActorCultivation2 = 5,
  TaskPresent = 1
}
return {raw, indexed}
