local this = class("pageHeroFavorabilityLevelUpTips", G_UIPageBase)
local _heroFavorabilityInfoTpl = L_GameTpl:getHeroFavorabilityInfoTpl()
local _heroTpl = L_GameTpl:getHeroTpl()

function this.bind()
  return {levelText = "", levelNextText = ""}
end

function this.methods()
  return {}
end

function this:preOpen(options)
  self.heroList = {}
  if options then
    self.heroList = options.heroList or {}
  end
  self.curIndex = 0
  self:showNextHero()
  self.timer = Timer.once(2 * #self.heroList, function()
    L_UI:close(self.pageName)
  end, self)
end

function this:close()
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
end

function this:showNextHero()
  if self.curIndex >= #self.heroList then
    L_UI:close("pageHeroFavorabilityLevelUpTips")
    return
  end
  self.curIndex = self.curIndex + 1
  local heroInfo = self.heroList[self.curIndex]
  self.heroId = heroInfo.heroId
  local hero = L_HeroStore:getHero(self.heroId)
  local heroConfigId = L_HeroStore:getHeroConfigId(hero)
  local endLevel = L_HeroStore:getHeroFavorAbilityLevel(hero)
  self.startLevel = endLevel - 1
  local infos = _heroFavorabilityInfoTpl:getChildren(heroConfigId)
  local temp = {}
  for i, tpl in ipairs(infos) do
    local lv = _heroFavorabilityInfoTpl:getFavorabilityLevel(tpl)
    if lv > self.startLevel and endLevel >= lv then
      local rewards = _heroFavorabilityInfoTpl:getInfo(tpl)
      for i = 1, #rewards do
        table.insert(temp, {
          rewardDescText = L_Config:provider(rewards[i])
        })
      end
    end
  end
  self.bind.levelText = string.format("%s%s", L_WordsTpl:getValue("info_char_lv"), tostring(self.startLevel))
  self.bind.levelNextText = string.format("%s%s", L_WordsTpl:getValue("info_char_lv"), tostring(endLevel))
end

return this
