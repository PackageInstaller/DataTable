local this = class("pageHeroFavorabilityLevelUp", G_UIPageBase)
local _heroFavorabilityInfoTpl = L_GameTpl:getHeroFavorabilityInfoTpl()
local _heroTpl = L_GameTpl:getHeroTpl()

local function isInDungeonLikeScene()
  return AzurWorld.DungeonMgr:CheckIsDungeonScene() or AzurWorld.proxyCenter.curProxy.proxyType == C_EWorldType.MultiDungeon or AzurWorld.abyssMgr.isInAbyss or AzurWorld.scenarioManager.RuntimeData.IsInTrial or AzurWorld.scenarioManager.GlobalData:GetIsInEndlessTrail()
end

function this.bind()
  return {
    levelText = "",
    levelNextText = "",
    go_go = false,
    unlockList = {
      moduleName = "pages/HeroPanel/favorability/cellHeroFavorabilityReward"
    },
    heroImg = ""
  }
end

function this.methods()
  return {
    onClick_mask = function(self)
      self:showNextHero()
    end,
    onClick_go = function(self)
      self:showNextHero()
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.heroData, {
        heroId = self.heroId
      })
    end
  }
end

function this:showNextHero()
  if self.curIndex >= #self.heroList then
    L_UI:close("pageHeroFavorabilityLevelUp")
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
  self.bind.unlockList:clear()
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
  self.bind.unlockList:insert_array(temp)
  local tempName = _heroTpl:getName(_heroTpl:getTplById(heroConfigId))
  if hero.type == L_Const.HeroType.HT_MAIN then
    tempName = L_PlayerStore:getPlayerName()
  end
  self.bind.levelText = string.format("%s%s", L_WordsTpl:getValue("info_char_lv"), tostring(self.startLevel))
  self.bind.levelNextText = string.format("%s%s", L_WordsTpl:getValue("info_char_lv"), tostring(endLevel))
  self.bind.go_go = self.curIndex >= #self.heroList and not isInDungeonLikeScene()
  local paintUrl = L_GameUtil.getAvatarTexturePath(heroConfigId, L_Const.avatarTextureIndex.head_talk)
  self.bind.heroImg = paintUrl
end

function this:preOpen(options)
  self.heroList = {}
  if options then
    self.heroList = options.heroList or {}
  end
  self.curIndex = 0
  self:showNextHero()
end

return this
