local UIBasePanel = require("Managers.UI.UIBasePanel")
local UI_Summon_Popup_ShareResource = require("UI.UIPackages.UI_Summon_Popup_ShareResource")
local System = require("System.System")
local TypeRawImage = typeof(CS.UnityEngine.UI.RawImage)
local DT = require("System.DataTable")
local LT = require("System.LangTable")
local DataCenter = require("Data.DataCenter")
local RectTransform = CS.UnityEngine.RectTransform
local Logger = require("Utility.Logger")
local EventMgr = require("Managers.EventManager.EventMgr")
local GenderDataUtils = require("Data.GenderDataUtils")
local SocialSharePlayerInfoPanel, Super = System.NewClass("SocialSharePlayerInfoPanel", UIBasePanel)
SocialSharePlayerInfoPanel.uiResCls = UI_Summon_Popup_ShareResource

function SocialSharePlayerInfoPanel:ctor(tex)
  Super.ctor(self)
  self.tex = tex
  self.clickShared = false
end

function SocialSharePlayerInfoPanel:OnBind(binder)
  self.binder = binder
  binder:LoadAllLangFont(self.ui.Text_Player_Name)
  self:ResetScale()
  self:SetTexture()
  self:BindCloseBtn()
  self:BindDownLoadBtn()
  self:BindLineBtn()
  self:BindFaceBookBtn()
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

function SocialSharePlayerInfoPanel:SetVisibleAboutShare()
  self.ui.Image_Role:SetActive(false)
  local playerName = DataCenter.playerData.DRole.name
  local uid = DataCenter.playerData.DRole.uid
  local headRes = GenderDataUtils.GetMainHeadRes()
  self.binder:SetImage(self.ui.Image_Awaker_Head, headRes)
  self.binder:SetText(self.ui.Text_Player_Name, playerName)
  self.binder:SetText(self.ui.Text_ID, uid)
end

function SocialSharePlayerInfoPanel:ResetScale()
  local bgRectTrans = self.ui.Bg:GetComponent(typeof(RectTransform))
  local sizeDelta = bgRectTrans.sizeDelta
  local safeArea = CS.UnityEngine.GameObject.Find("UIRoot/SafeArea")
  local rectTrans = safeArea:GetComponent(typeof(CS.UnityEngine.RectTransform))
  local ratio = bgRectTrans.rect.width / self.tex.width
  local width = sizeDelta.x
  local height = self.tex.height * ratio
  sizeDelta.x = width
  sizeDelta.y = height
  bgRectTrans.sizeDelta = sizeDelta
end

function SocialSharePlayerInfoPanel:SetTexture()
  local rawImg = self.ui.Image_Screenshot:GetComponent(TypeRawImage)
  rawImg.texture = self.tex
  self.ui.Bg:SetActive(true)
end

function SocialSharePlayerInfoPanel:BindDownLoadBtn()
  self.binder:BindZ1Button(self.ui.Btn_Download, function()
    local SdkMgr = require("Managers.Sdk.SdkMgr")
    SdkMgr.Instance:GetShare():SaveTex_2_PhoneAlbum(self.tex)
  end)
end

function SocialSharePlayerInfoPanel:BindLineBtn()
  self.binder:BindZ1Button(self.ui.Btn_Line, function()
    self.clickShared = true
    local message = ""
    local SdkMgr = require("Managers.Sdk.SdkMgr")
    local result = SdkMgr.Instance:GetShare():ShareLine(message, self.tex)
    if false == result then
      self.clickShared = false
    else
      self:Close()
    end
  end)
end

function SocialSharePlayerInfoPanel:BindFaceBookBtn()
  self.binder:BindZ1Button(self.ui.Btn_Facebook, function()
    self.clickShared = true
    local message = ""
    local SdkMgr = require("Managers.Sdk.SdkMgr")
    local result = SdkMgr.Instance:GetShare():ShareFaceBook(message, self.tex)
    if false == result then
      self.clickShared = false
    else
      self:Close()
    end
  end)
end

function SocialSharePlayerInfoPanel:BindCloseBtn()
  self.binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
end

function SocialSharePlayerInfoPanel:Close()
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

return SocialSharePlayerInfoPanel
