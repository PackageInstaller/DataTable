local this = class("moduleHeroShowStar", G_UIModuleBase)

function this.bind()
  return {uneven = false, even = true}
end

function this:refreshStar(star)
  if math.floor(star % 2) > 0 then
    self.bind.uneven = true
    self.bind.even = false
    for i = 0, self.bindComponents.uneven.childCount - 1 do
      self.bindComponents.uneven:GetChild(i).gameObject:ActiveTrans(false)
    end
    for i = 0, star - 1 do
      self.bindComponents.uneven:GetChild(i).gameObject:ActiveTrans(true)
    end
  else
    self.bind.uneven = false
    self.bind.even = true
    for i = 0, self.bindComponents.even.childCount - 1 do
      self.bindComponents.even:GetChild(i).gameObject:ActiveTrans(false)
    end
    for i = 0, star - 1 do
      self.bindComponents.even:GetChild(i).gameObject:ActiveTrans(true)
    end
  end
end

return this
