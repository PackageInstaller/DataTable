_class("UIAwardItem", UICustomWidget)
UIAwardItem = UIAwardItem

function UIAwardItem:OnShow()
  self._trans = self:GetGameObject()
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Stage, UIItemScale.Level3)
  self.uiItem:SetClickCallBack(function()
    self:bgOnClick()
  end)
end

function UIAwardItem:Flush(v)
  if not v then
    return
  end
  self._v = v
  local icon = v.icon
  local quality = v.color
  local text1 = v.count
  local strKey = ""
  local activityText = ""
  local awardType = v.type
  local itemId = v.id
  if awardType == StageAwardType.First then
    strKey = "str_discovery_first_award"
  elseif awardType == StageAwardType.Star then
    strKey = "str_discovery_3star_award"
  elseif awardType == StageAwardType.Activity then
    strKey = "str_discovery_activity_award"
    activityText = "str_item_xianshi"
  elseif awardType == StageAwardType.HasGen then
    strKey = "str_discovery_already_collect"
  else
    strKey = "str_discovery_normal_award"
  end
  self.uiItem:SetData({
    icon = icon,
    quality = quality,
    text1 = text1,
    awardText = StringTable.Get(strKey),
    itemId = itemId,
    topText = UIEnum.ItemRandomStr(v.randomType),
    activityText = StringTable.Get(activityText)
  })
end

function UIAwardItem:bgOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  if self._v then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowItemTips, self._v.id, self._trans.transform.position)
  end
end
