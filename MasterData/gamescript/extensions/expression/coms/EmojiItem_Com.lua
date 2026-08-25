local EmojiItem_Com, Super = NewViewComponent("EmojiItem_Com")

function EmojiItem_Com:ctor(uiNode, view, data, uiResource)
  Super.ctor(self, uiNode, view)
  self.ui = uiResource(uiNode)
  self.data = data
end

function EmojiItem_Com:RegisterNotifications()
end

function EmojiItem_Com:OnEnterComponent()
  self:UpdateShow()
  self:UpdateRed()
end

function EmojiItem_Com:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, function()
    if self.data.clickCB then
      local iconId = self.data.iconId
      self.data.clickCB(iconId)
    end
  end)
end

function EmojiItem_Com:UpdateRed()
  self:AddViewComponentOnce(self.ui.Com_RedDot_Daily, UICompRedDot, nil, nil, function()
    if self.data.uid ~= nil then
      do return RedPointDataUtils.IsEmojiNew end
      return RedPointDataUtils.IsEmojiNew, self.data.uid
    else
      return false
    end
  end)
end

function EmojiItem_Com:UpdateShow()
  self:UpdateGray()
  self:UpdateSelected()
  self:UpdateIcon()
  self:UpdateEmojiName()
  self:UpdateSelecting()
end

function EmojiItem_Com:UpdateSelected()
  self.ui.Image_Quantity:SetActive(self.data.selected == true)
end

function EmojiItem_Com:UpdateSelecting()
  self.ui.Image_Choose:SetActive(self.data.selecting == true)
end

function EmojiItem_Com:UpdateGray()
  self.ui.Image_Ash:SetActive(false)
  local curTime = TimeUtils.GetServerTime()
  local showGray = self.data.showGray
  if showGray then
    local inCD = EmojiController.Instance:ShowEmojiInCD()
    if inCD then
      local grayEndTime = EmojiModel.Instance:GetLastReqShowTime()
      local duration = grayEndTime - curTime
      self:BindTimer(duration, 0, nil, function()
        self.ui.Image_Ash:SetActive(false)
      end)
    end
    self.ui.Image_Ash:SetActive(inCD)
  end
end

function EmojiItem_Com:UpdateIcon()
  self.ui.Image_Bg:SetActive(false)
  local itemCfg = DT.Item[self.data.iconId]
  if itemCfg then
    self:SetImage(self.ui.Image_Icon, itemCfg.Icon)
  end
  self.ui.Image_Bg:SetActive(nil ~= itemCfg)
  self.ui.Image_Icon:SetActive(nil ~= itemCfg)
end

function EmojiItem_Com:UpdateEmojiName()
  if not self.ui.Text_Name then
    return
  end
  local itemCfg = DT.Item[self.data.iconId]
  self:SetText(self.ui.Text_Name, itemCfg and itemCfg.EmojiName or "")
end

return EmojiItem_Com
