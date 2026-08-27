local base = require("Game.WarChess.Ctrl.Base.WarChessCtrlBase")
local WarChessAnimationCtrl = class("WarChessAnimationCtrl", base)
local cs_Animations = CS.UnityEngine.Animations
local cs_ResLoader = CS.ResLoader
local util = require("XLua.Common.xlua_util")
local Stack = require("Framework.Lib.Stack")
local WarChessGridData = require("Game.WarChess.Data.WarChessGridData")
local WarChessHelper = require("Game.WarChess.WarChessHelper")
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local eUnitCat = eWarChessEnum.eUnitCat
local WarChessFXData = require("Game.WarChess.Data.WarChessFXData")

function WarChessAnimationCtrl:ctor(wcCtrl)
  self.resloader = cs_ResLoader.Create()
  self.__isLoadOver = false
  self.__isPlayingAnimationOfFX = false
  self.__isPlayingTip = false
  self.__isInMovieMode = false
  self.__effectPoolDic = {}
  self.__effectPrefabDic = {}
  self.__bornFxDic = {}
  self.__moveableFxDic = {}
  self.__monsterMoveableFxDic = {}
  self.__monsterAlarmFxDic = {}
  self.__monsterLinkFxDic = {}
  self.__curMoveableGridDic = nil
  self.__commonFxDic = {}
  self.__teamBindFxResDic = {}
  self.__teamBindFxDic = {}
  self.__needRefreshFxNum = 0
  self.__PlayAnimationFxDic = {}
  self.__waitPlayDic = {}
  self.__couldShowMoveableFX = true
  self.__onCameraMove = BindCallback(self, self.__OnCameraMove)
  MsgCenter:AddListener(eMsgEventId.WC_CameraMove, self.__onCameraMove)
  self.__onDeployTeamChange = BindCallback(self, self.__OnDeployTeamChange)
  MsgCenter:AddListener(eMsgEventId.WC_DeployTeamChange, self.__onDeployTeamChange)
  self.__onSelectTeam = BindCallback(self, self.__OnSelectTeam)
  MsgCenter:AddListener(eMsgEventId.WC_SelectTeam, self.__onSelectTeam)
  self.__onEntityUpdate = BindCallback(self, self.__OnEntityUpdate)
  MsgCenter:AddListener(eMsgEventId.WC_EntityInfoUpdate, self.__onEntityUpdate)
end

function WarChessAnimationCtrl:AddWCAnimationWaitPlay(key)
  self.__waitPlayDic[key] = true
end

function WarChessAnimationCtrl:RemoveWCAnimationWaitPlay(key)
  self.__waitPlayDic[key] = nil
  self:PlayWCAllShow()
end

function WarChessAnimationCtrl:PlayWCAllShow()
  if table.count(self.__waitPlayDic) > 0 then
    return
  end
  
  local function PlayAllShowGroup()
    self.__isPlayingAnimationOfFX = true
    self.wcCtrl.wcCamCtrl:RecordCamCurPos()
    self.wcCtrl.wcCamCtrl:SetIsCouldNormalMoveCamera(false)
    self.wcCtrl.wcCamCtrl:ShowWcCamCanUIClickBlock()
    local groupList = {}
    for groupId, groupData in pairs(self.__PlayAnimationFxDic) do
      table.insert(groupList, groupId)
    end
    table.sort(groupList)
    local focusedFlag = false
    for index, groupId in ipairs(groupList) do
      local groupData = self.__PlayAnimationFxDic[groupId]
      if groupId == 0 then
        for _, playFunc in pairs(groupData.playFuncList) do
          playFunc()
        end
      else
        if not self.__isPlayingTip and not focusedFlag then
          local foucusPos
          for _, pos in pairs(groupData.foucusPosList) do
            local x, y = WarChessHelper.Coordination2Pos(pos)
            if foucusPos == nil then
              foucusPos = Vector3.New(x, 0, y)
            else
              foucusPos = (foucusPos + Vector3.New(x, 0, y)) / 2
            end
          end
          self.wcCtrl.wcCamCtrl:SetWcCamFollowPos(foucusPos)
          focusedFlag = true
          coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
        end
        for _, playFunc in pairs(groupData.playFuncList) do
          playFunc()
        end
        coroutine.yield(CS.UnityEngine.WaitForSeconds(1.5))
      end
    end
    self.__isPlayingAnimationOfFX = false
    self.wcCtrl.wcCamCtrl:RecorverCamPos()
    self.wcCtrl.wcCamCtrl:SetIsCouldNormalMoveCamera(true)
    self.wcCtrl.wcCamCtrl:CloseWcCamCanUIClickBlock()
    self.__playAllShowCo = nil
    self.__PlayAnimationFxDic = {}
  end
  
  self.__playAllShowCo = GR.StartCoroutine(util.cs_generator(PlayAllShowGroup))
end

function WarChessAnimationCtrl:__AddShowGroup(groupId, foucusPos, playFunc)
  groupId = groupId or 0
  if self.__PlayAnimationFxDic[groupId] == nil then
    self.__PlayAnimationFxDic[groupId] = {
      playFuncList = {},
      foucusPosList = {}
    }
  end
  table.insert(self.__PlayAnimationFxDic[groupId].playFuncList, playFunc)
  table.insert(self.__PlayAnimationFxDic[groupId].foucusPosList, foucusPos)
end

