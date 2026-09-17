local this = class("fishHandbook")

function this:ctor()
  self.item_id = 0
  self.min_weight = 0
  self.max_weight = 0
  self.history_count = 0
  self.read = false
end

function this:getFishId()
  return self.item_id
end

function this:getFishMinWeight()
  return self.min_weight
end

function this:getFishMaxWeight()
  return self.max_weight
end

function this:getFishHistoryCount()
  return self.history_count
end

function this:getFishIsRead()
  return self.read
end

return this
