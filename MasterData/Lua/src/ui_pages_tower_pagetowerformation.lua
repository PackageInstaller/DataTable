local this = class("pageTowerFormation", G_UIPageBase)
local _heroTpl = L_GameTpl:getHeroTpl()

function this.bind()
  return {
    battleNameText = "",
    scoreText = "",
    repeatReward = L_Const.ModuleInfo.CellIcon,
    rewardList = L_Const.ModuleInfo.CellIcon,
    enemyList = L_Const.ModuleInfo.CellIcon,
    unitList = {
      moduleName = "modulePages/cellIconUnit"
    },
    moduleSortWay = {
      moduleName = "ModulePages/moduleSortWay"
    },
    filtrate = false,
    moduleFiltrate = {
      moduleName = "modulePages/filtrate/moduleHeroFiltrate"
    },
    formationList = {
      moduleName = "pages/tower/moduleTowerFormationCell"
    }
  }
end

function this.methods()
  return {
    onClick_closeBtn = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_detailBtn = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.hero)
    end,
    onClick_startChallengeBtn = this.onClickStartChallenge
  }
end

function this:preOpen(options)
  self._ESyncFormationServerDataHandler = handler(self, self.onRefreshFormationEvent)
  AzurWorld.formationMgr:RegisterEvent(C_EFormationEvent.ESyncFormationServerData, self._ESyncFormationServerDataHandler)
  L_TowerStore:listenCallFunc(L_TowerStore.event.refreshTowerScore, self.onRefreshTowerScore, self)
  self.battleData = options
  this.super.preOpen(self, options)
  self.heroList = L_HeroStore:getAllHero()
  self:updatePage()
end

function this:show()
  if self.bHide then
    self:updatePage()
    self.bHide = false
  end
end

function this:hide()
  self.bHide = true
end

function this:updatePage()
  self.bind.battleNameText = self.battleData.levelName
  self.modules.repeatReward:setGeneralContent(3, 354008, {
    itemNum = self.battleData.scoreReward
  })
  self:updateRewardList()
  self:updateEnemyList()
  self:initSortData()
  self:updateUnitList()
  self:updateFormationList()
  self:updateScore()
end

function this:updateScore()
  local currentScore = L_TowerStore:getTowerScore()
  local maxScore = L_TowerManager:getMaxScore()
  self.bind.scoreText = string.format(L_TowerConst.text.tower_score_text, currentScore, maxScore)
end

function this:initSortData()
  self.moduleFiltrateData = {
    closeCurModule = function()
      self.bind.filtrate = false
    end,
    filtrate = function(data)
      self:updateUnitList(data)
    end
  }
  self.modules.moduleFiltrate:initModule(self.moduleFiltrateData)
  local list = {
    L_Const.sortType.lv,
    L_Const.sortType.quality,
    L_Const.sortType.star
  }
  self.defaultSort = {
    {
      key = L_Const.sortType.lv,
      order = L_Const.sortOrder.DESC
    },
    {
      key = L_Const.sortType.quality,
      order = L_Const.sortOrder.DESC
    },
    {
      key = L_Const.sortType.star,
      order = L_Const.sortOrder.DESC
    },
    {
      key = "unitId",
      order = L_Const.sortOrder.DESC
    }
  }
  
  local function filtrateFunc(data)
    self.bind.filtrate = true
  end
  
  local function sortFunc(type, order)
    local sortParam = {
      {
        key = L_Const.sortType.lv,
        order = L_Const.sortOrder.DESC
      },
      {
        key = L_Const.sortType.quality,
        order = L_Const.sortOrder.DESC
      },
      {
        key = L_Const.sortType.star,
        order = L_Const.sortOrder.DESC
      },
      {
        key = "unitId",
        order = L_Const.sortOrder.DESC
      }
    }
    for _, v in ipairs(sortParam) do
      if v.key == type then
        table.remove(sortParam, _)
        break
      end
    end
    table.insert(sortParam, 1, {key = type, order = order})
    self.bind.unitList:sort(sortParam)
  end
  
  self.modules.moduleSortWay:initModule(list, sortFunc, filtrateFunc)
end