function WarChessAnimationCtrl:UpdateAnimations(unitAnimationClips)
  for _, UnitAnimationClip in ipairs(unitAnimationClips) do
    local groupId = UnitAnimationClip.groupId
    local pos = UnitAnimationClip.pos.pos
    self:__AddShowGroup(groupId, pos, function()
      local gid = UnitAnimationClip.pos.gid
      local pos = UnitAnimationClip.pos.pos
      local entityCat = UnitAnimationClip.entityCat
      local animaId = UnitAnimationClip.id & 255
      local animaTrigger = UnitAnimationClip.id & 256 > 0
      local x, y = WarChessHelper.Coordination2Pos(pos)
      local logicPos = Vector2.New(x, y)
      if entityCat == eUnitCat.entity then
        local entityData = self.wcCtrl.mapCtrl:GetEntityDataByLogicPos(gid, logicPos)
        if entityData ~= nil then
          entityData:PlayEntityAnimation(animaId, animaTrigger)
          self.PlayAniSound(animaId, entityData:GetWcEntityAniAudioDic())
          if isGameDev then
            print(tostring(entityData:GetEntityLogicPos()) .. "entity play animation:" .. tostring(animaId))
          end
        end
      elseif entityCat == eUnitCat.grid then
        local gridData = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(gid, logicPos)
        if gridData ~= nil then
          local gridGo = self.wcCtrl.mapCtrl:GetAreaObjectByGridData(gridData)
          if not IsNull(gridGo) then
            local gridGoAnimState = gridGo:GetComponentInChildren(typeof(CS.WarChessGridAnimState))
            if gridGoAnimState ~= nil then
              gridGoAnimState:SetStageValue(animaId)
              self.PlayAniSound(animaId, gridData:GetWcGridAniAudioDic())
              if animaTrigger then
                gridGoAnimState:Tigger()
              end
              local nameHash = gridGoAnimState:GetCurrentStateNameHash()
              gridData:SaveGridAnimArg(nameHash, animaId)
              if isGameDev then
                print(tostring(gridData:GetGridLogicPos()) .. "grid play animation:" .. tostring(animaId))
              end
            end
          end
        end
      end
    end)
  end
end

function WarChessAnimationCtrl.PlayAniSound(animaId, aniAudioDic)
  if aniAudioDic == nil or aniAudioDic[animaId] == nil then
    return
  end
  AudioManager:PlayAudioById(aniAudioDic[animaId])
end

function WarChessAnimationCtrl:GetIsPlayingAnimation()
  return self.__isPlayingAnimationOfFX
end

function WarChessAnimationCtrl:UpdateWCTip(tipsDiffMsg)
  for _, tipsDiff in ipairs(tipsDiffMsg) do
    local cat = tipsDiff.cat
    local pm1 = tipsDiff.pm1
    if cat == 1 then
      local callback
      
      function callback()
        local tipCfgs = ConfigData.warchess_tip[pm1]
        if tipCfgs == nil then
          error("war chess tipCfgs not exist tip parament:" .. tostring(pm1))
          return
        end
        self.__isPlayingTip = true
        UIManager:ShowWindowAsync(UIWindowTypeID.WarChessTalkDialog, function(window)
          if window ~= nil then
            window:InitWCMiniTV(tipCfgs, function()
              self.__isPlayingTip = false
              self.wcCtrl.wcNetworkCtrl:CS_WarChess_AvgOver(pm1, 2)
              WarChessManager:QuickExeWCGuideActions(eWarChessEnum.wcGuideMomentType.WCTipPlayOver, nil, nil, cat << 32 | pm1)
            end)
          end
        end)
        self.wcCtrl.teamCtrl:StartPlayEventsRemove(callback)
      end
      
      if self.wcCtrl.teamCtrl.startPlayAnimaPlaying then
        self.wcCtrl.teamCtrl:StartPlayEventsAdd(callback)
      else
        callback()
      end
    elseif cat == 2 then
      local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
      avgCtrl:StartAvg(nil, pm1, function()
        self.wcCtrl.wcNetworkCtrl:CS_WarChess_AvgOver(pm1, 1)
        WarChessManager:QuickExeWCGuideActions(eWarChessEnum.wcGuideMomentType.WCTipPlayOver, nil, nil, cat << 32 | pm1)
      end)
    elseif cat == 3 then
      do
        local isOpen = pm1 == 1
        if isOpen then
          UIManager:ShowWindow(UIWindowTypeID.MovieBlack)
          UIManager:HideWindow(UIWindowTypeID.WarChessMain)
          UIManager:HideWindow(UIWindowTypeID.WarChessInfo)
          self.__isInMovieMode = true
        else
          local mianWin = UIManager:GetWindow(UIWindowTypeID.WarChessMain)
          local infoWin = UIManager:GetWindow(UIWindowTypeID.WarChessInfo)
          if mianWin ~= nil then
            mianWin:Show()
          end
          if infoWin ~= nil then
            infoWin:Show()
          end
          local win = UIManager:GetWindow(UIWindowTypeID.MovieBlack)
          if win ~= nil then
            win:SlowClose(1, function()
              self.__isInMovieMode = false
            end)
          end
        end
      end
    end
  end
end

