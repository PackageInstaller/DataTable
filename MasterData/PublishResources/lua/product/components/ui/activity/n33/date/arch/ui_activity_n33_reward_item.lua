_class("UIActivityN33RewardItem", UICustomWidget)
UIActivityN33RewardItem = UIActivityN33RewardItem

function UIActivityN33RewardItem:OnShow(uiParams)
  self:InitWidget()
end

function UIActivityN33RewardItem:InitWidget()
  self.itemNode = self:GetGameObject("ItemNode")
  self.petNode = self:GetGameObject("PetNode")
  self.petDontClickMark = self:GetGameObject("PetDontClickMark")
  self.itemNumText = self:GetUIComponent("UILocalizationText", "ItemNumText")
  self.dontClickMark = self:GetUIComponent("Image", "DontClickMark")
  self.petImg = self:GetUIComponent("RawImageLoader", "petImg")
  self.petImgGo = self:GetGameObject("petImg")
  self.itemIconLoader = self:GetUIComponent("RawImageLoader", "icon")
  self.canClickShowTips = true
end

function UIActivityN33RewardItem:SetRewardData_Item(rewardConf, isReceived, activityConst)
  self.activityConst = activityConst
  self.itemNode:SetActive(true)
  self.petNode:SetActive(false)
  if not rewardConf then
    return
  end
  local assetid = rewardConf[1]
  assetid = assetid or rewardConf.assetid
  local count = rewardConf[2]
  count = count or rewardConf.count
  local templateData = Cfg.cfg_item[assetid]
  if not templateData then
    Log.fatal("###cfg_item is nil ! id --> ", assetid)
    return
  end
  self.itemNumText:SetText("X" .. count)
  self._assetID = assetid
  self._uiItemAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  local icon = templateData.Icon
  local quality = templateData.Color
  local text1 = count
  local itemId = templateData.ID
  self.itemIconLoader:LoadImage(icon)
  self.dontClickMark.gameObject:SetActive(isReceived)
  self.canClickShowTips = not isReceived
end

function UIActivityN33RewardItem:SetRewardData_PetStory(petStoryID, isReceived, activityConst)
  self.activityConst = activityConst
  self.itemNode:SetActive(false)
  self.petNode:SetActive(true)
  self.petDontClickMark:SetActive(isReceived)
  local cfg = Cfg.cfg_component_simulation_operation_story[petStoryID]
  self.petImg:LoadImage(cfg.BonuslIcon)
end

function UIActivityN33RewardItem:ClickItemBtnOnClick(go)
  if self.activityConst:CheckSimulationOperationIsOver() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIActivityN33MainController)
    return
  end
  if not self._assetID then
    return
  end
  if not self.canClickShowTips then
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftInteractiveEventRewardShowItemTips, self._assetID, self:GetGameObject().transform.position)
end