function this:updateUnitList(professionData, isUpdateFormation)
  self.bind.unitList:clear()
  local dataArray = {}
  local tmpHeroList = {}
  self.professionData = professionData
  if not table.isEmpty(professionData) then
    for i, v in pairs(self.heroList) do
      local tpl = _heroTpl:getTplById(L_HeroStore:getHeroConfigId(v))
      local pos = _heroTpl:getPosition(tpl)
      for k = 1, #professionData do
        if pos == professionData[k] then
          table.insert(tmpHeroList, v)
          break
        end
      end
    end
  else
    tmpHeroList = self.heroList
  end
  
  local function onClickCell(cell)
    local index = cell.bind.index
    self:clickHero(cell.bind.guid, index)
  end
  
  local formations = L_TowerManager:getTowerFormation(self.battleData.order)
  for i = 1, #tmpHeroList do
    if table.indexOf(formations, L_HeroStore:getHeroGuid(tmpHeroList[i])) == false then
      local hero = tmpHeroList[i]
      local heroItem = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(hero))
      table.insert(dataArray, {
        itemType = L_Const.resType.hero,
        guid = L_HeroStore:getHeroGuid(hero),
        index = i,
        star = L_HeroStore:getHeroStar(hero),
        lv = L_HeroStore:getHeroLevel(hero),
        quality = heroItem.quality,
        callback = onClickCell
      })
    end
  end
  if isUpdateFormation then
    self.bind.unitList:insert_array(dataArray)
  else
    self.bind.unitList:insert_array(dataArray, nil, self.defaultSort)
  end
end

function this:clickHero(heroId, index)
  local heroes = L_TowerManager:updateFormation(self.battleData.order, heroId)
  local posData = {}
  for i, v in pairs(heroes) do
    table.insert(posData, v.hero_id)
  end
  L_FormationManager:req_changeFormationData(L_FormationConst.FormationType.tower, self.battleData.order, posData, function()
    L_PlayerManager:playHeroVoice(heroId, L_Const.cvType.JoinFormation)
  end)
end

function this:updateRewardList()
  local rewards = L_DataUtil.parseRewardConfig(self.battleData.reward)
  local isGot = L_TowerManager:isBattlePassed(self.battleData.order)
  for _, reward in ipairs(rewards) do
    reward.activeReward = isGot
  end
  self.bind.rewardList:clear()
  self.bind.rewardList:insert_array(rewards)
end

function this:updateEnemyList()
  local enemies = {}
  for k, enemy in ipairs(self.battleData.enemyId) do
    table.insert(enemies, {
      showItem = true,
      itemType = L_Const.resType.hero,
      itemId = 109002
    })
  end
  self.bind.enemyList:clear()
  self.bind.enemyList:insert_array(enemies)
end

function this:onRefreshFormationEvent()
  self:updateFormationList()
  self:updateUnitList(self.professionData, true)
end

function this:updateFormationList()
  local posData = L_FormationStore:getFormationPosData(L_FormationConst.FormationType.tower, self.battleData.order)
  local res = {}
  for _, heroId in ipairs(posData) do
    if not math.isEmpty(heroId) and not math.isEmpty(heroId) then
      local heroData = L_HeroStore:getHero(heroId)
      table.insert(res, {
        heroId = heroId,
        petId = L_HeroStore:getHeroPetGuid(heroData),
        order = self.battleData.order
      })
    end
  end
  self.bind.formationList:clear()
  self.bind.formationList:insert_array(res)
end

function this:onRefreshTowerScore()
  self:updateScore()
end

function this:onEvent_loadSceneEndHandle()
  if self.openClimbTower then
    L_UI:open("pageTower", nil, function()
      self:dealBattle()
    end)
    self.openClimbTower = nil
    if self._onScenePrepared then
      C_GameFlow.flowEvent:Cancel(C_EGameFlowEvent.ScenePrepared, self._onScenePrepared)
    end
  end
end

function this:onClickStartChallenge()
  local curModule = L_WorldManager:getCurModule()
  local isHome = curModule == L_Const.worldModule.home
  if isHome then
    self._onScenePrepared = self._onScenePrepared or handler(self, self.onEvent_loadSceneEndHandle)
    C_GameFlow.flowEvent:Listen(C_EGameFlowEvent.ScenePrepared, self._onScenePrepared)
    self.openClimbTower = true
  else
    self:dealBattle()
  end
end

function this:dealBattle(callback)
  local formation = L_TowerManager:getTowerFormation(self.battleData.order)
  if #formation <= 0 then
    L_FlyMsgManager:showNormalMsgByKey(L_TowerConst.text.formation_empty_tips)
    return
  end
  L_TowerManager:startTowerBattle(self.battleData)
  L_BattleStore:req_createTowerBattle(self.battleData.battleId, self.battleData.towerId, self.battleData.order)
  L_UI:close(self.pageName)
end

function this:close(options)
  this.super.close(self, options)
  AzurWorld.formationMgr:UnregisterEvent(C_EFormationEvent.ESyncFormationServerData, self._ESyncFormationServerDataHandler)
  L_TowerStore:unListenCallFunc(L_TowerStore.event.refreshTowerScore, self.onRefreshTowerScore, self)
end

return this