function WarChessAnimationCtrl:UpdateWCFXs(unitFxes)
  for _, unitFx in ipairs(unitFxes) do
    local groupId = unitFx.groupId
    local pos = unitFx.pos.pos
    local x, y = WarChessHelper.Coordination2Pos(pos)
    local logicPos = Vector2.New(x, y)
    local gid = unitFx.pos.gid
    local entityCat = unitFx.entityCat
    local fxId = unitFx.id
    local isDelete = unitFx.isDelete
    local isOnce = unitFx.isOnce
    local isBind = unitFx.isBind
    local RunFunc
    if entityCat == eUnitCat.entity then
      local entityData = self.wcCtrl.mapCtrl:GetEntityDataByLogicPos(gid, logicPos)
      if entityData ~= nil then
        local fxDic = entityData:GetFxDataDic()
        if isDelete then
          local fxData = fxDic[fxId]
          if fxData ~= nil then
            fxDic[fxId] = nil
            do
              local moveableFX = self.__commonFxDic[fxData]
              if moveableFX ~= nil then
                function RunFunc()
                  self:RecycleWCEffect(fxData:GetWCFxResName(), moveableFX)
                  
                  self.__commonFxDic[fxData] = nil
                end
              end
            end
          end
        elseif fxDic[fxId] == nil then
          do
            local fxData = WarChessFXData.New(false, fxId, isOnce, isBind, entityData)
            fxDic[fxId] = fxData
            local showPos = entityData:GetEntityShowPos()
            
            function RunFunc()
              if isOnce then
                local effectGo = self:ShowWCEffect(fxData:GetWCFxResName(), showPos)
                self.PlayEffSound(fxData:GetWCFxAudioId())
                self.__commonFxDic[fxData] = effectGo
                self:UpdateWCEffect(fxData)
                TimerManager:StartTimer(5, function()
                  if self.__commonFxDic[fxData] ~= nil then
                    self:RecycleWCEffect(fxData:GetWCFxResName(), effectGo)
                    self.__commonFxDic[fxData] = nil
                  end
                  fxDic[fxId] = nil
                end, self, true)
              end
            end
          end
        end
      end
    elseif entityCat == eUnitCat.grid then
      local gridData = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(gid, logicPos)
      if gridData ~= nil then
        local fxDic = gridData:GetFxDataDic()
        if isDelete then
          local fxData = fxDic[fxId]
          if fxData ~= nil then
            fxDic[fxId] = nil
            
            function RunFunc()
              local moveableFX = self.__commonFxDic[fxData]
              if moveableFX ~= nil then
                self:RecycleWCEffect(fxData:GetWCFxResName(), moveableFX)
                self.__commonFxDic[fxData] = nil
              end
            end
          end
        elseif fxDic[fxId] == nil then
          do
            local fxData = WarChessFXData.New(true, fxId, isOnce, isBind, gridData)
            fxDic[fxId] = fxData
            local showPos = gridData:GetGridShowPos()
            
            function RunFunc()
              if isOnce then
                local effectGo = self:ShowWCEffect(fxData:GetWCFxResName(), showPos)
                self.PlayEffSound(fxData:GetWCFxAudioId())
                self.__commonFxDic[fxData] = effectGo
                self:UpdateWCEffect(fxData)
                TimerManager:StartTimer(5, function()
                  if self.__commonFxDic[fxData] ~= nil then
                    self:RecycleWCEffect(fxData:GetWCFxResName(), effectGo)
                    self.__commonFxDic[fxData] = nil
                  end
                  fxDic[fxId] = nil
                end, self, true)
              end
            end
          end
        end
      end
    end
    self:__AddShowGroup(groupId, pos, function()
      if RunFunc ~= nil then
        RunFunc()
      end
      local ok, camView = self.wcCtrl.wcCamCtrl:GetCameraViewOnPlaneRect()
      if ok then
        local curView = {
          xMin = camView[0],
          yMin = camView[1],
          xMax = camView[2],
          yMax = camView[3]
        }
        self:RefreshVisableFX(curView)
      end
    end)
  end
end

function WarChessAnimationCtrl:UpdateClientFxData(data, fxId, isAdd, isOnce, isBind, groupId)
  local entityCat, pos, gid
  if IsInstanceOfClass(data, WarChessGridData) then
    entityCat = eUnitCat.grid
    gid = data:GetWCGridBFId()
    pos = WarChessHelper.Pos2Coordination(data:GetGridLogicPos())
  else
    entityCat = eUnitCat.entity
    gid = data:GetWCEntityBFId()
    pos = WarChessHelper.Pos2Coordination(data:GetEntityLogicPos())
  end
  local clinetUnitFxes = {
    {
      pos = {gid = gid, pos = pos},
      entityCat = entityCat,
      id = fxId,
      isDelete = not isAdd,
      isOnce = isOnce,
      isBind = isBind,
      groupId = groupId or 0
    }
  }
  self:UpdateWCFXs(clinetUnitFxes)
end

function WarChessAnimationCtrl.PlayEffSound(audioId)
  if audioId == nil then
    return
  end
  if 0 < audioId then
    AudioManager:PlayAudioById(audioId)
  end
end

function WarChessAnimationCtrl:ShowWCEffect(effectName, showPos, bindGo)
  if string.IsNullOrEmpty(effectName) then
    error("fx name is nill pos:" .. tostring(showPos))
    return nil
  end
  local effectRoot = self.wcCtrl.bind.trans_effectRoot
  local stack = self.__effectPoolDic[effectName]
  local effectGo
  if stack ~= nil and not stack:Empty() then
    effectGo = stack:Pop()
  else
    local effectPrefab = self.__effectPrefabDic[effectName]
    if effectPrefab == nil then
      effectPrefab = self.resloader:LoadABAsset(PathConsts:GetWarChessEffectPrefabPath(effectName))
      self.__effectPrefabDic[effectName] = effectPrefab
    end
    effectGo = effectPrefab:Instantiate(effectRoot)
  end
  if IsNull(effectGo) then
    error("can't get fx go pos:" .. tostring(showPos) .. " fxName:" .. tostring(effectName))
    return
  end
  effectGo.transform:SetParent(effectRoot)
  effectGo.transform.position = showPos
  if bindGo ~= nil then
    effectGo.transform:SetParent(bindGo.transform)
  end
  effectGo:SetActive(true)
  return effectGo
