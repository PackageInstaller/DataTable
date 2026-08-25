local UIAnimationController = CS.Z1Client.UIAnimationController
local typeof = _ENV.typeof
local AddClipToPlay = AnimatorUtils.AddClipToPlay
local TYPEOF_Image = typeof(CS.UnityEngine.UI.Image)
local MailView, Super = System.NewClass("MailView", BaseView)
MailView.uiResCls = UI_MailResource

function MailView:ctor()
  Super.ctor(self)
  self.model = MailModel.Instance
  self._cacheTextObjMap = {}
  self._cacheImgObjMap = {}
  self._attachments = {}
end

function MailView:OnBuildView()
  Super.OnBuildView(self)
  UIUtils.ReplaceCircularListWithTable(self.ui.ScrollView_Mail, self.ui.UI_Btn_Mail)
  UIUtils.ReplaceCircularListWithTable(self.ui.ScrollView_Goods, self.ui.UI_Common_Item_WuPin_Type2)
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.collectAnimController = self.ui.UI_Mail_Effect_Email01:GetComponent(typeof(UIAnimationController))
  self:_InitTableviews()
  self:_InitBackButtonGroup()
  self:_CheckTreasureRed()
  self:_InitRedDots()
end

function MailView:_InitRedDots()
  self:AddRedPoint(self.ui.Com_RedDot_collection, RedDotDefine.RedDotID.TreasureMailEntry)
end

function MailView:_InitBackButtonGroup()
  local groupBtnGo = self:FindChild(self.ui.UI_Common_Btn_Back3, "Group_Back/Group_Btn")
  if not IsNil(groupBtnGo) then
    local canvasGroup = groupBtnGo:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
    if not IsNil(canvasGroup) then
      canvasGroup.alpha = 1
    end
  end
end

function MailView:_InitTableviews()
  self._mailTableview = self:CreateTableview(self.ui.ScrollView_Mail, function(_)
    if self.model.needSort then
      self.model:SortMailList()
      self.model:SetNeedSort(false)
    end
    return #self.model.mailList
  end, function(view, index)
    local mailData = self.model.mailList[index]
    local cell = self:DequeueCell(view, self.ui.UI_Btn_Mail)
    local isSelected = mailData:GetMailUid() == self.model.selectMailUid
    self:AddViewComponentOnce(cell.gameObject, MailListItemComp, mailData, isSelected, function(uid)
      self:_OnClickMailItem(uid, index)
    end)
    return cell
  end, function(_, index)
    local rt = self.ui.UI_Btn_Mail:GetComponent(typeof(CS.UnityEngine.RectTransform))
    if not IsNil(rt) then
      return rt.sizeDelta.x, rt.sizeDelta.y
    end
    return 570, 130
  end)
  self._goodsTableview = self:CreateTableview(self.ui.ScrollView_Goods, function(_)
    if not self.model:CheckChosenEmpty() then
      return 0
    end
    local uid = self.model.selectMailUid
    self._attachments = self.model:GetAttachments(uid) or {}
    self.model:UpdateMailAttachments(uid, self._attachments)
    return #self._attachments
  end, function(view, index)
    local data = self._attachments[index]
    local cell = self:DequeueCell(view, self.ui.UI_Common_Item_WuPin_Type2)
    local itemData = {
      itemTid = data.tid,
      itemCount = data and data.num,
      isGot = data.received
    }
    self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, itemData)
    return cell
  end, function(_, index)
    local rt = self.ui.UI_Common_Item_WuPin_Type2:GetComponent(typeof(CS.UnityEngine.RectTransform))
    if not IsNil(rt) then
      return rt.sizeDelta.x, rt.sizeDelta.y
    end
    return 156, 198
  end)
  self:_SetupTableview(self.ui.ScrollView_Mail, self._mailTableview)
  self:_SetupTableview(self.ui.ScrollView_Goods, self._goodsTableview)
  local rawMailTableview = self.ui.ScrollView_Mail:GetComponent(typeof(CS.UITableview))
  if not IsNil(rawMailTableview) then
    function rawMailTableview.tableCellWillRemove(_, idx)
      local mail = self.model.mailList[idx + 1]
      
      if not mail then
        return false
      end
      self.model:OnDeleteMailSuccess(mail)
      return true
    end
  end
