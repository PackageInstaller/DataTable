_class("UIHauteCoutureDrawDynamicProbablityBase", UICustomWidget)
UIHauteCoutureDrawDynamicProbablityBase = UIHauteCoutureDrawDynamicProbablityBase

function UIHauteCoutureDrawDynamicProbablityBase:Constructor()
  self._prizes = nil
  self._drawTimes = nil
  self._gotPrizeIds = nil
  self._componentId = 0
end

function UIHauteCoutureDrawDynamicProbablityBase:InitWidgetsBase()
  self.controller = self.uiOwner
  self._prizes = self.controller._prizes
  self._drawTimes = self.controller._drawTimes
  self._gotPrizeIds = self.controller._gotPrizeIds
  self._componentId = self.controller._componentId
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._text2 = self:GetUIComponent("RectTransform", "text2")
end

function UIHauteCoutureDrawDynamicProbablityBase:_OnValue()
  local data = self.controller._ctx
  local items = self._content:SpawnObjects(self:GetProbablityItemScript(), #self._prizes)
  local allRate = 0
  local allRateTab = {}
  for idx, v in ipairs(self._prizes) do
    if not table.icontains(self._gotPrizeIds, v.ID) and self:FilterDrawTimes(v) then
      local rate = 0
      rate = self:CalculateProbablity(v.ID)
      rate = math.ceil(rate * 100) / 100
      allRate = allRate + rate
      allRateTab[v.ID] = rate
    end
  end
  local moreRate = 0
  if 100 < allRate then
    moreRate = allRate - 100
  end
  if 1.0E-6 < moreRate then
    for k, v in ipairs(self._prizes) do
      local prizeId = v.ID
      if allRateTab[prizeId] then
        local rate = allRateTab[prizeId]
        rate = rate - 0.01
        allRateTab[prizeId] = rate
        moreRate = moreRate - 0.01
        if moreRate <= 1.0E-6 then
          break
        end
      end
    end
  end
  local replacedIDs = {}
  if data:IsReview() then
    replacedIDs = GameGlobal.GetModule(CampaignModule):GetSeniorSkinDuplicateRewardIndexs(self._prizes, data:GetSeniorSkinCmp():GetComponentInfo())
  end
  for k, v in ipairs(self._prizes) do
    items[k]:SetData(v, self._drawTimes, table.icontains(self._gotPrizeIds, v.ID), allRateTab[v.ID], table.icontains(replacedIDs, k))
  end
  self._text2:SetAsLastSibling()
end

function UIHauteCoutureDrawDynamicProbablityBase:GetProbablityItemScript()
  Log.error("UIHauteCoutureDrawDynamicProbablityBase:GetProbablityItemScript should be override")
  return ""
end

function UIHauteCoutureDrawDynamicProbablityBase:CalculateProbablity(id)
  local totalWeight = 0
  local componentId = self._componentId
  local cfgs = Cfg.cfg_component_senior_skin_weight({ComponentID = componentId})
  for _, cfg in pairs(cfgs) do
    if not table.icontains(self._gotPrizeIds, cfg.ID) and self:FilterDrawTimes(cfg) then
      totalWeight = totalWeight + cfg.Weight
    end
  end
  return Cfg.cfg_component_senior_skin_weight[id].Weight / totalWeight * 100
end

function UIHauteCoutureDrawDynamicProbablityBase:FilterDrawTimes(v)
  if v.RareLevel and self._drawTimes < v.RareLevel - 1 then
    return false
  end
  return true
end

function UIHauteCoutureDrawDynamicProbablityBase:MaskOnClick()
  self.controller:CloseDialog()
end

function UIHauteCoutureDrawDynamicProbablityBase:CloseOnClick()
  self.controller:CloseDialog()
end
