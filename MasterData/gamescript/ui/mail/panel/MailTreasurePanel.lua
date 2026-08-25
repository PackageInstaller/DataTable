local TYPEOF_Image = typeof(CS.UnityEngine.UI.Image)
local MailTreasurePanel, Super = System.NewClass("MailTreasurePanel", UIBasePanel)
MailTreasurePanel.uiResCls = UI_Pocket_MailResource

function MailTreasurePanel:ctor(model)
  Super.ctor(self)
  self.mailModel = model
  self._cacheTextObjMap = {}
  self._cacheImgObjMap = {}
end

function MailTreasurePanel:OnBind(binder)
  self.binder = binder
  local mailModel = self.mailModel
  local commonPopupConfirmTipsData = {
    textTitleCN = LT.Text("Mail_Treasures"),
    sizeType = CommonDefine.PopupTipsType.L,
    clickFunc = System.fn(self, self.Close)
  }
  self.binder:BindComponent(CommonPopupTips(self.ui.UI_Common_Popup_Tips_L, commonPopupConfirmTipsData))
  binder:BindButtonClick(self.ui.Btn_Close, System.fn(self, self.Close))
  if not self.mailModel then
    Logger.Warn("未传入参数: model, 界面异常")
  end
  binder:BindToVisible(self.ui.root, function()
    return self.mailModel ~= nil and #self.mailModel.treasureMailList > 0
  end)
  binder:BindToVisible(self.ui.Group_Null, function()
    return self.mailModel == nil or #self.mailModel.treasureMailList <= 0
  end)
  binder:BindToVisible(self.ui.Btn_Delete, function()
    return self.mailModel and self.mailModel:CheckTreasureChosenEmpty()
  end)
  binder:BindToVisible(self.ui.Group_Letter_Content, function()
    return self.mailModel and self.mailModel:CheckTreasureChosenEmpty()
  end)
  binder:BindButtonClick(self.ui.Btn_Delete, function()
    if not self.mailModel then
      return
    end
    if not self.mailModel:CheckTreasureChosenEmpty() then
      return
    end
    local uid = self.mailModel.selectTreasureMailUid
    
    local function func()
      self.mailModel:ReqDeleteMail(uid, self.mailModel.selectTreasureMailIndex, System.fn(self, self._ShowRemoveMailAnim))
    end
    
    Alert.Show(20064, nil, func)
  end)
  binder:BindToText(self.ui.Text_Introduce, function()
    if not self.mailModel then
      return
    end
    if not self.mailModel:CheckTreasureChosenEmpty() then
      return ""
    end
    local title = self.mailModel:GetMailTitle(self.mailModel.selectTreasureMailUid)
    return title
  end)
  binder:BindToText(self.ui.Text_Info, function()
    if not self.mailModel then
      return
    end
    if not self.mailModel:CheckTreasureChosenEmpty() then
      return ""
    end
    local info = self.mailModel:GetPublisher(self.mailModel.selectTreasureMailUid)
    return info
  end)
  binder:BindToText(self.ui.Text_TimeInfo, function()
    if not self.mailModel then
      return
    end
    if not self.mailModel:CheckTreasureChosenEmpty() then
      return ""
    end
    local timeText = self.mailModel:GetTimeInfoText(self.mailModel.selectTreasureMailUid)
    do return LT.Textf, "Mail_SendTime" end
    return LT.Textf, "Mail_SendTime", timeText
  end)
  binder:BindToRaw(function(cbinder, content)
    if not content then
      return
    end
    local contentHeight = 0
    local useTextObjCount = 0
    local useImgObjCount = 0
    local contentWidth = self.ui.Content.gameObject.transform.sizeDelta.x
    self:_FreeAllObj()
    for idx, detailContent in ipairs(content) do
      local detailObj
      local height = 0
      if detailContent[1] then
        detailObj = self:_GetFreeTextObj()
        if not detailObj then
          detailObj = GameObject.Instantiate(self.ui.Text_Detailed.gameObject, self.ui.Content.transform)
          self.binder:LoadAllLangFont(detailObj)
          self._cacheTextObjMap[detailObj] = false
        end
        self.binder:SetText(detailObj, detailContent[2], nil, function(linkText)
          local linkInfo = StrUtils.GetLinkInfo(linkText)
          print("mail link", linkText, table.tostring(linkInfo))
          if linkInfo.cfgName == "Survey" then
            local mail = mailModel:GetMail(mailModel.selectMailUid)
            mailModel:ReqShowSurvey(mail)
            return
          end
          local url = linkInfo and linkInfo.showContent
          if not url or "" == url then
            return
          end
          CS.UnityEngine.Application.OpenURL(url)
        end)
        self.binder:LoadAllLangFont(self.ui.Text_Detailed)
        self.binder:SetText(self.ui.Text_Detailed, detailContent[2])
        height = StrUtils.SetPreferredHeight(self.ui.Text_Detailed) + 30
        useTextObjCount = useTextObjCount + 1
        CS.Framework.TransformUtil.SetAnchoredPos(detailObj.transform, 0, contentHeight * -1)
      else
        detailObj = self:_GetFreeImgObj()
        if not detailObj then
          detailObj = GameObject.Instantiate(self.ui.Image_Detailed.gameObject, self.ui.Content.transform)
          self._cacheImgObjMap[detailObj] = false
        end
        self.binder:SetImageSync(detailObj, detailContent[2])
        local detailSprite = detailObj:GetComponent(TYPEOF_Image).sprite
        if detailSprite then
          local aspectRatio = detailSprite.rect.width / detailSprite.rect.height
          local targetWidth = math.min(contentWidth, detailSprite.rect.width)
          height = targetWidth / aspectRatio
          useImgObjCount = useImgObjCount + 1
        end
        CS.Framework.TransformUtil.SetAnchoredPos(detailObj.transform, contentWidth / 2, contentHeight * -1)
      end
      contentHeight = contentHeight + height
      detailObj:SetActive(true)
      detailObj.transform.sizeDelta = CS.UnityEngine.Vector2(contentWidth, height)
      detailObj.transform:SetAsLastSibling()
    end
    local viewSizeDelta = self.ui.Content.transform.sizeDelta
    self.ui.Content.transform.sizeDelta = CS.UnityEngine.Vector2(viewSizeDelta.x, contentHeight)
  end, function()
    do return mailModel.ParseMailText, mailModel end
    return mailModel.ParseMailText, mailModel, mailModel.selectTreasureMailUid
  end, true)
  binder:BindToCircularListView(self.ui.ScrollView_Mail, function()
    if not self.mailModel then
      return {}
    end
    if self.mailModel.treasureNeedSort then
      self.mailModel:SortTreasureMailList()
      self.mailModel:SetTreasureNeedSort(false)
    end
    return self.mailModel.treasureMailList
  end, function(cb, obj, index)
    if not self.mailModel then
      return
    end
    local data = self.mailModel.treasureMailList[index]
    
    local function OnClick(uid)
      if uid == self.mailModel.selectTreasureMailUid then
        return
      end
      
      local function callback()
        self.mailModel:SetSelectTreasureMailUid(uid)
        self.mailModel:SetSelectTreasureMailIndex(index)
      end
      
      self.mailModel:ReqReadMail(uid, callback, true)
    end
    
    local function OnSelect()
      return self.mailModel and data.mailUid == self.mailModel.selectTreasureMailUid
    end
    
    cb:BindComponent(MailListItem(obj, Btn_Pocket_Mail_ItemResource, data, self.mailModel, OnClick, OnSelect))
  end)
  local itemModel = binder:createModel(CommonIconItemModel)
  local itemDetailTipsModel = binder:createModel(CommonItemDetailTipsModel)
  
  local function OnClickItem(tid, uid)
    if not uid then
      return
    end
    itemModel:SetChosenItemUid(uid)
    itemDetailTipsModel:SetChosenItemUid(uid)
    itemDetailTipsModel:SetIsPreview(nil ~= uid)
    ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode.transform.parent.gameObject, nil, tid)
  end
  
  local attachments = {}
  binder:BindToCircularListView(self.ui.ScrollView_Goods, function()
    if not self.mailModel then
      return
    end
    if not self.mailModel:CheckTreasureChosenEmpty() then
      return {}
    end
    local uid = self.mailModel.selectTreasureMailUid
    attachments = self.mailModel:GetAttachments(uid) or {}
    self.mailModel:UpdateMailAttachments(uid, attachments)
    OnClickItem(nil, 0)
    itemModel:SetItemDataMap(attachments)
    itemDetailTipsModel:SetItemDataMap(attachments)
    return attachments
  end, function(cb, obj, index)
    local data = attachments[index]
    
    local function ShowReceived()
      return data.received
    end
    
    local itemData = {
      tid = data.tid,
      uid = data.uid,
      model = itemModel,
      callback = OnClickItem,
      showReceivedFunc = ShowReceived
    }
    cb:BindComponent(CommonIconItem(obj, itemData))
  end)
  binder:BindToVisible(self.ui.UI_Common_Item_Detail, function()
    return false
  end)
  binder:BindToVisible(self.ui.Btn_Tip_Mask, function()
    return itemDetailTipsModel.chosenUid > 0
  end)
  binder:BindButtonClick(self.ui.Btn_Tip_Mask, function()
    OnClickItem(nil, 0)
  end)
  self.binder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView_Mail)
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:Close()
  end)
