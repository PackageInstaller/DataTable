require("buff_logic_base")
_class("BuffLogicResetMonsterWeak", BuffLogicBase)
BuffLogicResetMonsterWeak = BuffLogicResetMonsterWeak

function BuffLogicResetMonsterWeak:DoLogic(notify)
  local ownerEntity = self:GetEntity()
  if not ownerEntity:HasMonsterWeak() then
    return
  end
  local monsterWeakCmpt = ownerEntity:MonsterWeak()
  local curWeakKeyList = {}
  local weakList = monsterWeakCmpt:GetMonsterWeakDataList()
  for key, _ in pairs(weakList) do
    table.insert(curWeakKeyList, key)
  end
  for _, key in ipairs(curWeakKeyList) do
    monsterWeakCmpt:RemoveMonsterWeakData(key)
  end
  local utilData = self._world:GetService("UtilData")
  local weakDataList = utilData:OnGetEntitySelectWeakEdgeDataList(ownerEntity:GetID(), curWeakKeyList)
  for _, weakData in ipairs(weakDataList) do
    monsterWeakCmpt:SetMonsterWeakData(weakData:GetKey(), weakData)
  end
  return BuffResultResetMonsterWeak:New(weakDataList)
end
