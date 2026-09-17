local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    dungeonCampaignInfo = {},
    dungeonInstanceInfo = {},
    dungeonCampaignEnd = {}
  }
end

return this
