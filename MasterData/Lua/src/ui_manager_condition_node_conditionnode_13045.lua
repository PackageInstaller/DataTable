local this = class("conditionNode_13045", require(L_R.condition .. "conditionNode"))
local _dungeonEntrustTpl = L_GameTpl:getDungeonEntrustTpl()

function this.checkFunc(condition)
  local allData = _dungeonEntrustTpl.data
  for id, _ in pairs(allData) do
    if not L_EntrustStore:checkEntrustLevelSuc(id) then
      return false
    end
  end
  return true
end

function this.descFunc(key, codData)
  return L_Lang:get(key)
end

return this
