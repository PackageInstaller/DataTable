local this = class("moduleDungeonEntry", G_UIModuleBase)
local _dungeonTpl = L_GameTpl:getDungeonTpl()
local _dungeonExpTpl = L_GameTpl:getDungeonExpTpl()
local _staminaChestDropTpl = L_GameTpl:getStaminaChestDropTpl()
local StaminaCurrencyConfig = L_ItemTplManager:getItemConfig(L_Const.resType.currency, L_Const.currencyType.stamina)

function this.bind()
  return {
    list_cellDungeonDifficulty = {
      moduleName = "pages/dungeon/dungeonIntegration/cellDungeonDifficultyOfModuleDungeonEntry"
    },
    img_dungeonLevel = nil,
    text_dungeonName = nil,
    text_dungeonIntroduce = nil,
    list_dungeonRewardList = {
      moduleName = "modulePages/cellIconBag"
    },
    text_staminaCost = nil,
    img_stamina = StaminaCurrencyConfig.icon,
    text_difficultyHint = "",
    active_imgCard = true,
    img_Card = nil
  }
end

function this.methods()
  return {
    onClick_buttonFormation = function(self)
      self:onClickButtonFormation()
    end,
    onClick_buttonDungeonEntry = function(self)
      self:onClickButtonDungeonEntry()
    end
  }
end

function this:open()
  self:registerEvents()
end

function this:registerEvents()
  self.onHeroDataRefreshHandler = handler(self, self.onHeroDataRefresh)
  AzurWorld.heroMgr:RegisterEvent(C_EHeroEvent.ESyncHeroServerData, self.onHeroDataRefreshHandler)
  self.onFormationDataRefreshHandler = handler(self, self.onFormationDataRefresh)
  AzurWorld.formationMgr:RegisterEvent(C_EFormationEvent.ESyncFormationServerData, self.onFormationDataRefreshHandler)
end

function this:initParent(parent)
  self.parent = parent
end

function this:initData(doorId, isExpDungeon)
  self.doorId = doorId
  self.isExpDungeon = isExpDungeon
  self.dungeonConfig = _dungeonTpl:getTplListByDoorId(self.doorId)
  for groupId, tplList in pairs(self.dungeonConfig) do
    self.groupId = groupId
    self.dungeonTplList = tplList
    break
  end
  table.sort(self.dungeonTplList, function(a, b)
    return a.dungeonGroupOrder < b.dungeonGroupOrder
  end)
  for i = #self.dungeonTplList, 1, -1 do
    local dungeonTpl = self.dungeonTplList[i]
    if L_ConditionManager:isComplete(_dungeonTpl:getUnlockCondition(dungeonTpl)) then
      self:setCurDifficultyDatas(dungeonTpl)
      self.curViewIndex = i
      break
    end
  end
  self.bind.active_imgCard = isExpDungeon
  if isExpDungeon then
    self.dungeonExpTpl = _dungeonExpTpl:getTplByDoorId(self.doorId)
    self.bind.img_Card = _dungeonExpTpl:getDungeonCard(self.dungeonExpTpl)
  end
end

function this:initUI()
  self:refreshDungeonDifficultyUI()
  self:refreshCellDungeonDifficultySelectUI()
  self:refreshDungeonInfoUI()
end

function this:showSelf()
  self.bind.active_self = true
end

function this:hideSelf()
  self.bind.active_self = false
end

function this:onClickButtonFormation()
  L_SystemBreakManager:jumpTo(L_SystemConst.enum.formation, {dontBack2RootWhenClose = true})
end

function this:onClickButtonDungeonEntry()
  local function endDo()
  end
  
  local isFullFormation = L_FormationStore:checkIsFullFormation()
  if not isFullFormation then
    L_GameUtil.showCommonTip({
      txtContent = L_Lang:get(L_WordsTpl:getValue("ui_dungeon_team_role")),
      confirmCallback = endDo
    })
    return
  end
  local averageHeroLevel = L_FormationStore:getAverageHeroLevelOfCurFormation()
  local showLevel = _dungeonTpl:getShowLevel(self.dungeonTplOfSelectDifficulty)
  if averageHeroLevel < showLevel then
    L_GameUtil.showCommonTip({
      txtContent = L_Lang:get(L_WordsTpl:getValue("ui_dungeon_team_level")),
      confirmCallback = endDo
    })
    return
  end
  local curStamina = L_PlayerStore:getCurrencyNum(L_Const.currencyType.stamina)
  if curStamina < _dungeonTpl:getNeedPower(self.dungeonTplOfSelectDifficulty) then
    L_GameUtil.showCommonTip({
      txtContent = L_WordsTpl:getValue("notice_pageDungeonEntry_01"),
      confirmCallback = endDo,
      showNoMoreType = L_Const.ShowNoMoreType.today,
      showNoMoreKey = L_Const.ShowNoMoreKey.pageDungeonEntry_start
    })
    return
  end
  endDo()
end

