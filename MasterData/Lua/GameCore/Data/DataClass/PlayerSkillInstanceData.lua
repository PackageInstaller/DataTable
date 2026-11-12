local PlayerSkillInstanceData = class("PlayerSkillInstanceData")
local newDayTime = UTILS.GetDayRefreshTimeOffset()

function PlayerSkillInstanceData:Init()
  self.curLevel = nil
  self.mapAllLevel = {}
  self.bInSettlement = false
  self.tbLastMaxHard = {}
  self.mapLevelCfg = {}
  self:InitConfigData()
  EventManager.Add("Skill_Instance_Gameplay_Time", self, self.OnEvent_Time)
end

function PlayerSkillInstanceData:OnEvent_Time(nTime)
  self._TotalTime = nTime
end

function PlayerSkillInstanceData:UnInit()
  EventManager.Remove("Skill_Instance_Gameplay_Time", self, self.OnEvent_Time)
end

function PlayerSkillInstanceData:InitConfigData()
  local function funcForeachLine(line)
    if nil == self.mapLevelCfg[line.Type] then
      self.mapLevelCfg[line.Type] = {}
    end
    self.mapLevelCfg[line.Type][line.Id] = line
  end
  
  ForEachTableLine(ConfigTable.Get("SkillInstance"), funcForeachLine)
end

function PlayerSkillInstanceData:EnterSkillInstanceEditor(nFloor, tbChar, tbDisc, tbNote)
  if self.curLevel ~= nil then
    printError("当前关卡level不为空1")
    return
  end
  local luaClass = require("Game.Editor.SkillInstance.SkillInstanceEditor")
  if luaClass == nil then
    return
  end
  self.curLevel = luaClass
  if type(self.curLevel.BindEvent) == "function" then
    self.curLevel:BindEvent()
  end
  if type(self.curLevel.Init) == "function" then
    self.curLevel:Init(self, nFloor, tbChar, tbDisc, tbNote)
  end
end

function PlayerSkillInstanceData:EnterSkillInstance(nLevelId, nBuildId)
  if self.curLevel ~= nil then
    printError("当前关卡level不为空1")
    return
  end
  local luaClass = require("Game.Adventure.SkillInstance.SkillInstanceLevel")
  if luaClass == nil then
    return
  end
  self.curLevel = luaClass
  if type(self.curLevel.BindEvent) == "function" then
    self.curLevel:BindEvent()
  end
  if type(self.curLevel.Init) == "function" then
    self.curLevel:Init(self, nLevelId, nBuildId)
  end
end

function PlayerSkillInstanceData:SetSelBuildId(nBuildId)
  self.selBuildId = nBuildId
end

function PlayerSkillInstanceData:GetCachedBuildId(nLevelId)
  if self.selBuildId ~= 0 and self.selBuildId ~= nil then
    local ret = self.selBuildId
    return ret
  end
  if nLevelId == 0 then
    return 0
  end
  if self.mapAllLevel[nLevelId] == nil then
    local mapLevelCfgData = ConfigTable.GetData("SkillInstance", nLevelId)
    if mapLevelCfgData == nil then
      return 0
    end
    if mapLevelCfgData.PreLevelId ~= 0 then
      if self.mapAllLevel[mapLevelCfgData.PreLevelId] ~= nil then
        return self.mapAllLevel[mapLevelCfgData.PreLevelId].nBuildId
      else
        return 0
      end
    else
      return 0
    end
  end
  return self.mapAllLevel[nLevelId].nBuildId
end

function PlayerSkillInstanceData:CacheSkillInstanceLevel(tbData)
  if tbData == nil then
    return
  end
  for _, mapData in ipairs(tbData) do
    local t1 = mapData.Star >= 1
    local t2 = mapData.Star >= 2
    local t3 = mapData.Star >= 3
    local nStar = mapData.Star
    local nBuildId = 0
    if mapData.Build ~= nil then
      nBuildId = mapData.Build.BuildId or 0
    end
    self.mapAllLevel[mapData.Id] = {
      nStar = nStar,
      nBuildId = nBuildId,
      tbTarget = {
        t1,
        t2,
        t3
      }
    }
  end
end

function PlayerSkillInstanceData:GetSkillInstanceLevelUnlock(nLevelId)
  local mapLevelCfgData = ConfigTable.GetData("SkillInstance", nLevelId)
  if mapLevelCfgData == nil then
    return false
  end
  if mapLevelCfgData.PreLevelId == 0 then
    return true
  end
  if PlayerData.Base:GetWorldClass() < mapLevelCfgData.NeedWorldClass then
    return false, mapLevelCfgData.NeedWorldClass
  end
  if self.mapAllLevel[mapLevelCfgData.PreLevelId] == nil then
    return false
  end
  if self.mapAllLevel[mapLevelCfgData.PreLevelId].nStar >= mapLevelCfgData.PreLevelStar then
    return true
  end
  return false
end

