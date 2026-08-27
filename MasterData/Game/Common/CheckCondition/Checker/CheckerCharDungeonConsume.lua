local CheckerCharDungeonConsume = {}

function CheckerCharDungeonConsume.LengthCheck(param)
  if 3 <= #param then
    return true
  end
  return false
end

function CheckerCharDungeonConsume.ParamsCheck(param)
  local activityId = param[2]
  local needCount = param[3]
  local heroGrowCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrow)
  if heroGrowCtrl == nil then
    return false
  end
  local actHeroData = heroGrowCtrl:GetHeroGrowActivity(activityId)
  if actHeroData == nil then
    return false
  end
  return needCount <= actHeroData:GetHeroGrowCostNum()
end

function CheckerCharDungeonConsume.GetUnlockInfo(param)
  return ""
end

return CheckerCharDungeonConsume
