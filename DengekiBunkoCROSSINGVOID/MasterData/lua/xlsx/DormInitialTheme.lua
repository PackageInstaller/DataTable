local raw = {
  [1] = ProtobufI("DormInitialTheme", {
    arrangement = ProtobufI("DormArrangement.Arrangement", {
      furnitures = {
        [1] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 100001,
          position = ProtobufI("DormArrangement.Position", {}),
          parent = -1
        }),
        [2] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 100002,
          position = ProtobufI("DormArrangement.Position", {}),
          parent = -1
        })
      }
    })
  }),
  [2] = ProtobufI("DormInitialTheme", {
    theme = 1,
    arrangement = ProtobufI("DormArrangement.Arrangement", {
      furnitures = {
        [1] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 100102,
          position = ProtobufI("DormArrangement.Position", {}),
          parent = -1
        }),
        [2] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 100101,
          position = ProtobufI("DormArrangement.Position", {}),
          parent = -1
        }),
        [3] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 100111,
          position = ProtobufI("DormArrangement.Position", {x = 10}),
          parent = -1
        }),
        [4] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 100103,
          position = ProtobufI("DormArrangement.Position", {x = 11, y = 2}),
          parent = -1
        }),
        [5] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 100106,
          position = ProtobufI("DormArrangement.Position", {}),
          parent = -1
        }),
        [6] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 100107,
          position = ProtobufI("DormArrangement.Position", {y = 17}),
          parent = -1
        }),
        [7] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 100108,
          position = ProtobufI("DormArrangement.Position", {x = 5, y = 6}),
          flip = true,
          parent = -1
        }),
        [8] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 100116,
          position = ProtobufI("DormArrangement.Position", {y = 9}),
          flip = true,
          parent = -1
        }),
        [9] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 100105,
          position = ProtobufI("DormArrangement.Position", {x = 13, y = 12}),
          parent = -1
        }),
        [10] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 100117,
          position = ProtobufI("DormArrangement.Position", {
            x = 6,
            y = 9,
            z = 2
          }),
          parent = 7
        }),
        [11] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 100118,
          position = ProtobufI("DormArrangement.Position", {x = 14, y = 9}),
          parent = -1
        })
      }
    })
  }),
  [3] = ProtobufI("DormInitialTheme", {
    theme = 999,
    arrangement = ProtobufI("DormArrangement.Arrangement", {
      furnitures = {
        [1] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 101,
          position = ProtobufI("DormArrangement.Position", {}),
          parent = -1
        }),
        [2] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 102,
          position = ProtobufI("DormArrangement.Position", {}),
          parent = -1
        }),
        [3] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 103,
          position = ProtobufI("DormArrangement.Position", {}),
          parent = -1
        }),
        [4] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 104,
          position = ProtobufI("DormArrangement.Position", {x = 2}),
          parent = -1
        }),
        [5] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 105,
          position = ProtobufI("DormArrangement.Position", {y = 3}),
          parent = -1
        }),
        [6] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 106,
          position = ProtobufI("DormArrangement.Position", {y = 5}),
          parent = -1
        }),
        [7] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 106,
          position = ProtobufI("DormArrangement.Position", {y = 11}),
          parent = -1
        }),
        [8] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 106,
          position = ProtobufI("DormArrangement.Position", {x = 10, y = 5}),
          parent = -1
        }),
        [9] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 106,
          position = ProtobufI("DormArrangement.Position", {x = 10, y = 11}),
          parent = -1
        }),
        [10] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 107,
          position = ProtobufI("DormArrangement.Position", {x = 4, y = 18}),
          parent = -1
        }),
        [11] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 108,
          position = ProtobufI("DormArrangement.Position", {y = 10}),
          parent = -1
        }),
        [12] = ProtobufI("DormArrangement.Furniture", {
          furnitureId = 109,
          position = ProtobufI("DormArrangement.Position", {x = 12, y = 18}),
          parent = -1
        })
      }
    })
  })
}
local indexed = {
  [0] = 1,
  [1] = 2,
  [999] = 3
}
return {raw, indexed}
