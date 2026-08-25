local ShareSummonView, Super = NewClass("ShareSummonView", BaseView)
ShareSummonView.uiResCls = UI_Summon_Popup_ShareResource
local RectTransform = CS.UnityEngine.RectTransform

function ShareSummonView:ctor(itemId, tex)
  Super.ctor(self)
  self.itemId = itemId
  self.tex = tex
  self.clickShared = false
  self.isJPShareOpen = ZoneFeatureUtils.IsZoneFeatureOpen(cd.ZoneFeature.JPShare)
end

function ShareSummonView:OnBuildView()
  Super.OnBuildView(self)
end

function ShareSummonView:RegisterNotifications()
  Super.RegisterNotifications(self)
end

function ShareSummonView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Download, System.fn(self, self._OnClickDownLoadBtn))
  if self.isJPShareOpen then
    self:AddButtonClickListener(self.ui.Btn_Twitter, System.fn(self, self._OnClickTwitterBtn))
  else
    self:AddButtonClickListener(self.ui.Btn_Line, System.fn(self, self._OnClickLineBtn))
    self:AddButtonClickListener(self.ui.Btn_Facebook, System.fn(self, self._OnClickFaceBookBtn))
  end
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
end

function ShareSummonView:OnEnterView()
  Super.OnEnterView(self)
  self:LoadAllLangFont(self.ui.Text_Player_Name)
  self:_ResetScale()
  self:_RefreshText()
  self:_RefreshImage()
  self:_RefreshVisible()
end

function ShareSummonView:OnExitView()
  Super.OnExitView(self)
end

function ShareSummonView:_ResetScale()
  local bgRectTrans = self.ui.Bg:GetComponent(typeof(RectTransform))
  local sizeDelta = bgRectTrans.sizeDelta
  local ratio = bgRectTrans.rect.width / self.tex.width
  local width = sizeDelta.x
  local height = self.tex.height * ratio
  sizeDelta.x = width
  sizeDelta.y = height
  bgRectTrans.sizeDelta = sizeDelta
end

function ShareSummonView:_RefreshText()
  local playerName = DataCenter.playerData.DRole.name
  self:SetText(self.ui.Text_Player_Name, playerName)
  local uid = DataCenter.playerData.DRole.uid
  self:SetText(self.ui.Text_ID, uid)
end

function ShareSummonView:_RefreshImage()
  local rawImg = self.ui.Image_Screenshot:GetComponent(typeof(CS.UnityEngine.UI.RawImage))
  rawImg.texture = self.tex
  local headRes = self:_GetHeadRes()
  self:SetImage(self.ui.Image_Awaker_Head, headRes)
end

function ShareSummonView:_RefreshVisible()
  self.ui.Bg:SetActive(true)
  self.ui.Btn_Twitter:SetActive(self.isJPShareOpen)
  self.ui.Btn_Line:SetActive(not self.isJPShareOpen)
  self.ui.Btn_Facebook:SetActive(not self.isJPShareOpen)
  self.ui.Image_Role:SetActive(false)
  local IsLangEN = Utils.IsLangEN()
  self.ui.Image_Text:SetActive(not IsLangEN)
  self.ui.Image_Text_EN:SetActive(IsLangEN)
end

function ShareSummonView:_OnClickDownLoadBtn()
  local SdkMgr = require("Managers.Sdk.SdkMgr")
  SdkMgr.Instance:GetShare():SaveTex_2_PhoneAlbum(self.tex)
end

function ShareSummonView:_OnClickTwitterBtn()
  self.clickShared = true
  local langId = DT.GetConstant("ShareTwitter")
  local itemCfg = DT.Item[self.itemId]
  local message = LT.Textf(langId, LT.Text(itemCfg.Name))
  local SdkMgr = require("Managers.Sdk.SdkMgr")
  local result = SdkMgr.Instance:GetShare():ShareTwitter(message, self.tex)
  if false == result then
    self.clickShared = false
  else
    self:Close()
  end
end

function ShareSummonView:_OnClickLineBtn()
  self.clickShared = true
  local langId = DT.GetConstant("ShareLine")
  local itemCfg = DT.Item[self.itemId]
  local message = LT.Textf(langId, LT.Text(itemCfg.Name))
  local SdkMgr = require("Managers.Sdk.SdkMgr")
  local result = SdkMgr.Instance:GetShare():ShareLine(message, self.tex)
  if false == result then
    self.clickShared = false
  else
    self:Close()
  end
end

function ShareSummonView:_OnClickFaceBookBtn()
  self.clickShared = true
  local langId = DT.GetConstant("ShareFacebook")
  local itemCfg = DT.Item[self.itemId]
  local message = LT.Textf(langId, LT.Text(itemCfg.Name))
  local SdkMgr = require("Managers.Sdk.SdkMgr")
  local result = SdkMgr.Instance:GetShare():ShareFaceBook(message, self.tex)
  if false == result then
    self.clickShared = false
  else
    self:Close()
  end
end

function ShareSummonView:_GetHeadRes()
  local avatarItemTid = DataCenter.playerData.DRole.icon
  if avatarItemTid and ItemDataUtils.IsAvatarItem(avatarItemTid) then
    do return ItemDataUtils.GetAvatarIcon end
    return ItemDataUtils.GetAvatarIcon, avatarItemTid
  else
    do return end
    return GenderDataUtils.GetMainHeadRes, avatarItemTid
  end
end

function ShareSummonView:Close()
  ShareSummonController.Instance:OnCloseShareSummonView(self.clickShared)
  Super.Close(self)
end

return ShareSummonView
