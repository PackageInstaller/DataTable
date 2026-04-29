_class("BuffLogicRefreshFeatureTrapDefenceHPPercent", BuffLogicBase)
BuffLogicRefreshFeatureTrapDefenceHPPercent = BuffLogicRefreshFeatureTrapDefenceHPPercent

function BuffLogicRefreshFeatureTrapDefenceHPPercent:DoLogic(notify)
  local notifyType = notify:GetNotifyType()
  if NotifyType.TrapHpChange ~= notifyType then
    return
  end
  local ntHPChange = notify
  local curHP = ntHPChange:GetHP()
  local maxHP = ntHPChange:GetMaxHP()
  local curHPPercent = math.floor(curHP / maxHP * 100 + 0.5)
  local result = BuffResultRefreshFeatureTrapDefenceHPPercent:New(curHPPercent)
  return result
end