end

function MailTreasurePanel:_ShowRemoveMailAnim(mail, index)
  if not (mail and index) or not self.binder then
    return
  end
  
  local function OnAnimCallback()
    self.mailModel:SetSelectTreasureMailUid()
    self.mailModel:SetSelectTreasureMailIndex()
    self.mailModel:OnDeleteMailSuccess(mail)
    if #self.mailModel.treasureMailList <= 0 then
      self:Close()
    end
  end
  
  self.binder:CircularRemoveItemWithAnim(self.ui.ScrollView_Mail, index, OnAnimCallback)
end

function MailTreasurePanel:_FreeAllObj()
  for obj, _ in pairs(self._cacheTextObjMap) do
    obj:SetActive(false)
    self._cacheTextObjMap[obj] = true
  end
  for obj, _ in pairs(self._cacheImgObjMap) do
    obj:SetActive(false)
    self._cacheImgObjMap[obj] = true
  end
end

function MailTreasurePanel:_GetFreeTextObj()
  for obj, isFree in pairs(self._cacheTextObjMap) do
    if isFree then
      self._cacheTextObjMap[obj] = false
      return obj
    end
  end
  return nil
end

function MailTreasurePanel:_GetFreeImgObj()
  for obj, isFree in pairs(self._cacheImgObjMap) do
    if isFree then
      self._cacheImgObjMap[obj] = false
      return obj
    end
  end
  return nil
end

function MailTreasurePanel:Close()
  self.mailModel:SetSelectTreasureMailUid()
  self.mailModel:SetSelectTreasureMailIndex()
  Super.Close(self)
  self.mailModel = nil
end

return MailTreasurePanel
