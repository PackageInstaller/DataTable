local raw = {
  [1] = ProtobufI("DormGiftGroupDetail", {
    detailId = 1,
    gift = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 56001,
        count = 5
      })
    }
  }),
  [2] = ProtobufI("DormGiftGroupDetail", {
    detailId = 2,
    gift = {
      [1] = ProtobufI("STResource", {type = 7, count = 10000})
    }
  }),
  [3] = ProtobufI("DormGiftGroupDetail", {
    detailId = 3,
    gift = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 53001,
        count = 1
      })
    }
  }),
  [4] = ProtobufI("DormGiftGroupDetail", {
    detailId = 4,
    gift = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 53002,
        count = 1
      })
    }
  }),
  [5] = ProtobufI("DormGiftGroupDetail", {
    detailId = 5,
    gift = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 53003,
        count = 1
      })
    }
  }),
  [6] = ProtobufI("DormGiftGroupDetail", {
    detailId = 6,
    gift = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 53004,
        count = 1
      })
    }
  })
}
local indexed = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5,
  [6] = 6
}
return {raw, indexed}
