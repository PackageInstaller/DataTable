local raw = {
  [1] = ProtobufI("QuestionActivtyConfig", {
    activityId = 99001,
    refreshCount = 10,
    questionActivtyCost = ProtobufI("STResource", {
      type = 11,
      id = 80016,
      count = 1
    }),
    questionTipsInterval1 = 3,
    questionTipsInterval2 = 10,
    questionTips1MaxNum = 5,
    allowPing = 5
  })
}
local indexed = {
  [99001] = 1
}
return {raw, indexed}
