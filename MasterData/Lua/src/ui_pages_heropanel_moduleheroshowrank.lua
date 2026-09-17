local this = class("moduleHeroShowRank", G_UIModuleBase)

function this.bind()
  return {}
end

function this:refreshStar(rank)
  for i = 0, self.bindComponents.rank.childCount - 1 do
    self.bindComponents.rank:GetChild(i).gameObject:ActiveTrans(false)
  end
  for i = 0, rank - 1 do
    self.bindComponents.rank:GetChild(i).gameObject:ActiveTrans(true)
  end
end

function this:refreshStarLevel5(rank)
  local showRank = rank
  if 2 < showRank then
    showRank = showRank + 1
  end
  self:refreshStar(showRank)
end

return this
