local this = class("friendPetItem")

function this:ctor()
  self.pet_name = nil
  self.guid = nil
  self.id = nil
  self.comprehension = nil
  self.skills = nil
  self.lv = nil
  self.rank = nil
  self.pid = nil
  self.name = nil
  self.avatar_url = nil
end

function this:isSpecialPet()
  return self.special
end

return this
