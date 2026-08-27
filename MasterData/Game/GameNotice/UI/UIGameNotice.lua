local UIGameNotice = class("UIGameNotice", UIBaseWindow)
local base = UIBaseWindow
local UINGameNoticeType = require("Game.GameNotice.UI.UINGameNoticeType")
local UINGameNoticeTag = require("Game.GameNotice.UI.UINGameNoticeTag")
local UINGameNoticeBannerItem = require("Game.GameNotice.UI.UINGameNoticeBannerItem")
local UINWebViewItem = require("Game.GameNotice.UI.UINWebViewItem")
local GameNoticEnum = require("Game.GameNotice.GameNoticEnum")
local JumpManager = require("Game.Jump.JumpManager")

function UIGameNotice:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnGameNoticeClose)
  self.typeList = {
    GameNoticEnum.eNoticType.system,
    GameNoticEnum.eNoticType.activity
  }
  self.typeItemDic = {}
  self._onTypeItemClick = BindCallback(self, self._OnTypeItemClick)
  self._onTagItemClick = BindCallback(self, self._OnTagItemClick)
  self._onTagItemPool = UIItemPool.New(UINGameNoticeTag, self.ui.obj_noticeItem)
  self.ui.obj_noticeItem:SetActive(false)
  self.ui.obj_webViewItem:SetActive(false)
  self._onBannerClick = BindCallback(self, self._OnBannerClick)
  self.UINGNBanner = UINGameNoticeBannerItem.New()
  self.UINGNBanner:Init(self.ui.obj_bannerItem)
  self.UINGNBanner:Hide()
  self.ctrl = ControllerManager:GetController(ControllerTypeId.GameNotice, true)
  self._onLogout = BindCallback(self, self._OnGameNoticeClose)
  MsgCenter:AddListener(eMsgEventId.OnLogout, self._onLogout)
end

function UIGameNotice:InitUIGameNotice(ShowErrorTips)
  self.ctrl:LoadGameNoticeDatas(function(isDone)
    if isDone and self.ctrl:HasNoticData() then
      NoticeManager:PuaseShowNotice("UIGameNotice")
      self:RefreshGameNotic(true)
    else
      if ShowErrorTips then
        CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(10012))
      end
      if self.closeCallback ~= nil then
        self.closeCallback()
      end
    end
  end)
  self:Hide()
end

function UIGameNotice:RefreshGameNotic(dataIsDone)
  if not dataIsDone then
    return
  end
  self.ctrl:SaveTimestamp()
  self:Show()
  self:RefreshUIGameNotice()
end

function UIGameNotice:RefreshUIGameNotice()
  self:RefreshGNTypeUI()
end

function UIGameNotice:RefreshGNTypeUI()
  for index, typeId in ipairs(self.typeList) do
    local typeItem = UINGameNoticeType.New()
    local go = self.ui.typeArr[index]
    typeItem:Init(go)
    typeItem:InitGameNoticType(typeId, self._onTypeItemClick)
    self.typeItemDic[typeId] = typeItem
  end
  local typeID = self.ctrl:GetNewGNType()
  self.typeItemDic[typeID]:SetNoticeTypeIsOn(true)
end

function UIGameNotice:_OnTypeItemClick(typeId)
  if self.typeId == typeId then
    return
  end
  self:RefresGNTogUI(nil)
  self:DestoryUniWebItem()
  self.UINGNBanner:Hide()
  self.typeId = typeId
  self.tagIdx = nil
  if self.ctrl:HasGameNoticData(typeId) then
    local tagIdx = self.ctrl:GetNewGNDataIndex(typeId) or 1
    self:RefresGNTogUI(tagIdx)
  else
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(10012))
  end
end

function UIGameNotice:RefresGNTogUI(tagIdx)
  local noticDataList = self.ctrl:GetNoticDataList(self.typeId)
  self._onTagItemPool:HideAll()
  self.tagItemDic = {}
  if tagIdx == nil then
    return
  end
  for index, gameNoticData in ipairs(noticDataList) do
    local item = self._onTagItemPool:GetOne()
    item:RefreshGameNoticeTag(index, gameNoticData, self._onTagItemClick)
    self.tagItemDic[index] = item
  end
  self.tagItemDic[tagIdx]:SetNoticeTagIsOn(true)
