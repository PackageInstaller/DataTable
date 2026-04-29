_class("UIHauteCoutureDrawRulesController", UIController)
UIHauteCoutureDrawRulesController = UIHauteCoutureDrawRulesController

function UIHauteCoutureDrawRulesController:Constructor()
  self._probablityTable = {}
end

function UIHauteCoutureDrawRulesController:OnShow(uiParams)
  self._isReview = uiParams[1] or false
  local prizes = uiParams[2]
  local replacedIdx = uiParams[3] or {}
  local items = self:GetUIComponent("UISelectObjectPath", "items")
  local pros = self:GetUIComponent("Transform", "Pros")
  items:SpawnObjects("UISeniorSKinProItems", 10)
  local itemWidgets = items:GetAllSpawnList()
  for i = 1, 10 do
    local prizeCfg = prizes[i]
    local prize, normalPrize
    if table.icontains(replacedIdx, i) then
      normalPrize = {
        prizeCfg.ReplaceRewardID,
        prizeCfg.ReplaceRewardCount
      }
    else
      normalPrize = {
        prizeCfg.RewardID,
        prizeCfg.RewardCount
      }
    end
    if prizeCfg.AppendGlow and prizeCfg.AppendGlow > 0 then
      prize = {
        {
          RoleAssetID.RoleAssetGlow,
          prizeCfg.AppendGlow
        },
        normalPrize
      }
    else
      prize = {normalPrize}
    end
    itemWidgets[i]:SetData(prize)
    pros:GetChild(i - 1):GetComponent(typeof(UILocalizationText)):SetText(prizeCfg.BaseProb)
  end
end

function UIHauteCoutureDrawRulesController:maskOnClick()
  self:CloseDialog()
end

function UIHauteCoutureDrawRulesController:_OnValue()
  self._ruleGrid.constraintCount = #self._prizes + 1
  local items = self._ruleGridPool:SpawnObjects("UIHauteCoutureDrawRuleItem", (self._maxRows + 1) * (self._maxCols + 1))
  local currentCount = 1
  for i = 1, self._maxRows + 1 do
    if 1 < i then
      local cfg = Cfg.cfg_item[self._prizes[i - 1].RewardID]
      items[currentCount]:SetImg(cfg.Icon, self._prizes[i - 1].RewardCount)
    end
    for j = 1, self._maxCols + 1 do
      items[currentCount]:SetData(i, j)
      items[currentCount]:SetProbablity("0.01%")
      currentCount = currentCount + 1
    end
  end
end

function UIHauteCoutureDrawRulesController:CalculateProbablity(row, col)
  for k, v in pairs(self._prizes) do
    local prizeIndex = 1
    self._probablityTable[prizeIndex] = {}
    for i = 1, #self._prizes do
      local index = 1
      if v.RareLevel ~= 0 and v.RareLevel ~= nil and index > self._ then
        self._probablityTable[prizeIndex][i] = "0.00%"
        index = index + 1
      end
    end
    if v.RareLevel ~= 0 and v.RareLevel ~= nil then
      for i = 1, v.RareLevel do
        self._probablityTable[prizeIndex][i] = "0.00%"
      end
    else
    end
    prizeIndex = prizeIndex + 1
  end
end
