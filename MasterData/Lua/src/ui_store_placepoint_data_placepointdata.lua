local this = class("placePointData")

function this:ctor()
  self.guid = nil
  self.place_id = nil
  self.building_guid = nil
  self.times = nil
  self.extra_times = nil
  self.storage_counts = {
    0,
    0,
    0
  }
  self.extra_storage_counts = 0
  self.extra_storage = {}
  self.heros = {}
end

return this
