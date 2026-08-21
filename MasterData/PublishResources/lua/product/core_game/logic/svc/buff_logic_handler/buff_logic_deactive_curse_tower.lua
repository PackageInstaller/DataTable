_class("BuffLogicDeactiveCurseTower", BuffLogicBase)
BuffLogicDeactiveCurseTower = BuffLogicDeactiveCurseTower

function BuffLogicDeactiveCurseTower:Constructor(buffInstance, logicParam)
end

function BuffLogicDeactiveCurseTower:DoLogic()
  local e = self._buffInstance:Entity()
  local curseTowerCmpt = e:CurseTower()
  if not curseTowerCmpt then
    return
  end
  curseTowerCmpt:SetTowerState(CurseTowerState.Deactive)
  return true
end
