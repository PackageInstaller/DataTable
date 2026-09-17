local this = class("cellRankStar", G_UIModuleBase)
local starId = {
  unlock = 0,
  target = 1,
  lock = 2
}

function this.bind()
  return {selectId_bgTabGroup = 1}
end

function this.methods()
  return {}
end

function this:open()
  self:initStar()
end

function this:initStar()
  local rankStarId = starId.lock
  if self.bind.id < self.bind.heroRank then
    rankStarId = starId.unlock
  elseif self.bind.id == self.bind.heroRank then
    rankStarId = starId.target
  elseif self.bind.id > self.bind.heroRank then
    rankStarId = starId.lock
  end
  self.bind.selectId_bgTabGroup = rankStarId
end

return this
