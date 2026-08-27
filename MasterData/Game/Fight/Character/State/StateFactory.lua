local DormFightConst = require("Game.Fight.DormFightConst")
local StateFactory = {}

function StateFactory.CreateState(stateType)
  local res
  if stateType == DormFightConst.StateEnum.AttackLayer_Attack then
    res = require("Game.Fight.Character.State.Attack.AttackState").New()
  elseif stateType == DormFightConst.StateEnum.AttackLayer_Born then
    res = require("Game.Fight.Character.State.Attack.BornState").New()
  elseif stateType == DormFightConst.StateEnum.AttackLayer_Drop then
    res = require("Game.Fight.Character.State.Attack.DropState").New()
  elseif stateType == DormFightConst.StateEnum.AttackLayer_Hit then
    res = require("Game.Fight.Character.State.Attack.HitState").New()
  elseif stateType == DormFightConst.StateEnum.AttackLayer_Idle then
    res = require("Game.Fight.Character.State.Attack.IdleState").New()
  elseif stateType == DormFightConst.StateEnum.AttackLayer_KnockOut then
    res = require("Game.Fight.Character.State.Attack.KnockOutState").New()
  elseif stateType == DormFightConst.StateEnum.MovementLayer_Born then
    res = require("Game.Fight.Character.State.Movement.BornState").New()
  elseif stateType == DormFightConst.StateEnum.MovementLayer_Drop then
    res = require("Game.Fight.Character.State.Movement.DropState").New()
  elseif stateType == DormFightConst.StateEnum.MovementLayer_Hit then
    res = require("Game.Fight.Character.State.Movement.HitState").New()
  elseif stateType == DormFightConst.StateEnum.MovementLayer_Idle then
    res = require("Game.Fight.Character.State.Movement.IdleState").New()
  elseif stateType == DormFightConst.StateEnum.MovementLayer_KnockOut then
    res = require("Game.Fight.Character.State.Movement.KnockOutState").New()
  elseif stateType == DormFightConst.StateEnum.MovementLayer_Move then
    res = require("Game.Fight.Character.State.Movement.MoveState").New()
  elseif stateType == DormFightConst.StateEnum.MovementLayer_Run then
    res = require("Game.Fight.Character.State.Movement.RunState").New()
  end
  return res
end

return StateFactory
