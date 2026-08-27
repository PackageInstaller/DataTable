local base = require("Game.WarChess.State.Base.WarChessStateBase")
local WarChessPlayState = class("WarChessPlayState", base)
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local CS_Physics = CS.PhysicsUtility
local cs_MessageCommon = CS.MessageCommon
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")

function WarChessPlayState:ctor()
  self.__CurSelectedTeamIndex = nil
  self.__isInteracting = false
  self.__isMovingTeam = false
  self.__moveTeamCallback = nil
  self.__moveOverCallback = nil
  self.__autoMoveCallback = nil
  self.__moveFairyCallback = nil
  self.__isMovingMonster = false
  self.__movingMonsterFuncDic = {}
  self.__isWaitingEntityAnimation = false
  self.__isPopingAPReduceAnimation = {}
  self.__isPressTeam = nil
  self.__pressTeam = nil
  self.__pressedTeamTime = nil
  self.__isWaitingTapAnotherTeam = nil
  self.__onTapAnotherTeamCallback = nil
  self.__isInCustomInput = false
  self.__customInputCallback = nil
  self.__onTeamMoveEndAction = BindCallback(self, self._WCMoveComplete)
  self.__onFingerTap = BindCallback(self, self.__OnFingerTap)
  self.__onFingerDown = BindCallback(self, self.__OnFingerDown)
  self.__onFingerSet = BindCallback(self, self.__OnFingerSet)
  self.__onFingerUp = BindCallback(self, self.__OnFingerUp)
  self.__onUpdate = BindCallback(self, self.__OnUpdate)
  self.__onInteractOver = BindCallback(self, self.__OnInteractOver)
  UpdateManager:AddUpdate(self.__onUpdate)
end

function WarChessPlayState:OnEnterState()
  self.__camMain = UIManager:GetMainCamera()
  CS_LeanTouch.OnFingerTap("+", self.__onFingerTap)
  CS_LeanTouch.OnFingerDown("+", self.__onFingerDown)
  CS_LeanTouch.OnFingerSet("+", self.__onFingerSet)
  CS_LeanTouch.OnFingerUp("+", self.__onFingerUp)
  local teamData
  if self.__CurSelectedTeamIndex ~= nil then
    teamData = self.wcCtrl.teamCtrl:GetTeamDataByTeamIndex(self.__CurSelectedTeamIndex)
    MsgCenter:Broadcast(eMsgEventId.WC_SelectTeam, teamData)
  else
    self.wcCtrl.animaCtrl:UpdateWCSelectedFX(false)
    MsgCenter:Broadcast(eMsgEventId.WC_SelectTeam, nil)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.WarChessInfo, function(win)
    if win ~= nil then
      win:InitWCInfo(self.wcCtrl)
    end
  end)
  UIUtil.AddOneCover("WaitWCPlay")
  self.wcCtrl.teamCtrl:SetBornOverCallback(function()
    UIUtil.CloseOneCover("WaitWCPlay")
    if self.wcCtrl:GetWCSurSubSystemCat() == eWarChessEnum.eSystemCat.battle and self.wcCtrl.battleCtrl:GetIsInBattleScene() then
      return
    end
    local globalData = WarChessManager:GetWCGlobalData()
    local enterPlayCount = globalData:GetEnterPlayCount()
    globalData:SetEnterPlayCount(enterPlayCount + 1)
    WarChessSeasonManager:OnWCEnterPlayState()
    UIManager:ShowWindowAsync(UIWindowTypeID.WarChessMain, function(win)
      if self.wcCtrl:GetWCSurSubSystemCat() == eWarChessEnum.eSystemCat.battle and self.wcCtrl.battleCtrl:GetIsInBattleScene() then
        if win ~= nil then
          win:Delete()
        end
        return
      end
      if win ~= nil then
        win:InitWarChessPlay(self, teamData)
      end
      if self.wcCtrl:IsWCReconnected() then
        WarChessSeasonManager:TryWcSsBuffSelect()
      end
      if enterPlayCount == 0 then
        if not self.wcCtrl:IsWCReconnected() then
          self.wcCtrl.teamCtrl.startPlayAnimaPlaying = true
          self.wcCtrl.palySquCtrl:AterEnterPlayState()
          if GuideManager:TryTriggerGuide(eGuideCondition.WCLevelFirstStart) then
          else
            WarChessManager:QuickExeWCGuideActions(eWarChessEnum.wcGuideMomentType.WCEnterPlay)
          end
        end
      else
        WarChessManager:QuickExeWCGuideActions(eWarChessEnum.wcGuideMomentType.WCDynEnterPlay)
      end
    end)
  end)
