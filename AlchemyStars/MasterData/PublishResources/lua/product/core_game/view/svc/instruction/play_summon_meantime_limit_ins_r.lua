require("base_ins_r")
_class("PlaySummonMeantimeLimitInstruction", BaseInstruction)
PlaySummonMeantimeLimitInstruction = PlaySummonMeantimeLimitInstruction

function PlaySummonMeantimeLimitInstruction:Constructor(paramList)
  self._trapDieSkillID = tonumber(paramList.trapDieSkillID)
  self._forceMeanTime = tonumber(paramList.forceMeanTime)
end

function PlaySummonMeantimeLimitInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local routineCmpt = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = routineCmpt:GetEffectResultsAsArray(SkillEffectType.SummonMeantimeLimit)
  if not resultArray then
    return
  end
  local trapServiceRender = world:GetService("TrapRender")
  local playSkillSvc = world:GetService("PlaySkill")
  local configSvc = world:GetService("Config")
  local skillPhaseArray
  if self._trapDieSkillID then
    local skillConfigData = configSvc:GetSkillConfigData(self._trapDieSkillID, casterEntity)
    skillPhaseArray = skillConfigData:GetSkillPhaseArray()
  end
  for _, result in ipairs(resultArray) do
    local destroyEntityID = result:GetDestroyEntityID()
    for i, entityID in ipairs(destroyEntityID) do
      local entity = world:GetEntityByID(entityID)
      if entity then
        local skillHolder = entity
        local skillResult = result:GetTrapDieSkillResult()[i]
        if skillResult then
          skillHolder:SkillRoutine():SetResultContainer(skillResult)
        end
        if self._trapDieSkillID then
          playSkillSvc:_SkillRoutineTask(TT, skillHolder, skillPhaseArray, self._trapDieSkillID)
        end
        trapServiceRender:PlayTrapDieSkill(TT, {entity})
      end
    end
    local trapIDList = result:GetTrapIDList()
    local replaceAttr = result:GetReplaceAttr()
    for i = 1, #trapIDList do
      local trapEntity = world:GetEntityByID(trapIDList[i])
      if self._forceMeanTime and self._forceMeanTime == 1 then
        GameGlobal.TaskManager():StartTask(function()
          self:_ShowTrap(TT, world, trapEntity, replaceAttr)
        end)
      else
        self:_ShowTrap(TT, world, trapEntity, replaceAttr)
      end
    end
    trapServiceRender:UpdateAllTrapSummonIndex()
  end
end

function PlaySummonMeantimeLimitInstruction:_ShowTrap(TT, world, trapEntity, replaceAttr)
  local trapServiceRender = world:GetService("TrapRender")
  trapServiceRender:CreateSingleTrapRender(TT, trapEntity, true)
  local hp, hpMax
  for key, value in pairs(replaceAttr) do
    if key == "MaxHP" then
      hpMax = value
    elseif key == "HP" then
      hp = value
    end
  end
  if hp and hpMax then
    trapEntity:ReplaceRedAndMaxHP(hp, hpMax)
  end
end
