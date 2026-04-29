require("buff_logic_base")
_class("BuffLogicAddDamageStatisticsComponent", BuffLogicBase)
BuffLogicAddDamageStatisticsComponent = BuffLogicAddDamageStatisticsComponent

function BuffLogicAddDamageStatisticsComponent:DoLogic(notify)
  if self:GetEntity():HasDamageStatisticsComponent() then
    Log.error(self._className, "已经执行过AddDamageStatisticsComponent逻辑的单位，在执行反逻辑前不可重新执行。")
    return
  end
  self:GetEntity():AddDamageStatisticsComponent()
end

_class("BuffLogicRemoveDamageStatisticsComponent", BuffLogicBase)
BuffLogicRemoveDamageStatisticsComponent = BuffLogicRemoveDamageStatisticsComponent

function BuffLogicRemoveDamageStatisticsComponent:DoLogic(notify)
  self:GetEntity():RemoveDamageStatisticsComponent()
end
