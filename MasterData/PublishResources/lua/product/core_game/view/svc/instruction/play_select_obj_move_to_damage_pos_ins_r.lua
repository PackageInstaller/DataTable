require("base_ins_r")
_class("PlaySelectObjMoveToDamagePosInstruction", BaseInstruction)
PlaySelectObjMoveToDamagePosInstruction = PlaySelectObjMoveToDamagePosInstruction

function PlaySelectObjMoveToDamagePosInstruction:Constructor(paramList)
  self._objName = paramList.objName
  self._time = tonumber(paramList.time)
  self._speed = tonumber(paramList.speed)
  self._form = tonumber(paramList.form)
  self._to = tonumber(paramList.to)
  self._block = tonumber(paramList.block)
  self._skillEffectType = tonumber(paramList.skillEffectType)
end

function PlaySelectObjMoveToDamagePosInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local obj = UnityEngine.GameObject.Find(self._objName)
  if not obj then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local targetEntityID1, targetEntityID2
  if self._skillEffectType == SkillEffectType.Damage then
    local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
    if damageResultArray == nil then
      return
    end
    local damageResult1 = damageResultArray[self._form]
    local damageResult2 = damageResultArray[self._to]
    if damageResult1 == nil or damageResult2 == nil then
      return
    end
    targetEntityID1 = damageResult1:GetTargetID()
    targetEntityID2 = damageResult2:GetTargetID()
  elseif self._skillEffectType == SkillEffectType.AddBuff then
    local buffResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddBuff)
    if buffResultArray == nil then
      return
    end
    local buffResult1 = buffResultArray[self._form]
    local buffResult2 = buffResultArray[self._to]
    if buffResult1 == nil or buffResult2 == nil then
      return
    end
    targetEntityID1 = buffResult1:GetEntityID()
    targetEntityID2 = buffResult2:GetEntityID()
  end
  local targetEntity1 = world:GetEntityByID(targetEntityID1)
  local targetEntity2 = world:GetEntityByID(targetEntityID2)
  if targetEntity1 == nil or targetEntity2 == nil then
    return
  end
  local boardSvcR = world:GetService("BoardRender")
  local posOld = boardSvcR:GetRealEntityGridPos(targetEntity1)
  local posNew = boardSvcR:GetRealEntityGridPos(targetEntity2)
  local distance = Vector2.Distance(posNew, posOld)
  local speed = self._speed
  if self._time then
    speed = distance / self._time * 1000
  end
  local targetPos = targetEntity2:GridLocation():Center()
  local targetRenderPos = boardSvcR:GridPos2RenderPos(targetPos)
  obj.transform:DOMove(targetRenderPos, self._time * 0.001)
  if self._block == 1 then
    YIELD(TT, self._time)
  end
end
