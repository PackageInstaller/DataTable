_class("UIHauteCoutureDrawRulesBase", UICustomWidget)
UIHauteCoutureDrawRulesBase = UIHauteCoutureDrawRulesBase

function UIHauteCoutureDrawRulesBase:Constructor()
  self.controller = nil
end

function UIHauteCoutureDrawRulesBase:InitWidgetsBase()
  self.controller = self.uiOwner
  self.items = self:GetUIComponent("UISelectObjectPath", "items")
  self.pros = self:GetUIComponent("Transform", "Pros")
end

function UIHauteCoutureDrawRulesBase:_OnValue()
  self.items.dynamicInfoOfEngine:SetObjectName(self:GetRuleItemPrefab())
  self.items:SpawnObjects(self:GetRuleItemScript(), 10)
  local itemWidgets = self.items:GetAllSpawnList()
  local data = self.controller.CtxData
  local prizes = data:GetPrizeCfgs()
  local replacedIdx
  if data:IsReview() then
    replacedIdx = GameGlobal.GetModule(CampaignModule):GetSeniorSkinDuplicateRewardIndexs(prizes, data:GetSeniorSkinCmp():GetComponentInfo())
    self:SetReviewRewardContenText()
  end
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
    self.pros:GetChild(i - 1):GetComponent(typeof(UILocalizationText)):SetText(prizeCfg.BaseProb)
  end
end

function UIHauteCoutureDrawRulesBase:GetRuleItemPrefab()
  Log.error("UIHauteCoutureDrawRulesBase:GetRuleItemPrefab should be inherited")
  return nil
end

function UIHauteCoutureDrawRulesBase:GetRuleItemScript()
  Log.error("UIHauteCoutureDrawRulesBase:GetRuleItemScript should be inherited")
  return nil
end

function UIHauteCoutureDrawRulesBase:SetReviewRewardContenText()
  Log.error("UIHauteCoutureDrawRulesBase:SetReviewRewardContenText should be inherited")
end

function UIHauteCoutureDrawRulesBase:MaskOnClick()
  self.controller:CloseDialog()
end
