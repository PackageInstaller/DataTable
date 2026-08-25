local EmojiShowView, Super = NewClass("EmojiShowView", BaseView)
EmojiShowView.uiResCls = UI_Pvp_Popup_Expression_ChooseResource

function EmojiShowView:ctor(parentNode)
  Super.ctor(self)
  self.parentNode = parentNode
end

function EmojiShowView:OnBuildView()
  local dataList = EmojiController.Instance:GetUsingEmojiList()
  local clickFunc = System.fn(self, self.OnClickItem)
  for i, v in ipairs(dataList) do
    v.clickCB = clickFunc
    v.showGray = true
  end
  self.dataList = dataList
  self.com = self:AddViewComponentOnce(self.ui.uiNode, EmojiShow_Com, dataList)
end

function EmojiShowView:OnClickItem(iconId)
  if 0 == iconId or nil == iconId then
    return
  end
  if EmojiController.Instance:ShowEmojiInCD() == false then
    EmojiController.Instance:ReqShowPVPEmoji(iconId)
    self:Close()
  else
    Alert.Show(10840)
    return
  end
end

function EmojiShowView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnSendEmoji, self.UpdateShow, self)
end

function EmojiShowView:UpdateShow()
  self.com:UpdateShow()
end

function EmojiShowView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
end

function EmojiShowView:OnEnterView()
  Super.OnEnterView(self)
  self.ui.Image_Bg.transform.position = self.parentNode.transform.position
  local pos = self.ui.Image_Bg.transform.anchoredPosition
  pos.x = pos.x - 50
  pos.y = pos.y + 80
  self.ui.Image_Bg.transform.anchoredPosition = pos
end

function EmojiShowView:OnExitView()
  Super.OnExitView(self)
end

return EmojiShowView