end

function MailView:_SetupTableview(scrollView, tableView)
  if IsNil(tableView) then
    return
  end
  local scrollRect = scrollView:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
  if IsNil(scrollRect) then
    return
  end
  local content = scrollRect.content
  if IsNil(content) then
    return
  end
  local vlg = content:GetComponent(typeof(CS.UnityEngine.UI.VerticalLayoutGroup))
  if not IsNil(vlg) then
    vlg.enabled = false
  end
  local hlg = content:GetComponent(typeof(CS.UnityEngine.UI.HorizontalLayoutGroup))
  if not IsNil(hlg) then
    hlg.enabled = false
  end
end

function MailView:RegisterNotifications()
  Super.RegisterNotifications(self)
  self:RegisterLocalNotify(NotifyId.OnChangeMailData, self._RefreshAll, self)
  self:RegisterLocalNotify(NotifyId.OnMailListLoaded, self._OnFirstReqMails, self)
end

function MailView:RegisterEvents()
  self:BindEvent(EventMgr.Instance.CommonRewardPanelClose, System.fn(self, self._OnRewardPanelClose))
  local backBtnGo = self:FindChild(self.ui.UI_Common_Btn_Back3, "Group_Back/Btn_Click")
  if not IsNil(backBtnGo) then
    self:AddButtonClickListener(backBtnGo, System.fn(self, self.Close))
  end
  self:AddButtonClickListener(self.ui.Btn_Mail, System.fn(self, self._OnClickMailIntro))
  self:AddButtonClickListener(self.ui.Btn_Collection, System.fn(self, self._OnClickOpenTreasureBox))
  self:AddButtonClickListener(self.ui.Btn_Litter, System.fn(self, self._OnClickDeleteMail))
  self:AddButtonClickListener(self.ui.Btn_Receive, System.fn(self, self._OnClickGetAttachment))
  self:AddButtonClickListener(self.ui.Group_Unclickable, System.fn(self, self._OnClickDeleteAllReadMail))
  self:AddButtonClickListener(self.ui.Group_Normal, System.fn(self, self._OnClickGetAllAttachment))
end

function MailView:_OnRewardPanelClose(source)
  if "Mail" ~= source then
    return
  end
  if not self.model:ShouldShowGetCollectMailAnim() then
    return
  end
  self:PlayAnim(self.collectAnimController, "UI_Mail_Effect_Email01")
  self.model:SetShowCollectMailAnim(false)
end

function MailView:OnEnterView()
  Super.OnEnterView(self)
  AudioManager.Instance:PostSoundEvent("SET_STATE_A_INTERFACE_MAILBOX")
  self:_ReqMailData()
  self:_RefreshVisible()
end

function MailView:OnExitView()
  UIUtils.DestroyRuntimeTableComponent(self.ui.ScrollView_Mail)
  UIUtils.DestroyRuntimeTableComponent(self.ui.ScrollView_Goods)
  Super.OnExitView(self)
  self.model:ClearMailList()
  self.model:SetSelectMailUid()
  self.model:SetSelectMailIndex()
end

function MailView:_ReqMailData()
  self.model:ReqTreasureMailList()
  self.model:ReqMailList()
end

function MailView:_OnFirstReqMails()
  if not self.ui or not self.ui.ScrollView_Mail then
    return
  end
  if #self.model.mailList > 0 then
    self:PlayTableViewFadeInAnim(self.ui.ScrollView_Mail)
  end
end

function MailView:_RefreshAll()
  if not self.ui then
    return
  end
  self:_RefreshText()
  self:_RefreshVisible()
  self:_RefreshMailList()
  self:_RefreshGoodsList()
  self:_RefreshContent()
