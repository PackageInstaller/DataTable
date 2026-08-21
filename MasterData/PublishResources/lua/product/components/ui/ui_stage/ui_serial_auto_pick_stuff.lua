require("ui_item")
_class("UISerialAutoPickStuff", UIItem)
UISerialAutoPickStuff = UISerialAutoPickStuff

function UISerialAutoPickStuff:Constructor()
  self._uiTips = nil
  self._widgetTips = nil
end

function UISerialAutoPickStuff:OnShow(uiParams)
  UIItem.OnShow(self, uiParams)
  self._aps = GameGlobal.GetModule(SerialAutoFightModule):GetApsData()
end

function UISerialAutoPickStuff:OnHide()
end

function UISerialAutoPickStuff:ColorText(clr, txt)
  return string.format("<color=#%s>%s</color>", clr, txt)
end

function UISerialAutoPickStuff:SetTips(tipsName)
  local uiOwner = self:RootUIOwner()
  self._uiTips = uiOwner:GetUIComponent("UISelectObjectPath", tipsName)
  self._widgetTips = self._uiTips:SpawnObject("UISelectInfo")
  local itemId = self._aps:GetItemID()
  local itemCondition = self._aps:GetItemCondition()
  local roleModule = self:GetModule(RoleModule)
  local count = roleModule:GetAssetCount(itemId)
  count = math.max(0, count)
  local showCount
  if 9999 < count then
    showCount = "9999+"
  else
    showCount = tostring(count)
  end
  local str = ""
  if itemCondition <= count then
    str = str .. self:ColorText("ffd300", showCount)
    str = str .. self:ColorText("ffffff", "/")
    str = str .. self:ColorText("ffd300", tostring(itemCondition))
  else
    str = str .. self:ColorText("ff0000", showCount)
    str = str .. self:ColorText("ffffff", "/")
    str = str .. self:ColorText("ffffff", tostring(itemCondition))
  end
  local cfg = Cfg.cfg_item[itemId]
  local icon = cfg.Icon
  local quality = cfg.Color
  local topText = StringTable.Get("str_battle_set_auto_fight_stat_title")
  self:SetForm(UIItemForm.Stage)
  self:SetData({
    icon = icon,
    quality = quality,
    text1 = str,
    itemId = itemId,
    topText = topText
  })
  self:EnableNode(UIItemNode.Award, false)
  self:SetClickCallBack(function(go)
    self:ShowTipBtnOnClick(go)
  end)
end

function UISerialAutoPickStuff:ShowTipBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  self._widgetTips:SetData(self._aps:GetItemID(), go.transform.position)
end
