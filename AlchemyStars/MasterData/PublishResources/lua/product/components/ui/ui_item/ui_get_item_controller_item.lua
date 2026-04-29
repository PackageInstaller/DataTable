_class("UIGetItemControllerItem", UICustomWidget)
UIGetItemControllerItem = UIGetItemControllerItem
local maxNumCount = 5

function UIGetItemControllerItem:OnShow(uiParams)
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._anim = self:GetUIComponent("Animation", "rect")
  self._eff = self:GetGameObject("Effect")
  self._itemAlpha = self:GetUIComponent("CanvasGroup", "uiitem")
  self._index = -1
  self._pstid = -1
  self._itemCount = 0
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Base)
  self.uiItem:SetClickCallBack(function(go)
    self:itemOnClick(go)
  end)
end

function UIGetItemControllerItem:SetData(itemInfo, index, clickCallback, nameColor, tweenIdx, beforeTime)
  self._eff:SetActive(false)
  self._itemAlpha.alpha = 0
  self._index = index
  self._templateData = itemInfo
  self._item_id = self._templateData.item_id
  if tweenIdx then
    local tweenTime = beforeTime + (tweenIdx - 1) * 100
    if self._tweenEvent then
      GameGlobal.Timer():CancelEvent(self._tweenEvent)
      self._tweenEvent = nil
    end
    self._tweenEvent = GameGlobal.Timer():AddEvent(tweenTime, function()
      self:_PlayAnim()
    end)
  end
  local text2Color = nameColor
  local text2 = StringTable.Get(self._templateData.item_name)
  local quality = self._templateData.color
  self._itemCount = self._templateData.item_count
  local icon = self._templateData.icon
  local tex = self:FormatItemCount(self._itemCount)
  local text1 = tex
  local itemId = self._templateData.item_id
  local des = self._templateData.item_des
  local awardType = self._templateData.award_type
  self._clickCallback = clickCallback
  local activityText = ""
  if awardType and awardType == StageAwardType.Activity then
    activityText = StringTable.Get("str_item_xianshi")
  end
  self.uiItem:ClearItemData()
  self.uiItem:SetData({
    icon = icon,
    quality = quality,
    text1 = text1,
    text2 = text2,
    text2Color = text2Color,
    itemId = itemId,
    des = des,
    activityText = activityText,
    showHeartStone = self._templateData.heartstone
  })
end

function UIGetItemControllerItem:_PlayAnim()
  self._anim:Play("uieff_UIGetItemControllerItem")
end

function UIGetItemControllerItem:itemOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  if not self._templateData then
    return
  end
  if self._clickCallback then
    self._rect:DOPunchScale(Vector3(0.1, 0.1, 0.1), 0.2)
    self._clickCallback(self._item_id, go.transform.position)
  end
end

function UIGetItemControllerItem:GetIndex()
  return self._index
end

function UIGetItemControllerItem:OnHide()
  if self._tweenEvent then
    GameGlobal.Timer():CancelEvent(self._tweenEvent)
    self._tweenEvent = nil
  end
end

function UIGetItemControllerItem:FormatItemCount(count)
  local tex = HelperProxy:GetInstance():FormatItemCount(count)
  return tex
end