end

function WarChessPlayState:GetCurSelectedTeamData()
  if self.__CurSelectedTeamIndex ~= nil then
    local teamData = self.wcCtrl.teamCtrl:GetTeamDataByTeamIndex(self.__CurSelectedTeamIndex)
    return teamData
  end
end

function WarChessPlayState:IsMovingMonster()
  return self.__isMovingMonster
end

function WarChessPlayState:_WCMoveComplete()
  self.__isMovingTeam = false
  local moveOverCallback = self.__moveOverCallback
  local autoMoveCallback = self.__autoMoveCallback
  self.__moveOverCallback = nil
  self.__autoMoveCallback = nil
  self.__moveTeamCallback = nil
  self.wcCtrl:RunAllSystemChange()
  if moveOverCallback ~= nil then
    moveOverCallback()
  end
  if autoMoveCallback ~= nil then
    autoMoveCallback()
  end
end

function WarChessPlayState:IsMovingTeam()
  return self.__isMovingTeam
end

function WarChessPlayState:__OnUpdate()
  if self.__isMovingTeam and self.__moveTeamCallback ~= nil then
    local moveComplete = self.__moveTeamCallback()
    if moveComplete then
      TimerManager:AddLateCommand(self.__onTeamMoveEndAction)
      self.__moveTeamCallback = nil
    end
  end
  if self.__moveFairyCallback ~= nil then
    local moveComplete = self.__moveFairyCallback()
    if moveComplete then
      self.__moveFairyCallback = nil
    end
  end
  if self.__isMovingMonster then
    for entityId, moveUpdateFunc in pairs(self.__movingMonsterFuncDic) do
      local isFinish = moveUpdateFunc()
      if isFinish then
        self.__movingMonsterFuncDic[entityId] = nil
        if table.count(self.__movingMonsterFuncDic) <= 0 then
          self.__isMovingMonster = false
          self.wcCtrl:RunAllSystemChange()
        end
      end
    end
  end
end

function WarChessPlayState:__OnFingerTap(finger)
  if finger == nil or finger.StartedOverGui or finger.IsOverGui then
    return
  end
  if self.__isInCustomInput then
    if self.__customInputCallback ~= nil then
      local pos = self.wcCtrl.inputCtrl:GetMouseCurentGroundPos()
      self.__customInputCallback(pos)
    end
    return
  end
  if self.__isMovingTeam or self:IsMovingMonster() or self.__isInteracting or self.__isWaitingEntityAnimation or self.wcCtrl:IsWCInSubSystem() or self.wcCtrl.animaCtrl:GetIsPlayingAnimation() then
    return
  end
  local pos = self.wcCtrl.inputCtrl:GetMouseCurentGroundPos()
  local isOK, logicPos
  if pos ~= nil then
    isOK, logicPos = self:TrySelectTeam(pos)
    if not isOK then
      isOK, logicPos = self:TryClickGrid(pos)
    end
  end
  if not isOK then
    self:WCHideInteract()
    return
  end
  self.wcCtrl.animaCtrl:UpdateWCSelectedFX(self.__CurSelectedTeamIndex ~= nil, logicPos)
  self:CheckWCGuideClick()
  if self.__isWaitingTapAnotherTeam then
    self:SetIsWaitingTapAnotherTeam(false)
    self.__onTapAnotherTeamCallback = nil
  end
  self.__isPressTeam = false
end

