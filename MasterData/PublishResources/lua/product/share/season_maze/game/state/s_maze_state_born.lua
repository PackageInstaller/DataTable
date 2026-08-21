require("s_maze_state_base")
_class("SMazeState_Born", SMazeStateBase)
SMazeState_Born = SMazeState_Born

function SMazeState_Born:OnEnter(fromCamp)
  local bornNode = self:_GetBornNode()
  if not bornNode then
    self:_LogError("找不到出生点")
  end
  self:_Log("当前出生点:", bornNode:ID())
  self._machine:SetCurNode(bornNode)
  local player = self._manager:Player()
  player:SetPos(bornNode:Position())
  player:MoveFollowerImmidiately()
  self._bornNode = bornNode
  self._manager:SeasonMazeCameraManager():SeasonCamera():Focus(self._bornNode:Position())
  self._manager:SeasonMazeCameraManager():SeasonCamera():ChangePos(self._bornNode:Position())
  local bornNodeState = SMazeNodeState.StayTemp
  if self:GetNodeState(self._bornNode) == SeasonMazePointStateType.SMPST_End then
    bornNodeState = SMazeNodeState.UnReachable
  end
  self._manager:MapManager():RefreshLinkState(self._bornNode:ID(), bornNodeState, true)
  if fromCamp then
    local relicValues = self._manager:GetAttrsDeltaByReason(SeasonMazeRewardReason.SMRR_RoomCamp)
    if relicValues then
      for key, value in pairs(relicValues) do
        local eft = SeasonMazeEffect:New()
        eft.type = SeasonMazeEffectType.SMET_Pro
        eft.id = key
        eft.value_min = value
        eft.value_max = value
        self:AddRelicEft(eft)
      end
      self:PlayAssetToast(TT, {})
    end
    self:Start()
  end
end

function SMazeState_Born:Start()
  local cpt = self._manager:GetMazeComponent()
  self._battleState = GameGlobal.GetModule(SeasonMazeModule):UIModule():GetAndClearBattleExitState()
  if self._battleState == SMazeBattleExitState.BossBattleSuccess and cpt:GetAttrValue(SeasonMazeAttrType.SMAT_Boss_Gold_Interest) then
    local oldGold = GameGlobal.GetModule(SeasonMazeModule):UIModule():_GetAndClearGoldBeforeBossBattle()
    if oldGold and 0 < oldGold then
      local gold = math.floor(oldGold * cpt:GetAttrValue(SeasonMazeAttrType.SMAT_Boss_Gold_Interest) / 1000)
      local eft = SeasonMazeEffect:New()
      eft.type = SeasonMazeEffectType.SMET_Pro
      eft.id = SeasonMazeAttrType.SMAT_Gold
      eft.value_min = gold
      eft.value_max = gold
      self:AddRelicEft(eft)
      self:PlayAssetToast(TT, {})
    end
  end
  local state = cpt:CurOperate()
  self:_Log("开始游戏:", state)
  if state == SeasonMazeActionState.SMAS_Invalid then
    self:_LogError("状态错误 当前秘境未初始化")
    return
  end
  if state == SeasonMazeActionState.SMAS_Init then
    self._machine:ChangeStateTo(SMazeState_RoundBegin)
    return
  end
  if state == SeasonMazeActionState.SMAS_NewHand then
    self._machine:ChangeStateTo(SMazeState_Levelup)
    return
  end
  if state == SeasonMazeActionState.SMAS_BreakPet then
    self._machine:ChangeStateTo(SMazeState_ChooseFullPet)
    return
  end
  if state == SeasonMazeActionState.SMAS_RandomHand then
    self._machine:ChangeStateTo(SMazeState_PlayCard, self._bornNode, true)
    return
  end
  if state == SeasonMazeActionState.SMAS_ChooseHand then
    self._machine:ChangeStateTo(SMazeState_PlayCard, self._bornNode, false)
    return
  end
  if state == SeasonMazeActionState.SMAS_GoPoint then
    local count = self._remainSteps
    self:_Log("恢复行走状态 剩余步数:", count)
    if count <= 0 then
      local startID = cpt:GetComponentInfo().cur_point
      local sourceNode = self._manager:MapManager():GetNode(startID)
      self._machine:ChangeStateTo(SMazeState_ArriveRoom, sourceNode, self._bornNode)
    else
      self._machine:ChangeStateTo(SMazeState_PlayerMove, count)
    end
    return
  end
  if state == SeasonMazeActionState.SMAS_RoomOperate then
    self:_Log("恢复房间结算状态", self._bornNode:ID(), self._bornNode:Room():ID())
    if self:GetNodeState(self._bornNode) == SeasonMazePointStateType.SMPST_Choose then
      self._machine:ChangeStateTo(SMazeState_RoomSettle, self._bornNode, true)
      return
    else
      self._machine:ChangeStateTo(SMazeState_RoomSettle, self._bornNode, false)
      return
    end
  end
  if state == SeasonMazeActionState.SMAS_Relic then
    self._machine:ChangeStateTo(SMazeState_ChooseRelic)
    return
  end
  if state == SeasonMazeActionState.SMAS_BossBattle then
    local count = cpt:GetAttrValue(SeasonMazeAttrType.SMAT_Round)
    if count ~= 0 then
      Log.exception("当前回合数不是0 无法恢复boss突袭状态:", count)
    end
    self._machine:ChangeStateTo(SMazeState_BossAttack)
    return
  end
  if state == SeasonMazeActionState.SMAS_HardClearing then
    self._machine:ChangeStateTo(SMazeState_MazeComplete)
    return
  end
  if state == SeasonMazeActionState.SMAS_NewHand then
    self._machine:ChangeStateTo(SMazeState_Levelup)
    return
  end
  if state == SeasonMazeActionState.SMAS_RoundEnd then
    self._machine:ChangeStateTo(SMazeState_RoundEnd, self._bornNode)
    return
  end
  if state == SeasonMazeActionState.SMAS_HardVictory then
    local ticket = cpt:GetAttrValue(SeasonMazeAttrType.SMAT_WorldBossTicket)
    if ticket and 0 < ticket then
      if self._battleState == SMazeBattleExitState.RoomBattleSuccess or self._battleState == SMazeBattleExitState.RoomBattleFailed then
        self._machine:ChangeStateTo(SMazeState_WorldBoss, true)
      else
        self._machine:ChangeStateTo(SMazeState_WorldBoss)
      end
      return
    else
      self:_Log("没有秘境荒典门票正常结算")
      self._machine:ChangeStateTo(SMazeState_MazeComplete)
      return
    end
  end
