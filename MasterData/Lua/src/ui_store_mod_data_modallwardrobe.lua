local this = class("modAllWardrobe")

function this:ctor()
  self.id = -1
  self.sex = 2
  self.type = -1
  self.initial = 0
  self.name = ""
  self.wardrobeId = -1
  self.modAllColorList = {}
end

return this