function WarChessPlayState:__OnFingerDown(finger)
  if finger == nil or finger.StartedOverGui or finger.IsOverGui then
    return
  end
  if self.__isMovingTeam or self:IsMovingMonster() or self.__isInteracting or self.__isWaitingEntityAnimation or self.wcCtrl:IsWCInSubSystem() or self.wcCtrl.animaCtrl:GetIsPlayingAnimation() then
    return
  end
  local pos = self.wcCtrl.inputCtrl:GetMouseCurentGroundPos()
  local isOk, teamData = self:__TryGetTeamDataFromPos(pos)
  if isOk then
    self.__isPressTeam = true
    self.__pressTeam = teamData
    self.__pressedTeamTime = 0
  end
end

function WarChessPlayState:__OnFingerSet(finger)
  if self.__isPressTeam then
    self.__pressedTeamTime = self.__pressedTeamTime + Time.deltaTime
    local wcLevelCfg = WarChessManager:GetWCLevelCfg()
    local couldExchangeTeams = wcLevelCfg.exchange
    if couldExchangeTeams and self.__pressedTeamTime > 0.2 then
      self.wcCtrl.wcCamCtrl:SetIsCouldNormalMoveCamera(false)
      local longPressTeamRate = self.__pressedTeamTime / ConfigData.buildinConfig.WarchessLongPressTeamTime
      local fingerScreenPos = finger.ScreenPosition
      MsgCenter:Broadcast(eMsgEventId.WC_LongPressRateChange, longPressTeamRate, fingerScreenPos)
    end
  end
end

function WarChessPlayState:__OnFingerUp(finger)
  if self.__isPressTeam then
    self.wcCtrl.wcCamCtrl:SetIsCouldNormalMoveCamera(true)
    local teamIndex = self.__pressTeam:GetWCTeamIndex()
    if self.__CurSelectedTeamIndex == nil then
      self:WCPlayStateSelectTeam(self.__pressTeam)
    end
    local wcLevelCfg = WarChessManager:GetWCLevelCfg()
    local couldExchangeTeams = wcLevelCfg.exchange
    if couldExchangeTeams and self.__pressedTeamTime > ConfigData.buildinConfig.WarchessLongPressTeamTime then
      if teamIndex == self.__CurSelectedTeamIndex then
        self:__PopTeamInteract()
      else
        self:__PopTeamInteract(self.__pressTeam)
      end
    end
  end
  MsgCenter:Broadcast(eMsgEventId.WC_LongPressRateChange, nil)
  self.__isPressTeam = false
  self.__pressedTeamTime = 0
end

function WarChessPlayState:__TryGetTeamDataFromPos(pos)
  local teamData
  local gridData = self.wcCtrl.mapCtrl:GetGridDataByGrounPos(nil, pos)
  if gridData ~= nil then
    local logicPos = gridData:GetGridLogicPos()
    teamData = self.wcCtrl.teamCtrl:GetTeamDataByLogicPos(logicPos)
  end
  if teamData == nil then
    local hits = CS_Physics.Raycast(self.__camMain, 1 << LayerMask.Character, true)
    for i = 0, hits.Length - 1 do
      local hitCollider = hits[i].transform
      if not IsNull(hitCollider) then
        teamData = self.wcCtrl.teamCtrl:GetTeamDataByGo(hitCollider.transform.parent.gameObject)
        if teamData == nil then
          return false
        else
          break
        end
      end
    end
  end
  if teamData == nil then
    return false
  end
  return true, teamData
end

function WarChessPlayState:TrySelectTeam(pos)
  local isOk, teamData = self:__TryGetTeamDataFromPos(pos)
  if not isOk then
    return false
  end
  local logicPos = teamData:GetWCTeamLogicPos()
  if not self:IsCorrectGuideClick(logicPos) then
    return false
  end
  if self.__isWaitingTapAnotherTeam then
    self.__onTapAnotherTeamCallback(teamData)
    return true, logicPos
  end
  self:WCPlayStateSelectTeam(teamData)
  return true, logicPos
end

