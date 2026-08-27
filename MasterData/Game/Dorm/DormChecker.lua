local DormChecker = {}
local HeroTalkUnlockType = {Friendship = 1, Rank = 2}
local HeroTalkCheckFunc = {
  [HeroTalkUnlockType.Friendship] = function(heroId, arg)
    local level = PlayerDataCenter.allFriendshipData:GetLevel(heroId)
    return arg <= level
  end,
  [HeroTalkUnlockType.Rank] = function(heroId, arg)
    local heroData = PlayerDataCenter:GetHeroData(heroId)
    if heroData == nil then
      return false
    end
    return arg <= heroData.rank
  end
}

function DormChecker.CheckerTalkUnlock(heroId, unlockType, arg)
  local func = HeroTalkCheckFunc[unlockType]
  if func == nil then
    return false
  end
  return func(heroId, arg)
end

return DormChecker
