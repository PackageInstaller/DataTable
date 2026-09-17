local this = class("pageHeroFavorabilityDetail", G_UIPageBase)
local _heroFavorabilityExpTpl = L_GameTpl:getHeroFavorabilityExpTpl()
local _heroFavorabilityInfoTpl = L_GameTpl:getHeroFavorabilityInfoTpl()
local _heroTpl = L_GameTpl:getHeroTpl()

function this.bind()
  return {
    go_preLevel = true,
    go_nextLevel = true,
    detailTitleText = "",
    favorValueText = "",
    favorLevelText = "",
    favorRequireText = "",
    currentActive = true,
    lockIconActive = false,
    rewardAreaActive = false,
    favorabilityUnlockList = {
      moduleName = "pages/HeroPanel/favorability/cellHeroFavorabilityReward"
    },
    favorabilityLevelList = {
      moduleName = "pages/HeroPanel/favorability/cellHeroFavorabilityLevel"
    },
    rewardList = {
      moduleName = "modulePages/cellIconCircle"
    }
  }
end

function this.methods()
  return {
    onClick_preLevel = function(self)
      self:setSelectLevel(self.selectLevel - 1)
      self:foucsLevelIndex()
    end,
    onClick_nextLevel = function(self)
      self:setSelectLevel(self.selectLevel + 1)
      self:foucsLevelIndex()
    end,
    onClick_close = function(self)
      L_UI:close("pageHeroFavorabilityDetail")
    end,
    favorabilityLevelList = {
      selectLevel = function(self, id)
        if self.selectLevel ~= id then
          self:setSelectLevel(id)
        end
      end
    },
    rewardList = {
      onClick = function(self, itemType)
        if itemType == L_Const.resType.soulEssence then
          L_UI:close("pageHeroFavorabilityDetail")
        end
      end
    }
  }
end

function this:preOpen(options)
  print("=========================options.heroId", options.heroId)
  self.heroId = 0
  self.options = options
  if options then
    self.heroId = options and options.heroId or 0
    if options.preCallback then
      options.preCallback()
    end
    self.closeCallback = options.favorabilityDetailCloseCallback
  end
  local hero = L_HeroStore:getHero(self.heroId)
  local curLevel = L_HeroStore:getHeroFavorAbilityLevel(hero)
  self:setSelectLevel(curLevel + 1)
  self:refreshLevelArea()
  self:foucsLevelIndex(true)
end

function this:open()
  if not self.checkReward then
    self:checkAndRequestReward()
  end
  if self.bindComponents.rootAnim then
    if self.options and self.options.leftJoin then
      self.bindComponents.rootAnim:Play("anim_hero_favor_open_left")
    else
      self.bindComponents.rootAnim:Play("anim_hero_favor_open")
    end
  end
  C_InputManager.SetGamepadUIInputMap(self.pageName, true)
end

function this:checkAndRequestReward()
  self.checkReward = true
  local heroData = L_HeroStore:getHero(self.heroId)
  local rewards = L_HeroStore:getHeroStoreFavorRewards(heroData)
  if rewards and 0 < #rewards then
    L_FavorabilityStore:req_getFavorabilityReward(self.heroId, function()
    end)
  end
end

function this:foucsLevelIndex(bOpen)
  local maxLevel = _heroFavorabilityExpTpl:getMaxFavorabilityLevel()
  if self.selectLevel > 2 and self.selectLevel < maxLevel - 2 then
    self.bindComponents.levelTableView:FocusItemIndex(self.selectLevel - 3)
  end
  if self.selectLevel >= maxLevel - 2 then
    self.bindComponents.levelTableView.horizontalNormalizedPosition = 1
    if bOpen then
      Timer.once(0.1, function()
        self.bindComponents.levelTableView.horizontalNormalizedPosition = 1
      end, self, self.gameObject)
    end
  end
end

function this:setSelectLevel(level)
  local maxLevel = _heroFavorabilityExpTpl:getMaxFavorabilityLevel()
  if level < 1 then
    level = 1
  end
  if maxLevel < level then
    level = maxLevel
  end
  if self.selectLevel == level then
    return
  end
  self.selectLevel = level
  for i = 1, #self.bind.favorabilityLevelList do
    local favorabilityLevel = self.bind.favorabilityLevelList:getValue(i, "level")
    self.bind.favorabilityLevelList:change(i, {
      selected = favorabilityLevel == self.selectLevel
    })
  end
  self:refreshDetailArea()
end

