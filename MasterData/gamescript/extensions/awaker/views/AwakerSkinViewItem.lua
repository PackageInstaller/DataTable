local AwakerSkinViewItem, Super = NewViewComponent("AwakerSkinViewItem")

function AwakerSkinViewItem:ctor(uiNode, view, awakerTid, skinTid, isBuy, isMyAwaker)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Awaker_Item_SkinResource(uiNode)
  self.awakerTid = awakerTid
  self.skinTid = skinTid
  self.isBuy = isBuy
  self.isMyAwaker = isMyAwaker
end

function AwakerSkinViewItem:OnBuildComponent()
  self:AddButtonClickListener(self.ui.Btn_Skin_Click, System.fn(self, self._OnClick))
end

function AwakerSkinViewItem:RegisterNotifications()
end

function AwakerSkinViewItem:RegisterEvents()
end

function AwakerSkinViewItem:OnEnterComponent()
  self:SetText(self.ui.Text_AwakerSkinName, AwakerSkinUtils.GetSkinName(self.skinTid))
  self:SetFullHead()
  self:_RefreshSkinQuality()
  self:AddViewComponentOnce(self.ui.Image_RedDot, UICompRedDot, CommonDefine.RedDotType.TextNew, nil, function()
    if self.isBuy then
      return false
    end
    if not self.isMyAwaker then
      return false
    end
    if AwakerSkinUtils.IsNewSkin(self.skinTid) then
      return RedPointDataUtils.RedAttrType.IsNew
    end
    return false
  end)
end

function AwakerSkinViewItem:_RefreshSkinQuality()
  self:SetActive(self.ui.Image_SkinQuality, true)
  AwakerUiUtils.RefreshAwakerSkinStarGroup(self, self.binder, self.skinTid)
  self:SetImage(self.ui.Image_Quality, AwakerSkinCfgUtils.GetSkinQualityImage(self.skinTid))
  self:SetImage(self.ui.Image_SkinQuality, AwakerSkinCfgUtils.GetSkinQualityBottomImage(self.skinTid))
end

function AwakerSkinViewItem:SetFullHead()
  if self.skinTid == CommonDefine.DefaultSkinTid then
    local fullHead = AwakerSkinUtils.GetAwakerDefaultFullHeadImg(self.awakerTid)
    self:SetImage(self.ui.Image_AwakerSkin, fullHead)
  else
    local fullHead = AwakerSkinUtils.GetSkinFullHeadImg(self.skinTid)
    self:SetImage(self.ui.Image_AwakerSkin, fullHead)
  end
end

function AwakerSkinViewItem:OnExitView()
  Super.OnExitView(self)
end

function AwakerSkinViewItem:_OnClick()
  Logger.Debug("[AwakerSkinViewItem] _OnClick, skinTid=%s", self.skinTid)
  self:Notify(NotifyId.OnAwakerSkinClick, self.skinTid)
  if not self.isBuy and AwakerSkinUtils.IsNewSkin(self.skinTid) then
    AwakerSkinUtils.ClearNewSkinTag(self.skinTid)
  end
end

return AwakerSkinViewItem