end

function WarChessAnimationCtrl:RecycleWCEffect(effectName, effectGo)
  if IsNull(effectGo) then
    return
  end
  local recycleRoot = self.wcCtrl.bind.trans_effectRecycle
  local stack = self.__effectPoolDic[effectName]
  if stack == nil then
    stack = Stack.New()
    self.__effectPoolDic[effectName] = stack
  end
  if isGameDev then
    for _, data in pairs(stack.data) do
      if effectGo == data then
        warn(string.format("recycle repeat warchess fx:%s, pls check it!!!", effectName))
        return
      end
    end
  end
  stack:Push(effectGo)
  effectGo.transform:SetParent(recycleRoot)
  effectGo:SetActive(false)
end

function WarChessAnimationCtrl:UpdateWCEffect(fxData)
  local effectGo = self.__commonFxDic[fxData]
  if effectGo == nil then
    return
  end
  if fxData:GetWCFXIsNeedFillCount() then
    local num = fxData:GetWCFXCoutNum()
    if num ~= nil then
      local effectUnit = effectGo:GetComponent(typeof(CS.EffectUnit))
      effectUnit:SetCountValue(num)
    end
  end
end

function WarChessAnimationCtrl:RefreshAllWCBornFX(curView)
  local wait2RemoveList = {}
  for gridData, BornLoopFX in pairs(self.__bornFxDic) do
    local gridPos = gridData:GetGridLogicPos()
    if not WarChessHelper.IsPointInRect(curView, gridPos.x, gridPos.y) then
      self:RecycleWCEffect("FXP_BornPositionLoop", BornLoopFX)
      table.insert(wait2RemoveList, gridData)
    end
  end
  for _, gridData in pairs(wait2RemoveList) do
    self.__bornFxDic[gridData] = nil
  end
  for x = curView.xMin, curView.xMax do
    for y = curView.yMin, curView.yMax do
      local gridData = self.wcCtrl.mapCtrl:GetGridDataByLogicXY(nil, x, y)
      if gridData ~= nil then
        if gridData:GetCouldShowBornFX() then
          if self.__bornFxDic[gridData] == nil then
            local BornLoopFX = self:ShowWCEffect("FXP_BornPositionLoop", gridData:GetGridShowPos())
            self.__bornFxDic[gridData] = BornLoopFX
          end
        else
          local BornLoopFX = self.__bornFxDic[gridData]
          if BornLoopFX ~= nil then
            self:RecycleWCEffect("FXP_BornPositionLoop", BornLoopFX)
            self.__bornFxDic[gridData] = nil
            local BornEbdFX = self:ShowWCEffect("FXP_BornPositionEnd", gridData:GetGridShowPos())
            TimerManager:StartTimer(2, function()
              if IsNull(BornEbdFX) then
                return
              end
              self:RecycleWCEffect("FXP_BornPositionEnd", BornEbdFX)
            end, self, true)
          end
        end
      end
    end
  end
end

function WarChessAnimationCtrl:PlayWcHeroQuickMoveFx(fromPosV3, toPosV3)
  if self._quickMoveFx == nil then
    local leapEffectPath = "FX/Commander/RTS_Xuanzeyidong/FXP_pick-in" .. PathConsts.PrefabExtension
    self._quickMoveFx = self.resloader:LoadABAsset(leapEffectPath):Instantiate(self.wcCtrl.bind.trans_effectRoot)
    local leapEffectPathgo = "FX/Commander/RTS_Xuanzeyidong/FXP_pick-go" .. PathConsts.PrefabExtension
    self._quickMoveFromFx = self.resloader:LoadABAsset(leapEffectPathgo):Instantiate(self.wcCtrl.bind.trans_effectRoot)
  end
  self._quickMoveFx:SetActive(false)
  self._quickMoveFx:SetActive(true)
  self._quickMoveFx.transform.position = toPosV3
  self._quickMoveFromFx:SetActive(false)
  self._quickMoveFromFx:SetActive(true)
  self._quickMoveFromFx.transform.position = fromPosV3
end

function WarChessAnimationCtrl:RefreshWCMoveableFX(curView)
  if self.__curMoveableGridDic == nil or not self.__couldShowMoveableFX then
    for gridData, moveableFX in pairs(self.__moveableFxDic) do
      self:RecycleWCEffect("FXP_MovableRange", moveableFX)
    end
    self.__moveableFxDic = {}
  else
    local wait2RemoveList = {}
    for gridData, moveableFX in pairs(self.__moveableFxDic) do
      local gridPos = gridData:GetGridLogicPos()
      if not WarChessHelper.IsPointInRect(curView, gridPos.x, gridPos.y) then
        self:RecycleWCEffect("FXP_MovableRange", moveableFX)
        table.insert(wait2RemoveList, gridData)
      end
    end
    for _, gridData in pairs(wait2RemoveList) do
      self.__moveableFxDic[gridData] = nil
    end
    for x = curView.xMin, curView.xMax do
      for y = curView.yMin, curView.yMax do
        local gridData = self.wcCtrl.mapCtrl:GetGridDataByLogicXY(nil, x, y)
        if gridData ~= nil then
          if self.__curMoveableGridDic[gridData] ~= nil then
            if self.__moveableFxDic[gridData] == nil then
              local moveableFX = self:ShowWCEffect("FXP_MovableRange", gridData:GetGridShowPos())
              self.__moveableFxDic[gridData] = moveableFX
            end
          else
            local moveableFX = self.__moveableFxDic[gridData]
            if moveableFX ~= nil then
              self:RecycleWCEffect("FXP_MovableRange", moveableFX)
              self.__moveableFxDic[gridData] = nil
            end
          end
        end
      end
    end
  end
