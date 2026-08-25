local TrinketPlanEditController = NewClass("TrinketPlanEditController", BaseController)

function TrinketPlanEditController:OnInit()
end

function TrinketPlanEditController:OnReset()
end

function TrinketPlanEditController:ReqEquipTrinket(trinketUid)
  if not trinketUid or 0 == trinketUid then
    return
  end
  local trinketData = ItemDataUtils.GetItemByUid(trinketUid)
  if not trinketData then
    Logger.Info("找不到密契:", trinketUid)
    return
  end
  if EditTrinketSuitPlanModel.Instance:IsTrinketInCurPlan(trinketUid) then
    self:ReqPutOffTrinket(trinketUid)
  else
    self:ReqPutOnTrinket(trinketUid)
  end
end

function TrinketPlanEditController:ReqPutOffTrinket(uid)
  if not uid or 0 == uid then
    return
  end
  EditTrinketSuitPlanModel.Instance:PutOffTrinket(uid)
end

function TrinketPlanEditController:ReqPutOnTrinket(uid)
  if not uid or 0 == uid then
    return
  end
  local trinketData = ItemDataUtils.GetItemByUid(uid)
  if not trinketData then
    Logger.Info("找不到饰品:", uid)
    return
  end
  
  local function ReqPutOnTrinket()
    EditTrinketSuitPlanModel.Instance:PutOnTrinket(uid)
  end
  
  local curPlanId = EditTrinketSuitPlanModel.Instance:GetPlanId()
  local planId = AwakerTrinketExtModel.Instance:GetTrinketPlanId(uid)
  if planId ~= curPlanId and planId and planId > 0 then
    local planName = AwakerTrinketExtModel.Instance:GetTrinketPlanName(planId)
    local itemName = TrinketModel:GetTrinketName(trinketData.tid, false)
    local desc = LT.Textf(DT.TipsType[20049].Desc, itemName, planName)
    Alert.Show(20049, nil, ReqPutOnTrinket, nil, desc)
    return
  end
  ReqPutOnTrinket()
end

function TrinketPlanEditController:TakeOffAllTrinkets()
  EditTrinketSuitPlanModel.Instance:TakeOffAllTrinkets()
end

return TrinketPlanEditController