end

function MailView:_RefreshText()
  self:SetText(self.ui.Text_Quantity, self.model:GetQuantityShow(self.model.mailList, "Mail_Number"))
  local uid = self.model.selectMailUid
  local title = uid and self.model:GetMailTitle(uid) or ""
  local publisher = uid and self.model:GetPublisher(uid) or ""
  local timeText = uid and self.model:GetTimeInfoText(uid) or ""
  self:SetText(self.ui.Text_Introduce, title)
  self:SetText(self.ui.Text_Info, publisher)
  self:SetText(self.ui.Text_TimeInfo, timeText)
end

function MailView:_RefreshVisible()
  local hasMail = not self.model:IsEmpyMailBox(self.model.mailList)
  local chosen = self.model:CheckChosenEmpty()
  self.ui.Select_Letter:SetActive(not chosen)
  self.ui.root:SetActive(hasMail)
  self.ui.Empty:SetActive(not hasMail)
  self.ui.Group_Letter_Content:SetActive(chosen)
  local showReceive = false
  local showDelete = false
  if chosen then
    local uid = self.model.selectMailUid
    showReceive = self.model:CanReceiveAttachment(uid)
    if self.model:IsClientSurveyMail(uid) then
      showDelete = false
    else
      local hasAttachment = self.model:HasAttachment(uid)
      local hasMailRead = self.model:IsMailRead(uid)
      if hasAttachment then
        showDelete = hasMailRead
      else
        showDelete = true
      end
    end
  end
  self.ui.Btn_Receive:SetActive(showReceive)
  self.ui.Btn_Litter:SetActive(showDelete)
end

function MailView:_RefreshMailList()
  if self._mailTableview then
    self._mailTableview:ReloadData()
  end
end

function MailView:_RefreshGoodsList()
  if self._goodsTableview then
    self._goodsTableview:ReloadData()
  end
end

function MailView:_RefreshContent()
  local content = self.model:ParseMailText(self.model.selectMailUid)
  self:_RenderContent(content)
end

function MailView:_RenderContent(content)
  if not content then
    return
  end
  if self._renderingContent then
    return
  end
  self._renderingContent = true
  self:_FreeAllObj()
  local contentHeight = 0
  local contentWidth = self.ui.Content.gameObject.transform.sizeDelta.x
  for _, detailContent in ipairs(content) do
    local detailObj
    local height = 0
    if detailContent[1] then
      detailObj = self:_GetFreeTextObj()
      if not detailObj then
        detailObj = GameObject.Instantiate(self.ui.Text_Detailed.gameObject, self.ui.Content.transform)
        self.binder:LoadAllLangFont(detailObj)
        self._cacheTextObjMap[detailObj] = true
      end
      self:SetText(detailObj, detailContent[2], nil, System.fn(self, self._OnClickLink))
      self.binder:LoadAllLangFont(self.ui.Text_Detailed)
      self:SetText(self.ui.Text_Detailed, detailContent[2])
      height = StrUtils.SetPreferredHeight(self.ui.Text_Detailed) + 30
      CS.Framework.TransformUtil.SetAnchoredPos(detailObj.transform, 0, contentHeight * -1)
    else
      detailObj = self:_GetFreeImgObj()
      if not detailObj then
        detailObj = GameObject.Instantiate(self.ui.Image_Detailed.gameObject, self.ui.Content.transform)
        self._cacheImgObjMap[detailObj] = true
      end
      self:SetImage(detailObj, detailContent[2], nil, function()
        if self.ui and not IsNil(self.ui.uiNode) and not self._renderingContent then
          self:_RefreshContent()
        end
      end)
      local detailSprite = detailObj:GetComponent(TYPEOF_Image).sprite
      if detailSprite then
        local aspectRatio = detailSprite.rect.width / detailSprite.rect.height
        local targetWidth = math.min(contentWidth, detailSprite.rect.width)
        height = targetWidth / aspectRatio
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
  self._renderingContent = false