function PlayerSkillInstanceData:GetSkillInstanceUnlockMsg(nLevelId)
  local mapLevelCfgData = ConfigTable.GetData("SkillInstance", nLevelId)
  if mapLevelCfgData.PreLevelId == 0 then
    return true
  end
  local isWorldClass = true
  if PlayerData.Base:GetWorldClass() < mapLevelCfgData.NeedWorldClass then
    isWorldClass = false
  end
  local isPreLevelStar = true
  if self.mapAllLevel[mapLevelCfgData.PreLevelId] == nil or self.mapAllLevel[mapLevelCfgData.PreLevelId].nStar < mapLevelCfgData.PreLevelStar then
    isPreLevelStar = false
  end
  if isWorldClass == false or isPreLevelStar == false then
    return false, isWorldClass, isPreLevelStar
  end
  return true
end

function PlayerSkillInstanceData:GetSkillInstanceStar(nLevelId)
  if nLevelId == nil then
    return 0, {
      false,
      false,
      false
    }
  end
  if self.mapAllLevel[nLevelId] == nil then
    return 0, {
      false,
      false,
      false
    }
  end
  return self.mapAllLevel[nLevelId].nStar, self.mapAllLevel[nLevelId].tbTarget == nil and {
    false,
    false,
    false
  } or self.mapAllLevel[nLevelId].tbTarget
end

function PlayerSkillInstanceData:MsgEnterSkillInstance(nLevelId, nBuildId, callback)
  self._EntryTime = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  self._Build_id = nBuildId
  self._Level_id = nLevelId
  local mapBuildData = PlayerData.Build:GetBuildData(nBuildId)
  local bTrial = mapBuildData.nBuildSource == AllEnum.BuildSource.Trial or mapBuildData.nBuildSource == AllEnum.BuildSource.LimitedTrial
  local nBuildType = bTrial and 2 or 1
  local msg = {}
  msg.Id = nLevelId
  msg.Build = {Type = nBuildType, BuildId = nBuildId}
  
  local function msgCallback(_, mapChangeInfo)
    self:EnterSkillInstance(nLevelId, nBuildId)
    if self.mapAllLevel[nLevelId] == nil then
      self.mapAllLevel[nLevelId] = {nStar = 0, nBuildId = 0}
    end
    self.mapAllLevel[nLevelId].nBuildId = nBuildId
    if callback ~= nil then
      callback(mapChangeInfo)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.skill_instance_apply_req, msg, nil, msgCallback)
end

function PlayerSkillInstanceData:MsgSettleSkillInstance(nLevelId, nBuildId, nStar, callback)
  local msg = {}
  msg.Star = nStar
  msg.Events = {
    List = PlayerData.Achievement:GetBattleAchievement(GameEnum.levelType.SkillInstance, 0 < nStar)
  }
  
  local function msgCallback(_, mapMsgData)
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    local t1 = 1 <= nStar
    local t2 = 2 <= nStar
    local t3 = 3 <= nStar
    if self.mapAllLevel[nLevelId] ~= nil then
      if self.mapAllLevel[nLevelId].nStar < nStar then
        self.mapAllLevel[nLevelId].nStar = nStar
      end
      if self.mapAllLevel[nLevelId].tbTarget == nil then
        self.mapAllLevel[nLevelId].tbTarget = {
          false,
          false,
          false
        }
      end
      self.mapAllLevel[nLevelId].tbTarget[1] = t1 or self.mapAllLevel[nLevelId].tbTarget[1]
      self.mapAllLevel[nLevelId].tbTarget[2] = t2 or self.mapAllLevel[nLevelId].tbTarget[2]
      self.mapAllLevel[nLevelId].tbTarget[3] = t3 or self.mapAllLevel[nLevelId].tbTarget[3]
    else
      self.mapAllLevel[nLevelId] = {
        nStar = nStar,
        nBuildId = nBuildId,
        tbTarget = {
          t1,
          t2,
          t3
        }
      }
    end
    if callback ~= nil then
      callback(mapMsgData.AwardItems, mapMsgData.FirstItems, mapMsgData.ThreeStarItems, mapMsgData.SurpriseItems, mapMsgData.DoubleItems, mapMsgData.Exp, mapMsgData.Change)
    end
    self._EndTime = CS.ClientManager.Instance.serverTimeStampWithTimeZone
    local tabUpLevel = {}
    table.insert(tabUpLevel, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tabUpLevel, {
      "game_cost_time",
      tostring(self._TotalTime)
    })
    table.insert(tabUpLevel, {
      "real_cost_time",
      tostring(self._EndTime - self._EntryTime)
    })
    table.insert(tabUpLevel, {
      "build_id",
      tostring(self._Build_id)
    })
    table.insert(tabUpLevel, {
      "battle_id",
      tostring(self._Level_id)
    })
    if 0 < nStar then
      table.insert(tabUpLevel, {
        "battle_result",
        tostring(1)
      })
    else
      table.insert(tabUpLevel, {
        "battle_result",
        tostring(2)
      })
    end
    NovaAPI.UserEventUpload("skill_instance_battle", tabUpLevel)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.skill_instance_settle_req, msg, nil, msgCallback)
end