function WarChessPlayState:WCPlayStateSelectTeam(teamData, dontDisSelect, isForce)
  if not isForce and (self.__isMovingTeam or self.__isInteracting or self.wcCtrl:IsWCInSubSystem()) then
    return false
  end
  if self.__isWaitingTapAnotherTeam then
    self:SetIsWaitingTapAnotherTeam(false)
    self.__onTapAnotherTeamCallback = nil
  end
  local teamIndex = teamData:GetWCTeamIndex()
  if self.__CurSelectedTeamIndex ~= teamIndex then
    self.__CurSelectedTeamIndex = teamIndex
    MsgCenter:Broadcast(eMsgEventId.WC_SelectTeam, teamData)
  else
    if dontDisSelect then
      return true, true
    end
    self:WCPlayDeselectTeam()
  end
  self:WCHideInteract()
  return true, false
end

function WarChessPlayState:WCPlayDeselectTeam()
  self.__CurSelectedTeamIndex = nil
  MsgCenter:Broadcast(eMsgEventId.WC_SelectTeam, nil)
end

function WarChessPlayState:__PopTeamInteract(targetTeamData)
  local sourceTeamData = self.wcCtrl.teamCtrl:GetTeamDataByTeamIndex(self.__CurSelectedTeamIndex)
  local win_wcInfo = UIManager:GetWindow(UIWindowTypeID.WarChessInfo)
  if win_wcInfo == nil then
    return false
  end
  
  local function actCallback()
    if targetTeamData ~= nil then
      self:__TeamExchangePos(targetTeamData)
      return
    end
    self:SetIsWaitingTapAnotherTeam(true)
    self.__onTapAnotherTeamCallback = BindCallback(self, self.__TeamExchangePos)
  end
  
  local costAP = 0
  local typeIndex = 4
  self.__isPopedData = nil
  if targetTeamData ~= nil then
    win_wcInfo:PopCustomInteractUI(targetTeamData, actCallback, costAP, typeIndex)
  else
    win_wcInfo:PopCustomInteractUI(sourceTeamData, actCallback, costAP, typeIndex)
  end
end

function WarChessPlayState:__TeamExchangePos(targetTeamData)
  local sourceTeamData = self.wcCtrl.teamCtrl:GetTeamDataByTeamIndex(self.__CurSelectedTeamIndex)
  if targetTeamData == sourceTeamData then
    self:SetIsWaitingTapAnotherTeam(false)
    return
  end
  local s_wid, s_tid = self.wcCtrl.teamCtrl:GetWCTeamIdentify(sourceTeamData)
  local t_wid, t_tid = self.wcCtrl.teamCtrl:GetWCTeamIdentify(targetTeamData)
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_WarChessExchangePos(s_wid, s_tid, t_wid, t_tid, function()
    local sorceHeroEntity = self.wcCtrl.teamCtrl:GetWCHeroEntity(sourceTeamData:GetWCTeamIndex(), nil, nil)
    local sourceTeamPos = sorceHeroEntity:WCHeroEntityGetShowPos()
    local targetHeroEntity = self.wcCtrl.teamCtrl:GetWCHeroEntity(targetTeamData:GetWCTeamIndex(), nil, nil)
    local targetTeamPos = targetHeroEntity:WCHeroEntityGetShowPos()
    self.wcCtrl.wcCamCtrl:SetWcCamFollowPos(sourceTeamPos)
    self.wcCtrl.teamCtrl:ReSetTeamStandGridData()
    self.wcCtrl.teamCtrl:CalTeamCouldMoveGridDic(sourceTeamData)
    self.wcCtrl.teamCtrl:CalTeamCouldMoveGridDic(targetTeamData)
    local fxGo_t = self.wcCtrl.animaCtrl:ShowWCEffect("FXP_CSMBlueIn", targetTeamPos)
    local fxGo_s = self.wcCtrl.animaCtrl:ShowWCEffect("FXP_CSMBlueIn", sourceTeamPos)
    TimerManager:StartTimer(5, function()
      if self.wcCtrl == nil or self.wcCtrl.animaCtrl == nil then
        return
      end
      self.wcCtrl.animaCtrl:RecycleWCEffect("FXP_CSMBlueIn", fxGo_t)
      self.wcCtrl.animaCtrl:RecycleWCEffect("FXP_CSMBlueIn", fxGo_s)
    end, self, true)
  end)
end

