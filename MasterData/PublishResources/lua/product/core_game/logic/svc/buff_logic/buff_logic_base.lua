_class("BuffLogicBase", Object)
BuffLogicBase = BuffLogicBase

function BuffLogicBase:Constructor(buffInstance, logicParam)
  self._buffInstance = buffInstance
  self._entity = buffInstance:Entity()
  self._world = buffInstance:World()
  self._buffLogicService = self._world:GetService("BuffLogic")
  self._buffComponent = self._entity:BuffComponent()
  self._logicParam = logicParam
end

function BuffLogicBase:SetLogicIndex(index)
  self._logicIndex = index
end

function BuffLogicBase:GetLogicIndex()
  return self._logicIndex
end

function BuffLogicBase:NeedCheckGameTurn()
  return false
end

function BuffLogicBase:DoLogic(notify, triggers, index)
end

function BuffLogicBase:DoOverlap(logicParam, context)
  Log.exception(self:GetLogicName(), " DoOverlap() not implemented!")
end

function BuffLogicBase:GetLogicName()
  return self._logicParam.logic
end

function BuffLogicBase:GetBuffSeq()
  return self._buffInstance._buffSeq
end

function BuffLogicBase:GetWorld()
  return self._world
end

function BuffLogicBase:GetEntity()
  return self._entity
end

function BuffLogicBase:GetCasterEntity()
  local casterEntity = self._buffInstance:Context() and self._buffInstance:Context().casterEntity or nil
  casterEntity = casterEntity or self:GetEntity()
  return casterEntity
end

function BuffLogicBase:GetBuffComponent()
  return self._buffComponent
end

function BuffLogicBase:GetLogicParam()
  return self._logicParam
end

function BuffLogicBase:GetBuffLogicService()
  return self._buffLogicService
end

function BuffLogicBase:UpdateTeamDefenceLogic(teamEntity)
  local battleService = self._world:GetService("Battle")
  battleService:UpdateTeamDefenceLogic(teamEntity)
end

function BuffLogicBase:GetBuffSourceEntity()
  local buffComponent = self._entity:BuffComponent()
  if buffComponent then
    local buffSource = buffComponent:GetBuffSourceByBuffID(self._buffInstance:BuffID())
    local buffLogicService = self._world:GetService("BuffLogic")
    return buffLogicService:GetBuffSourceEntity(buffSource)
  end
  return nil
end

function BuffLogicBase:PrintBuffLogicLog(...)
  if self._world and self._world:IsDevelopEnv() then
    Log.debug(...)
  end
end
