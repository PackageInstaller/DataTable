local this = class("conditionNode_13044", require(L_R.condition .. "conditionNode"))
local _dungeonEntrustTpl = L_GameTpl:getDungeonEntrustTpl()

function this.checkFunc(condition)
  local starNum = L_EntrustStore:getEntrustLevelStar(condition[2])
  return starNum >= condition[3]
end

function this.descFunc(key, codData)
  local cfg = _dungeonEntrustTpl:getTplById(codData[2])
  local name = _dungeonEntrustTpl:getName(cfg)
  local subName = _dungeonEntrustTpl:getSubName(cfg)
  local desc = CS.System.String.Format(key, name, subName)
  return desc
end

return this