function PlayerSkillInstanceData:EventUpload(result, nLevelId, nBuildId)
  self._EndTime = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  local tabUpLevel = {}
  table.insert(tabUpLevel, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  table.insert(tabUpLevel, {
    "game_cost_time",
    tostring(self._TotalTime)
  })
  table.insert(tabUpLevel, {
    "real_cost_time",
    tostring(self._EndTime - self._EntryTime)
  })
  table.insert(tabUpLevel, {
    "build_id",
    tostring(nBuildId)
  })
  table.insert(tabUpLevel, {
    "battle_id",
    tostring(nLevelId)
  })
  table.insert(tabUpLevel, {
    "battle_result",
    tostring(result)
  })
  NovaAPI.UserEventUpload("skill_instance_battle", tabUpLevel)
end

function PlayerSkillInstanceData:LevelEnd()
  if nil ~= self.curLevel and type(self.curLevel.UnBindEvent) == "function" then
    self.curLevel:UnBindEvent()
  end
  self.curLevel = nil
end

function PlayerSkillInstanceData.CalStar(nOrigin)
  nOrigin = (nOrigin & 1431655765) + (nOrigin >> 1 & 1431655765)
  nOrigin = (nOrigin & 858993459) + (nOrigin >> 2 & 858993459)
  nOrigin = (nOrigin & 252645135) + (nOrigin >> 4 & 252645135)
  nOrigin = nOrigin * 16843009 >> 24
  return nOrigin
end

function PlayerSkillInstanceData:GetCurLevel()
  if self.curLevel == nil then
    return 0
  end
  return self.curLevel.nLevelId
end

function PlayerSkillInstanceData:SetLastMaxHard(nGroupId, nMaxHard)
  self.tbLastMaxHard[nGroupId] = nMaxHard
end

function PlayerSkillInstanceData:GetLastMaxHard(nGroupId)
  return self.tbLastMaxHard[nGroupId] or 0
end

function PlayerSkillInstanceData:GetMaxSkillInstanceHard(nType)
  local retHard = 1
  local tbLevelList = self.mapLevelCfg[nType]
  if nil ~= tbLevelList then
    for nLevelId, mapLevel in pairs(tbLevelList) do
      if self:GetSkillInstanceLevelUnlock(nLevelId) then
        retHard = math.max(mapLevel.Difficulty, retHard)
      end
    end
  end
  return retHard
end

function PlayerSkillInstanceData:GetLevelOpenState(nType)
  local mapData = ConfigTable.GetData("SkillInstanceType", nType)
  if nil ~= mapData then
    local worldClass = PlayerData.Base:GetWorldClass()
    local bWorldClass = worldClass >= mapData.WorldClassLevel
    local bUnlock = bWorldClass
    if not bWorldClass then
      return AllEnum.SkillInstanceState.Not_WorldClass, bUnlock
    end
    return AllEnum.SkillInstanceState.Open, bUnlock
  end
  return AllEnum.SkillInstanceState.None
end

function PlayerSkillInstanceData:GetUnOpenTipText(nLevelState, nType)
  local sTipStr = ""
  if nLevelState == AllEnum.SkillInstanceState.Not_WorldClass then
    local mapData = ConfigTable.GetData("SkillInstanceType", nType)
    sTipStr = orderedFormat(ConfigTable.GetUIText("WorldClass_Lock") or "", mapData.WorldClassLevel)
  elseif nLevelState == AllEnum.SkillInstanceState.Not_HardUnlock then
    sTipStr = ConfigTable.GetUIText("Level_Lock")
  end
  return sTipStr
end

function PlayerSkillInstanceData:CheckLevelOpen(nType, nHard, bShowTips)
  if nType == 0 then
    return AllEnum.SkillInstanceState.Open
  end
  local nLevelState, bUnlock = self:GetLevelOpenState(nType)
  if nil ~= nHard and nLevelState == AllEnum.SkillInstanceState.Open then
    local nMaxUnlockHard = self:GetMaxSkillInstanceHard(nType)
    if nHard > nMaxUnlockHard then
      nLevelState = AllEnum.SkillInstanceState.Not_HardUnlock
    end
  end
  if true == bShowTips then
    local sTipStr = self:GetUnOpenTipText(nLevelState, nType)
    if nil ~= sTipStr and "" ~= sTipStr then
      EventManager.Hit(EventId.OpenMessageBox, sTipStr)
    end
  end
  return nLevelState == AllEnum.SkillInstanceState.Open, bUnlock
end

function PlayerSkillInstanceData:SetSettlementState(bInSettlement)
  self.bInSettlement = bInSettlement
end

function PlayerSkillInstanceData:GetSettlementState()
  return self.bInSettlement
end

function PlayerSkillInstanceData:SendSkillInstanceRaidReq(nId, nCount, callback)
  local Events = {}
  local msgData = {Id = nId, Times = nCount}
  if 0 < #Events then
    msgData.Events = {
      List = {}
    }
    msgData.Events.List = Events
  end
  
  local function successCallback(_, mapMainData)
    callback(mapMainData.Rewards, mapMainData.Change)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.skill_instance_sweep_req, msgData, nil, successCallback)
end

return PlayerSkillInstanceData