end

function UIGameNotice:_OnTagItemClick(tagIdx)
  if self.tagIdx == tagIdx then
    return
  end
  self.tagIdx = tagIdx
  self.ctrl:SetGameNoticeIsRead(self.typeId, tagIdx)
  self:RefreshGNDetailViewUI(self.typeId, tagIdx)
end

function UIGameNotice:RefreshGNDetailViewUI(typeId, tagIdx)
  local gameNoticData = self.ctrl:GetNoticData(typeId, tagIdx)
  if gameNoticData == nil then
    return
  end
  if gameNoticData.template == GameNoticEnum.eTemplates.banner then
    self:DestoryUniWebItem()
    self.UINGNBanner:UpdateGNBanner(gameNoticData, self._onBannerClick)
    return
  end
  if gameNoticData.template == GameNoticEnum.eTemplates.html then
    self.UINGNBanner:Hide()
    local encryptUrl = self.ctrl:GetEncryptHtmlUrl(gameNoticData.idx)
    if encryptUrl ~= nil then
      self:CreateUniWebItem(encryptUrl, true)
    end
    return
  end
end

function UIGameNotice:CreateUniWebItem(url, hasFade)
  self:DestoryUniWebItem()
  local uniWebItem = UINWebViewItem.New()
  local go = self.ui.obj_webViewItem:Instantiate()
  go:SetActive(true)
  uniWebItem:Init(go)
  uniWebItem:LoadWebViewByUrl(url, hasFade)
  self.uniWebItem = uniWebItem
end

function UIGameNotice:DestoryUniWebItem(clearCache)
  if self.uniWebItem ~= nil and not IsNull(self.uniWebItem.gameObject) then
    if clearCache then
      self.uniWebItem:ClearCache()
    end
    DestroyUnityObject(self.uniWebItem.gameObject)
    self.uniWebItem = nil
  end
end

function UIGameNotice:_OnBannerClick(gameNoticeData)
  if gameNoticeData:IsJumpOuter() then
    if self.__OnOpenUrl == nil then
      self.__OnOpenUrl = BindCallback(self, self.OnOpenUrl)
    end
    self.jumpUrl = gameNoticeData:GetJumpUrl()
    CS.MessageCommon.ShowMessageBox(ConfigData:GetTipContent(TipContent.bannerJumpMention), ConfigData:GetTipContent(TipContent.commonConfirm), ConfigData:GetTipContent(TipContent.commonCancle), self.__OnOpenUrl, nil)
    return
  end
  if not gameNoticeData:IsJumpInner() then
    return
  end
  local targetID = gameNoticeData:GetJumpID()
  local jumpArgs = gameNoticeData:GetJumpArgs()
  local bool, num = JumpManager:ValidateJump(targetID, jumpArgs)
  if not bool then
    return
  end
  JumpManager:Jump(targetID, nil, nil, jumpArgs)
  self:_OnGameNoticeClose(true)
end

function UIGameNotice:OnOpenUrl()
  CS.UnityEngine.Application.OpenURL(self.jumpUrl)
end

function UIGameNotice:_OnGameNoticeClose(notRunNext)
  if self.closeCallback ~= nil then
    self.closeCallback(nil, notRunNext)
  end
  self:Delete()
end

function UIGameNotice:SetCloseCallback(callback)
  self.closeCallback = callback
end

function UIGameNotice:OnDelete()
  self.ctrl:SaveModelData()
  if self.typeItemDic ~= nil then
    for k, v in pairs(self.typeItemDic) do
      v:Delete()
    end
    self.typeItemDic = nil
  end
  self._onTagItemPool:DeleteAll()
  self:DestoryUniWebItem(true)
  self.UINGNBanner:Delete()
  self.closeCallback = nil
  MsgCenter:RemoveListener(eMsgEventId.OnLogout, self._onLogout)
  NoticeManager:ContinueShowNotice("UIGameNotice")
  base.OnDelete(self)
end

return UIGameNotice
