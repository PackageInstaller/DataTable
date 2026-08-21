require("monster_behavior_base")
_class("MonsterBeHaviorChgDirectionWhenAttacked", MonsterBeHaviorBase)
MonsterBeHaviorChgDirectionWhenAttacked = MonsterBeHaviorChgDirectionWhenAttacked

function MonsterBeHaviorChgDirectionWhenAttacked:Name()
  return "MonsterBeHaviorChgDirectionWhenAttacked"
end

function MonsterBeHaviorChgDirectionWhenAttacked:Exec()
  local moveBehavior = self:GetBehavior(MonsterBeHaviorMove:Name())
  if moveBehavior then
    moveBehavior:ChgDirection()
  end
end

function MonsterBeHaviorChgDirectionWhenAttacked:OnInit(param)
end

function MonsterBeHaviorChgDirectionWhenAttacked:OnShow()
end

function MonsterBeHaviorChgDirectionWhenAttacked:OnReset()
end

function MonsterBeHaviorChgDirectionWhenAttacked:OnRelease()
end