function this:refreshDetailArea()
  if self.lastSelectLevel ~= nil then
    self.bindComponents.switchAnimation:Stop()
    if self.lastSelectLevel > self.selectLevel then
      self.bindComponents.switchAnimation:Play("anim_hero_favor_content_show_left")
    end
    if self.lastSelectLevel < self.selectLevel then
      self.bindComponents.switchAnimation:Play("anim_hero_favor_content_show_right")
    end
  end
  self.lastSelectLevel = self.selectLevel
  local hero = L_HeroStore:getHero(self.heroId)
  local heroConfigId = L_HeroStore:getHeroConfigId(hero)
  local curLevel = L_HeroStore:getHeroFavorAbilityLevel(hero)
  self.bind.currentActive = curLevel == self.selectLevel
  self.bind.lockIconActive = curLevel < self.selectLevel
  local tpl = _heroFavorabilityInfoTpl:getTplById(heroConfigId, self.selectLevel)
  local unlockInfo = _heroFavorabilityInfoTpl:getInfo(tpl)
  self.bind.favorabilityUnlockList:clear()
  local unlockData = {}
  for i = 1, #unlockInfo do
    table.insert(unlockData, {
      rewardDescText = L_Config:provider(unlockInfo[i]),
      lockedText = L_Config:provider(unlockInfo[i]),
      rewardDescTextActive = curLevel >= self.selectLevel,
      lockedTextActive = curLevel < self.selectLevel
    })
  end
  self.bind.favorabilityUnlockList:insert_array(unlockData)
  local tempName = _heroTpl:getName(_heroTpl:getTplById(heroConfigId))
  if heroConfigId == L_GameUtil.getDefaultHeroId() then
    tempName = L_PlayerStore:getPlayerName()
  end
  local maxExp = _heroFavorabilityExpTpl:getFavorabilityTotalExp(self.selectLevel - 1)
  local favorabilityExp = L_HeroStore:getHeroFavorAbilityExp(hero)
  local curExp = _heroFavorabilityExpTpl:getFavorabilityTotalExp(curLevel - 1) + favorabilityExp
  self.bind.detailTitleText = string.format("%02d", self.selectLevel)
  self.bind.favorValueText = curExp .. "/" .. maxExp
  if self.selectLevel == 0 then
    self.bind.detailTitleText = "0"
  end
  self.bind.favorLevelText = L_GameTpl:getWordsTpl():getTplById("ui_favor_level") .. self.selectLevel
  if self.bind.lockIconActive then
    self.bind.favorRequireText = L_WordsTpl:getValue("ui_favor_unsatisified", {
      [0] = maxExp
    })
  else
    self.bind.favorRequireText = L_WordsTpl:getValue("ui_favor_satisified", {
      [0] = maxExp
    })
  end
  self:setRewardArea()
end

function this:setRewardArea()
  local hero = L_HeroStore:getHero(self.heroId)
  local heroConfigId = L_HeroStore:getHeroConfigId(hero)
  local curLevel = L_HeroStore:getHeroFavorAbilityLevel(hero)
  local isRewardGot = curLevel >= self.selectLevel
  self.bind.rewardList:clear()
  local tpl = _heroFavorabilityInfoTpl:getTplById(heroConfigId, self.selectLevel)
  local rewards = _heroFavorabilityInfoTpl:getReward(tpl)
  self.bind.rewardAreaActive = not table.isEmpty(rewards)
  if self.bind.rewardAreaActive then
    local rewardsData = L_DataUtil.parseRewardConfig(rewards)
    self.bind.rewardList:insert_array(rewardsData)
  end
  for _, v in pairs(self.modules.rewardList) do
    v:setClaimedState(isRewardGot)
  end
end

function this:refreshLevelArea()
  self.bind.favorabilityLevelList:clear()
  local levelData = {}
  local maxLevel = _heroFavorabilityExpTpl:getMaxFavorabilityLevel()
  for i = 1, maxLevel do
    local tpl = _heroFavorabilityExpTpl:getTplById(i)
    if tpl then
      local level = _heroFavorabilityExpTpl:getFavorabilityLevel(tpl)
      table.insert(levelData, {
        level = level,
        selected = level == self.selectLevel,
        hideRight = level == maxLevel
      })
    end
  end
  self.bind.favorabilityLevelList:insert_array(levelData)
end

function this:close()
  if self.closeCallback then
    self.closeCallback()
  end
  C_InputManager.SetGamepadUIInputMap(self.pageName, false)
end

return this
