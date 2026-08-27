local EpGuideUtil = {}
local GuideActionType = {
  PlayGuide = 1,
  PlayUltGuide = 2,
  ClearUltMp = 3,
  TeamCoordChange = 4,
  HideCmderSkill = 5,
  HideBattleRestart = 6,
  PlayCmderGuide = 7,
  HideUIAndGuideAndSelect = 8,
  SetCmderSkillSelectable = 9,
  SetCmderSkillActive = 10,
  SetDeployCmderSkillActive = 11,
  DeployCmderSkillNoClick = 12,
  SetConsumeSkillSelectable = 13,
  BattlePlayerSkillUseTimesMatch = 14,
  ChangeHeroHeadItem = 15
}
EpGuideUtil.GuideActionFunc = {
  [GuideActionType.PlayGuide] = function(guideAction)
    local guideCfg = ConfigData.guide[guideAction.action_args]
    if guideCfg.guide_type == 2 then
      GuideManager:StartNewTriggerGuide(guideAction.action_args)
    else
      GuideManager:StartNewGuide(guideAction.action_args)
    end
  end,
  [GuideActionType.PlayUltGuide] = function(guideAction)
    if GuideManager.inGuide then
      return
    end
    if ExplorationManager.epCtrl == nil then
      return
    end
    local ultCount = ExplorationManager.epCtrl.battleCtrl:GetEpBattleUltFullCount()
    if ultCount ~= guideAction.action_delay then
      return
    end
    local oldTimeScale = Time.unity_time.timeScale
    Time.unity_time.timeScale = 0
    local guideCfg = ConfigData.guide[guideAction.action_args]
    if guideCfg.guide_type == 2 then
      GuideManager:StartNewTriggerGuide(guideAction.action_args, function()
        Time.unity_time.timeScale = oldTimeScale
      end)
    else
      GuideManager:StartNewGuide(guideAction.action_args, function()
        Time.unity_time.timeScale = oldTimeScale
      end)
    end
  end,
  [GuideActionType.ClearUltMp] = function(guideAction)
    ExplorationManager:GetDynPlayer().playerUltSkillMp = 0
  end,
  [GuideActionType.TeamCoordChange] = function(guideAction)
    local dynPlayer = ExplorationManager:GetDynPlayer()
    if dynPlayer == nil then
      return
    end
    for _, dynHero in pairs(dynPlayer.heroList) do
      local coord = guideAction.action_args[dynHero:GetID()]
      if coord ~= nil then
        dynHero:SetCoordXY(coord[1], coord[2], ConfigData.buildinConfig.BenchX)
      end
    end
  end,
  [GuideActionType.HideCmderSkill] = function(guideAction)
    local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
    if window ~= nil then
      window:ShowPlayerSkillNode(false)
    end
  end,
  [GuideActionType.HideBattleRestart] = function(guideAction)
    if ExplorationManager.epCtrl == nil then
      return
    end
    ExplorationManager.epCtrl.battleCtrl:SetCloseReloadSupport(true)
  end,
  [GuideActionType.PlayCmderGuide] = function(guideAction)
    if GuideManager.inGuide then
      return
    end
    if ExplorationManager.epCtrl == nil then
      return
    end
    if #guideAction.action_args > 1 and guideAction.action_args[2] == 1 then
      CS.BattleManager.Instance.CurBattleController.PlayerController:EndSelectInputByCancel()
    end
    local oldTimeScale = Time.unity_time.timeScale
    Time.unity_time.timeScale = 0
    local guideId = guideAction.action_args[1]
    local guideCfg = ConfigData.guide[guideId]
    if guideCfg.guide_type == 2 then
      GuideManager:StartNewTriggerGuide(guideId, function()
        Time.unity_time.timeScale = oldTimeScale
      end)
    else
      GuideManager:StartNewGuide(guideId, function()
        Time.unity_time.timeScale = oldTimeScale
      end)
    end
  end,
  [GuideActionType.HideUIAndGuideAndSelect] = function(guideAction)
    if ExplorationManager.epCtrl == nil then
      return
    end
    UIManager:HideWindow(UIWindowTypeID.EpEventRoom)
    local eventCtrl = ExplorationManager.epCtrl.eventCtrl
    local choiceData = eventCtrl:GetEpEventData().choiceDatalist[1]
    local choiceCfg = eventCtrl:GetEpEventChoiceCfg(choiceData)
    if choiceCfg == nil then
      warn("event choice is nil")
      return
    end
    if guideAction.action_args[1] <= 0 then
      ExplorationManager.epCtrl.eventCtrl:OnChoiceItemClick(choiceCfg, guideAction.action_args[2], true)
      return
    end
    local guideId = guideAction.action_args[1]
    local guideCfg = ConfigData.guide[guideId]
    if guideCfg.guide_type == 2 then
      GuideManager:StartNewTriggerGuide(guideId, function()
        ExplorationManager.epCtrl.eventCtrl:OnChoiceItemClick(choiceCfg, guideAction.action_args[2], true)
      end)
    else
      GuideManager:StartNewGuide(guideId, function()
        ExplorationManager.epCtrl.eventCtrl:OnChoiceItemClick(choiceCfg, guideAction.action_args[2], true)
      end)
    end
  end,
  [GuideActionType.SetCmderSkillSelectable] = function(guideAction)
    local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
    if window == nil then
      return
    end
    local skillItem = window.playerSkillNode:SetSkillItemActive(guideAction.action_args[1])
    if skillItem == nil then
      warn("ep guide SetCmderSkillSelectable,not find skillItem index:" .. tostring(guideAction.action_args[1]))
      return
    end
    if guideAction.action_args[2] == 1 then
      skillItem:SetSkillBtnEnabled(true)
    else
      skillItem:SetSkillBtnEnabled(false)
    end
  end,
  [GuideActionType.SetCmderSkillActive] = function(guideAction)
    local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
    if window == nil then
      return
    end
    local skillItem = window.playerSkillNode:SetSkillItemActive(guideAction.action_args[1])
    if skillItem == nil then
      warn("ep guide SetCmderSkillActive,not find skillItem index:" .. tostring(guideAction.action_args[1]))
      return
    end
    if guideAction.action_args[2] == 1 then
      skillItem:Show()
    else
      skillItem:Hide()
    end
  end,
  [GuideActionType.SetDeployCmderSkillActive] = function(guideAction)
    local window = UIManager:GetWindow(UIWindowTypeID.Battle)
    if window == nil then
      return
    end
    local cmderSKillItem = window:GetBattleCmderSkillByIndex(guideAction.action_args[1])
    if cmderSKillItem == nil then
      warn("ep guide SetDeployCmderSkillActive,not find skillItem index:" .. tostring(guideAction.action_args[1]))
      return
    end
    if guideAction.action_args[2] == 1 then
      cmderSKillItem:Show()
    else
      cmderSKillItem:Hide()
    end
  end,
  [GuideActionType.DeployCmderSkillNoClick] = function(guideAction)
    local window = UIManager:GetWindow(UIWindowTypeID.Battle)
    if window == nil then
      return
    end
    window:GetBattleCstNode():SetCmderRootRaycastActive(false)
  end,
  [GuideActionType.SetConsumeSkillSelectable] = function(guideAction)
    local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
    if window == nil then
      return
    end
    local skillItem = window.playerSkillNode:SetConsumeSkillItemActive(guideAction.action_args[1])
    if skillItem == nil then
      warn("ep guide SetConsumeSkillSelectable,not find skillItem index:" .. tostring(guideAction.action_args[1]))
      return
    end
    if guideAction.action_args[2] == 1 then
      skillItem:SetSkillBtnEnabled(true)
    else
      skillItem:SetSkillBtnEnabled(false)
    end
  end,
  [GuideActionType.BattlePlayerSkillUseTimesMatch] = function(guideAction)
    local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
    if window == nil then
      return
    end
    local usedTimes = window.playerSkillNode:GetPlayerSkillUsedTimes()
    if usedTimes == 0 then
      local oldTimeScale = Time.unity_time.timeScale
      Time.unity_time.timeScale = 0
      local guideCfg = ConfigData.guide[guideAction.action_args]
      if guideCfg.guide_type == 2 then
        GuideManager:StartNewTriggerGuide(guideAction.action_args, function()
          Time.unity_time.timeScale = oldTimeScale
        end)
      else
        GuideManager:StartNewGuide(guideAction.action_args, function()
          Time.unity_time.timeScale = oldTimeScale
        end)
      end
    end
  end,
  [GuideActionType.ChangeHeroHeadItem] = function(guideAction)
    local dynPlayer = ExplorationManager:GetDynPlayer()
    if dynPlayer == nil then
      return
    end
    local isChange = false
    local heroList = dynPlayer.heroList
    for _, dynHeroData in ipairs(heroList) do
      local heroId = dynHeroData.dataId
      local itemId = guideAction.action_args[heroId]
      if itemId ~= nil then
        if itemId == 1 then
          local isGirl = PlayerDataCenter.inforData:GetSex()
          local headId
          if isGirl then
            itemId = ConstGlobalItem.ProfessorGridHead
          else
            itemId = ConstGlobalItem.ProfessorBodyHead
          end
        end
        local itemCfg = ConfigData.item[itemId]
        if itemCfg ~= nil then
          dynHeroData:SetGuideResName(itemCfg.icon)
          isChange = true
        end
      end
    end
    if isChange then
      local epWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
      if epWindow ~= nil then
        epWindow:ReInitDungeonHeroList(dynPlayer)
      end
    end
  end
}

function EpGuideUtil.ExecuteEpGuideActions(actionList, battleCount)
  battleCount = battleCount or 0
  for _, guideAction in ipairs(actionList) do
    EpGuideUtil.ExecuteEpGuideActionOne(guideAction, battleCount)
  end
end

function EpGuideUtil.ExecuteEpGuideActionOne(guideAction, battleCount)
  local epCtrl = ExplorationManager.epCtrl
  if epCtrl ~= nil and epCtrl.autoCtrl:IsAutoModeRunning() then
    return
  end
  battleCount = battleCount or 0
  if 0 <= guideAction.battle_count and battleCount ~= guideAction.battle_count then
    return
  end
  local func = EpGuideUtil.GuideActionFunc[guideAction.action_type]
  if func == nil then
    error("no support ep guide action type:" .. tostring(guideAction.action_type))
  else
    func(guideAction)
  end
end

return EpGuideUtil
