local TYPEOF_Image = typeof(CS.UnityEngine.UI.Image)
local TreasureMailView, Super = System.NewClass("TreasureMailView", BaseView)
TreasureMailView.uiResCls = UI_Pocket_MailResource

function TreasureMailView:ctor()
  Super.ctor(self)
  self.model = MailModel.Instance
  self._cacheTextObjMap = {}
  self._cacheImgObjMap = {}
  self._attachments = {}
end

function TreasureMailView:OnBuildView()
  Super.OnBuildView(self)
  local commonPopupConfirmTipsData = {
    textTitleCN = LT.Text("Mail_Treasures"),
    sizeType = CommonDefine.PopupTipsType.L,
    clickFunc = System.fn(self, self.Close)
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Popup_Tips_L, UICompCommonPopupTips, commonPopupConfirmTipsData)
  UIUtils.ReplaceCircularListWithTable(self.ui.ScrollView_Mail, self.ui.Btn_Mail)
  UIUtils.ReplaceCircularListWithTable(self.ui.ScrollView_Goods, self.ui.UI_Common_Item_WuPin_Type2)
  self:_InitTableviews()
end

function TreasureMailView:_InitTableviews()
  self._mailTableview = self:CreateTableview(self.ui.ScrollView_Mail, function(_)
    if self.model.treasureNeedSort then
      self.model:SortTreasureMailList()
      self.model:SetTreasureNeedSort(false)
    end
    return #self.model.treasureMailList
  end, function(view, index)
    local mailData = self.model.treasureMailList[index]
    local cell = self:DequeueCell(view, self.ui.Btn_Mail)
    local isSelected = mailData:GetMailUid() == self.model.selectTreasureMailUid
    self:AddViewComponentOnce(cell.gameObject, TreasureMailListItemComp, mailData, isSelected, function(uid)
      self:_OnClickMailItem(uid, index)
    end)
    return cell
  end, function(_, index)
    local rt = self.ui.Btn_Mail:GetComponent(typeof(CS.UnityEngine.RectTransform))
    if not IsNil(rt) then
      return rt.sizeDelta.x, rt.sizeDelta.y
    end
    return 502, 112
  end)
  self._goodsTableview = self:CreateTableview(self.ui.ScrollView_Goods, function(_)
    if not self.model:CheckTreasureChosenEmpty() then
      return 0
    end
    local uid = self.model.selectTreasureMailUid
    self._attachments = self.model:GetAttachments(uid) or {}
    self.model:UpdateMailAttachments(uid, self._attachments)
    return #self._attachments
  end, function(view, index)
    local data = self._attachments[index]
    local cell = self:DequeueCell(view, self.ui.UI_Common_Item_WuPin_Type2)
    local itemData = {
      itemTid = data.tid,
      itemCount = data.num,
      isGot = data.received,
      clickFunc = function()
        self:_OnClickItem(data.tid, data.uid)
      end
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
      local mail = self.model.treasureMailList[idx + 1]
      
      if not mail then
        return false
      end
      self.model:OnDeleteMailSuccess(mail)
      return true
    end
  end
end

function TreasureMailView:_SetupTableview(scrollView, tableView)
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

function TreasureMailView:RegisterNotifications()
  Super.RegisterNotifications(self)
  self:RegisterLocalNotify(NotifyId.OnChangeTreasureMailData, self._RefreshAll, self)
end

function TreasureMailView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Close, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Delete, System.fn(self, self._OnClickDeleteMail))
  self:AddButtonClickListener(self.ui.Btn_Tip_Mask, System.fn(self, self._OnCloseItemTips))
end

function TreasureMailView:OnEnterView()
  Super.OnEnterView(self)
  self:_RefreshAll()
  self:PlayTableViewFadeInAnim(self.ui.ScrollView_Mail)
end

function TreasureMailView:OnExitView()
  UIUtils.DestroyRuntimeTableComponent(self.ui.ScrollView_Mail)
  UIUtils.DestroyRuntimeTableComponent(self.ui.ScrollView_Goods)
  Super.OnExitView(self)
  self.model:SetSelectTreasureMailUid()
  self.model:SetSelectTreasureMailIndex()
end

function TreasureMailView:_RefreshAll()
  if not self.ui then
    return
  end
  self:_RefreshText()
  self:_RefreshVisible()
  self:_RefreshMailList()
  self:_RefreshGoodsList()
  self:_RefreshContent()
end

function TreasureMailView:_RefreshText()
  local uid = self.model.selectTreasureMailUid
  local title = uid and self.model:GetMailTitle(uid) or ""
  local publisher = uid and self.model:GetPublisher(uid) or ""
  local timeText = uid and self.model:GetTimeInfoText(uid) or ""
  self:SetText(self.ui.Text_Introduce, title)
  self:SetText(self.ui.Text_Info, publisher)
  self:SetText(self.ui.Text_TimeInfo, LT.Textf("Mail_SendTime", timeText))
end

function TreasureMailView:_RefreshVisible()
  local hasMail = #self.model.treasureMailList > 0
  local chosen = self.model:CheckTreasureChosenEmpty()
  self.ui.root:SetActive(hasMail)
  self.ui.Group_Null:SetActive(not hasMail)
  self.ui.Btn_Delete:SetActive(chosen)
  self.ui.Group_Letter_Content:SetActive(chosen)
end

function TreasureMailView:_RefreshMailList()
  if self._mailTableview then
    self._mailTableview:ReloadData()
  end
end

function TreasureMailView:_RefreshGoodsList()
  if self._goodsTableview then
    self._goodsTableview:ReloadData()
  end
end

function TreasureMailView:_RefreshContent()
  local content = self.model:ParseMailText(self.model.selectTreasureMailUid)
  self:_RenderContent(content)
end

function TreasureMailView:_RenderContent(content)
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

function TreasureMailView:_OnClickLink(linkText)
  local linkInfo = StrUtils.GetLinkInfo(linkText)
  print("mail link", linkText, table.tostring(linkInfo))
  if linkInfo.cfgName == "Survey" then
    local mail = self.model:GetMail(self.model.selectTreasureMailUid)
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

function TreasureMailView:_FreeAllObj()
  for obj, _ in pairs(self._cacheTextObjMap) do
    obj:SetActive(false)
  end
  for obj, _ in pairs(self._cacheImgObjMap) do
    obj:SetActive(false)
  end
end

function TreasureMailView:_GetFreeTextObj()
  for obj, isFree in pairs(self._cacheTextObjMap) do
    if isFree then
      self._cacheTextObjMap[obj] = false
      return obj
    end
  end
  return nil
end

function TreasureMailView:_GetFreeImgObj()
  for obj, isFree in pairs(self._cacheImgObjMap) do
    if isFree then
      self._cacheImgObjMap[obj] = false
      return obj
    end
  end
  return nil
end

function TreasureMailView:_OnClickMailItem(uid, index)
  if uid == self.model.selectTreasureMailUid then
    return
  end
  
  local function callback()
    self.model:SetSelectTreasureMailUid(uid)
    self.model:SetSelectTreasureMailIndex(index)
    self:_RefreshAll()
  end
  
  self.model:ReqReadMail(uid, callback)
end

function TreasureMailView:_OnClickDeleteMail()
  MailController.Instance:DeleteTreasureMail(nil, nil, System.fn(self, self._OnDeleteTreasureMailWithAnim))
end

function TreasureMailView:_OnDeleteTreasureMailWithAnim(mail, index)
  self.model:SetSelectTreasureMailUid()
  self.model:SetSelectTreasureMailIndex()
  local curIndex
  for i, mo in ipairs(self.model.treasureMailList) do
    if mo:GetMailUid() == mail:GetMailUid() then
      curIndex = i
      break
    end
  end
  local visibleCell = curIndex and self._mailTableview and self._mailTableview:GetCellAtIndex(curIndex - 1) or nil
  local playedAnim = false
  if curIndex and not IsNil(visibleCell) then
    self._mailTableview:RemoveCellAtIndex(curIndex - 1, true, true)
    playedAnim = true
  else
    self.model:OnDeleteMailSuccess(mail)
  end
  if #self.model.treasureMailList <= 0 then
    self:Close()
  elseif playedAnim then
    self:_RefreshText()
    self:_RefreshVisible()
    self:_RefreshGoodsList()
    self:_RefreshContent()
  else
    self:_RefreshAll()
  end
end

function TreasureMailView:_OnClickItem(tid, uid)
  if not uid then
    return
  end
  ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode.transform.parent.gameObject, nil, tid)
end

function TreasureMailView:_OnCloseItemTips()
  self.ui.UI_Common_Item_Detail:SetActive(false)
end

return TreasureMailView