end

function MailView:_OnClickLink(linkText)
  local linkInfo = StrUtils.GetLinkInfo(linkText)
  print("mail link", linkText, table.tostring(linkInfo))
  if linkInfo.cfgName == "Survey" then
    local mail = self.model:GetMail(self.model.selectMailUid)
    if mail then
      self.model:ReqShowSurvey(mail)
    end
    return
  end
  local url = linkInfo and linkInfo.showContent
  if not url or "" == url then
    return
  end
  CS.UnityEngine.Application.OpenURL(url)
end

function MailView:_FreeAllObj()
  for obj, _ in pairs(self._cacheTextObjMap) do
    obj:SetActive(false)
  end
  for obj, _ in pairs(self._cacheImgObjMap) do
    obj:SetActive(false)
  end
end

function MailView:_GetFreeTextObj()
  for obj, isFree in pairs(self._cacheTextObjMap) do
    if isFree then
      self._cacheTextObjMap[obj] = false
      return obj
    end
  end
  return nil
end

function MailView:_GetFreeImgObj()
  for obj, isFree in pairs(self._cacheImgObjMap) do
    if isFree then
      self._cacheImgObjMap[obj] = false
      return obj
    end
  end
  return nil
end

function MailView:_OnClickMailIntro()
  MailController.Instance:OpenMailIntroView()
end

function MailView:_OnClickOpenTreasureBox()
  MailController.Instance:OpenTreasureBox()
end

function MailView:_OnClickDeleteMail()
  MailController.Instance:DeleteMail(nil, nil, System.fn(self, self._OnDeleteMailWithAnim))
end

function MailView:_OnDeleteMailWithAnim(mail, index)
  local curIndex
  for i, mo in ipairs(self.model.mailList) do
    if mo:GetMailUid() == mail:GetMailUid() then
      curIndex = i
      break
    end
  end
  self.model:SetSelectMailUid()
  self.model:SetSelectMailIndex()
  local visibleCell = curIndex and self._mailTableview and self._mailTableview:GetCellAtIndex(curIndex - 1) or nil
  if curIndex and not IsNil(visibleCell) then
    self._mailTableview:RemoveCellAtIndex(curIndex - 1, true, true)
    self:_RefreshText()
    self:_RefreshVisible()
    self:_RefreshGoodsList()
    self:_RefreshContent()
  else
    self.model:OnDeleteMailSuccess(mail)
    self.model:LocalNotify(NotifyId.OnChangeMailData)
  end
end

function MailView:_OnClickDeleteAllReadMail()
  MailController.Instance:DeleteAllReadMail()
end

function MailView:_OnClickGetAttachment()
  MailController.Instance:ReceiveAttachment()
end

function MailView:_OnClickGetAllAttachment()
  MailController.Instance:ReceiveAllAttachment()
end

function MailView:_OnClickMailItem(uid, index)
  if uid == self.model.selectMailUid then
    return
  end
  
  local function callback()
    self.model:SetSelectMailUid(uid)
    self.model:SetSelectMailIndex(index)
    self:_OnChangeSelectMail()
    self:_RefreshAll()
  end
  
  self.model:ReqReadMail(uid, callback)
end

function MailView:_OnChangeSelectMail()
  if self.model:HasAttachment(self.model.selectMailUid) and self._goodsTableview then
    self._goodsTableview:MoveCellInView(0, false)
  end
end

function MailView:_CheckTreasureRed()
  local redAttrType = RedPointDataUtils.RedAttrType.Red
  local hasTreasureRed = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.TreasureMail) == redAttrType
  if hasTreasureRed then
    self.model:SetTreasureRedState(MailDataUtils.TreasureRedState.ShouldShowRed)
  end
end

function MailView:PlayAnim(controller, clipsString, func)
  if not controller then
    return
  end
  local clipsToPlay = ""
  controller:PlayMultiState(AddClipToPlay(clipsToPlay, clipsString), func)
end

return MailView
