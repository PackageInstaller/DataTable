local raw = {
  [1] = ProtobufI("Sort", {
    id = 1,
    localization = "Sort_ActorColor",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "orderNew", param = 1}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 1
  }),
  [2] = ProtobufI("Sort", {
    id = 2,
    localization = "Sort_ActorLevel",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "orderNew", param = 1}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 1
  }),
  [3] = ProtobufI("Sort", {
    id = 3,
    localization = "Sort_StarLevel",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "orderNew", param = 1}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 1
  }),
  [4] = ProtobufI("Sort", {
    id = 4,
    localization = "Sort_GetTime",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "orderNew", param = 1}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 1
  }),
  [5] = ProtobufI("Sort", {
    id = 5,
    localization = "Sort_ActorName",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "orderNew", param = 1}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "actorName"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "quality", param = 1}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "level", param = 1}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "star", param = 1}),
      [7] = ProtobufI("Sort.SortKey", {keyName = "uid", param = 1})
    },
    type = 1
  }),
  [6] = ProtobufI("Sort", {
    id = 6,
    localization = "Sort_Quality",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "orderNew", param = 1}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "position", param = 2}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 2
  }),
  [7] = ProtobufI("Sort", {
    id = 7,
    localization = "Sort_EquipLevel",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "orderNew", param = 1}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "position", param = 2}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 2
  }),
  [8] = ProtobufI("Sort", {
    id = 8,
    localization = "Sort_GetTime",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "orderNew", param = 1}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 2
  }),
  [9] = ProtobufI("Sort", {
    id = 9,
    localization = "Sort_EquipOn",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "orderNew", param = 1}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "equipOn", param = 1}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "position", param = 2}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [7] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 2
  }),
  [10] = ProtobufI("Sort", {
    id = 10,
    localization = "Sort_Quality",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "gotTime"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1})
    },
    type = 3
  }),
  [11] = ProtobufI("Sort", {
    id = 11,
    localization = "Sort_GetTime",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "gotTime"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "quality", param = 1}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1})
    },
    type = 3
  }),
  [12] = ProtobufI("Sort", {
    id = 12,
    localization = "Sort_GetTime",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "gotTime"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1})
    },
    type = 3
  }),
  [13] = ProtobufI("Sort", {
    id = 13,
    localization = "Sort_ItemExp",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "exp"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "gotTime"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1})
    },
    type = 3
  }),
  [14] = ProtobufI("Sort", {
    id = 14,
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {
        keyName = "auraActorQuality"
      }),
      [2] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [3] = ProtobufI("Sort.SortKey", {
        keyName = "actorNameEn",
        param = 1
      }),
      [4] = ProtobufI("Sort.SortKey", {
        keyName = "auraActorId"
      })
    },
    type = 4
  }),
  [15] = ProtobufI("Sort", {
    id = 15,
    localization = "Sort_CollectionsActorDefault",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "id"})
    },
    type = 5
  }),
  [16] = ProtobufI("Sort", {
    id = 16,
    localization = "Sort_ByCollectionsActorName",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "actorName"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "id"})
    },
    type = 5
  }),
  [17] = ProtobufI("Sort", {
    id = 17,
    localization = "Sort_CollectionsActorDefault",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {
        keyName = "favourLevel"
      }),
      [2] = ProtobufI("Sort.SortKey", {keyName = "favour"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "unlockTime"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "roleId"})
    },
    type = 9
  }),
  [18] = ProtobufI("Sort", {
    id = 18,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "online", param = 1}),
      [2] = ProtobufI("Sort.SortKey", {
        keyName = "lastLogoutTime",
        param = 1
      })
    },
    type = 7
  }),
  [19] = ProtobufI("Sort", {
    id = 19,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "level", param = 1})
    },
    type = 7
  }),
  [20] = ProtobufI("Sort", {
    id = 20,
    localization = "Sort_ActorCultivation",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "orderNew", param = 1}),
      [2] = ProtobufI("Sort.SortKey", {
        keyName = "cultivationTotal"
      }),
      [3] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [7] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 1
  }),
  [21] = ProtobufI("Sort", {
    id = 21,
    localization = "Sort_ActorSpeed",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "orderNew", param = 1}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "speed"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [7] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 1
  }),
  [22] = ProtobufI("Sort", {
    id = 22,
    localization = "Sort_GuildMemberCount",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {
        keyName = "membersCount"
      }),
      [2] = ProtobufI("Sort.SortKey", {keyName = "level", param = 1}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "score", param = 2})
    },
    type = 6
  }),
  [23] = ProtobufI("Sort", {
    id = 23,
    localization = "Sort_GuildScore",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "score"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "level", param = 1}),
      [3] = ProtobufI("Sort.SortKey", {
        keyName = "membersCount",
        param = 2
      })
    },
    type = 6
  }),
  [24] = ProtobufI("Sort", {
    id = 24,
    localization = "Sort_Quality",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "position", param = 2}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 2
  }),
  [25] = ProtobufI("Sort", {
    id = 25,
    localization = "Sort_EquipLevel",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "position", param = 2}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 2
  }),
  [26] = ProtobufI("Sort", {
    id = 26,
    localization = "Sort_GetTime",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 2
  }),
  [27] = ProtobufI("Sort", {
    id = 27,
    localization = "Sort_ActorColor",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 8
  }),
  [28] = ProtobufI("Sort", {
    id = 28,
    localization = "Sort_ActorLevel",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 8
  }),
  [29] = ProtobufI("Sort", {
    id = 29,
    localization = "Sort_StarLevel",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 8
  }),
  [30] = ProtobufI("Sort", {
    id = 30,
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "role"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "quality", param = 1}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "level", param = 1}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "star", param = 1}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "uid", param = 1})
    },
    type = 1
  }),
  [31] = ProtobufI("Sort", {
    id = 31,
    localization = "Sort_ByCollectionsActorName",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "roleId"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "favour"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "unlockTime"}),
      [4] = ProtobufI("Sort.SortKey", {
        keyName = "favourLevel"
      })
    },
    type = 9
  }),
  [32] = ProtobufI("Sort", {
    id = 32,
    localization = "Sort_ActorColor",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 1
  }),
  [33] = ProtobufI("Sort", {
    id = 33,
    localization = "Sort_ActorLevel",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 1
  }),
  [34] = ProtobufI("Sort", {
    id = 34,
    localization = "Sort_StarLevel",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 1
  }),
  [35] = ProtobufI("Sort", {
    id = 35,
    localization = "Sort_ActorCultivation",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {
        keyName = "cultivationTotal"
      }),
      [2] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 1
  }),
  [36] = ProtobufI("Sort", {
    id = 36,
    localization = "Sort_ActorSpeed",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "speed"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 1
  }),
  [37] = ProtobufI("Sort", {
    id = 37,
    localization = "Sort_ActorName",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "actorName"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "quality", param = 1}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "level", param = 1}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "star", param = 1}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "uid", param = 1})
    },
    type = 1
  }),
  [38] = ProtobufI("Sort", {
    id = 38,
    localization = "Sort_GetTime",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 1
  }),
  [39] = ProtobufI("Sort", {
    id = 39,
    localization = "Sort_GuildLevel",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "score", param = 1}),
      [3] = ProtobufI("Sort.SortKey", {
        keyName = "membersCount",
        param = 2
      })
    },
    type = 6
  }),
  [40] = ProtobufI("Sort", {
    id = 40,
    localization = "Sort_ActorColor",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "alive"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 11
  }),
  [41] = ProtobufI("Sort", {
    id = 41,
    localization = "Sort_ActorLevel",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "alive"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 11
  }),
  [42] = ProtobufI("Sort", {
    id = 42,
    localization = "Sort_StarLevel",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "alive"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 11
  }),
  [43] = ProtobufI("Sort", {
    id = 43,
    localization = "Sort_GetTime",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "alive"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 11
  }),
  [44] = ProtobufI("Sort", {
    id = 44,
    localization = "Sort_ActorName",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "alive"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "actorName"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "quality", param = 1}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "level", param = 1}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "star", param = 1}),
      [7] = ProtobufI("Sort.SortKey", {keyName = "uid", param = 1})
    },
    type = 11
  }),
  [45] = ProtobufI("Sort", {
    id = 45,
    localization = "Sort_ActorSpeed",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "alive"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "speed"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [7] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 11
  }),
  [46] = ProtobufI("Sort", {
    id = 46,
    localization = "Sort_ActorCultivation",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "alive"}),
      [2] = ProtobufI("Sort.SortKey", {
        keyName = "cultivationTotal"
      }),
      [3] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [7] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 11
  }),
  [47] = ProtobufI("Sort", {
    id = 47,
    localization = "Sort_ActorCultivation",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {
        keyName = "cultivation"
      }),
      [2] = ProtobufI("Sort.SortKey", {keyName = "id"})
    },
    type = 12
  }),
  [48] = ProtobufI("Sort", {
    id = 54,
    localization = "Sort_AttackRate",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "AttackRate"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "position", param = 2}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1})
    },
    type = 2
  }),
  [49] = ProtobufI("Sort", {
    id = 55,
    localization = "Sort_HpRate",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "HpRate"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "position", param = 2}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1})
    },
    type = 2
  }),
  [50] = ProtobufI("Sort", {
    id = 56,
    localization = "Sort_PhysicalDefenseRate",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {
        keyName = "PhysicalDefenseRate"
      }),
      [2] = ProtobufI("Sort.SortKey", {keyName = "position", param = 2}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1})
    },
    type = 2
  }),
  [51] = ProtobufI("Sort", {
    id = 57,
    localization = "Sort_MagicalDefenseRate",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {
        keyName = "MagicalDefenseRate"
      }),
      [2] = ProtobufI("Sort.SortKey", {keyName = "position", param = 2}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1})
    },
    type = 2
  }),
  [52] = ProtobufI("Sort", {
    id = 58,
    localization = "Sort_CriticalHitRate",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {
        keyName = "CriticalHitRate"
      }),
      [2] = ProtobufI("Sort.SortKey", {keyName = "position", param = 2}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1})
    },
    type = 2
  }),
  [53] = ProtobufI("Sort", {
    id = 59,
    localization = "Sort_CriticalHitDamageRate",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {
        keyName = "CriticalHitDamageRate"
      }),
      [2] = ProtobufI("Sort.SortKey", {keyName = "position", param = 2}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1})
    },
    type = 2
  }),
  [54] = ProtobufI("Sort", {
    id = 48,
    localization = "Sort_ActorColor",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 13
  }),
  [55] = ProtobufI("Sort", {
    id = 49,
    localization = "Sort_ActorLevel",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 13
  }),
  [56] = ProtobufI("Sort", {
    id = 50,
    localization = "Sort_StarLevel",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 13
  }),
  [57] = ProtobufI("Sort", {
    id = 51,
    localization = "Sort_ActorCultivation",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {
        keyName = "cultivationTotal"
      }),
      [2] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 13
  }),
  [58] = ProtobufI("Sort", {
    id = 52,
    localization = "Sort_ActorSpeed",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "speed"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "quality"}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "star"}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "uid"})
    },
    type = 13
  }),
  [59] = ProtobufI("Sort", {
    id = 53,
    localization = "Sort_ActorName",
    algorithm = 1,
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "actorName"}),
      [2] = ProtobufI("Sort.SortKey", {keyName = "id", param = 1}),
      [3] = ProtobufI("Sort.SortKey", {keyName = "quality", param = 1}),
      [4] = ProtobufI("Sort.SortKey", {keyName = "level", param = 1}),
      [5] = ProtobufI("Sort.SortKey", {keyName = "star", param = 1}),
      [6] = ProtobufI("Sort.SortKey", {keyName = "uid", param = 1})
    },
    type = 13
  }),
  [60] = ProtobufI("Sort", {
    id = 66,
    localization = "Sort_ActorLevel",
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "level"}),
      [2] = ProtobufI("Sort.SortKey", {
        keyName = "lastLogoutTime"
      })
    },
    type = 7
  }),
  [61] = ProtobufI("Sort", {
    id = 67,
    localization = "Sort_LogoutTime",
    keys = {
      [1] = ProtobufI("Sort.SortKey", {keyName = "online"}),
      [2] = ProtobufI("Sort.SortKey", {
        keyName = "lastLogoutTime"
      }),
      [3] = ProtobufI("Sort.SortKey", {keyName = "level"})
    },
    type = 7
  })
}
local indexed = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5,
  [6] = 6,
  [7] = 7,
  [8] = 8,
  [9] = 9,
  [10] = 10,
  [11] = 11,
  [12] = 12,
  [13] = 13,
  [14] = 14,
  [15] = 15,
  [16] = 16,
  [17] = 17,
  [18] = 18,
  [19] = 19,
  [20] = 20,
  [21] = 21,
  [22] = 22,
  [23] = 23,
  [24] = 24,
  [25] = 25,
  [26] = 26,
  [27] = 27,
  [28] = 28,
  [29] = 29,
  [30] = 30,
  [31] = 31,
  [32] = 32,
  [33] = 33,
  [34] = 34,
  [35] = 35,
  [36] = 36,
  [37] = 37,
  [38] = 38,
  [39] = 39,
  [40] = 40,
  [41] = 41,
  [42] = 42,
  [43] = 43,
  [44] = 44,
  [45] = 45,
  [46] = 46,
  [47] = 47,
  [48] = 54,
  [49] = 55,
  [50] = 56,
  [51] = 57,
  [52] = 58,
  [53] = 59,
  [54] = 48,
  [55] = 49,
  [56] = 50,
  [57] = 51,
  [58] = 52,
  [59] = 53,
  [66] = 60,
  [67] = 61
}
return {raw, indexed}
