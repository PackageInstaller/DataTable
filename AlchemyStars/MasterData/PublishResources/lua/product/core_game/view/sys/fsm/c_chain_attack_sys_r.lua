require("chain_attack_state_system")
_class("ClientChainAttackSystem_Render", ChainAttackStateSystem)
ClientChainAttackSystem_Render = ClientChainAttackSystem_Render

function ClientChainAttackSystem_Render:_DoRenderBeforeCalcChain(TT)
  local ntBeforeCalcChainSkill = NTBeforeCalcChainSkill:New()
  self._world:GetService("PlayBuff"):PlayBuffView(TT, ntBeforeCalcChainSkill)
end

function ClientChainAttackSystem_Render:_DoRenderShowSuperChainSkill(TT)
  local chainAttackServiceRender = self.world:GetService("ChainAttackRender")
  chainAttackServiceRender:_DoRenderShowSuperChainSkill(TT)
end

function ClientChainAttackSystem_Render:_DoRenderShowChainAttack(TT, teamEntity)
  local chainAttackServiceRender = self.world:GetService("ChainAttackRender")
  chainAttackServiceRender:_DoRenderShowChainAttack(TT, teamEntity)
  local playSkillSvc = self._world:GetService("PlaySkill")
  playSkillSvc:ShowPlayerEntity(teamEntity)
  TaskManager:GetInstance():CoreGameStartTask(function(TT)
    chainAttackServiceRender:_StopFocusEffect()
  end)
  playSkillSvc:_ClearCombo()
end

function ClientChainAttackSystem_Render:_DoRenderClearLastAttack()
  local renderBattleSvc = self._world:GetService("RenderBattle")
  local comboNum = 0
  renderBattleSvc:SetComboNum(comboNum)
end

function ClientChainAttackSystem_Render:_DoRenderInWave(TT, traps, monsters)
  local sMonsterShowRender = self._world:GetService("MonsterShowRender")
  sMonsterShowRender:PlaySpawnInWave(TT, traps, monsters)
end

function ClientChainAttackSystem_Render:_DoRenderNotifyEnterAuroraTimeInChainSys(TT, isAuroraTime)
  if isAuroraTime then
    local playbuffsvc = self._world:GetService("PlayBuff")
    playbuffsvc:PlayBuffView(TT, NTEnterAuroraTimeInChainSys:New())
  end
end

function ClientChainAttackSystem_Render:_DoRenderClearChainPath()
  local rBoardEntity = self._world:GetRenderBoardEntity()
  rBoardEntity:RenderChainPath():ClearRenderChainPath()
  local playSkillSvc = self._world:GetService("PlaySkill")
  playSkillSvc:_ClearCombo()
  local renderBattleSvc = self._world:GetService("RenderBattle")
  local comboNum = 0
  renderBattleSvc:SetComboNum(comboNum)
end

function ClientChainAttackSystem_Render:_DoRenderWaitPlaySkillTaskFinish(TT)
  local playSkillService = self._world:GetService("PlaySkill")
  local listWaitTask = playSkillService:GetWaitFreeList()
  self:_WaitTasksEnd(TT, listWaitTask)
end

function ClientChainAttackSystem_Render:_DoRenderPlayerBuffDelayed(TT, teamEntity)
  local playBuffService = self._world:GetService("PlayBuff")
  playBuffService:PlayPlayerTurnStartBuff(TT, teamEntity, nil, true)
end

function ClientChainAttackSystem_Render:_DoRenderResetAuroraTimeState(TT)
  local battleRenderCmpt = self._world:BattleRenderConfig()
  battleRenderCmpt:SetReEnterAuroraTimePlayed(false)
end

function ClientChainAttackSystem_Render:_WaitChainAttackTrapTaskEnd(TT)
  local trapRSvc = self._world:GetService("TrapRender")
  while not trapRSvc:IsTrapViewTaskOver() do
    YIELD(TT)
  end
  trapRSvc:ClearTrapViewTask()
end

function ClientChainAttackSystem_Render:_DoRenderShowAutoBeadSkill(TT, teamEntity)
  local autoBeadServiceRender = self.world:GetService("AutoBeadRender")
  autoBeadServiceRender:_DoRenderShowAutoBeadAttack(TT, teamEntity)
  local playSkillSvc = self._world:GetService("PlaySkill")
  playSkillSvc:ShowPlayerEntity(teamEntity)
  TaskManager:GetInstance():CoreGameStartTask(function(TT)
    autoBeadServiceRender:_StopFocusEffect()
  end)
  playSkillSvc:_ClearCombo()
end

function ClientChainAttackSystem_Render:_DoRenderNotifyChainAttackFinish(TT, teamEntity, ntChainAttackFinish)
  if ntChainAttackFinish then
    local playbuffsvc = self._world:GetService("PlayBuff")
    playbuffsvc:PlayBuffView(TT, NTChainAttackFinish:New(teamEntity))
  end
end

function ClientChainAttackSystem_Render:_DoRenderActiveSkillLinkLineRestorePos(TT, teamEntity, isActiveSkillLinkLine)
  if not isActiveSkillLinkLine then
    return
  end
  local renderBattleStatCmpt = self._world:RenderBattleStat()
  renderBattleStatCmpt:SetPet1702361ActiveSkillPreviewState(false)
  local teamLeader = teamEntity:Team():GetTeamLeaderEntity()
  local es = teamEntity:Team():GetTeamPetEntities()
  local boardServiceRender = self._world:GetService("BoardRender")
  local casterPos = boardServiceRender:GetRealEntityGridPos(teamLeader)
  local playBuffSvc = self._world:GetService("PlayBuff")
  local utilDataSvc = self._world:GetService("UtilData")
  local sourcePos, sourceDir = utilDataSvc:GetRenderActiveSkillLinkLineTeamPos()
  teamEntity:SetLocation(sourcePos, sourceDir)
  playBuffSvc:PlayBuffView(TT, NTActiveSkillLinkLineChainAttackFinish:New(teamEntity, casterPos))
  teamLeader = teamEntity:Team():GetTeamLeaderEntity()
  local boardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = boardEntity:RenderBoard()
  local ghostEntityID = renderBoardCmpt:GetActiveLinkLineGhostEntityID()
  local ghostEntity = self._world:GetEntityByID(ghostEntityID)
  if ghostEntity then
    self._world:DestroyEntity(ghostEntity)
  end
  teamEntity:Location():SetSyncToHPBarState(true)
  renderBoardCmpt:SetActiveLinkLineGhostEntityID(nil)
  for i, petEntity in ipairs(es) do
    petEntity:SetLocation(sourcePos, sourceDir)
    if petEntity:GetID() ~= teamLeader:GetID() then
      petEntity:SetViewVisible(false)
    else
      petEntity:SetViewVisible(true)
    end
  end
end
