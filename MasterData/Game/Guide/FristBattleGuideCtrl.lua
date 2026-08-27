local FristBattleGuideCtrl = {}
local TaskEnum = require("Game.Task.TaskEnum")
local FormationData = require("Game.PlayerData.FormationData")
local FirstBattleConfig = require("Game.Guide.FirstBattleConfig")

function FristBattleGuideCtrl:__Init()
  self.guideDungeonId = nil
  self.battleGuideType = nil
  self.lastbattleGuide = false
end

function FristBattleGuideCtrl:ResetData()
  self:__Init()
end

function FristBattleGuideCtrl:TryStartFirstBattleGuide(taskList)
  taskList = taskList or PlayerDataCenter.allTaskData.specialTaskDatas
  for k, taskData in pairs(taskList) do
    if taskData.stcData.special_type == TaskEnum.eSpecialType.FirstBattleGuide1 then
      self.battleGuideType = taskData.stcData.special_type
      self.guideDungeonId = taskData.stcData.special_param[1]
      local firstBattle1Config = FirstBattleConfig.firstBattle1
      local formation = FormationData.FromCustomData(1, firstBattle1Config.formHeroList, firstBattle1Config.csTreeId, firstBattle1Config.formCSList)
      NetworkManager:GetNetwork(NetworkTypeID.Hero):SendFormationFresh(1, formation.data, formation:GetFmtFairyUID())
      BattleDungeonManager:SaveFormation(formation)
      BattleDungeonManager:RequestEnterDungeon(self.guideDungeonId, formation)
      UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.black, false)
      self.lastbattleGuide = true
      return true
    elseif taskData.stcData.special_type == TaskEnum.eSpecialType.FirstBattleGuide2 then
      self.battleGuideType = taskData.stcData.special_type
      self.guideDungeonId = taskData.stcData.special_param[1]
      local firstBattle2Config = FirstBattleConfig.firstBattle2
      local formHeroList = {}
      for k, v in pairs(firstBattle2Config.formHeroList) do
        formHeroList[k] = v
      end
      local formation = FormationData.FromCustomData(1, formHeroList, firstBattle2Config.csTreeId, firstBattle2Config.formCSList)
      NetworkManager:GetNetwork(NetworkTypeID.Hero):SendFormationFresh(1, formation.data, formation:GetFmtFairyUID())
      BattleDungeonManager:SaveFormation(formation)
      BattleDungeonManager:RequestEnterDungeon(self.guideDungeonId, formation)
      UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.black, false)
      self.lastbattleGuide = true
      return true
    elseif taskData.stcData.special_type == TaskEnum.eSpecialType.QuckEnterExploration then
      self.guideExplorationId = taskData.stcData.special_param[1]
      local has, dungeonId, moduleId = ExplorationManager:HasUncompletedEp()
      if has then
        ExplorationManager:ContinueLastExploration()
      else
        ExplorationManager:ReqEnterExploration(self.guideExplorationId, 1, proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration, false, callBack)
      end
      self.lastbattleGuide = true
      return true
    end
  end
  return false
end

function FristBattleGuideCtrl:GetFirstBattleConfig()
  if self.battleGuideType == TaskEnum.eSpecialType.FirstBattleGuide1 then
    return FirstBattleConfig.firstBattle1
  elseif self.battleGuideType == TaskEnum.eSpecialType.FirstBattleGuide2 then
    return FirstBattleConfig.firstBattle2
  end
  return nil
end

return FristBattleGuideCtrl
