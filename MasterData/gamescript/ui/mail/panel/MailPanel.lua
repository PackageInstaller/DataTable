local UIAnimationController = CS.Z1Client.UIAnimationController
local typeof = _ENV.typeof
local AddClipToPlay = AnimatorUtils.AddClipToPlay
local TYPEOF_Image = typeof(CS.UnityEngine.UI.Image)
local MailPanel, Super = System.NewClass("MailPanel", UIBasePanel)
MailPanel.uiResCls = UI_MailResource

function MailPanel:ctor()
  Super.ctor(self)
  self.showCollectAnim = Vue.ref(false)
  self._cacheTextObjMap = {}
  self._cacheImgObjMap = {}
end

local mailModel

function MailPanel:OnBind(binder)
  self.binder = binder
  AudioManager.Instance:PostSoundEvent("SET_STATE_A_INTERFACE_MAILBOX")
  local collectUIAnimController = self.ui.UI_Mail_Effect_Email01:GetComponent(typeof(UIAnimationController))
  self.scrollrect_mail = self.ui.ScrollView_Mail:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
  binder:SetActive(self.ui.ScrollView_Mail, true)
  if self.scrollrect_mail then
    self.scrollrect_mail.enabled = true
  end
  mailModel = binder:createModel(MailModel)
  self:ReqMailData(mailModel)
  self:_CheckTreasureRed()
  binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    self:Close()
  end))
  binder:BindEvent(EventMgr.Instance.OnMailSyncEvent, System.fn(self, self._OnSyncMails))
  binder:BindEvent(EventMgr.Instance.CommonRewardPanelClose, function(source)
    if "Mail" ~= source then
      return
    end
    if not mailModel.showGetCollectMailAnim then
      return
    end
    self:PlayAnim(collectUIAnimController, "UI_Mail_Effect_Email01")
    mailModel:SetShowCollectMailAnim(false)
  end)
  binder:BindButtonClick(self.ui.Btn_Mail, function()
    MailDataUtils.OpenMailIntroPanel()
  end)
  binder:BindButtonClick(self.ui.Btn_Collection, function()
    MailDataUtils.OpenMailTreasurePanel(mailModel)
    mailModel:SetTreasureRedState(MailDataUtils.TreasureRedState.NotRed)
    RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.TreasureMail, RedPointDataUtils.RedAttrType.Red)
  end)
  binder:BindButtonClick(self.ui.Btn_Litter, function()
    if not mailModel:CheckChosenEmpty() then
      return
    end
    local uid = mailModel.selectMailUid
    if not mailModel:IsMailRead(uid) then
      Logger.Debug("邮件尚未读")
      return
    end
    local index = mailModel.selectMailIndex
    
    local function func()
      mailModel:ReqDeleteMail(uid, index, System.fn(self, self._ShowRemoveMailAnim))
    end
    
    Alert.Show(20063, nil, func)
  end)
  
  local function itemNumCalc(list, itemId, itemNum)
    for _, itemData in pairs(list) do
      if itemData and itemData.tid == itemId then
        itemNum = itemNum + (itemData.num or 0)
        break
      end
    end
    return itemNum
  end
  
  local function checkItemOver(isAll, itemId, func)
    local itemNum = 0
    if isAll then
      for key, mail in pairs(mailModel.mails) do
        local list = mailModel:GetAttachments(key)
        if list then
          itemNum = itemNumCalc(list, itemId, itemNum)
        end
      end
    else
      local uid = mailModel.selectMailUid
      local list = mailModel:GetAttachments(uid)
      if list then
        itemNum = itemNumCalc(list, itemId, itemNum)
      end
    end
    if itemNum > 0 then
      do return func end
      return func, itemNum, itemNumCalc(list, itemId, itemNum), list, itemId, itemNum, mailModel:GetAttachments(key), itemNumCalc(list, itemId, itemNum), list, itemId, itemNum
    else
      return false
    end
  end
  
  local function reqGetAttachment()
    local uid = mailModel.selectMailUid
    mailModel:ReqGetAttachment(uid)
  end
  
  binder:BindButtonClick(self.ui.Btn_Receive, function()
    if not mailModel:CheckChosenEmpty() then
      return
    end
    local energyItemId = DT.GetConstant("EnergyItemTid")
    local params = DT.GetOriginalConstant("DailyChallengeSkipConsume")
    local skipItemId = params[1]
    if checkItemOver(false, energyItemId, GetEnergyCheckUtils.EnergyIsOverMax) then
      GetEnergyCheckUtils.TipsShow(reqGetAttachment)
    elseif checkItemOver(false, skipItemId, GetChallengeSkipItemCheckUtils.ItemIsOverMax) then
      GetChallengeSkipItemCheckUtils.TipsShow(reqGetAttachment)
    else
      reqGetAttachment()
    end
  end)
  binder:BindButtonClick(self.ui.Group_Unclickable, function()
    if mailModel:IsEmpyMailBox(mailModel.mailList) then
      return
    end
    local readMailNum = mailModel:HasReadMailNum()
    if 0 == readMailNum then
      return
    end
    
    local function func()
      mailModel:ReqDeleteAllMail("mail")
    end
    
    Alert.Show(20062, nil, func)
  end)
  binder:BindButtonClick(self.ui.Group_Normal, function()
    if mailModel:IsEmpyMailBox(mailModel.mailList) then
      return
    end
    
    local function reqGetAllAttachment()
      mailModel:ReqGetAllAttachment()
    end
    
    local params = DT.GetOriginalConstant("DailyChallengeSkipConsume")
    local skipItemId = params[1]
    
    local function tryReqGetAllAttachment()
      if checkItemOver(true, skipItemId, GetChallengeSkipItemCheckUtils.ItemIsOverMax) then
        GetChallengeSkipItemCheckUtils.TipsShow(reqGetAllAttachment)
        return
      end
      reqGetAllAttachment()
    end
    
    mailModel:ReqAllGainEnergyItemCount(function(svrData)
      local energy = svrData and svrData.count or 0
      if GetEnergyCheckUtils.EnergyIsOverMax(energy or 0) then
        GetEnergyCheckUtils.TipsShow(tryReqGetAllAttachment)
        return
      end
      tryReqGetAllAttachment()
    end)
  end)
  binder:BindToText(self.ui.Text_Quantity, function()
    do return mailModel.GetQuantityShow, mailModel, mailModel.mailList end
    return mailModel.GetQuantityShow, mailModel, mailModel.mailList, "Mail_Number"
  end)
  binder:BindToText(self.ui.Text_Introduce, function()
    if not mailModel:CheckChosenEmpty() then
      return ""
    end
    local title = mailModel:GetMailTitle(mailModel.selectMailUid)
    return title
  end)
  binder:BindToText(self.ui.Text_Info, function()
    if not mailModel:CheckChosenEmpty() then
      return ""
    end
    local info = mailModel:GetPublisher(mailModel.selectMailUid)
    return info
  end)
  binder:BindToText(self.ui.Text_TimeInfo, function()
    if not mailModel:CheckChosenEmpty() then
      return ""
    end
    local timeText = mailModel:GetTimeInfoText(mailModel.selectMailUid)
    return timeText
  end)
  binder:BindToRaw(function(_, content)
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
    return mailModel.ParseMailText, mailModel, mailModel.selectMailUid
  end, true)
  binder:BindToVisible(self.ui.Select_Letter, function()
    return not mailModel:CheckChosenEmpty()
  end)
  binder:BindToVisible(self.ui.root, function()
    return not mailModel:IsEmpyMailBox(mailModel.mailList)
  end)
  binder:BindToVisible(self.ui.Empty, function()
    do return mailModel.IsEmpyMailBox, mailModel end
    return mailModel.IsEmpyMailBox, mailModel, mailModel.mailList
  end)
  binder:BindToVisible(self.ui.Group_Letter_Content, function()
    do return mailModel.CheckChosenEmpty end
    return mailModel.CheckChosenEmpty, mailModel
  end)
  binder:BindToVisible(self.ui.Btn_Receive, function()
    if not mailModel:CheckChosenEmpty() then
      return false
    end
    local uid = mailModel.selectMailUid
    do return mailModel.CanReceiveAttachment, mailModel end
    return mailModel.CanReceiveAttachment, mailModel, uid
  end)
  binder:BindToVisible(self.ui.Btn_Litter, function()
    local selectedMailUid = mailModel.selectMailUid
    if nil ~= selectedMailUid then
      if mailModel:IsClientSurveyMail(selectedMailUid) then
        return false
      end
      local hasAttachment = mailModel:HasAttachment(selectedMailUid)
      local hasMailRead = mailModel:IsMailRead(selectedMailUid)
      if hasAttachment then
        return hasMailRead
      end
    end
    do return mailModel.CheckChosenEmpty end
    return mailModel.CheckChosenEmpty, mailModel, mailModel, selectedMailUid
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Mail, function()
    if mailModel.needSort then
      mailModel:SortMailList()
      mailModel:SetNeedSort(false)
    end
    return mailModel.mailList
  end, function(cb, obj, index)
    local data = mailModel.mailList[index]
    
    local function OnClick(uid)
      if uid == mailModel.selectMailUid then
        return
      end
      
      local function callback()
        mailModel:SetSelectMailUid(uid)
        mailModel:SetSelectMailIndex(index)
      end
      
      mailModel:ReqReadMail(uid, callback)
    end
    
    local function OnSelect()
      return data.mailUid == mailModel.selectMailUid
    end
    
    cb:BindComponent(MailListItem(obj, UI_Btn_MailResource, data, mailModel, OnClick, OnSelect))
  end, nil, true)
  local itemModel = binder:createModel(CommonIconItemModel)
  local attachments = {}
  binder:BindToCircularListView(self.ui.ScrollView_Goods, function()
    if not mailModel:CheckChosenEmpty() then
      return {}
    end
    local uid = mailModel.selectMailUid
    attachments = mailModel:GetAttachments(uid)
    mailModel:UpdateMailAttachments(uid, attachments)
    itemModel:SetItemDataMap(attachments)
    return attachments
  end, function(cb, obj, index)
    local data = attachments[index]
    local itemData = {
      itemTid = data.tid,
      itemCount = data and data.num,
      isGotFunc = function()
        return data.received
      end
    }
    cb:BindComponent(CommonIconItemType2(obj, itemData))
  end)
  binder:BindToVisible(self.ui.UI_Common_Item_Detail, function()
    return false
  end)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_collection, CommonDefine.RedDotType.Dot, nil, function()
    if mailModel.treasureRedState == MailDataUtils.TreasureRedState.NotRed then
      return
    end
    local ret = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.TreasureMail)
    return ret
  end))
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_Mail, CommonDefine.RedDotType.Dot, function()
    return false
  end))
  binder:BindToRaw(System.fn(self, self._OnChangeSelectMail), function()
    return mailModel.selectMailUid
  end)
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
end