function WarChessPlayState:TryClickGrid(pos)
  local gridData = self.wcCtrl.mapCtrl:GetGridDataByGrounPos(nil, pos)
  if gridData == nil then
    AudioManager:PlayAudioById(1243)
    return false
  end
  local logicPos = gridData:GetGridLogicPos()
  if not self:IsCorrectGuideClick(logicPos) then
    return false
  end
  local entityData = self.wcCtrl.mapCtrl:GetEntityDataByLogicPos(nil, logicPos)
  if self.__CurSelectedTeamIndex ~= nil then
    local teamData = self.wcCtrl.teamCtrl:GetTeamDataByTeamIndex(self.__CurSelectedTeamIndex)
    if teamData == nil then
      return false
    end
    if entityData ~= nil then
      local isOK = self:__PopEntityInteract(entityData, teamData)
      if isOK then
        return true, logicPos
      end
    end
    local isOK = self:__PopGridInteract(gridData, teamData)
    if isOK then
      return true, logicPos
    end
    local isOK = self:Walk2Grid(gridData, nil)
    if isOK then
      self:WCHideInteract()
      return true, logicPos
    else
      AudioManager:PlayAudioById(1243)
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8510))
    end
  else
    if entityData ~= nil then
      local isOK = self:__PopEntityInteract(entityData, nil)
      if isOK then
        return true, logicPos
      end
    end
    local isOK = self:__PopGridInteract(gridData, nil)
    if isOK then
      return true, logicPos
    end
  end
end

function WarChessPlayState:Walk2Grid(gridData, moveOverCallback, isAutoMove)
  local isOK, moveTeamCallback = self.wcCtrl.teamCtrl:MoveWCTeam2Grid(self.__CurSelectedTeamIndex, gridData)
  if isOK then
    local teamData = self.wcCtrl.teamCtrl:GetTeamDataByTeamIndex(self.__CurSelectedTeamIndex)
    local wid, tid = self.wcCtrl.teamCtrl:GetWCTeamIdentify(teamData)
    self.__isMovingTeam = true
    local moveFairyCallback = self.wcCtrl.teamCtrl:UpdateAllFairyFollowMove()
    if isAutoMove then
      self.__moveTeamCallback = moveTeamCallback
      self.__moveOverCallback = moveOverCallback
      self.__moveFairyCallback = moveFairyCallback
      return true
    end
    self.wcCtrl.wcNetworkCtrl:CS_WarChess_MoveTo(wid, tid, gridData, function(argList)
      if argList.Count ~= 1 then
        error("argList.Count error:" .. tostring(argList.Count))
        return
      end
      local isSucess = argList[0]
      if isSucess then
        self.__moveTeamCallback = moveTeamCallback
        self.__moveOverCallback = moveOverCallback
        self.__moveFairyCallback = moveFairyCallback
      else
        self.__isMovingTeam = false
      end
    end)
    return true
  end
  if moveOverCallback ~= nil then
    moveOverCallback()
  end
  return false
end

function WarChessPlayState:Turn2Grid(gridData, moveOverCallback)
  local isOK, moveTeamCallback = self.wcCtrl.teamCtrl:SetTeamFace2Grid(self.__CurSelectedTeamIndex, gridData)
  if isOK then
    self.__moveTeamCallback = moveTeamCallback
    self.__isMovingTeam = true
    self.__moveOverCallback = moveOverCallback
    return true
  end
  if moveOverCallback ~= nil then
    moveOverCallback()
  end
  return false
end

function WarChessPlayState:SeTryAutoMoveMoverOverCallback(callback)
  self.__autoMoveCallback = callback
end

function WarChessPlayState:__OnInteractOver()
  self.__isInteracting = false
end

