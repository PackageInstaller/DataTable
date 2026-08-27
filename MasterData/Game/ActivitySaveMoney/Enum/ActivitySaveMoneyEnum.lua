local ActivitySaveMoneyEnum = {}
ActivitySaveMoneyEnum.RedDotType = {redDotLooked = 1, redDotReward = 2}
ActivitySaveMoneyEnum.SaveMoneyActivityState = {
  saveState = 1,
  getState = 2,
  expire = 3
}
ActivitySaveMoneyEnum.SaveMoneyStageState = {
  lock = 1,
  canGet = 2,
  gotten = 3,
  expire = 4
}
return ActivitySaveMoneyEnum
