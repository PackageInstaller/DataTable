local this = class("pageHeroRankRewardPreview", G_UIPageBase)
local talentRankRewardTpl = L_GameTpl:getTalentRankReward()

function this.bind()
  return {
    scrollIndex = 1,
    list_reward = {
      moduleName = "pages/HeroPanel/talent/cellTalentRankReward"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
      if self.onClose then
        self.onClose()
      end
    end
  }
end

function this:preOpen(options)
  self.heroId = options.heroId
  local hero = L_HeroStore:getHero(self.heroId)
  local heroRank = L_HeroStore:getHeroRank(hero)
  local tmp = {}
  local data = talentRankRewardTpl:getSortedData()
  for _, reward in ipairs(data) do
    local can = false
    local rank = reward.level
    local isShowBg = false
    local get = L_HeroStore:IsRankRewardGetted(hero, rank)
    if heroRank >= rank then
      can = true
    end
    if heroRank >= rank - 2 and heroRank < rank + 2 and not get then
      isShowBg = true
    end
    table.insert(tmp, {
      icon = reward.icon,
      heroId = options.heroId,
      rank = rank,
      showBg = isShowBg,
      canGet = can,
      reward = L_DataUtil.parseRewardConfig(reward.item),
      getted = get
    })
  end
  self.bind.list_reward:clear()
  self.bind.list_reward:insert_array(tmp)
  if options and options.index then
    self.bind.scrollIndex = options.index
  end
end

return this
