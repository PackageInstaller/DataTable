local this = class("pageBattleSettle", G_UIPageBase)

function this.bind()
  return {
    go_heroAndPetExp = false,
    list_heroAndPetExp = {
      moduleName = "pages/battle/cellSettleExp"
    }
  }
end

function this.methods()
  return {}
end

function this:check(options, callback)
  local topPageName = L_UI:currentPage(L_UI.groupKeys.stack)
  local ret = L_UI:stackRootPage() == topPageName
  if ret then
    local reward = L_BattleStore:getParseBattleReward()
    local currencyReward = reward[L_Const.resType.currency]
    local heroCache = L_BattleStore:getHeroCacheData()
    ret = not table.isEmpty(currencyReward) and not table.isEmpty(heroCache)
  end
  callback(ret)
  if not ret and options and options.closeCallback then
    options.closeCallback()
  end
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._delayCloseCount = 0
  L_UI:addListener(L_UI.pageEvent.showed, self.onEvent_showPage, self)
  self:initPage()
end

function this:open()
end

function this:initPage()
  self:initExpList()
end

function this:close(options)
  L_UI:removeListener(L_UI.pageEvent.showed, self.onEvent_showPage)
  L_BattleStore:setBattleReward(nil)
  L_BattleStore:clearHeroDataCache()
  L_TimerManager:clearTimer(self)
end

function this:initExpList()
  local posData = L_FormationStore:getFormationPosData(L_FormationConst.FormationType.world)
  local tmp = {}
  for i, heroGuid in pairs(posData) do
    if not math.isEmpty(heroGuid) then
      table.insert(tmp, {heroId = heroGuid})
    end
  end
  for i, v in ipairs(tmp) do
    v.index = i
    v.lastHero = i == #tmp
  end
  self.bind.go_heroAndPetExp = not table.isEmpty(tmp)
  self.bind.list_heroAndPetExp:clear()
  self.bind.list_heroAndPetExp:insert_array(tmp)
  L_TimerManager:newOrResetTimer(self, "playCellAni", function()
    for i, v in pairs(self.modules.list_heroAndPetExp) do
      v:playShowAni()
    end
  end, 0.264)
end

function this:onEvent_showPage(pageName)
  local curCfg = C_UIMgr.GetPageConfig(pageName)
  if curCfg.group == CS.Azur.Gameplay.EUIGroup.Stack then
    local topPageName = L_UI:currentPage(L_UI.groupKeys.stack)
    local cfg = C_UIMgr.GetPageConfig(topPageName)
    if cfg.mode ~= CS.Azur.Gameplay.EUIMode.Coexist and pageName ~= self.pageName then
      L_UI:close(self.pageName)
    end
  end
end

function this:delayClosePage()
  self._delayCloseCount = self._delayCloseCount + 1
  if self._delayCloseCount == #self.modules.list_heroAndPetExp then
    L_TimerManager:newOrResetTimer(self, "delayClosePage", function()
      L_UI:close(self.pageName)
    end, 0.594)
  end
end

return this
