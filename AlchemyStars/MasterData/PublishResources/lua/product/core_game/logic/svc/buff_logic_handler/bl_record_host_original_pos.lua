_class("BuffLogicRecordHostOriginalPos", BuffLogicBase)
BuffLogicRecordHostOriginalPos = BuffLogicRecordHostOriginalPos

function BuffLogicRecordHostOriginalPos:DoLogic(notify)
  local notifyType = notify:GetNotifyType()
  if notifyType ~= NotifyType.HitBackEnd and notifyType ~= NotifyType.TractionEnd then
    return
  end
  local buffComponent = self._entity:BuffComponent()
  if not buffComponent then
    return
  end
  if not notify.GetPosStart then
    return
  end
  local pos = notify:GetPosStart()
  if pos then
    buffComponent:SetBuffValue("HostOriginalPos", pos)
  end
end
