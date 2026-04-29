require("play_skill_phase_base_r")
_class("PlaySkillZhongxuSummonTrapOrAttachFlagPhase", PlaySkillPhaseBase)
PlaySkillZhongxuSummonTrapOrAttachFlagPhase = PlaySkillZhongxuSummonTrapOrAttachFlagPhase

function PlaySkillZhongxuSummonTrapOrAttachFlagPhase:PlayFlight(TT, casterEntity, phaseParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local waitTaskIDs = {}
  local checkTrapIDList = phaseParam:GetCheckTrapIDList()
  if checkTrapIDList and 0 < #checkTrapIDList then
    local trapResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonTrap)
    if trapResultArray then
      for i = 1, #trapResultArray do
        local result = trapResultArray[i]
        local summonTrapID = result:GetTrapID()
        if table.icontains(checkTrapIDList, summonTrapID) then
          do
            local taskId = GameGlobal.TaskManager():CoreGameStartTask(function()
              self:_ShowTrapFromSummonTrap(TT, phaseParam, result)
            end)
            table.insert(waitTaskIDs, taskId)
          end
        end
      end
    end
  end
  local addFlagResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddMoveScopeRecordCmpt)
  if addFlagResultArray then
    for i = 1, #addFlagResultArray do
      local result = addFlagResultArray[i]
      local hostEntityID = result:GetHostEntityID()
      local hostEntity = self._world:GetEntityByID(hostEntityID)
      if not hostEntity or hostEntity:HasTrapID() then
      elseif hostEntity:HasMonsterID() then
        if hostEntity:HasBodyArea() then
          local bodyArea = hostEntity:BodyArea():GetArea()
          if #bodyArea == 1 then
            local taskId = GameGlobal.TaskManager():CoreGameStartTask(function()
              self:_SingleGridMonsterPlayAddFlag(TT, phaseParam, hostEntity, result)
            end)
            table.insert(waitTaskIDs, taskId)
          else
            local taskId = GameGlobal.TaskManager():CoreGameStartTask(function()
              self:_MultiGridMonsterPlayAddFlag(TT, phaseParam, hostEntity, result)
            end)
            table.insert(waitTaskIDs, taskId)
          end
        end
      elseif self._world:MatchType() == MatchType.MT_BlackFist and hostEntity:HasTeam() then
        do
          local taskId = GameGlobal.TaskManager():CoreGameStartTask(function()
            self:_SingleGridMonsterPlayAddFlag(TT, phaseParam, hostEntity, result)
          end)
          table.insert(waitTaskIDs, taskId)
        end
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(waitTaskIDs) do
    YIELD(TT)
  end
end

function PlaySkillZhongxuSummonTrapOrAttachFlagPhase:_ShowTrapFromSummonTrap(TT, phaseParam, result)
  local posSummon = result:GetPos()
  local utilSvc = self._world:GetService("UtilData")
  local array = utilSvc:GetTrapsAtPos(posSummon)
  local trapID = result:GetTrapID()
  local trapEntity
  for _, eTrap in ipairs(array) do
    local cTrap = eTrap:TrapID()
    if cTrap and cTrap:GetTrapID() == trapID and not eTrap:HasDeadMark() then
      trapEntity = eTrap
      break
    end
  end
  if not trapEntity then
    Log.error(self._className, "trap not found: ", tostring(result:GetPos()), " id=", trapID)
    return
  end
  self:_ShowTrap(TT, trapEntity, posSummon)
end

function PlaySkillZhongxuSummonTrapOrAttachFlagPhase:_ShowTrap(TT, trapEntity, posSummon)
  trapEntity:SetPosition(posSummon)
  local trapServiceRender = self._world:GetService("TrapRender")
  trapServiceRender:CreateSingleTrapRender(TT, trapEntity, true)
  if self._effectID and self._effectID > 0 then
    local effectService = self._world:GetService("Effect")
    effectService:CreateWorldPositionDirectionEffect(self._effectID, posSummon)
  end
end

function PlaySkillZhongxuSummonTrapOrAttachFlagPhase:_SingleGridMonsterPlayAddFlag(TT, phaseParam, entity, result)
  local effectDelay = phaseParam:GetSingeGridMonsterEffectDelay()
  local effectID = phaseParam:GetSingeGridMonsterEffectID()
  local loopAnim = phaseParam:GetSingeGridMonsterEffectLoopAnim()
  local loopAnimDelay = phaseParam:GetSingeGridMonsterEffectLoopAnimDelay()
  YIELD(TT, effectDelay)
  local effectService = self._world:GetService("Effect")
  local effectEntity = effectService:CreateEffect(effectID, entity)
  YIELD(TT, loopAnimDelay)
  local effectGo = effectEntity:View():GetGameObject()
  local anim = effectGo:GetComponentInChildren(typeof(UnityEngine.Animation))
  if anim then
    anim:Play(loopAnim)
  end
  YIELD(TT)
end

function PlaySkillZhongxuSummonTrapOrAttachFlagPhase:_MultiGridMonsterPlayAddFlag(TT, phaseParam, entity, result)
  local effectDelay = phaseParam:GetMultiGridMonsterEffectDelay()
  local effectID = phaseParam:GetMultiGridMonsterEffectID()
  local loopAnim = phaseParam:GetMultiGridMonsterEffectLoopAnim()
  local loopAnimDelay = phaseParam:GetMultiGridMonsterEffectLoopAnimDelay()
  local flagEffectID = phaseParam:GetMultiGridMonsterFlagEffectID()
  YIELD(TT, effectDelay)
  local effectService = self._world:GetService("Effect")
  local effectEntity = effectService:CreateEffect(effectID, entity)
  local flagEffectEntity = effectService:CreateEffect(flagEffectID, entity)
  local effectControllerComponent = flagEffectEntity:EffectController()
  if effectControllerComponent then
    local gridOffSet = result:GetOffSet()
    local hostPos = entity:GetGridPosition()
    local flagPos = hostPos + gridOffSet
    local csgo = entity:View().ViewWrapper.GameObject
    local csTransformRoot = csgo.transform:Find("Root")
    if csTransformRoot then
      local rootPos = csTransformRoot.position
      local boardServiceRender = self._world:GetService("BoardRender")
      local flagRenderPos = boardServiceRender:GridPos2RenderPos(flagPos)
      local off = flagRenderPos - rootPos
      local renderOffSet = Vector3(off.x, 0, off.z)
      effectControllerComponent:SetPosOffSet(renderOffSet)
    end
  end
  YIELD(TT, loopAnimDelay)
  local effectGo = effectEntity:View():GetGameObject()
  local anim = effectGo:GetComponentInChildren(typeof(UnityEngine.Animation))
  if anim then
    anim:Play(loopAnim)
  end
  YIELD(TT)
end
