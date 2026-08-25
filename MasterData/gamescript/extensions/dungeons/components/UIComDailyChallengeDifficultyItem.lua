local UIComDailyChallengeDifficultyItem, Super = NewViewComponent("UIComDailyChallengeDifficultyItem")

function UIComDailyChallengeDifficultyItem:ctor(uiNode, view, index, info, selectCB)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeons_Item_Common_ElementResource(uiNode)
  self.index = index
  self.info = info
  self.selectCB = selectCB
  self.info.unlocked = true
end

function UIComDailyChallengeDifficultyItem:RegisterNotifications()
end

function UIComDailyChallengeDifficultyItem:OnEnterComponent()
  self.ui.Image_D_Icon:SetActive(false)
  self.ui.Image_Mask_Icon:SetActive(false)
  self:UpdateShow()
end

function UIComDailyChallengeDifficultyItem:UpdateShow()
  self:SetText(self.ui.Text_Title, self.info.name)
  self.ui.Text_Desc:SetActive(self.info.unlocked)
  self:SetText(self.ui.Text_Desc, self.info.lvDesc)
  self.ui.Group_Mask:SetActive(not self.info.unlocked)
  self.ui.Text_Tip:SetActive(not self.info.unlocked)
  self:SetText(self.ui.Text_Tip, self.info.unlockDesc)
  local colorType = self.info.unlocked and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark
  self:SetTextColorType(self.ui.Text_Tip, colorType)
  self.ui.Group_Nor:SetActive(self.info.unlocked and not self.info.isCarzy)
  self.ui.Group_Select:SetActive(self.info.curSelectIdx == self.index)
  self.ui.Image_Madness:SetActive(self.info.unlocked and self.info.isCarzy)
end

function UIComDailyChallengeDifficultyItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, function()
    self.selectCB(self.index)
  end)
end

function UIComDailyChallengeDifficultyItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return UIComDailyChallengeDifficultyItem
