_class("UIResAward", UICustomWidget)
UIResAward = UIResAward

function UIResAward:OnShow()
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.ResInstance, UIItemScale.Level2)
  self.uiItem:SetClickCallBack(function()
    self:bgOnClick()
  end)
  self._trans = self:GetGameObject()
  self._resModule = self:GetModule(ResDungeonModule)
  self:AttachEvent(GameEventType.ChangeResDouble, self.OnChangeResDouble)
end

function UIResAward:OnHide()
  self:DetachEvent(GameEventType.ChangeResDouble, self.OnChangeResDouble)
end

function UIResAward:OnChangeResDouble(double)
  if double then
    self.uiItem:SetData({showRes = true})
  else
    self.uiItem:SetData({showRes = false})
  end
end

function UIResAward:Flush(v)
  if not v then
    return
  end
  self._v = v
  local icon = v.icon
  local quality = v.color
  local double = self._resModule:IsOpenDoubleRes()
  local itemId = v.id
  local awardType = v.type
  local activityText = ""
  if awardType == StageAwardType.Activity then
    activityText = "str_item_xianshi"
  end
  self.uiItem:SetData({
    icon = icon,
    quality = quality,
    showRes = double,
    itemId = itemId,
    topText = UIEnum.ItemRandomStr(v.randomType),
    activityText = StringTable.Get(activityText)
  })
end

function UIResAward:bgOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  if self._v then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowItemTips, self._v.id, self._trans.transform.position)
  end
end