function this:onClickCellDungeonDifficulty(viewIndex)
  if not self:checkIsCanChooseTargetDungeonDifficulty(viewIndex) then
    local targetDungeonTpl = self.dungeonTplList[viewIndex]
    local desc = L_ConditionManager:getDescs(_dungeonTpl:getUnlockCondition(targetDungeonTpl))
    L_FlyMsgManager:showNormalMsg(desc[1])
    return
  end
  self.curViewIndex = viewIndex
  self:setCurDifficultyDatas(self.dungeonTplList[self.curViewIndex])
  self:refreshCellDungeonDifficultySelectUI()
  self:refreshDungeonInfoUI()
end

function this:onHeroDataRefresh()
  self:refreshDungeonInfoUI()
end

function this:onFormationDataRefresh()
  self:refreshDungeonInfoUI()
end

function this:close()
  self:unRegisterEvents()
end

function this:refreshDungeonDifficultyUI()
  local cellDungeonDifficultyEmptyList = {}
  for i = 1, #self.dungeonTplList do
    table.insert(cellDungeonDifficultyEmptyList, {
      toggle_isLock = true,
      active_hasNext = i < #self.dungeonTplList,
      maxViewIndex = #self.dungeonTplList
    })
  end
  self.bind.list_cellDungeonDifficulty:clear()
  self.bind.list_cellDungeonDifficulty:insert_array(cellDungeonDifficultyEmptyList)
  for i = 1, #self.dungeonTplList do
    local cellDungeonDifficultyOfModuleDungeonEntry = self.bind.list_cellDungeonDifficulty:getItemCls(i)
    cellDungeonDifficultyOfModuleDungeonEntry:setParent(self)
    cellDungeonDifficultyOfModuleDungeonEntry:setDataAndViewIndex(self.dungeonTplList[i], i)
    cellDungeonDifficultyOfModuleDungeonEntry:refreshUI()
  end
end

function this:setCurDifficultyDatas(dungeonTpl)
  self.dungeonTplOfSelectDifficulty = dungeonTpl
  self.dungeoneTplIdOfSelectDifficulty = _dungeonTpl:getId(self.dungeonTplOfSelectDifficulty)
  self.staminaChestDropTplOfSelectDifficulty = _staminaChestDropTpl:getTplByWorldFilter(L_Const.StaminaBoxSystemType.SBST_CAMPAIGN, self.dungeoneTplIdOfSelectDifficulty)
  self.dungeonRewardList = L_DataUtil.parseRangeRewardConfig(_staminaChestDropTpl:getRewardDisplay(self.staminaChestDropTplOfSelectDifficulty))
end

function this:refreshCellDungeonDifficultySelectUI()
  for i = 1, #self.bind.list_cellDungeonDifficulty do
    local cellDungeonDifficultyOfModuleDungeonEntry = self.bind.list_cellDungeonDifficulty:getItemCls(i)
    cellDungeonDifficultyOfModuleDungeonEntry:setSelect(i == self.curViewIndex)
  end
end

function this:refreshDungeonInfoUI()
  local dungeonIntroduce = ""
  if self.isExpDungeon then
    self.dungeonExpTpl = _dungeonExpTpl:getTplByDoorId(self.doorId)
    dungeonIntroduce = _dungeonExpTpl:getDungeonIntroduce(self.dungeonExpTpl)
  elseif self.dungeonTplOfSelectDifficulty then
    dungeonIntroduce = _dungeonTpl:getDesc(self.dungeonTplOfSelectDifficulty)
  end
  self.bind.text_dungeonIntroduce = dungeonIntroduce
  self.bind.img_dungeonLevel = _dungeonTpl:getDifficultyIconPath(self.dungeonTplOfSelectDifficulty)
  self.bind.text_dungeonName = _dungeonTpl:getName(self.dungeonTplOfSelectDifficulty)
  local showLevel = _dungeonTpl:getShowLevel(self.dungeonTplOfSelectDifficulty)
  local oriTextDifficultyHint = L_Lang:get(L_WordsTpl:getValue("ui_dungeon_team_level_remind"), {
    [0] = showLevel
  })
  local averageHeroLevel = L_FormationStore:getAverageHeroLevelOfCurFormation()
  self.bind.text_difficultyHint = showLevel > averageHeroLevel and L_GameUtil.fillColor(oriTextDifficultyHint, L_Const.colorHtml.red005) or oriTextDifficultyHint
  self.bind.list_dungeonRewardList:clear()
  self.bind.list_dungeonRewardList:insert_array(self.dungeonRewardList)
  self.bind.text_staminaCost = "x" .. _dungeonTpl:getNeedPower(self.dungeonTplOfSelectDifficulty)
end

function this:checkIsCanChooseTargetDungeonDifficulty(viewIndex)
  local targetDungeonTpl = self.dungeonTplList[viewIndex]
  return L_ConditionManager:isComplete(_dungeonTpl:getUnlockCondition(targetDungeonTpl))
end

function this:unRegisterEvents()
  AzurWorld.heroMgr:UnregisterEvent(C_EHeroEvent.ESyncHeroServerData, self.onHeroDataRefreshHandler)
  AzurWorld.formationMgr:UnregisterEvent(C_EFormationEvent.ESyncFormationServerData, self.onFormationDataRefreshHandler)
end

return this
