local raw = {
  [1] = ProtobufI("ActivityItemIconInfo", {
    activityId = 41001,
    activityType = 41,
    iconInfos = {
      [1] = ProtobufI("ActivityItemIconInfo.iconInfo", {
        id = 1001,
        resIcon = "ResItem_1001"
      })
    }
  })
}
local indexed = {
  [41001] = 1
}
return {raw, indexed}
