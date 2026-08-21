_class("SkillEffectCalc_RefreshGridByBoardID", Object)
SkillEffectCalc_RefreshGridByBoardID = SkillEffectCalc_RefreshGridByBoardID

function SkillEffectCalc_RefreshGridByBoardID:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_RefreshGridByBoardID:DoSkillEffectCalculator(skillEffectCalcParam)
  local param = skillEffectCalcParam.skillEffectParam
  local boardID = param:GetBoardID()
  local result = SkillEffectRefreshGridByBoardIDResult:New()
  local trapSvc = self._world:GetService("TrapLogic")
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for _, trap in ipairs(trapGroup:GetEntities()) do
    if not trap:HasDeadMark() then
      trap:Attributes():Modify("HP", 0)
      local disableDieSkill = true
      trapSvc:AddTrapDeadMark(trap, disableDieSkill)
      result:AddDestroyTrapEntityIDList(trap:GetID())
    end
  end
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local logicEntitySvc = self._world:GetService("LogicEntity")
  logicEntitySvc:GenerateBoardDataByID(boardID, teamEntity)
  local utilDataSvc = self._world:GetService("UtilData")
  local gridPieceData = utilDataSvc:GetReplicaGridEntityData()
  result:SetGridPieceData(gridPieceData)
  local battleFlags = self._world:BattleFlags()
  battleFlags:AddSceneChangeTimes(1)
  local changeTimes = battleFlags:GetSceneChangeTimes()
  result:SetSceneChangeTimes(changeTimes)
  return {result}
end