end

function WarChessAnimationCtrl:WCSetMoveableFXVisiabel(teamData)
  self:__OnSelectTeam(teamData)
end

function WarChessAnimationCtrl:RefreshWCMonsterMoveableFX(curView)
  if self.monsterMoveableGridDic == nil then
    for gridData, moveableFX in pairs(self.__monsterMoveableFxDic) do
      self:RecycleWCEffect("FXP_MovableRange_monster", moveableFX)
    end
    self.__monsterMoveableFxDic = {}
  else
    local wait2RemoveList = {}
    for gridData, moveableFX in pairs(self.__monsterMoveableFxDic) do
      local gridPos = gridData:GetGridLogicPos()
      if not WarChessHelper.IsPointInRect(curView, gridPos.x, gridPos.y) then
        self:RecycleWCEffect("FXP_MovableRange_monster", moveableFX)
        table.insert(wait2RemoveList, gridData)
      end
    end
    for _, gridData in pairs(wait2RemoveList) do
      self.__monsterMoveableFxDic[gridData] = nil
    end
    for x = curView.xMin, curView.xMax do
      for y = curView.yMin, curView.yMax do
        local gridData = self.wcCtrl.mapCtrl:GetGridDataByLogicXY(nil, x, y)
        if gridData ~= nil then
          if self.monsterMoveableGridDic[gridData] ~= nil then
            if self.__monsterMoveableFxDic[gridData] == nil then
              local moveableFX = self:ShowWCEffect("FXP_MovableRange_monster", gridData:GetGridShowPos())
              self.__monsterMoveableFxDic[gridData] = moveableFX
            end
          else
            local moveableFX = self.__monsterMoveableFxDic[gridData]
            if moveableFX ~= nil then
              self:RecycleWCEffect("FXP_MovableRange_monster", moveableFX)
              self.__monsterMoveableFxDic[gridData] = nil
            end
          end
        end
      end
    end
  end
end

function WarChessAnimationCtrl:SetMonsterMoveableGridDic(monsterMoveableGridDic, levelNubDic)
  if self.__monsterMoveableSpreadTimer then
    TimerManager:StopTimer(self.__monsterMoveableSpreadTimer)
    self.__monsterMoveableSpreadTimer = nil
  end
  if monsterMoveableGridDic and levelNubDic then
    local nubIdxSet = {}
    for idx, _ in pairs(levelNubDic) do
      table.insert(nubIdxSet, idx)
    end
    local LevelCount = table.count(levelNubDic)
    local intervalSeconds = 0
    local popFinishSeconds = 0.5
    intervalSeconds = popFinishSeconds / 3
    if 3 < LevelCount then
      intervalSeconds = popFinishSeconds / LevelCount
    end
    self.monsterMoveableGridDic = {}
    self.__monsterMoveableSpreadTimer = TimerManager:StartTimer(intervalSeconds, function()
      if #nubIdxSet < 1 or not self.monsterMoveableGridDic then
        TimerManager:StopTimer(self.__monsterMoveableSpreadTimer)
        self.__monsterMoveableSpreadTimer = nil
        return
      end
      for gridData, _ in pairs(levelNubDic[table.remove(nubIdxSet, 1)]) do
        self.monsterMoveableGridDic[gridData] = true
      end
      local ok, camView = self.wcCtrl.wcCamCtrl:GetCameraViewOnPlaneRect()
      if ok then
        local curView = {
          xMin = camView[0],
          yMin = camView[1],
          xMax = camView[2],
          yMax = camView[3]
        }
        self:RefreshWCMonsterMoveableFX(curView)
      end
    end, self)
  else
    self.monsterMoveableGridDic = nil
    local ok, camView = self.wcCtrl.wcCamCtrl:GetCameraViewOnPlaneRect()
    if ok then
      local curView = {
        xMin = camView[0],
        yMin = camView[1],
        xMax = camView[2],
        yMax = camView[3]
      }
      self:RefreshWCMonsterMoveableFX(curView)
    end
  end
end

function WarChessAnimationCtrl:RefreshWCMonsterAlarmFX(entityData)
  if self.monsterAlarmGridDic == nil or self.monsterAlarmGridDic[entityData] == nil then
    self.__monsterAlarmFxDic[entityData] = self.__monsterAlarmFxDic[entityData] or {}
    for gridData, moveableFX in pairs(self.__monsterAlarmFxDic[entityData]) do
      self:RecycleWCEffect("FXP_jingjie_dige01", moveableFX)
    end
    self.__monsterAlarmFxDic[entityData] = {}
  else
    for gridData, isHave in pairs(self.monsterAlarmGridDic[entityData]) do
      self.__monsterAlarmFxDic[entityData] = self.__monsterAlarmFxDic[entityData] or {}
      if self.__monsterAlarmFxDic[entityData][gridData] == nil then
        local moveableFX = self:ShowWCEffect("FXP_jingjie_dige01", gridData:GetGridShowPos())
        self.__monsterAlarmFxDic[entityData][gridData] = moveableFX
      end
    end
  end
end

