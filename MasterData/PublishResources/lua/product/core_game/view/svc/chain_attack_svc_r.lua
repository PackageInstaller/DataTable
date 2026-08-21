require("base_service")
_class("ChainAttackServiceRender", BaseService)
ChainAttackServiceRender = ChainAttackServiceRender

function ChainAttackServiceRender:Constructor(world)
  self.world = world
end

function ChainAttackServiceRender:_DoRenderShowChainAttack(TT, teamEntity)
  local ntChainStart = NTChainSkillTurnStart:New(teamEntity)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, ntChainStart)
  local ntChainSkip = NTChainSkillTurnStartSkipped:New(teamEntity)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, ntChainSkip)
  for i, pet in ipairs(teamEntity:Team():GetTeamPetEntities()) do
    self._world:EventDispatcher():Dispatch(GameEventType.InOutQueue, pet:PetPstID():GetPstID(), false)
  end
  local teamLeaderEntity = teamEntity:GetTeamLeaderPetEntity()
  if teamEntity:HasChainSkillSequence() then
    teamEntity:RemoveChainSkillSequence()
  end
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local chainAtkRes = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.ChainAttack)
  local playerHasChainAttack = chainAtkRes:GetPetHasCastChainSkill(teamLeaderEntity:GetID())
  renderBoardEntity:ReplaceRenderRoundTeam(chainAtkRes:GetChainTeamResult())
  local rchainpath = renderBoardEntity:RenderChainPath()
  local piece_type = rchainpath:GetRenderPieceType()
  teamEntity:AddChainSkillSequence()
  local chain_skill_sequence_cmpt = teamEntity:ChainSkillSequence()
  local chain_skill_sequence_table = chain_skill_sequence_cmpt.ChainSkillSeqTable
  self:_CalcChainSkillCount(teamEntity, piece_type, chain_skill_sequence_table)
  local pieceService = self._world:GetService("Piece")
  local chainSkillCnt = #chain_skill_sequence_table
  if 0 < #chain_skill_sequence_table then
    local firstPetID = chain_skill_sequence_table[1]
    self:_HideOtherPetsExcept(firstPetID)
    if self:_HasSuperChainSkill() == false and playerHasChainAttack then
      YIELD(TT, 200)
    end
    local petEntityID = self:_GetFirstChainSkillActorID(chain_skill_sequence_table)
    local petEntity = self._world:GetEntityByID(petEntityID)
    petEntity:AddChainSkillFlag()
    pieceService:SetAllPieceDark()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.IdleEnd, 2, petEntityID)
    while 0 < #chain_skill_sequence_table do
      YIELD(TT, 100)
    end
  end
  pieceService:RefreshPieceAnim()
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTChainSkillTurnEnd:New(chainSkillCnt))
end

