local raw = {
  [1] = ProtobufI("ActivityMiniGames", {
    activityId = 54008,
    gameId = 91001,
    rewardTimesEveryday = 3
  })
}
local indexed = {
  [54008] = {
    [91001] = 1
  }
}
return {raw, indexed}
