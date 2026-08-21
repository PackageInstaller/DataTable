_class("UIHomeShowAwardsItem", UICustomWidget)
UIHomeShowAwardsItem = UIHomeShowAwardsItem
local maxNumCount = 5

function UIHomeShowAwardsItem:OnShow(uiParams)
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._anim = self:GetUIComponent("Animation", "rect")
  self._eff = self:GetGameObject("Effect")
  self._itemAlpha = self:GetUIComponent("CanvasGroup", "uiitem")
  self._index = -1
  self._pstid = -1
  self._itemCount = 0
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItemHomeland")
end

function UIHomeShowAwardsItem:SetData(itemInfo, index, clickCallback, nameColor, tweenIdx, beforeTime)
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
  self._itemCount = self._templateData.item_count
  local ra = RoleAsset:New()
  ra.assetid = self._item_id
  ra.count = self._itemCount
  self.uiItem:Flush(ra)
end

function UIHomeShowAwardsItem:_PlayAnim()
  self._anim:Play("uieff_UIGetItemControllerItem")
end

function UIHomeShowAwardsItem:GetIndex()
  return self._index
end

function UIHomeShowAwardsItem:OnHide()
  if self._tweenEvent then
    GameGlobal.Timer():CancelEvent(self._tweenEvent)
    self._tweenEvent = nil
  end
end

function UIHomeShowAwardsItem:FormatItemCount(count)
  local tex = HelperProxy:GetInstance():FormatItemCount(count)
  return tex
end
