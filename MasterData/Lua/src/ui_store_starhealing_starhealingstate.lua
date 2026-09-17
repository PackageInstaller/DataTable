local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    isCharged = false,
    charge = {
      lastdaytime = 0,
      reduce_time = 0,
      ban_time = 0,
      add_hp = 0,
      cur_value = 0
    }
  }
end

return this
