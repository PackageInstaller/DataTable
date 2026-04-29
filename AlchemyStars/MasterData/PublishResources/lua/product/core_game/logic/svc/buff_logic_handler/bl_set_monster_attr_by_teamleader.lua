_class("BuffLogicSetMonsterAttrByTeamLeader", BuffLogicBase)
BuffLogicSetMonsterAttrByTeamLeader = BuffLogicSetMonsterAttrByTeamLeader
local BLSetMonsterAttrByTeamLeaderType = {
  TeamLeaderAttack = 1,
  Def = 2,
  MaxHP = 3
}

function BuffLogicSetMonsterAttrByTeamLeader:Constructor(buffInstance, logicParam)
  self._addValue = logicParam.addValue or 0
  self._type = logicParam.type
end

function BuffLogicSetMonsterAttrByTeamLeader:DoLogic()
  if not self._entity:HasMonsterID() then
    return
  end
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamLeadPstID = teamEntity:Team():GetTeamLeaderPetPstID()
  local petData = self._world:GetPetData(teamLeadPstID)
  local atk = petData:GetPetAttack()
  local allPetList = self._world:GetLocalMatchPetList()
  local def, maxHP = 0, 0
  for _, pet in ipairs(allPetList) do
    def = def + pet:GetPetDefence()
    maxHP = maxHP + pet:GetPetHealth()
  end
  if self._type == BLSetMonsterAttrByTeamLeaderType.TeamLeaderAttack then
    local value = atk * (1 + self._addValue)
    Log.info("BuffLogicSetMonsterAttrByTeamLeader SetMonsterAttack ", value, "MonsterID:", self._entity:MonsterID():GetMonsterID())
    self._entity:Attributes():Modify("Attack", value)
  end
  if self._type == BLSetMonsterAttrByTeamLeaderType.Def then
    local value = def * (1 + self._addValue)
    Log.info("BuffLogicSetMonsterAttrByTeamLeader SetMonsterDef ", value, "MonsterID:", self._entity:MonsterID():GetMonsterID())
    self._entity:Attributes():Modify("Defense", value)
  end
  if self._type == BLSetMonsterAttrByTeamLeaderType.MaxHP then
    local value = maxHP * (1 + self._addValue)
    Log.info("BuffLogicSetMonsterAttrByTeamLeader SetMonsterMaxHP ", value, "MonsterID:", self._entity:MonsterID():GetMonsterID())
    self._entity:Attributes():Modify("HP", value)
    self._entity:Attributes():Modify("MaxHP", value)
  end
end