function WarChessPlayState:__PopEntityInteract(entityData, teamData)
  local win_wcInfo = UIManager:GetWindow(UIWindowTypeID.WarChessInfo)
  if win_wcInfo == nil then
    return false
  end
  local interacts = entityData:GetEntityInteractions()
  local unit = entityData:GetEntityUnit()
  local isOK = win_wcInfo:PopInteractUI(interacts, entityData, unit, teamData, function(interactCfg, isAutoOpenInfo)
    if not isAutoOpenInfo then
      self.__isPopedData = nil
    end
    self.wcCtrl.mapCtrl:TryShowWCMonsterCouldMoveRange(false)
    local costAP = self.wcCtrl.interactCtrl:GetWCIneractionAPCost(interactCfg)
    if teamData ~= nil and costAP > teamData:GetTeamActionPoint() then
      AudioManager:PlayAudioById(1245)
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8519))
      return
    end
    local curOver = false
    local isSubOk = self.wcCtrl.interactCtrl:WCDealEntityInteract(entityData, teamData, interactCfg, function()
      self:__onInteractOver()
      curOver = true
      if teamData ~= nil then
        self.wcCtrl.animaCtrl:UpdateWCSelectedFX(true, teamData:GetWCTeamLogicPos())
      end
      MsgCenter:Broadcast(eMsgEventId.WC_EntityInfoUpdate, entityData)
    end)
    if isSubOk then
      if curOver then
        return
      end
      self.__isInteracting = true
    else
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8510))
    end
  end)
  if isOK then
    if self.__CurSelectedTeamIndex == nil then
      self.wcCtrl.mapCtrl:TryShowWCMonsterCouldMoveRange(true, entityData)
    end
    if self.__isPopedData ~= nil and self.__isPopedData == entityData or CommonUtil.GetIsWarChessQuickInteract() and not GuideManager.inGuide then
      win_wcInfo.OPNode:WCOpDoubleClick()
      self.__isPopedData = nil
    elseif teamData ~= nil then
      self.__isPopedData = entityData
    end
  end
  return isOK
end

function WarChessPlayState:__PopGridInteract(gridData, teamData)
  local win_wcInfo = UIManager:GetWindow(UIWindowTypeID.WarChessInfo)
  if win_wcInfo == nil then
    return false
  end
  local interacts = gridData:GetGridInteractions()
  local unit = gridData:GetGridUnit()
  local isOK = win_wcInfo:PopInteractUI(interacts, gridData, unit, teamData, function(interactCfg, isAutoOpenInfo)
    if not isAutoOpenInfo then
      self.__isPopedData = nil
    end
    local costAP = self.wcCtrl.interactCtrl:GetWCIneractionAPCost(interactCfg)
    if teamData ~= nil and costAP > teamData:GetTeamActionPoint() then
      AudioManager:PlayAudioById(1245)
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8519))
      return
    end
    local curOver = false
    local isSubOk = self.wcCtrl.interactCtrl:WCDealGridInteract(gridData, teamData, interactCfg, function()
      self:__onInteractOver()
      curOver = true
      if teamData ~= nil then
        self.wcCtrl.animaCtrl:UpdateWCSelectedFX(true, teamData:GetWCTeamLogicPos())
      end
      MsgCenter:Broadcast(eMsgEventId.WC_GridInfoUpdate, gridData)
    end)
    if isSubOk then
      if curOver then
        return
      end
      self.__isInteracting = true
    else
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8510))
    end
  end)
  if isOK then
    if self.__isPopedData ~= nil and self.__isPopedData == gridData or CommonUtil.GetIsWarChessQuickInteract() and not GuideManager.inGuide then
      win_wcInfo.OPNode:WCOpDoubleClick()
      self.__isPopedData = nil
    elseif teamData ~= nil then
      self.__isPopedData = gridData
    end
  end
  return isOK
end

function WarChessPlayState:WCHideInteract()
  local win_wcInfo = UIManager:GetWindow(UIWindowTypeID.WarChessInfo)
  if win_wcInfo == nil then
    return false
  end
  win_wcInfo.OPNode:Hide()
  win_wcInfo.MonsterTagNode:Hide()
  win_wcInfo:HideShowInfo()
  self.__isPopedData = nil
  self.wcCtrl.mapCtrl:TryShowWCMonsterCouldMoveRange(false)
end

function WarChessPlayState:WCAddMonsterMove(entityId, moveUpdateFunc)
  if self.__movingMonsterFuncDic == nil then
    self.__movingMonsterFuncDic = {}
  end
  self.__isMovingMonster = true
  self.__movingMonsterFuncDic[entityId] = moveUpdateFunc
end

