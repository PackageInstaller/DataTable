require("ui_side_enter_item_campaign")
_class("UIShopSailingPlanEnter", UISideEnterItem_Campaign)
UIShopSailingPlanEnter = UIShopSailingPlanEnter

function UIShopSailingPlanEnter:Constructor()
end

function UIShopSailingPlanEnter:_OnAfterUILayerChanged()
  if self._setShowCallback then
    local open = self:_CheckOpen()
    self._setShowCallback(open)
  end
end

function UIShopSailingPlanEnter:_CheckOpen(TT)
  self:_LoadCampaign(TT)
  local isOpen = self._campaign:CheckCampaignOpen()
  local isTime = UISideEnterItem_FixedTime.CheckOpen(self._btnCfg.BeginTime, self._btnCfg.EndTime)
  local sailingPlanHelper = UIShopSailingPlanHelper:New()
  local isActive = sailingPlanHelper:CheckActive()
  Log.debug("###[UIShopSailingPlanEnter] isOpen:", isOpen, "|isTime:", isTime, "|isActive:", isActive)
  return isOpen and isTime and isActive
end

function UIShopSailingPlanEnter:BtnOnClick(go)
  local sailingPlanHelper = UIShopSailingPlanHelper:New()
  local active = sailingPlanHelper:CheckActive()
  if not active then
    return
  end
  local jumpModule = GameGlobal.GetModule(QuestModule).uiModule
  jumpModule:SetJumpUIData(UIJumpType.UI_JumpMall, {2, 9})
  jumpModule:Jump()
end
