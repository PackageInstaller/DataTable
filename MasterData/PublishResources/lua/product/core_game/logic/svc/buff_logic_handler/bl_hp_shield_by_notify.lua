_class("BuffLogicAddHPShieldByNotify", BuffLogicBase)
BuffLogicAddHPShieldByNotify = BuffLogicAddHPShieldByNotify
local HPShieldByNotifyCalcType = {Percent = 1, Value = 2}
_enum("HPShieldByNotifyCalcType", HPShieldByNotifyCalcType)

function BuffLogicAddHPShieldByNotify:Constructor(buffInstance, logicParam)
  self._shieldNumber = logicParam.shieldNumber
  self._shieldCalcType = logicParam.shieldCalcType
  self._shieldFromType = logicParam.shieldFromType or HPShieldFromType.OwnerHP
  self._shieldFromParam = logicParam.shieldFromParam
  self._shieldTeleportMul = logicParam.shieldTeleportMul
end

function BuffLogicAddHPShieldByNotify:DoLogic(notify)
  local buffResultEntity
  local entity = self._buffInstance:Entity()
  if entity:HasMonsterID() then
    buffResultEntity = entity
  else
    buffResultEntity = self._world:Player():GetCurrentTeamEntity()
  end
  local value = 0
  if self._shieldFromType then
    value = self._buffLogicService:CalcShieldFormValue(notify, self._shieldFromType, self._shieldFromParam, entity, self._buffInstance)
  end
  local notifyValue
  if notify:GetNotifyType() == NotifyType.Teleport then
    local boardSvr = self._world:GetService("BoardLogic")
    local maxTeleportRing = math.max(boardSvr:GetCurBoardMaxX(), boardSvr:GetCurBoardMaxY())
    local oldPos = notify:GetPosOld()
    local teleportPos = notify:GetPosNew()
    local casterEntity = notify:GetNotifyEntity()
    local bodyArea = casterEntity:BodyArea():GetArea()
    local teleportDis
    if oldPos ~= teleportPos then
      for i = 1, maxTeleportRing do
        local ringRange = ComputeScopeRange.ComputeRange_SquareRing(oldPos, #bodyArea, i)
        if table.Vector2Include(ringRange, teleportPos) then
          teleportDis = i
          break
        end
      end
      notifyValue = teleportDis * self._shieldTeleportMul
    else
      teleportDis = 0
      notifyValue = 0
    end
    Log.fatal("瞬移圈数：", teleportDis, "瞬移加成值：", notifyValue, "瞬移每圈加成值：", self._shieldTeleportMul)
  end
  if not notifyValue then
    return
  end
  local baseShieldValue = self._shieldNumber
  local finalShieldValue
  if self._shieldCalcType == HPShieldByNotifyCalcType.Percent then
    finalShieldValue = value * notifyValue + baseShieldValue
    Log.fatal("类型1 基础护盾值=", baseShieldValue, "基础取值：", value, "配置数值：", self._shieldNumber, "最终值：", finalShieldValue, " 公式=瞬移圈数 * 每瞬移一圈提升的数值 * 基准值类型取值 + 基础护盾值")
  elseif self._shieldCalcType == HPShieldByNotifyCalcType.Value then
    finalShieldValue = notifyValue + baseShieldValue
    Log.fatal("类型2 基础护盾值=", baseShieldValue, "配置数值：", self._shieldNumber, "最终值：", finalShieldValue, " 公式=瞬移圈数 * 每瞬移一圈提升的数值 + 基础护盾值")
  end
  if not finalShieldValue then
    return
  end
  local curHpSh = self._buffLogicService:AddHPShield(buffResultEntity, finalShieldValue)
  local damageInfo = DamageInfo:New(0, DamageType.Recover)
  damageInfo:SetHPShield(curHpSh)
  damageInfo:IsInitShield(true)
  self._world:GetMatchLogger():BeginBuff(self._entity:GetID(), self._buffInstance:BuffID())
  local logger = self._world:GetMatchLogger()
  logger:AddHPShieldLog(self._entity:GetID(), {
    key = "AddHPShieldByNotify",
    desc = "BUFF瞬移加血条盾 施法者[caster]  加盾值[addShield] 当前血条盾[curShield] ",
    caster = self._entity:GetID(),
    addShield = finalShieldValue,
    curShield = curHpSh
  })
  self._world:GetMatchLogger():EndBuff(self._entity:GetID())
  local buffResult = BuffResultAddHPShield:New(buffResultEntity:GetID(), damageInfo)
  return buffResult
end

function BuffLogicAddHPShieldByNotify:DoOverlap(logicParam)
  self._shieldPercent = logicParam.shieldPercent
  return self:DoLogic()
end