function WarChessPlayState:SetWCGridClickGuide(x, y, endAction)
  self._clickGuide = {
    x = x,
    y = y,
    guideAction = endAction,
    complete = false
  }
end

function WarChessPlayState:IsCorrectGuideClick(pos)
  if self._clickGuide == nil then
    return true
  end
  if pos.x == self._clickGuide.x and pos.y == self._clickGuide.y then
    self._clickGuide.complete = true
    return true
  end
  return false
end

function WarChessPlayState:CheckWCGuideClick()
  if self._clickGuide == nil or self._clickGuide.complete ~= true then
    return
  end
  local action = self._clickGuide.guideAction
  self._clickGuide = nil
  if action ~= nil then
    action()
  end
end

function WarChessPlayState:SetIsWaitingEntityAnimation(bool)
  self.__isWaitingEntityAnimation = bool
end

function WarChessPlayState:GetIsWaitingEntityAnimation()
  return self.__isWaitingEntityAnimation
end

function WarChessPlayState:SetIsWaitingAPReduceAnimation(teamIndex, bool)
  self.__isPopingAPReduceAnimation[teamIndex] = bool
  self.wcCtrl:RunAllSystemChange()
end

function WarChessPlayState:GetIsWaitingAPReduceAnimation()
  local isHaveWait = false
  for teamIndex, bool in pairs(self.__isPopingAPReduceAnimation) do
    if bool then
      isHaveWait = true
      break
    end
  end
  return isHaveWait
end

function WarChessPlayState:SetIsWaitingTapAnotherTeam(bool)
  self.__isWaitingTapAnotherTeam = bool
  if bool then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8529))
  end
  self.wcCtrl.animaCtrl:SetCouldShowMoveableFX(not bool)
  local teamDataDic = self.wcCtrl.teamCtrl:GetWCTeams()
  for _, teamData in pairs(teamDataDic) do
    local teamIndex = teamData:GetWCTeamIndex()
    local heroEntity = self.wcCtrl.teamCtrl:GetWCHeroEntity(teamIndex, nil, nil)
    local teamPos = heroEntity:WCHeroEntityGetShowPos()
    if not bool or teamIndex ~= self.__CurSelectedTeamIndex then
      if bool then
        if heroEntity.couldSelectFxGo == nil then
          local fxGo = self.wcCtrl.animaCtrl:ShowWCEffect("FXP_BornPositionLoop", teamPos)
          heroEntity.couldSelectFxGo = fxGo
        end
      elseif heroEntity.couldSelectFxGo ~= nil then
        self.wcCtrl.animaCtrl:RecycleWCEffect("FXP_BornPositionLoop", heroEntity.couldSelectFxGo)
        heroEntity.couldSelectFxGo = nil
      end
    end
  end
end

function WarChessPlayState:SetWCCustomInput(isOpen, callback)
  if self.__isInCustomInput == isOpen and isOpen then
    warn("custom input callback may not correct: corverd by other custom input")
  end
  self.__isInCustomInput = isOpen
  self.__customInputCallback = callback
end

function WarChessPlayState:OnExitState()
  CS_LeanTouch.OnFingerTap("-", self.__onFingerTap)
  CS_LeanTouch.OnFingerDown("-", self.__onFingerDown)
  CS_LeanTouch.OnFingerSet("-", self.__onFingerSet)
  CS_LeanTouch.OnFingerUp("-", self.__onFingerUp)
  self.__isMovingTeam = false
  self.__isMovingMonster = false
  self.__moveTeamCallback = nil
  self.__moveOverCallback = nil
  self.__moveFairyCallback = nil
  self.__movingMonsterFuncDic = nil
  UIUtil.CloseOneCover("WaitWCPlay")
  UIManager:HideWindow(UIWindowTypeID.WarChessInfo)
  UIManager:HideWindow(UIWindowTypeID.WarChessMain)
end

function WarChessPlayState:IsCanOpenMenu()
  if self.__isMovingTeam or self:IsMovingMonster() or self.__isInteracting or self.__isWaitingEntityAnimation or self.wcCtrl:IsWCInSubSystem() or self.wcCtrl.animaCtrl:GetIsPlayingAnimation() then
    return false
  end
  return true
end

return WarChessPlayState
