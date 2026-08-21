require("base_ins_r")
_class("PlayEffectAtTrapInstruction", BaseInstruction)
PlayEffectAtTrapInstruction = PlayEffectAtTrapInstruction

function PlayEffectAtTrapInstruction:Constructor(paramList)
  self._trapID = tonumber(paramList.trapID)
  self._effectID = tonumber(paramList.effectID)
  self._waitTime = tonumber(paramList.waitTime or 0)
end

function PlayEffectAtTrapInstruction:GetCacheResource()
  local t = {}
  if self._effectID then
    local cfgfx = Cfg.cfg_effect[self._effectID]
    if cfgfx then
      table.insert(t, {
        cfgfx.ResPath,
        1
      })
    end
  end
  return t
end

function PlayEffectAtTrapInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  self._world = world
  self._effectService = self._world:GetService("Effect")
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local utilDataSvc = self._world:GetService("UtilData")
  local listPosRet = {}
  local listTraps = trapGroup:GetEntities()
  local taskIDList = {}
  for i = 1, #listTraps do
    local trap = listTraps[i]
    if trap and not trap:HasDeadMark() then
      local trapComponent = trap:Trap()
      if trapComponent and trapComponent:GetTrapID() == self._trapID then
        local pos = trap:GetRenderGridPosition()
        local taskID = GameGlobal.TaskManager():CoreGameStartTask(self.PlayEffect, self, pos)
        table.insert(taskIDList, taskID)
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function PlayEffectAtTrapInstruction:PlayEffect(TT, pos)
  self._effectService:CreateWorldPositionDirectionEffect(self._effectID, pos)
  if self._waitTime then
    YIELD(TT, self._waitTime)
  end
end
