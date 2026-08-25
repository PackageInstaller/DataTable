local CommonHeadItem, Super = System.NewComponent("CommonHeadItem")

function CommonHeadItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Common_HeadResource(uiNode)
  self.redFunc = data.redFunc
  self.clickCb = data.clickCb
  self.headIcon = data.headIcon
  self.frameIcon = data.frameIcon
  self.hideHead = data.hideHead
  self.hideFrame = data.hideFrame
  self.refreshOnDay = data.refreshOnDay
end

function CommonHeadItem:OnBind(binder)
  self.binder = binder
  binder:BindEvent(EventMgr.Instance.OnGenderChange, System.fn(self, self._OnGenderChange))
  binder:BindEvent(EventMgr.Instance.SocialSetAvatar, System.fn(self, self._RefreshWhenAvatarChanged))
  binder:BindEvent(EventMgr.Instance.SocialSetAvatarFrame, System.fn(self, self._RefreshWhenAvatarFrameChanged))
  if self.refreshOnDay then
    self:_OnCheckIsInAprileFool(binder)
  end
  binder:SetImage(self.ui.Image_Awaker_Head, self.headIcon or PlayerDataUtils.GetRoleHeadImg())
  binder:SetImage(self.ui.UI_Common_HeadFrame, self.frameIcon or PlayerDataUtils.GetRoleHeadFrameImg())
  self.ui.Image_Awaker_Head:SetActive(not self.hideHead)
  self.ui.UI_Common_HeadFrame:SetActive(not self.hideFrame)
  if self.clickCb then
    binder:BindButtonClick(self.ui.Btn_Click, self.clickCb)
  end
  if self.redFunc then
    binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, nil, nil, self.redFunc))
  end
end

function CommonHeadItem:_OnCheckIsInAprileFool(binder)
  local isInAprileFool = PlayerDataUtils.IsInAprileFool()
  binder:BindEvent(EventMgr.Instance.OnDayRefresh, System.fn(self, self._OnDayRefresh))
  binder:BindTimer(1, -1, function()
    local inAprileFool = PlayerDataUtils.IsInAprileFool()
    if isInAprileFool ~= inAprileFool then
      isInAprileFool = inAprileFool
      self:_OnDayRefresh()
    end
  end)
end

function CommonHeadItem:_OnGenderChange()
  local targetHeadImg = self.headIcon or PlayerDataUtils.GetRoleHeadImg()
  local genderHeadImgList = GenderDataUtils.GetAvatarResList()
  if table.contains(genderHeadImgList, targetHeadImg) then
    self.binder:SetImage(self.ui.Image_Awaker_Head, GenderDataUtils.GetMainCharacterAvatarRes())
  end
end

function CommonHeadItem:_RefreshWhenAvatarChanged(newItemTid)
  if self.headIcon ~= nil then
    return
  end
  self.binder:SetImage(self.ui.Image_Awaker_Head, ItemDataUtils.GetAvatarIcon(newItemTid))
end

function CommonHeadItem:_RefreshWhenAvatarFrameChanged(newItemTid)
  if self.frameIcon ~= nil then
    return
  end
  self.binder:SetImage(self.ui.UI_Common_HeadFrame, ItemDataUtils.GetItemIcon(newItemTid))
end

function CommonHeadItem:_OnDayRefresh()
  if self.headIcon == nil then
    self.binder:SetImage(self.ui.Image_Awaker_Head, PlayerDataUtils.GetRoleHeadImg())
  end
  if nil == self.frameIcon then
    self.binder:SetImage(self.ui.UI_Common_HeadFrame, PlayerDataUtils.GetRoleHeadFrameImg())
  end
end

return CommonHeadItem
