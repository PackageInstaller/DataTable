_class("UIShopSailingPlanItem", UICustomWidget)
UIShopSailingPlanItem = UIShopSailingPlanItem

function UIShopSailingPlanItem:Constructor()
end

function UIShopSailingPlanItem:SetData(idx, roleAsset, callback, haveState, status, buystate, animTime, skinTag1, skinTag2, itemScale)
  self._callback = callback
  self._id = roleAsset.assetid
  self._count = roleAsset.count
  self._haveState = haveState
  self._status = status
  self._buystate = buystate
  self._scale = itemScale
  self.skinTag1 = skinTag1
  self.skinTag2 = skinTag2
  self:GetComponents()
  self:OnValue()
  self:PlayAnim(animTime)
end

function UIShopSailingPlanItem:OnHide()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
end

function UIShopSailingPlanItem:PlayAnim(animTime)
  if animTime then
    self._rootAlpha.alpha = 0
    if animTime == 0 then
      self._anim:Play()
    else
      if self._event then
        GameGlobal.Timer():CancelEvent(self._event)
        self._event = nil
      end
      self._event = GameGlobal.Timer():AddEvent(animTime, function()
        self._anim:Play()
      end)
    end
  else
    self._rootTr.anchoredPosition = Vector2(0, 0)
    self._rootAlpha.alpha = 1
  end
end

function UIShopSailingPlanItem:GetComponents()
  self._anim = self:GetUIComponent("Animation", "anim")
  self._rootTr = self:GetUIComponent("RectTransform", "Root")
  self._rootAlpha = self:GetUIComponent("CanvasGroup", "Root")
  self._uiitem = self:GetUIComponent("Transform", "uiitem")
  self._statusGo = self:GetGameObject("status")
  self._not = self:GetGameObject("not")
  self._com = self:GetGameObject("com")
  self._got = self:GetGameObject("got")
  self._isSkin = self:GetGameObject("isSkin")
  self._tagPos = self:GetUIComponent("RectTransform", "tagPos")
  self._tagPos2 = self:GetUIComponent("RectTransform", "tagPos2")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._txt1 = self:GetUIComponent("UILocalizationText", "txt1")
  self._quality = self:GetUIComponent("Image", "quality")
  self._uiCommonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self._tagPos11 = self:GetGameObject("tagPos11")
  self._tagPos12 = self:GetGameObject("tagPos12")
  self._tagPos21 = self:GetGameObject("tagPos21")
end

function UIShopSailingPlanItem:OnValue()
  local cfg_item = Cfg.cfg_item[self._id]
  if not cfg_item then
    Log.error("###[UIShopSailingPlanItem] cfg_item is nil ! id : ", self._id)
  end
  if self._scale then
    self._uiitem.localScale = Vector3(self._scale, self._scale, self._scale)
  end
  self._icon:LoadImage(cfg_item.Icon)
  self._txt1:SetText(self._count)
  local qualityName = UIEnum.ItemColorFrame(cfg_item.Color)
  self._quality.sprite = self._uiCommonAtlas:GetSprite(qualityName)
  if not self._haveState then
    self._statusGo:SetActive(false)
  elseif self._buystate then
    local buy = self._buystate ~= BuyGiftStateType.EBGST_INIT
    self._not:SetActive(not buy)
    self._com:SetActive(buy and self._status == QuestStatus.QUEST_Completed)
    self._got:SetActive(buy and self._status == QuestStatus.QUEST_Taken)
  else
    self._not:SetActive(false)
    self._com:SetActive(self._status == QuestStatus.QUEST_Completed)
    self._got:SetActive(self._status == QuestStatus.QUEST_Taken)
  end
  local idx = string.find(tostring(self._id), "40")
  local isSkin = idx and idx == 1
  self._isSkin:SetActive(isSkin)
  if isSkin then
    self._tagPos21:SetActive(self.skinTag2)
    self._tagPos11:SetActive(self.skinTag1)
    self._tagPos12:SetActive(self.skinTag1)
  end
end

function UIShopSailingPlanItem:BtnOnClick(go)
  if self._callback then
    self._callback(self._id, go.transform.position)
  end
end
