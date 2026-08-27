local LotteryConfig = class("LotteryConfig")

function LotteryConfig:ctor()
  self.NextFreeTime = 0
end

return LotteryConfig
