local raw = {
  [1] = ProtobufI("SigninGift", {
    days = 3,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 2
      })
    }
  }),
  [2] = ProtobufI("SigninGift", {
    days = 7,
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 100000})
    }
  }),
  [3] = ProtobufI("SigninGift", {
    days = 14,
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 200})
    }
  }),
  [4] = ProtobufI("SigninGift", {
    days = 21,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 10
      })
    }
  })
}
local indexed = {
  [3] = 1,
  [7] = 2,
  [14] = 3,
  [21] = 4
}
return {raw, indexed}
