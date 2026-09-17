local module = class("moduleStarRating", G_UIModuleBase)

function module:ctor(...)
  module.super.ctor(self, ...)
end

function module:refreshStar(star, levelUpStar)
  if not self.isBind then
    return
  end
  for i = 0, self.bindComponents.starGroup.childCount - 1 do
    self.bindComponents.starGroup:GetChild(i).gameObject:ActiveTrans(false)
  end
  for i = 1, star do
    self.bindComponents.starGroup:GetChild(i - 1).gameObject:ActiveTrans(true)
  end
  if levelUpStar then
    for i = 0, self.bindComponents.levelupStarGroup.childCount - 1 do
      self.bindComponents.levelupStarGroup:GetChild(i).gameObject:ActiveTrans(false)
    end
    for i = 1, levelUpStar do
      self.bindComponents.levelupStarGroup:GetChild(i - 1).gameObject:ActiveTrans(true)
    end
  end
end

return module