function MailPanel:_FreeAllObj()
  for obj, _ in pairs(self._cacheTextObjMap) do
    obj:SetActive(false)
    self._cacheTextObjMap[obj] = true
  end
  for obj, _ in pairs(self._cacheImgObjMap) do
    obj:SetActive(false)
    self._cacheImgObjMap[obj] = true
  end
end

function MailPanel:_GetFreeTextObj()
  for obj, isFree in pairs(self._cacheTextObjMap) do
    if isFree then
      self._cacheTextObjMap[obj] = false
      return obj
    end
  end
  return nil
end

function MailPanel:_GetFreeImgObj()
  for obj, isFree in pairs(self._cacheImgObjMap) do
    if isFree then
      self._cacheImgObjMap[obj] = false
      return obj
    end
  end
  return nil
end

function MailPanel:ReqMailData(model)
  self.binder:SetActive(self.ui.uiNode, false)
  model:ReqTreasureMailList()
  model:ReqMailList(function()
    if not self.ui or IsNil(self.ui.uiNode) then
      return
    end
    self.binder:SetActive(self.ui.uiNode, true)
    self:_OnFirstReqMails()
  end)
end

function MailPanel:_OnSyncMails(data)
  if not data or not mailModel then
    return
  end
  local hasAdd = data.add and table.next(data.add) ~= nil
  local hasDel = data.del and nil ~= table.next(data.del)
  if hasAdd then
    mailModel:UpdateMails(data.add)
  end
  if hasDel then
    for _, uid in ipairs(data.del) do
      mailModel:RemoveMail(uid)
    end
  end
  MailDataUtils.SetSyncStatus(hasAdd, hasDel)