function WarChessAnimationCtrl:SetMonsterAlarmGridDic(monsterAlarmGridDic, levelNubDic, entityData, distance)
  if monsterAlarmGridDic and levelNubDic then
    local nubIdxSet = {}
    for idx, _ in pairs(levelNubDic) do
      table.insert(nubIdxSet, idx)
    end
    if #nubIdxSet < 1 then
      return
    end
    self.monsterAlarmGridDic = self.monsterAlarmGridDic or {}
    self.monsterAlarmGridDic[entityData] = self.monsterAlarmGridDic[entityData] or {}
    for i, idx in pairs(nubIdxSet) do
      if idx <= distance then
        for gridData, _ in pairs(levelNubDic[idx]) do
          self.monsterAlarmGridDic[entityData][gridData] = true
        end
      end
    end
    self:RefreshWCMonsterAlarmFX(entityData)
  else
    self.monsterAlarmGridDic = nil
    self:RefreshWCMonsterAlarmFX(entityData)
  end
end

function WarChessAnimationCtrl:RefeshAllEntityLinkFx()
  local groupListDic = self.wcCtrl.mapCtrl:GetAllLinkedEntityGroupData()
  for groupId, groupList in pairs(groupListDic) do
    if #groupList < 2 then
      error("Symbiotic(linked) num less then 2")
    else
      if self.__monsterLinkFxDic[groupId] ~= nil then
        for _, linkFxGo in pairs(self.__monsterLinkFxDic[groupId]) do
          self:RecycleWCEffect("FXP_battle_Monster_lx", linkFxGo)
        end
      end
      self.__monsterLinkFxDic[groupId] = {}
      local lastEntityData
      for _, entityData in pairs(groupList) do
        if lastEntityData ~= nil then
          local linkFxGo = self:ShowWCEffect("FXP_battle_Monster_lx", entityData:GetEntityShowPos())
          local startBindPoint = entityData:GetEntityShowPos() + Vector3.Temp(0, 0.25, 0)
          local endBindPoint = lastEntityData:GetEntityShowPos() + Vector3.Temp(0, 0.25, 0)
          local effectUnit = linkFxGo:GetComponent(typeof(CS.EffectUnit))
          effectUnit:SetLineEffect(startBindPoint, endBindPoint)
          table.insert(self.__monsterLinkFxDic[groupId], linkFxGo)
        end
        lastEntityData = entityData
      end
    end
  end
end

function WarChessAnimationCtrl:__OnEntityUpdate(entityData, isDelete)
  if not isDelete then
    return
  end
  self.__monsterAlarmFxDic[entityData] = self.__monsterAlarmFxDic[entityData] or {}
  for gridData, moveableFX in pairs(self.__monsterAlarmFxDic[entityData]) do
    self:RecycleWCEffect("FXP_jingjie_dige01", moveableFX)
  end
  self.__monsterAlarmFxDic[entityData] = {}
  local groupId = entityData:GetEntitySymbioticId()
  if groupId ~= nil then
    local LinkFxList = self.__monsterLinkFxDic[groupId]
    if LinkFxList ~= nil then
      self.__monsterLinkFxDic[groupId] = nil
      for _, linkFxGo in pairs(LinkFxList) do
        self:RecycleWCEffect("FXP_battle_Monster_lx", linkFxGo)
      end
    end
  end
end

function WarChessAnimationCtrl:RefreshVisableFX(curView)
  local wait2RemoveList = {}
  for fxData, moveableFX in pairs(self.__commonFxDic) do
    local gridPos = fxData:GetWCFxLogicPos()
    if fxData:GetWCFXIsNotOnce() and not fxData:GetWCFXIsBound() and (gridPos == nil or not WarChessHelper.IsPointInRect(curView, gridPos.x, gridPos.y)) then
      self:RecycleWCEffect(fxData:GetWCFxResName(), moveableFX)
      table.insert(wait2RemoveList, fxData)
    end
  end
  for _, fxData in pairs(wait2RemoveList) do
    self.__commonFxDic[fxData] = nil
  end
  for x = curView.xMin, curView.xMax do
    for y = curView.yMin, curView.yMax do
      local gridData = self.wcCtrl.mapCtrl:GetGridDataByLogicXY(nil, x, y)
      local entityData = self.wcCtrl.mapCtrl:GetEntityDataByLogicPosXY(nil, x, y)
      if gridData ~= nil then
        local fxDic = gridData:GetFxDataDic()
        for _, fxData in pairs(fxDic) do
          if fxData:GetWCFXIsNotOnce() and self.__commonFxDic[fxData] == nil then
            local effectName = fxData:GetWCFxResName()
            local fx = self:ShowWCEffect(effectName, gridData:GetGridShowPos())
            self.__commonFxDic[fxData] = fx
            self:UpdateWCEffect(fxData)
          end
        end
      end
      if entityData ~= nil then
        local fxDic = entityData:GetFxDataDic()
        for _, fxData in pairs(fxDic) do
          if fxData:GetWCFXIsNotOnce() and self.__commonFxDic[fxData] == nil then
            local effectName = fxData:GetWCFxResName()
            local fx = self:ShowWCEffect(effectName, entityData:GetEntityShowPos())
            if fxData:GetWCFXIsBound() then
              local parentGo = entityData:WCEntityGetParentGO()
              fx.transform:SetParent(parentGo.transform)
            end
            self.__commonFxDic[fxData] = fx
            self:UpdateWCEffect(fxData)
          end
        end
      end
    end
  end
end

