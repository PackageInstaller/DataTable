require("pet_chain_skill_self_attack_r")
require("pet_chain_skill_shadow_attack_r")
require("pet_chain_skill_agent_attack_r")
_class("PlayerChainAttackStateSystem_Render", ReactiveSystem)
PlayerChainAttackStateSystem_Render = PlayerChainAttackStateSystem_Render

function PlayerChainAttackStateSystem_Render:Constructor(world)
  self._world = world
  self._configService = world:GetService("Config")
end

function PlayerChainAttackStateSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.ChainSkillFlag)
  }, {"Added"})
  return c
end

function PlayerChainAttackStateSystem_Render:Filter(entity)
  if not entity:HasMoveFSM() then
    return false
  end
  local move_fsm_cmpt = entity:MoveFSM()
  local cur_state_id = move_fsm_cmpt:GetMoveFSMCurStateID()
  if cur_state_id == PlayerActionStateID.ChainSkillAttack then
    return true
  end
  return false
end

function PlayerChainAttackStateSystem_Render:ExecuteEntities(entities)
  local len = #entities
  for i = 1, len do
    self:HandleAttack(entities[i])
  end
end

function PlayerChainAttackStateSystem_Render:HandleAttack(entity)
  local chain_skill_cmpt = entity:ChainSkill()
  if chain_skill_cmpt == nil then
    self._world:EventDispatcher():Dispatch(GameEventType.ChainSkillAttackFinish, 1, entity:GetID())
    return
  end
  local chainNum = chain_skill_cmpt:GetChainNum()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local chainAtkResCmpt = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.ChainAttack)
  local chain_skill_id = chainAtkResCmpt:GetPetCastChainSkillID(entity:GetID())
  if chain_skill_id <= 0 then
    self._world:EventDispatcher():Dispatch(GameEventType.ChainSkillAttackFinish, 1, entity:GetID())
    return
  end
  local playSkillService = self._world:GetService("PlaySkill")
  playSkillService:ShowCasterEntity(entity:GetID())
  self:_PlayChainAttackVoice(entity)
  self:_UAReportChainAttack(entity, chain_skill_id, chainNum)
  TaskManager:GetInstance():CoreGameStartTask(self._DoPlayChainAttack, self, entity, chain_skill_id)
end

function PlayerChainAttackStateSystem_Render:GetPetForward(casterEntity)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local casterPos = casterEntity:GridLocation().Position
  local damageResultList = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if not damageResultList then
    return Vector2(0, 1)
  end
  
  local function get_index(c, p)
    if p.x - c.x == 0 and 0 < p.y - c.y then
      return 1
    end
    if p.x - c.x > 0 and 0 < p.y - c.y then
      return 2
    end
    if p.x - c.x > 0 and p.y - c.y == 0 then
      return 3
    end
    if p.x - c.x > 0 and 0 > p.y - c.y then
      return 4
    end
    if p.x - c.x == 0 and 0 > p.y - c.y then
      return 5
    end
    if p.x - c.x < 0 and 0 > p.y - c.y then
      return 6
    end
    if p.x - c.x < 0 and p.y - c.y == 0 then
      return 7
    end
    if p.x - c.x < 0 and 0 < p.y - c.y then
      return 8
    end
    return 1
  end
  
  local damagePosList = {}
  for i, result in ipairs(damageResultList) do
    damagePosList[i] = result:GetGridPos()
  end
  
  local function cmpFunc(damageResultPos1, damageResultPos2)
    local dis1 = Vector2.Distance(damageResultPos1, casterPos)
    local dis2 = Vector2.Distance(damageResultPos2, casterPos)
    if dis1 == dis2 then
      return get_index(casterPos, damageResultPos1) < get_index(casterPos, damageResultPos2)
    else
      return dis1 < dis2
    end
  end
  
  table.sort(damagePosList, cmpFunc)
  local dir = damagePosList[1] - casterPos
  return dir
end

function PlayerChainAttackStateSystem_Render:_DoPlayChainAttack(TT, casterEntity, skillID)
  self:_WaitChainAttackTrapTaskEnd(TT)
  local chainTaskIDList = {}
  local utilData = self._world:GetService("UtilData")
  local petCanMultiStageChainSkill = utilData:OnCheckPetCanMultiStageChainSkill(casterEntity)
  if petCanMultiStageChainSkill then
    self:_OnPlayChainSkillForMultiStage(TT, casterEntity, skillID)
  else
    chainTaskIDList = self:_OnPlayChainSkill(TT, casterEntity, skillID)
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(chainTaskIDList, true) do
    YIELD(TT)
  end
  local guideService = self._world:GetService("Guide")
  local guideTaskId = guideService:Trigger(GameEventType.GuidePlayerSkillFinish, GuidePlaySkillFinish.ChainSkillFinish, casterEntity)
  while not TaskHelper:GetInstance():IsTaskFinished(guideTaskId, true) do
    YIELD(TT)
  end
  local pstId = casterEntity:PetPstID():GetPstID()
  self._world:EventDispatcher():Dispatch(GameEventType.InOutQueue, pstId, false)
  self._world:EventDispatcher():Dispatch(GameEventType.ShowHideChainSkillCG, pstId, false)
  self._world:EventDispatcher():Dispatch(GameEventType.ChainSkillAttackFinish, 1, casterEntity:GetID())
