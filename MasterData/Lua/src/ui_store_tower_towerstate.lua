local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    towerId = 0,
    score = 0,
    towerTime = 0,
    scoreTime = 0,
    scoreRewardRecord = {},
    firstRewardRecord = {}
  }
end

return this
