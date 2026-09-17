local this = class("kiboDuelSimulatorItem")

function this:ctor()
  self.kiboId = nil
  self.lv = 1
end

function this:setKiboId(id)
  if self.kiboId == id then
    return
  end
  self.kiboId = id
end

function this:setLevel(level)
  if 1 <= level and level <= 100 then
    self.lv = level
  end
end

function this:clear()
  self.kiboId = nil
  self.lv = 1
end

return this
