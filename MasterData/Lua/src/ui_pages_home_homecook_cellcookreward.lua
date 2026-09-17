local this = class("cellCookReward", G_UIModuleBase)
local TAGPOS = {
  [1] = {x = 151, y = 168.5},
  [2] = {x = 99.3, y = 162.3}
}
local GETBGPOS = {
  [1] = {x = -7, y = -198.3},
  [2] = {x = -11, y = -166}
}

function this.bind()
  return {
    name = "",
    evaluate = "",
    iconBg = "",
    effects = false,
    icon = "",
    isFirst = false,
    getBgScale = C_Vector3(1, 1, 1),
    bgScale = C_Vector3(1, 1, 1),
    getBgPos = C_Vector3(0, 0, 0),
    tagPos = C_Vector3(0, 0, 0)
  }
end

function this.methods()
  return {}
end

function this:open()
  if self.bind.isMultiple then
    self.bind.getBgScale = C_Vector3(0.9, 0.9, 1)
    self.bind.bgScale = C_Vector3(0.71, 0.71, 1)
    self.bind.getBgPos = C_Vector3(GETBGPOS[2].x, GETBGPOS[2].y, 0)
    self.bind.tagPos = C_Vector3(TAGPOS[2].x, TAGPOS[2].y, 0)
  else
    self.bind.getBgScale = C_Vector3(1, 1, 1)
    self.bind.bgScale = C_Vector3(0.8, 0.8, 1)
    self.bind.getBgPos = C_Vector3(GETBGPOS[1].x, GETBGPOS[1].y, 0)
    self.bind.tagPos = C_Vector3(TAGPOS[1].x, TAGPOS[1].y, 0)
  end
end

return this