function WarChessAnimationCtrl:RefreshSingleCommonFX(data, savedFxes, isGrid)
  local fxDic = data:GetFxDataDic()
  for _, fx in pairs(savedFxes) do
    local fxId = fx.id
    local isOnce = false
    local isBind = fx.isBind
    if fxDic[fxId] == nil then
      local fxData = WarChessFXData.New(isGrid, fxId, isOnce, isBind, data)
      fxDic[fxId] = fxData
    end
    if self.__isLoadOver then
      if self.__needRefreshFxNum > 0 then
        self.__needRefreshFxNum = self.__needRefreshFxNum + 1
      else
        TimerManager:AddLateCommand(function()
          self.__NeedRefreshFxDataList = 0
          local ok, camView = self.wcCtrl.wcCamCtrl:GetCameraViewOnPlaneRect()
          if ok then
            local curView = {
              xMin = camView[0],
              yMin = camView[1],
              xMax = camView[2],
              yMax = camView[3]
            }
            self:RefreshVisableFX(curView)
          end
        end)
      end
    end
  end
end

function WarChessAnimationCtrl:UpdateSingleWCFX(data)
  local fxDic = data:GetFxDataDic()
  for _, fxData in pairs(fxDic) do
    self:UpdateWCEffect(fxData)
  end
end

function WarChessAnimationCtrl:RemoveSingleWCFX(data)
  local fxDic = data:GetFxDataDic()
  if fxDic == nil then
    return
  end
  for _, fxData in pairs(fxDic) do
    local effectGo = self.__commonFxDic[fxData]
    if effectGo == nil then
      return
    end
    self:RecycleWCEffect(fxData:GetWCFxResName(), effectGo)
    self.__commonFxDic[fxData] = nil
  end
end

function WarChessAnimationCtrl:__OnCameraMove(ok, curView, lastView)
  if ok then
    self:RefreshAllWCBornFX(curView)
    self:RefreshWCMoveableFX(curView)
    self:RefreshWCMonsterMoveableFX(curView)
    self:RefreshVisableFX(curView)
  end
end

function WarChessAnimationCtrl:__OnDeployTeamChange()
  local ok, camView = self.wcCtrl.wcCamCtrl:GetCameraViewOnPlaneRect()
  if ok then
    local curView = {
      xMin = camView[0],
      yMin = camView[1],
      xMax = camView[2],
      yMax = camView[3]
    }
    self:RefreshAllWCBornFX(curView)
  end
end

function WarChessAnimationCtrl:__OnSelectTeam(teamData)
  if self.__moveableSpreadTimer then
    TimerManager:StopTimer(self.__moveableSpreadTimer)
    self.__moveableSpreadTimer = nil
  end
  local couldShow = self.__couldShowMoveableFX and teamData ~= nil
  if couldShow then
    self.wcCtrl.teamCtrl:CalTeamCouldMoveGridDic(teamData)
    local levelNubDic = teamData:GetWCTeamLevelNubDic()
    local nubIdxSet = {}
    for idx, _ in pairs(levelNubDic) do
      table.insert(nubIdxSet, idx)
    end
    local LevelCount = table.count(levelNubDic)
    local intervalSeconds = 0
    local popFinishSeconds = 0.5
    intervalSeconds = popFinishSeconds / 3
    if 3 < LevelCount then
      intervalSeconds = popFinishSeconds / LevelCount
    end
    self.__curMoveableGridDic = {}
    self.__moveableSpreadTimer = TimerManager:StartTimer(intervalSeconds, function()
      if #nubIdxSet < 1 or not self.__curMoveableGridDic then
        TimerManager:StopTimer(self.__moveableSpreadTimer)
        self.__moveableSpreadTimer = nil
        return
      end
      for gridData, _ in pairs(levelNubDic[table.remove(nubIdxSet, 1)]) do
        self.__curMoveableGridDic[gridData] = true
      end
      local ok, camView = self.wcCtrl.wcCamCtrl:GetCameraViewOnPlaneRect()
      if ok then
        local curView = {
          xMin = camView[0],
          yMin = camView[1],
          xMax = camView[2],
          yMax = camView[3]
        }
        self:RefreshWCMoveableFX(curView)
      end
    end, self)
  else
    self.__curMoveableGridDic = nil
    local ok, camView = self.wcCtrl.wcCamCtrl:GetCameraViewOnPlaneRect()
    if ok then
      local curView = {
        xMin = camView[0],
        yMin = camView[1],
        xMax = camView[2],
        yMax = camView[3]
      }
      self:RefreshWCMoveableFX(curView)
    end
  end
end

function WarChessAnimationCtrl:SetCouldShowMoveableFX(isShow)
  if self.__couldShowMoveableFX == isShow then
    return
  end
  if isShow then
    local ok, camView = self.wcCtrl.wcCamCtrl:GetCameraViewOnPlaneRect()
    if ok then
      local curView = {
        xMin = camView[0],
        yMin = camView[1],
        xMax = camView[2],
        yMax = camView[3]
      }
      self:RefreshWCMoveableFX(curView)
    end
  else
    for gridData, moveableFX in pairs(self.__moveableFxDic) do
      self:RecycleWCEffect("FXP_MovableRange", moveableFX)
    end
    self.__moveableFxDic = {}
  end
  self.__couldShowMoveableFX = isShow
end

function WarChessAnimationCtrl:UpdateWCSelectedFX(isShow, logicPos)
  if isShow then
    local showPos = Vector3.New(logicPos.x, 0, logicPos.y)
    if self.__selectFX == nil then
      self.__selectFX = self:ShowWCEffect("FXP_Select", showPos)
    else
      self.__selectFX.gameObject:SetActive(true)
      self.__selectFX.transform.position = showPos
    end
  elseif self.__selectFX ~= nil then
    self.__selectFX.gameObject:SetActive(false)
  end
