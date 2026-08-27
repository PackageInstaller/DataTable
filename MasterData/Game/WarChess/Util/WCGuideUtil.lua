local WCGuideUtil = {}
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local GuideActionType = {
  PlayGuide = 1,
  HideBattleRetreat = 2,
  AllowWcCamDrag = 3,
  SelectTeam = 4
}
WCGuideUtil.GuideActionFunc = {
  [GuideActionType.PlayGuide] = function(guideAction)
    local guideCfg = ConfigData.guide[guideAction.action_args]
    if guideCfg.guide_type == 2 then
      GuideManager:StartNewTriggerGuide(guideAction.action_args)
    else
      GuideManager:StartNewGuide(guideAction.action_args)
    end
  end,
  [GuideActionType.HideBattleRetreat] = function(guideAction)
    local wcCtrl = WarChessManager:GetWarChessCtrl()
    if wcCtrl == nil then
      return
    end
    wcCtrl.battleCtrl:SetWCAllowRetreatBattle(false)
  end,
  [GuideActionType.AllowWcCamDrag] = function(guideAction)
    local wcCtrl = WarChessManager:GetWarChessCtrl()
    if wcCtrl == nil then
      return
    end
    wcCtrl.wcCamCtrl:AllowWcCamDrag(guideAction.action_args)
  end,
  [GuideActionType.SelectTeam] = function(guideAction)
    local wcCtrl = WarChessManager:GetWarChessCtrl()
    if wcCtrl == nil then
      return
    end
    if wcCtrl.state ~= eWarChessEnum.eWarChessState.play then
      return
    end
    local teamIndex = guideAction.action_args[1]
    local curSelectedTeamData = wcCtrl.curState:GetCurSelectedTeamData()
    if curSelectedTeamData == nil or curSelectedTeamData:GetWCTeamIndex() ~= teamIndex then
      local teamData = wcCtrl.teamCtrl:GetTeamDataByTeamIndex(teamIndex)
      if teamData == nil then
        error("warchess can't select team by index:" .. tostring(teamIndex))
        return
      end
      wcCtrl.curState:WCPlayStateSelectTeam(teamData, true, true)
    end
  end
}

function WCGuideUtil.GetWCGuideActionsById(wcLevelId, moment, logicCoord, tipArg)
  local wcGuideCfg = ConfigData.warchess_guide[wcLevelId]
  if wcGuideCfg == nil then
    return nil
  end
  local momentDicCfg
  if eWarChessEnum.wcGuideMomentGlobal[moment] then
    momentDicCfg = wcGuideCfg.global
  else
    if logicCoord == nil then
      error("ExecuteWCGuideActions moment logic is null:" .. tostring(moment))
      return nil
    end
    momentDicCfg = wcGuideCfg[logicCoord]
  end
  if momentDicCfg == nil then
    return nil
  end
  local actionList = momentDicCfg[moment]
  if moment == eWarChessEnum.wcGuideMomentType.WCTipPlayOver and actionList ~= nil then
    local actionList_temp = {}
    if tipArg ~= nil then
      for index, guide_config in ipairs(actionList) do
        local cat = guide_config.action_moment_args[1]
        local pm1 = guide_config.action_moment_args[2]
        if cat == nil or pm1 == nil then
          error("wc guide cfg error tip over guide arg is not enough wc_guideId:" .. tostring(guide_config.id))
        else
          local arg = cat << 32 | pm1
          if arg == tipArg then
            table.insert(actionList_temp, guide_config)
          end
        end
      end
    end
    actionList = actionList_temp
  end
  return actionList
end

function WCGuideUtil.ExecuteWCGuideActions(actionList, battleCount)
  battleCount = battleCount or 0
  for _, guideAction in ipairs(actionList) do
    WCGuideUtil.ExecuteWCGuideActionOne(guideAction, battleCount)
  end
end

function WCGuideUtil.ExecuteWCGuideActionOne(guideAction, battleCount)
  battleCount = battleCount or 0
  if 0 <= guideAction.battle_count and battleCount ~= guideAction.battle_count then
    return
  end
  if 0 < guideAction.triggered_count then
    local globalData = WarChessManager:GetWCGlobalData()
    if globalData == nil then
      return
    end
    local exeCount = globalData:GetWCGuideExeCount(guideAction.id)
    if exeCount >= guideAction.triggered_count then
      return
    else
      globalData:SetWCGuideExeCount(guideAction.id, exeCount + 1)
    end
  end
  local func = WCGuideUtil.GuideActionFunc[guideAction.action_type]
  if func == nil then
    error("no support wc guide action type:" .. tostring(guideAction.action_type))
  else
    func(guideAction)
  end
end

return WCGuideUtil
