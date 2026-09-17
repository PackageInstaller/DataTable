local this = class("moduleHeroAdvanceRank", G_UIModuleBase)

function this.bind()
  return {}
end

function this:refresh(rank)
  if rank then
    for i = 0, self.bindComponents.cur.childCount - 1 do
      self.bindComponents.cur:GetChild(i).gameObject:ActiveTrans(false)
    end
    for i = 0, rank - 2 do
      self.bindComponents.cur:GetChild(i).gameObject:ActiveTrans(true)
    end
    for i = 0, self.bindComponents.advance.childCount - 1 do
      self.bindComponents.advance:GetChild(i).gameObject:ActiveTrans(false)
    end
    self.bindComponents.advance:GetChild(rank - 1).gameObject:ActiveTrans(true)
  end
end

return this
