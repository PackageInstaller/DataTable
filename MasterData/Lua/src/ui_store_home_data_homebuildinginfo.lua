local this = class("homeBuildingInfo")

function this:ctor()
  self.id = 0
  self.build_id = nil
  self.total_num = 0
  self.used_num = 0
  self.unlock = false
end

return this