function ChainAttackServiceRender:_CalcChainSkillCount(teamEntity, pieceType, chainSkillSequenceTable)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local chainAtkResCmpt = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.ChainAttack)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local rchainpath = renderBoardEntity:RenderChainPath()
  local renderChainPathCmpt = self._world:GetRenderBoardEntity():RenderChainPath()
  local chainRate = renderChainPathCmpt:GetRenderPathChainRateAtIndex(#rchainpath:GetRenderChainPath())
  local petRoundTeam = self:_GetChainPetRoundTeam()
  for petIndex = 1, #petRoundTeam do
    local petEntityID = petRoundTeam[petIndex]
    local petHasAttack = chainAtkResCmpt:GetPetHasCastChainSkill(petEntityID)
    if petHasAttack and not table.icontains(chainSkillSequenceTable, petEntityID) then
      chainSkillSequenceTable[#chainSkillSequenceTable + 1] = petEntityID
      local petEntity = self._world:GetEntityByID(petEntityID)
      petEntity:ReplaceChainSkill(chainRate)
    end
  end
end

function ChainAttackServiceRender:_HideOtherPetsExcept(entityID)
  local petRoundTeam = self:_GetChainPetRoundTeam()
  for petIndex = 1, #petRoundTeam do
    local petEntityID = petRoundTeam[petIndex]
    local petEntity = self._world:GetEntityByID(petEntityID)
    if petEntity:HasViewExtension() then
      petEntity:SetViewVisible(entityID == petEntityID)
    end
  end
end

function ChainAttackServiceRender:_GetFirstChainSkillActorID(chain_skill_sequence_table)
  local pet_entity_id = chain_skill_sequence_table[1]
  pet_entity_id = pet_entity_id or -1
  return pet_entity_id
end

function ChainAttackServiceRender:_HasSuperChainSkill()
  local utilData = self._world:GetService("UtilData")
  local superChainCount = utilData:GetCurrentTeamSuperChainCount()
  local petRoundTeam = self:_GetChainPetRoundTeam()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local chainAtkResCmpt = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.ChainAttack)
  for i, v in ipairs(petRoundTeam) do
    local petEntity = self._world:GetEntityByID(v)
    local chainSkillCmpt = petEntity:ChainSkill()
    local hasDamage = chainAtkResCmpt:ChainAttackResultHasDamage(v)
    if hasDamage == true and chainSkillCmpt ~= nil then
      local realChainNum = chainSkillCmpt:GetChainNum()
      if superChainCount <= realChainNum then
        return true
      end
    end
  end
  return false
end

function ChainAttackServiceRender:_StopFocusEffect(TT)
  self._world:MainCamera():EnableDarkCamera(false)
  local toNormalTime = BattleConst.ChainSkillToNormalTime
  local targetAlpha = 0
  local originalAlpha = BattleConst.ChainSkillDarkAlpha
  self._world:MainCamera():EnableDarkCamera(false)
  local lastTime = 0
  local timeService = self._world:GetService("Time")
  local curTime = timeService:GetCurrentTimeMs()
  local startTime = curTime
  local timeLen = curTime - startTime
  while toNormalTime > timeLen do
    local deltaTime = timeService:GetDeltaTimeMs()
    timeLen = timeLen + deltaTime
    local percent = timeLen / toNormalTime
    local imgAlpha = originalAlpha - percent * originalAlpha
    self._world:MainCamera():SetHudBgAlpha(imgAlpha)
    self._world:EventDispatcher():Dispatch(GameEventType.SetHeadMaskAlpha, imgAlpha)
    YIELD(TT)
  end
end

function ChainAttackServiceRender:_DoRenderShowSuperChainSkill(TT, teamEntity)
  local isSuperChainSkill = self:_HasSuperChainSkill()
  local focusEffectTaskID = -1
  if isSuperChainSkill == true then
    focusEffectTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._StartFocusEffect, self)
    local renderEntitySvc = self._world:GetService("RenderEntity")
    local pos = renderEntitySvc:GetScreenHeadPos(teamEntity)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideSuperChain, true, pos)
    YIELD(TT, 1000)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideSuperChain, false)
  end
  if 0 < focusEffectTaskID then
    while not TaskHelper:GetInstance():IsTaskFinished(focusEffectTaskID) do
      YIELD(TT)
    end
  end
end

function ChainAttackServiceRender:_StartFocusEffect(TT)
  local toDarkTime = BattleConst.ChainSkillToDarkTime
  local targetAlpha = BattleConst.ChainSkillDarkAlpha
  self._world:MainCamera():EnableDarkCamera(true)
  local lastTime = 0
  local timeService = self._world:GetService("Time")
  local curTime = timeService:GetCurrentTimeMs()
  local startTime = curTime
  local timeLen = curTime - startTime
  while toDarkTime > timeLen do
    local deltaTime = timeService:GetDeltaTimeMs()
    timeLen = timeLen + deltaTime
    local percent = timeLen / toDarkTime
    local imgAlpha = percent * targetAlpha
    self._world:MainCamera():SetHudBgAlpha(imgAlpha)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetHeadMaskAlpha, imgAlpha)
    YIELD(TT)
  end
  local pieceService = self._world:GetService("Piece")
  pieceService:SetAllPieceDark()
end

function ChainAttackServiceRender:_GetChainPetRoundTeam()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local petRoundTeam = renderBoardEntity:RenderRoundTeam():GetRoundTeam()
  return petRoundTeam
end
