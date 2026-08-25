local UIBasePanel = require("Managers.UI.UIBasePanel")
local UI_Summon_Popup_ShareResource = require("UI.UIPackages.UI_Summon_Popup_ShareResource")
local System = require("System.System")
local TypeRawImage = typeof(CS.UnityEngine.UI.RawImage)
local DT = require("System.DataTable")
local LT = require("System.LangTable")
local DataCenter = require("Data.DataCenter")
local RectTransform = CS.UnityEngine.RectTransform
local EventMgr = require("Managers.EventManager.EventMgr")
local GenderDataUtils = require("Data.GenderDataUtils")
local ShareSummonPanel, Super = System.NewClass("ShareSummonPanel", UIBasePanel)
ShareSummonPanel.uiResCls = UI_Summon_Popup_ShareResource

function ShareSummonPanel:ctor(itemId, tex)
  Super.ctor(self)
  self.itemId = itemId
  self.tex = tex
  self.clickShared = false
end

function ShareSummonPanel:OnBind(binder)
  self.binder = binder
  binder:LoadAllLangFont(self.ui.Text_Player_Name)
  self:ResetScale()
  self:SetTexture()
  self:BindCloseBtn()
  self:BindDownLoadBtn()
  local isJPShareOpen = ZoneFeatureUtils.IsZoneFeatureOpen(cd.ZoneFeature.JPShare)
  self.ui.Btn_Facebook:SetActive(not isJPShareOpen)
  self.ui.Btn_Line:SetActive(not isJPShareOpen)
  self.ui.Btn_Twitter:SetActive(isJPShareOpen)
  if isJPShareOpen then
    self:BindTwitterBtn()
  else
    self:BindLineBtn()
    self:BindFaceBookBtn()
  end
  self:SetVisibleAboutShare()
end

function ShareSummonPanel:SetLangLogo()
  self.ui.Image_Text:SetActive(not Utils.IsLangEN())
  self.ui.Image_Text_EN:SetActive(Utils.IsLangEN())
end

function ShareSummonPanel:SetVisibleAboutShare()
  self:SetLangLogo()
  self.ui.Image_Role:SetActive(false)
  local playerName = DataCenter.playerData.DRole.name
  local uid = DataCenter.playerData.DRole.uid
  local headRes = self:GetHeadRes()
  self.binder:SetImage(self.ui.Image_Awaker_Head, headRes)
  self.binder:SetText(self.ui.Text_Player_Name, playerName)
  self.binder:SetText(self.ui.Text_ID, uid)
end

function ShareSummonPanel:GetHeadRes()
  local avatarItemTid = DataCenter.playerData.DRole.icon
  if avatarItemTid and ItemDataUtils.IsAvatarItem(avatarItemTid) then
    do return ItemDataUtils.GetAvatarIcon end
    return ItemDataUtils.GetAvatarIcon, avatarItemTid
  else
    do return end
    return GenderDataUtils.GetMainHeadRes, avatarItemTid
  end
end

function ShareSummonPanel:ResetScale()
  local bgRectTrans = self.ui.Bg:GetComponent(typeof(RectTransform))
  local sizeDelta = bgRectTrans.sizeDelta
  local ratio = bgRectTrans.rect.width / self.tex.width
  local width = sizeDelta.x
  local height = self.tex.height * ratio
  sizeDelta.x = width
  sizeDelta.y = height
  bgRectTrans.sizeDelta = sizeDelta
end

function ShareSummonPanel:SetTexture()
  local rawImg = self.ui.Image_Screenshot:GetComponent(TypeRawImage)
  rawImg.texture = self.tex
  self.ui.Bg:SetActive(true)
end

function ShareSummonPanel:BindDownLoadBtn()
  self.binder:BindZ1Button(self.ui.Btn_Download, function()
    local SdkMgr = require("Managers.Sdk.SdkMgr")
    SdkMgr.Instance:GetShare():SaveTex_2_PhoneAlbum(self.tex)
  end)
end

function ShareSummonPanel:BindLineBtn()
  self.binder:BindZ1Button(self.ui.Btn_Line, function()
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
  end)
end

function ShareSummonPanel:BindTwitterBtn()
  if not self.ui.Btn_Twitter then
    return
  end
  local publish_region = "JP"
  if "JP" ~= publish_region then
    self.ui.Btn_Twitter:SetActive(false)
    return
  end
  self.ui.Btn_Twitter:SetActive(true)
  self.binder:BindZ1Button(self.ui.Btn_Twitter, function()
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
  end)
end

function ShareSummonPanel:BindFaceBookBtn()
  self.binder:BindZ1Button(self.ui.Btn_Facebook, function()
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
  end)
end

function ShareSummonPanel:BindCloseBtn()
  self.binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
end

function ShareSummonPanel:Close()
  EventMgr.Instance.HideWhenCaptureScreen:Dispatch(true)
  local canReq = not DataCenter.gameData.ShareRewardFinish
  if self.clickShared and canReq then
    local ProtoManager = require("Net.ProtoManager")
    ProtoManager.Instance:ReqServer("SettingRequest", "ReqShareReward", function(_)
      DataCenter.gameData.ShareRewardFinish = true
    end)
  end
  Super.Close(self)
end

return ShareSummonPanel