end

function WarChessAnimationCtrl:AddBindFx4Team(teamData, eHeroBindFxType, fxResName)
  local teamIndex = teamData:GetWCTeamIndex()
  local key = teamIndex << 8 | eHeroBindFxType
  if self.__teamBindFxResDic[key] ~= nil then
    if self.__teamBindFxResDic[key] == fxResName then
      if self.__teamBindFxDic[key] ~= nil then
        return
      end
    else
      self:RemoveBindFxFromTeam(teamData, eHeroBindFxType)
    end
  end
  local heroEntity = self.wcCtrl.teamCtrl:GetWCHeroEntity(teamIndex, nil, nil)
  local teamPos = heroEntity:WCHeroEntityGetShowPos()
  local heroEntityRoot = heroEntity:GetWCHeroParentGo()
  local fxGo = self:ShowWCEffect(fxResName, teamPos, heroEntityRoot)
  self.__teamBindFxResDic[key] = fxResName
  self.__teamBindFxDic[key] = fxGo
  return fxGo
end

function WarChessAnimationCtrl:RemoveBindFxFromTeam(teamData, eHeroBindFxType)
  local teamIndex = teamData:GetWCTeamIndex()
  local key = teamIndex << 8 | eHeroBindFxType
  local fxResName = self.__teamBindFxResDic[key]
  local fxGo = self.__teamBindFxDic[key]
  if fxResName ~= nil then
    self.__teamBindFxResDic[key] = nil
  end
  if fxGo ~= nil then
    self:RecycleWCEffect(fxResName, fxGo)
    self.__teamBindFxDic[key] = nil
  end
  return fxGo
end

function WarChessAnimationCtrl:OnSceneLoadOver()
  local ok, camView = self.wcCtrl.wcCamCtrl:GetCameraViewOnPlaneRect()
  if ok then
    local curView = {
      xMin = camView[0],
      yMin = camView[1],
      xMax = camView[2],
      yMax = camView[3]
    }
    self:RefreshAllWCBornFX(curView)
    self:RefreshVisableFX(curView)
    self.wcCtrl.mapCtrl:AfterAnimationCtrlLoadOver()
  end
  self.__isLoadOver = true
end

function WarChessAnimationCtrl:OnSceneUnload()
  self.__isLoadOver = false
  self.__isPlayingAnimationOfFX = false
  self.__effectPoolDic = {}
  self.__effectPrefabDic = {}
  self.__bornFxDic = {}
  self.__moveableFxDic = {}
  self.__monsterMoveableFxDic = {}
  self.__monsterAlarmFxDic = {}
  self.__monsterLinkFxDic = {}
  self.__curMoveableGridDic = {}
  self.__commonFxDic = {}
  self.__teamBindFxDic = {}
  self.__selectFX = nil
  self._quickMoveFx = nil
  self._quickMoveFromFx = nil
  if self.__playAllShowCo ~= nil then
    GR.StopCoroutine(self.__playAllShowCo)
    self.wcCtrl.wcCamCtrl:SetIsCouldNormalMoveCamera(true)
    self.__playAllShowCo = nil
  end
end

function WarChessAnimationCtrl:CleanAllFx()
  if self.__playAllShowCo ~= nil then
    GR.StopCoroutine(self.__playAllShowCo)
    self.wcCtrl.wcCamCtrl:SetIsCouldNormalMoveCamera(true)
    self.__playAllShowCo = nil
  end
  for fxData, moveableFX in pairs(self.__commonFxDic) do
    self:RecycleWCEffect(fxData:GetWCFxResName(), moveableFX)
  end
  self.__commonFxDic = {}
  for gridData, BornLoopFX in pairs(self.__bornFxDic) do
    self:RecycleWCEffect("FXP_BornPositionLoop", BornLoopFX)
  end
  self.__bornFxDic = {}
  for gridData, moveableFX in pairs(self.__moveableFxDic) do
    self:RecycleWCEffect("FXP_MovableRange", moveableFX)
  end
  self.__curMoveableGridDic = {}
  self.__moveableFxDic = {}
  for gridData, moveableFX in pairs(self.__monsterMoveableFxDic) do
    self:RecycleWCEffect("FXP_MovableRange_monster", moveableFX)
  end
  self.__monsterMoveableFxDic = {}
  for entityData, fxDic in pairs(self.__monsterAlarmFxDic) do
    for gridData, alarmFX in pairs(fxDic) do
      self:RecycleWCEffect("FXP_jingjie_dige01", alarmFX)
    end
  end
  self.__monsterAlarmFxDic = {}
  for groupId, LinkFxList in pairs(self.__monsterLinkFxDic) do
    for _, linkFxGo in pairs(LinkFxList) do
      self:RecycleWCEffect("FXP_battle_Monster_lx", linkFxGo)
    end
  end
  self.__monsterLinkFxDic = {}
  if self.__selectFX ~= nil then
    self.__selectFX.gameObject:SetActive(false)
  end
end

function WarChessAnimationCtrl:Delete()
  self:CleanAllFx()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.WC_CameraMove, self.__onCameraMove)
  MsgCenter:RemoveListener(eMsgEventId.WC_DeployTeamChange, self.__onDeployTeamChange)
  MsgCenter:RemoveListener(eMsgEventId.WC_SelectTeam, self.__onSelectTeam)
  MsgCenter:RemoveListener(eMsgEventId.WC_EntityInfoUpdate, self.__onEntityUpdate)
end

return WarChessAnimationCtrl
