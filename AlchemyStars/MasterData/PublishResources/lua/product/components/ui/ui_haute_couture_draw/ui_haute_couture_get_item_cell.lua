_class("UIHauteCoutureGetItemCell", UICustomWidget)
UIHauteCoutureGetItemCell = UIHauteCoutureGetItemCell

function UIHauteCoutureGetItemCell:OnShow(uiParams)
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._anim = self:GetUIComponent("Animation", "rect")
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIHauteItem")
end

function UIHauteCoutureGetItemCell:SetData(itemInfo, clickCallback)
  self._templateData = itemInfo
  self._item_id = self._templateData.item_id
  local text2 = "<color=#847e7e>" .. StringTable.Get(self._templateData.item_name) .. "</color>"
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
  local roleAsset = RoleAsset:New()
  roleAsset.assetid = self._item_id
  roleAsset.count = self._itemCount
  self.uiItem:Flush(roleAsset, function(go)
    self:itemOnClick(go)
  end, itemInfo.showTag)
end

function UIHauteCoutureGetItemCell:itemOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  if not self._templateData then
    return
  end
  if self._clickCallback then
    self._clickCallback(self._item_id, go.transform.position)
  end
end

function UIHauteCoutureGetItemCell:FormatItemCount(count)
  local tex = HelperProxy:GetInstance():FormatItemCount(count)
  return tex
end

_class("KLRoleAsset", Object)
KLRoleAsset = KLRoleAsset

function KLRoleAsset:Constructor()
  self.assetid = 0
  self.count = 0
  self.goumai = false
end