end

function MailPanel:_CheckTreasureRed()
  if not mailModel then
    return
  end
  local redAttrType = RedPointDataUtils.RedAttrType.Red
  local hasTreasureRed = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.TreasureMail) == redAttrType
  if hasTreasureRed then
    mailModel:SetTreasureRedState(MailDataUtils.TreasureRedState.ShouldShowRed)
  end
end

function MailPanel:_OnFirstReqMails()
  if not (self.binder and self.ui) or not self.ui.ScrollView_Mail then
    return
  end
  if mailModel and #mailModel.mailList > 0 then
    self.binder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView_Mail)
  end
end

function MailPanel:_ShowRemoveMailAnim(mail, index)
  if not (mail and index) or not self.binder then
    return
  end
  
  local function OnAnimCallback()
    mailModel:OnDeleteMailSuccess(mail)
    mailModel:SetSelectMailUid()
    mailModel:SetSelectMailIndex()
  end
  
  self.binder:CircularRemoveItemWithAnim(self.ui.ScrollView_Mail, index, OnAnimCallback)
end

function MailPanel:_OnChangeSelectMail(childBinder, mailUid, _)
  if not (childBinder and mailUid) or not mailModel then
    return
  end
  local hasItem = mailModel:HasAttachment(mailUid)
  if hasItem then
    childBinder:CircularScrollTo(self.ui.ScrollView_Goods, 1)
  end
end

function MailPanel:PlayAnim(controller, clipsString, func)
  if not controller then
    return
  end
  local clipsToPlay = ""
  controller:PlayMultiState(AddClipToPlay(clipsToPlay, clipsString), func)
end

function MailPanel:Close()
  Super.Close(self)
  if mailModel then
    mailModel:ClearMailList()
  end
  self._cacheImgObjMap = nil
  self._cacheTextObjMap = nil
end

return MailPanel
