require("base_ins_r")
_class("PlayLevelTrapCommonSummonInstruction", BaseInstruction)
PlayLevelTrapCommonSummonInstruction = PlayLevelTrapCommonSummonInstruction

function PlayLevelTrapCommonSummonInstruction:Constructor(paramList)
  self._paramList = paramList
  self._destroyEffectID = tonumber(paramList.destroyEffectID)
  self._lvUpEffectID = tonumber(paramList.lvUpEffectID)
  self._maxLevelCamEffectID = tonumber(paramList.maxLevelCamEffectID)
  self._maxLevelAudioID = tonumber(paramList.maxLevelAudioID)
  self._summonDelay = tonumber(paramList.summonDelay) or 0
  self._destroyDelay = tonumber(paramList.destroyDelay) or 0
  self._destroyInterval = tonumber(paramList.destroyInterval) or 0
  self._forceMeanTime = 1
end

function PlayLevelTrapCommonSummonInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local routineCmpt = casterEntity:SkillRoutine():GetResultContainer()
  if not routineCmpt then
    return
  end
  local resultArray
  resultArray = routineCmpt:GetEffectResultsAsArray(SkillEffectType.LevelTrapAbsortSummon)
  resultArray = resultArray or routineCmpt:GetEffectResultsAsArray(SkillEffectType.LevelTrapUpLevel)
  resultArray = resultArray or routineCmpt:GetEffectResultsAsArray(SkillEffectType.LevelTrapSummonOrUpLevel)
  if not resultArray then
    return
  end
  local effectService = world:GetService("Effect")
  local trapServiceRender = world:GetService("TrapRender")
  local hasMaxLevel = false
  if self._lvUpEffectID and self._lvUpEffectID > 0 then
    for _, result in ipairs(resultArray) do
      local destroyList = result:GetDestroyList()
      if destroyList then
        for index, destroyResult in ipairs(destroyList) do
          local eID = destroyResult:GetEntityID()
          local eTrap = world:GetEntityByID(eID)
          if eTrap then
            effectService:CreateWorldPositionEffect(self._lvUpEffectID, eTrap:GetGridPosition())
          end
        end
      end
    end
  end
  if 0 < self._destroyDelay then
    YIELD(TT, self._destroyDelay)
  end
  for _, result in ipairs(resultArray) do
    local destroyList = result:GetDestroyList()
    if destroyList then
      for index, destroyResult in ipairs(destroyList) do
        local eID = destroyResult:GetEntityID()
        local eTrap = world:GetEntityByID(eID)
        if eTrap then
          trapServiceRender:PlayTrapDieSkill(TT, {eTrap}, true)
          if self._destroyEffectID and 0 < self._destroyEffectID then
            effectService:CreateWorldPositionEffect(self._destroyEffectID, eTrap:GetGridPosition())
          end
          if 0 < self._destroyInterval and index < #destroyList then
            YIELD(TT, self._destroyInterval)
          end
        end
      end
    end
  end
  if 0 < self._summonDelay then
    YIELD(TT, self._summonDelay)
  end
  for _, result in ipairs(resultArray) do
    local summonList = result:GetSummonList()
    if result:HasMaxLevel() then
      hasMaxLevel = true
    end
    if summonList then
      for __, summonResult in ipairs(summonList) do
        local trapIDList = summonResult:GetTrapIDList()
        for i = 1, #trapIDList do
          local trapEntity = world:GetEntityByID(trapIDList[i])
          local summonPos = Vector2(summonResult:GetPos().x, summonResult:GetPos().y)
          if self._forceMeanTime and self._forceMeanTime == 1 then
            GameGlobal.TaskManager():CoreGameStartTask(function()
              self:_ShowTrap(TT, world, trapEntity, summonPos)
            end)
          else
            self:_ShowTrap(TT, world, trapEntity, summonPos)
          end
        end
      end
    end
  end
  if hasMaxLevel then
    effectService:CreateScreenEffPointEffect(self._maxLevelCamEffectID)
    AudioHelperController.PlayInnerGameSfx(self._maxLevelAudioID)
  end
end

function PlayLevelTrapCommonSummonInstruction:_ShowTrap(TT, world, trapEntity, pos)
  local trapServiceRender = world:GetService("TrapRender")
  trapServiceRender:CreateSingleTrapRender(TT, trapEntity, true)
  trapEntity:SetPosition(pos)
end

function PlayLevelTrapCommonSummonInstruction:GetCacheResource()
  local t = {}
  if self._destroyEffectID and self._destroyEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._destroyEffectID].ResPath,
      1
    })
  end
  if self._lvUpEffectID and 0 < self._lvUpEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._lvUpEffectID].ResPath,
      1
    })
  end
  if self._maxLevelCamEffectID and 0 < self._maxLevelCamEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._maxLevelCamEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayLevelTrapCommonSummonInstruction:GetCacheAudio()
  if self._maxLevelAudioID and self._maxLevelAudioID > 0 then
    return {
      self._maxLevelAudioID
    }
  end
end