end

function SMazeState_Born:_GetBornNode()
  local cpt = self._manager:GetMazeComponent()
  local state = cpt:CurOperate()
  if state == SeasonMazeActionState.SMAS_GoPoint then
    local steps, id = self:_GetRemainStep()
    self._remainSteps = steps
    return self._manager:MapManager():GetNode(id)
  else
    local nodeid = cpt:GetComponentInfo().cur_point
    return self._manager:MapManager():GetNode(nodeid)
  end
end

function SMazeState_Born:_GetRemainStep()
  local cpt = self._manager:GetMazeComponent()
  local total = cpt:GetAttrValue(SeasonMazeAttrType.SMAT_Round_Step_All)
  local forkIDs = cpt:GetComponentInfo().tmp_point
  local startID = cpt:GetComponentInfo().cur_point
  if not forkIDs or table.count(forkIDs) == 0 then
    return total, startID
  end
  local tmpForks = {}
  for key, value in pairs(forkIDs) do
    tmpForks[key] = value
  end
  forkIDs = tmpForks
  local tmpID = startID
  local stopped = false
  while true do
    local node = self._manager:MapManager():GetNode(tmpID)
    local nextNodes = node:NextPoints()
    if nextNodes and 1 < #nextNodes then
      local found = false
      for _, next in ipairs(nextNodes) do
        for __, forkID in pairs(forkIDs) do
          if next:ID() == forkID then
            tmpID = forkID
            found = true
            table.removev(forkIDs, forkID)
            break
          end
        end
        if found then
          total = total - 1
          break
        end
      end
      if not found then
        stopped = true
      end
    else
      tmpID = nextNodes[1]:ID()
      total = total - 1
    end
    if not (total ~= 0 and not stopped and next(forkIDs)) then
      break
    end
  end
  return total, tmpID
end
