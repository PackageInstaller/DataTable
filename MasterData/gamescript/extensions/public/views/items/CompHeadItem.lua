local CompHeadItem, Super = NewViewComponent("CompHeadItem")

function CompHeadItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_HeadResource(uiNode)
  self.redFunc = data.redFunc
  self.clickCb = data.clickCb
  self.headIcon = data.headIcon
  self.frameIcon = data.frameIcon
  self.hideHead = data.hideHead
  self.hideFrame = data.hideFrame
end

function CompHeadItem:RegisterEvents()
  self:BindEvent(EventMgr.Instance.SocialSetAvatar, System.fn(self, self._RefreshWhenAvatarChanged))
  self:BindEvent(EventMgr.Instance.SocialSetAvatarFrame, System.fn(self, self._RefreshWhenAvatarFrameChanged))
end

function CompHeadItem:OnEnterComponent()
  self:SetImage(self.ui.Image_Awaker_Head, self.headIcon or PlayerDataUtils.GetRoleHeadImg())
  self:SetImage(self.ui.UI_Common_HeadFrame, self.frameIcon or PlayerDataUtils.GetRoleHeadFrameImg())
  self.ui.Image_Awaker_Head:SetActive(not self.hideHead)
  self.ui.UI_Common_HeadFrame:SetActive(not self.hideFrame)
  if self.clickCb then
    self:AddButtonClickListener(self.ui.Btn_Click, self.clickCb)
  end
  if self.redFunc then
    self:AddViewComponentOnce(self.ui.Com_RedDot, UICompRedDot, nil, nil, self.redFunc)
  end
end

function CompHeadItem:_RefreshWhenAvatarChanged(newItemTid)
  self:SetImage(self.ui.Image_Awaker_Head, ItemDataUtils.GetAvatarIcon(newItemTid))
end

function CompHeadItem:_RefreshWhenAvatarFrameChanged(newItemTid)
  self:SetImage(self.ui.UI_Common_HeadFrame, ItemDataUtils.GetItemIcon(newItemTid))
end

return CompHeadItem
