_class("BuffLogicAddElite", BuffLogicBase)
BuffLogicAddElite = BuffLogicAddElite

function BuffLogicAddElite:Constructor(buffInstance, logicParam)
  self._eliteIDArray = logicParam.eliteIDArray
  if not self._eliteIDArray then
    Log.error("[AddElite] config error: elite id array is nil!")
  end
end

function BuffLogicAddElite:DoLogic(notify)
  local ownerEntity = self._buffInstance:Entity()
  local monsterIDCmpt = ownerEntity:MonsterID()
  if not monsterIDCmpt then
    return
  end
  local addEliteIDArray = {}
  local ownerEliteIDArray = monsterIDCmpt:GetEliteIDArray()
  for _, id in ipairs(self._eliteIDArray) do
    if not table.icontains(ownerEliteIDArray, id) then
      table.insert(addEliteIDArray, id)
    end
  end
  if #addEliteIDArray == 0 then
    return
  end
  table.appendArray(ownerEliteIDArray, addEliteIDArray)
  monsterIDCmpt:SetEliteIDArray(ownerEliteIDArray)
  local result = BuffResultAddElite:New(addEliteIDArray)
  local world = self._buffInstance:World()
  local buffLogicSvc = world:GetService("BuffLogic")
  for _, eliteID in ipairs(addEliteIDArray) do
    local cfg = Cfg.cfg_monster_elite[eliteID]
    if not cfg then
      Log.error("[AddElite]", "invalid eliteID: ", eliteID)
    elseif cfg.Buff and #cfg.Buff ~= 0 then
      for _, buffID in ipairs(cfg.Buff) do
        Log.debug("[AddElite]", "entityID: ", ownerEntity:GetID(), "elite ID: ", eliteID, ", buffID: ", buffID)
        local buffIns = buffLogicSvc:AddBuff(buffID, ownerEntity, {})
        if buffIns then
          result:AddBuffSeq(buffIns:BuffSeq())
        end
      end
    end
  end
  return result
end