end

function PlayerChainAttackStateSystem_Render:_OnPlayChainSkill(TT, casterEntity, skillID)
  local chainTaskIDList = {}
  local selfAttack = PetChainSkillSelfAttack:New(self._world)
  local selfAttackTaskID = TaskManager:GetInstance():CoreGameStartTask(selfAttack.DoPlayPetSelfChainAttack, selfAttack, casterEntity, skillID)
  if 0 < selfAttackTaskID then
    chainTaskIDList[#chainTaskIDList + 1] = selfAttackTaskID
  end
  local shadowAttack = PetChainSkillShadowAttack:New(self._world)
  local shadowAttackTaskID = TaskManager:GetInstance():CoreGameStartTask(shadowAttack.DoPlayPetShadowChainAttack, shadowAttack, casterEntity, skillID)
  if 0 < shadowAttackTaskID then
    chainTaskIDList[#chainTaskIDList + 1] = shadowAttackTaskID
  end
  local agentAttack = PetChainSkillAgentAttack:New(self._world)
  local agentAttackTaskID = TaskManager:GetInstance():CoreGameStartTask(agentAttack.DoPlayPetAgentChainAttack, agentAttack, casterEntity, skillID)
  if 0 < agentAttackTaskID then
    chainTaskIDList[#chainTaskIDList + 1] = agentAttackTaskID
  end
  return chainTaskIDList
end

function PlayerChainAttackStateSystem_Render:_OnPlayChainSkillForMultiStage(TT, casterEntity, skillID)
  local utilData = self._world:GetService("UtilData")
  local chainTimes = utilData:OnGetPetChainTimesForRender(casterEntity)
  local chainTaskIDList = {}
  for chainTimeIndex = 1, chainTimes do
    local chainSkillStageInfoList = utilData:OnGetPetChainSkillConfigIDList(casterEntity, chainTimeIndex)
    local curChainTimeSkillStageCount = table.count(chainSkillStageInfoList)
    for index = 1, curChainTimeSkillStageCount do
      if chainTimeIndex == 1 or index == curChainTimeSkillStageCount then
        local selfAttack = PetChainSkillSelfAttackForMultiStage:New(self._world)
        local selfAttackTaskID = TaskManager:GetInstance():CoreGameStartTask(selfAttack.DoPlayPetSelfChainAttackForMultiStage, selfAttack, casterEntity, chainTimeIndex, index)
        if 0 < selfAttackTaskID then
          chainTaskIDList[#chainTaskIDList + 1] = selfAttackTaskID
        end
      end
      if chainTimeIndex == 1 and index == curChainTimeSkillStageCount then
        local shadowAttack = PetChainSkillShadowAttack:New(self._world)
        local shadowAttackTaskID = TaskManager:GetInstance():CoreGameStartTask(shadowAttack.DoPlayPetShadowChainAttack, shadowAttack, casterEntity, skillID)
        if 0 < shadowAttackTaskID then
          chainTaskIDList[#chainTaskIDList + 1] = shadowAttackTaskID
        end
      end
      if index == curChainTimeSkillStageCount then
        local agentAttack = PetChainSkillAgentAttackSelect:New(self._world)
        local agentAttackTaskID = TaskManager:GetInstance():CoreGameStartTask(agentAttack.DoPlayPetAgentChainAttackSelect, agentAttack, casterEntity, chainTimeIndex)
        if 0 < agentAttackTaskID then
          chainTaskIDList[#chainTaskIDList + 1] = agentAttackTaskID
        end
      end
      while not TaskHelper:GetInstance():IsAllTaskFinished(chainTaskIDList, true) do
        YIELD(TT)
      end
    end
    while not TaskHelper:GetInstance():IsAllTaskFinished(chainTaskIDList, true) do
      YIELD(TT)
    end
  end
end

function PlayerChainAttackStateSystem_Render:_WaitChainAttackTrapTaskEnd(TT)
  local trapServiceRender = self._world:GetService("TrapRender")
  while not trapServiceRender:IsTrapViewTaskOver() do
    YIELD(TT)
  end
  trapServiceRender:ClearTrapViewTask()
end

function PlayerChainAttackStateSystem_Render:_PlayChainAttackVoice(casterEntity)
  local tplID = casterEntity:PetPstID():GetTemplateID()
  local pm = GameGlobal.GetModule(PetAudioModule)
  InnerGameHelperRender.InnerGamePlayPetUIVoice("ChainSkill", tplID)
end

function PlayerChainAttackStateSystem_Render:_UAReportChainAttack(casterEntity, skillID, chainNum)
  local tplID = casterEntity:PetPstID():GetTemplateID()
  GameGlobal.UAReportForceGuideEvent("FightSpellChainSkill", {
    skillID,
    chainNum,
    tplID
  }, false, true)
end
