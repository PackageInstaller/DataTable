local MailCtrl = class("MailCtrl", BaseCtrl)
MailCtrl._mapNodeConfig = {
  ImgBG = {sNodeName = "----BG----", sComponentName = "Image"},
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  mainEmpty = {sComponentName = "GameObject"},
  tex_empty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mail_EmptyTip"
  },
  mailItem = {sComponentName = "GameObject"},
  mailItemSc = {
    sComponentName = "LoopScrollView"
  },
  btnOneKeyReceive = {
    sComponentName = "UIButton",
    callback = "OneKeyReceive"
  },
  tex_OneKeyReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mail_OneKeyReceive"
  },
  btnOneKeyDel = {sComponentName = "UIButton", callback = "OneKeyDel"},
  tex_OneKeyDel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mail_OneKeyDel"
  },
  texMailCount = {sComponentName = "TMP_Text"},
  DetailPanel = {sComponentName = "GameObject"},
  detailBg = {sComponentName = "GameObject"},
  detailBgAnim = {sNodeName = "detailBg", sComponentName = "Animator"},
  detailIcon = {sComponentName = "Image"},
  detailTitle = {sComponentName = "TMP_Text"},
  deadLine_Icon_1 = {sComponentName = "GameObject"},
  deadLine_Icon_2 = {sComponentName = "GameObject"},
  deadLine_Icon_3 = {sComponentName = "GameObject"},
  detailDeadline = {sComponentName = "TMP_Text"},
  detailSendTime = {sComponentName = "TMP_Text"},
  detailSourceTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mail_Sender"
  },
  detailSource = {sComponentName = "TMP_Text"},
  detailDesc = {sComponentName = "TMP_Text"},
  detailDescSc = {sComponentName = "ScrollRect"},
  detail_Link = {
    sNodeName = "detailDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnLinkClick_Word"
  },
  detailDesc2 = {sComponentName = "TMP_Text"},
  detailDescSc2 = {sComponentName = "ScrollRect"},
  detail_Link2 = {
    sNodeName = "detailDesc2",
    sComponentName = "TMPHyperLink",
    callback = "OnLinkClick_Word"
  },
  detailItemRoot_2 = {sComponentName = "Transform"},
  detailItemSc_2 = {sComponentName = "ScrollRect"},
  detailItem = {sComponentName = "GameObject"},
  detailItemEmpty = {sComponentName = "GameObject"},
  detailBtnReceive = {
    sComponentName = "UIButton",
    callback = "OnClickDetailReceive"
  },
  tex_detailBtnReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mail_Receive"
  },
  detailBtnSurvery = {
    sComponentName = "UIButton",
    callback = "OnClickDetailSurvery"
  },
  tex_detailBtnSurvery = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mail_Survery"
  },
  detailDeadlineBg = {sComponentName = "GameObject"},
  detailClose = {
    sComponentName = "UIButton",
    callback = "OnCloseDetail"
  },
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnCloseDetail"
  },
  btnCollect = {
    sComponentName = "UIButton",
    callback = "OnClick_Collect"
  },
  btnUnCollect = {
    sComponentName = "UIButton",
    callback = "OnClick_UnCollect"
  }
}
MailCtrl._mapEventConfig = {
  [EventId.RefrushMailView] = "SetMailGroup",
  OnEvent_RefrushMailGroup = "RefrushMailGroup",
  GetAllMailList = "OnGetAllMailList"
}

function MailCtrl:FadeIn()
  EventManager.Hit(EventId.SetTransition)
end

function MailCtrl:Awake()
  self.maxMailCount = ConfigTable.GetConfigNumber("MailMax")
  self.detailMsg = nil
  self.detailReadGo = nil
  self.tbDetailItemCtrl2 = {}
  self.tbDetailItemEmpty = {}
  self.tbMailRewardCtrl = {}
  self.tabCache = {}
  self.isNeedRefList = false
end

function MailCtrl:OnEnable()
  self._mapNode.detailItem.gameObject:SetActive(false)
  local nId = CS.UnityEngine.SortingLayer.NameToID(AllEnum.SortingLayerName.UI)
  if not self.isOpen then
    self:SetMailGroup()
    self.isOpen = true
  end
  local sFullPath = string.format("Image/UIBG/%s", "bg_common_03")
  if self._mapNode and self._mapNode.ImgBG then
    self:SetPngSprite(self._mapNode.ImgBG, sFullPath)
  end
end

function MailCtrl:OnDisable()
  RedDotManager.SetValid(RedDotDefine.Mail_UnRead, nil, false)
  RedDotManager.SetValid(RedDotDefine.Mail_New, nil, false)
  self.tbDetailItemEmpty = nil
  for nIndex, objCtrl in pairs(self.tbDetailItemCtrl2) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbDetailItemCtrl2[nIndex] = nil
  end
  self.tbDetailItemCtrl2 = {}
  for nInstanceId, tbObjCtrl in pairs(self.tbMailRewardCtrl) do
    for _, objCtrl in pairs(tbObjCtrl) do
      self:UnbindCtrlByNode(objCtrl)
    end
    self.tbMailRewardCtrl[nInstanceId] = nil
  end
  self.tbMailRewardCtrl = {}
end

function MailCtrl:OnDestroy()
  self.detailReadGo = nil
  self.detailMsg = nil
  self.tabCache = nil
  self.isOpen = nil
  PlayerData.Mail:CancelTimeDelay()
  PlayerData.Mail:ClearFunCallBack()
end

function MailCtrl:SetMailGroup(isOpen)
  self.mailCount = 0
  local tab = PlayerData.Mail._mapMail
  local currentTime = CS.ClientManager.Instance.serverTimeStamp
  self.tabCache = {}
  for i, v in pairs(tab) do
    if v.Deadline == 0 or currentTime < v.Deadline then
      self.mailCount = self.mailCount + 1
      table.insert(self.tabCache, v)
    end
  end
  table.sort(self.tabCache, function(a, b)
    return a.Pin and not b.Pin or a.Pin == b.Pin and a.Time > b.Time
  end)
  if self.mailCount ~= 0 then
    self._mapNode.mailItem:SetActive(true)
    self._mapNode.mailItemSc:SetAnim(0.1)
    self._mapNode.mailItemSc:Init(self.mailCount, self, self.RefreshGroupGrid)
    NovaAPI.SetTMPText(self._mapNode.texMailCount, "<color=#08d3d4>" .. self.mailCount .. "</color><color=#fafafa>/" .. self.maxMailCount .. "</color>")
    self._mapNode.mainEmpty:SetActive(false)
  else
    self._mapNode.mainEmpty:SetActive(true)
    self._mapNode.mailItem:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.texMailCount, "<color=#08d3d4>" .. self.mailCount .. "</color><color=#fafafa>/" .. self.maxMailCount .. "</color>")
  end
  if not isOpen then
    self._mapNode.DetailPanel:SetActive(false)
  end
end

function MailCtrl:RefrushMailGroup()
  self._mapNode.DetailPanel:SetActive(false)
  self:SetMailGroup()
end

function MailCtrl:RefreshGroupGrid(goGrid, gridIndex)
  local nInstanceID = goGrid:GetInstanceID()
  local nIndex = gridIndex + 1
  local tempID = self.tabCache[nIndex].Id
  local data = PlayerData.Mail._mapMail[tempID]
  if data == nil then
    return
  end
  local objMailImg = goGrid.transform:Find("AnimRoot"):GetComponent("Image")
  local icon = goGrid.transform:Find("AnimRoot/iconMask/Icon"):GetComponent("Image")
  local texTitle = goGrid.transform:Find("AnimRoot/texTitle"):GetComponent("TMP_Text")
  local texSource = goGrid.transform:Find("AnimRoot/send/texSource"):GetComponent("TMP_Text")
  local texTime = goGrid.transform:Find("AnimRoot/texTime"):GetComponent("TMP_Text")
  local texDeadline = goGrid.transform:Find("AnimRoot/texDeadline"):GetComponent("TMP_Text")
  local objDeadline_1 = goGrid.transform:Find("AnimRoot/texDeadline/objDeadline_1").gameObject
  local objDeadline_2 = goGrid.transform:Find("AnimRoot/texDeadline/objDeadline_2").gameObject
  local objDeadline_3 = goGrid.transform:Find("AnimRoot/texDeadline/objDeadline_3").gameObject
  local attaCount = goGrid.transform:Find("AnimRoot/attaCount").gameObject
  local texAttaCount = goGrid.transform:Find("AnimRoot/attaCount/texAttaCount"):GetComponent("TMP_Text")
  local objGrey = goGrid.transform:Find("AnimRoot/objGrey").gameObject
  local line_1 = goGrid.transform:Find("AnimRoot/line_1").gameObject
  local objMainIconRead = goGrid.transform:Find("AnimRoot/objMainIconRead").gameObject
  local objMainIconNotRead = goGrid.transform:Find("AnimRoot/objMainIconNotRead").gameObject
  local objMainIconRecv = goGrid.transform:Find("AnimRoot/objMainIconRecv").gameObject
  local objCollectMark = goGrid.transform:Find("AnimRoot/collectMark").gameObject
  objCollectMark:SetActive(data.Pin)
  if nil == self.tbMailRewardCtrl[nInstanceID] then
    self.tbMailRewardCtrl[nInstanceID] = {}
    local itemCtrl = self:BindCtrlByNode(goGrid.transform:Find("AnimRoot/item1").gameObject, "Game.UI.TemplateEx.TemplateItemCtrl")
    self.tbMailRewardCtrl[nInstanceID][1] = itemCtrl
  end
  for _, v in ipairs(self.tbMailRewardCtrl[nInstanceID]) do
    v.gameObject:SetActive(false)
  end
  local btnReceive = goGrid.transform:Find("AnimRoot/btnReceive"):GetComponent("UIButton")
  local txtBtn = goGrid.transform:Find("AnimRoot/btnReceive/AnimRoot/txtBtn"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtBtn, ConfigTable.GetUIText("Mail_Receive"))
  local btnRead = goGrid.transform:Find("AnimRoot"):GetComponent("Button")
  objGrey:SetActive(false)
  line_1:SetActive(false)
  btnReceive.gameObject:SetActive(false)
  objMainIconRead:SetActive(false)
  objMainIconNotRead:SetActive(false)
  objMainIconRecv:SetActive(false)
  objDeadline_1:SetActive(false)
  objDeadline_2:SetActive(false)
  objDeadline_3:SetActive(false)
  local strTmpTitle = ""
  if string.find(data.Subject, "MailTemplate") ~= nil then
    local sList = string.split(data.Subject, ".")
    if 2 <= #sList and tonumber(sList[2]) then
      local dMsg = ConfigTable.GetData("MailTemplate", tonumber(sList[2]))
      if dMsg then
        strTmpTitle = dMsg.Subject
      else
        strTmpTitle = data.Subject
      end
    else
      strTmpTitle = data.Subject
    end
  else
    strTmpTitle = data.Subject
  end
  if data.SubjectArgs and #data.SubjectArgs > 0 then
    NovaAPI.SetTMPText(texTitle, self:MailFormat(strTmpTitle, data.SubjectArgs))
  else
    NovaAPI.SetTMPText(texTitle, strTmpTitle)
  end
  if string.find(data.Author, "MailTemplate") ~= nil then
    local sList = string.split(data.Author, ".")
    if 2 <= #sList and tonumber(sList[2]) then
      local dMsg = ConfigTable.GetData("MailTemplate", tonumber(sList[2]))
      if dMsg then
        NovaAPI.SetTMPText(texSource, ConfigTable.GetUIText("Mail_Sender") .. dMsg.Author)
      else
        NovaAPI.SetTMPText(texSource, ConfigTable.GetUIText("Mail_Sender") .. data.Author)
      end
    else
      NovaAPI.SetTMPText(texSource, ConfigTable.GetUIText("Mail_Sender") .. data.Author)
    end
  else
    NovaAPI.SetTMPText(texSource, ConfigTable.GetUIText("Mail_Sender") .. data.Author)
  end
  NovaAPI.SetTMPText(texTime, orderedFormat(ConfigTable.GetUIText("Mail_Time") or "", tonumber(os.date("%Y", data.Time)), tonumber(os.date("%m", data.Time)), tonumber(os.date("%d", data.Time))))
  if data.TemplateId == 0 then
    self:SetPngSprite(icon, "Icon/Head/head_999902" .. AllEnum.CharHeadIconSurfix.XL)
  else
    local mailTData = ConfigTable.GetData("MailTemplate", data.TemplateId)
    self:SetPngSprite(icon, mailTData.Icon .. AllEnum.CharHeadIconSurfix.XL)
  end
  if data.Deadline ~= 0 then
    local remainTime = data.Deadline - CS.ClientManager.Instance.serverTimeStamp
    if 86400 <= remainTime then
      NovaAPI.SetTMPText(texDeadline, "<color=#FEC254>" .. orderedFormat(ConfigTable.GetUIText("Mail_LeftTime_Day") or "", math.floor(remainTime / 86400)) .. "</color>")
      objDeadline_1:SetActive(true)
    elseif 3600 <= remainTime then
      NovaAPI.SetTMPText(texDeadline, "<color=#FB8037>" .. orderedFormat(ConfigTable.GetUIText("Mail_LeftTime_Hour") or "", math.floor(remainTime / 3600)) .. "</color>")
      objDeadline_2:SetActive(true)
    else
      NovaAPI.SetTMPText(texDeadline, "<color=#FF5579>" .. ConfigTable.GetUIText("Mail_LeftTime_LessThenHour") .. "</color>")
      objDeadline_3:SetActive(true)
    end
  else
    NovaAPI.SetTMPText(texDeadline, "")
  end
  if data.Attachments and 0 < #data.Attachments then
    for i, v in ipairs(data.Attachments) do
      if 1 < i then
        break
      end
      if nil ~= self.tbMailRewardCtrl[nInstanceID][i] then
        local itemCtrl = self.tbMailRewardCtrl[nInstanceID][i]
        itemCtrl.gameObject:SetActive(true)
        local itemCfg = ConfigTable.GetData_Item(v.Tid)
        if itemCfg.Type == GameEnum.itemType.Char then
          itemCtrl:SetChar(v.Tid, v.Qty, data.Recv)
        else
          itemCtrl:SetItem(v.Tid, nil, v.Qty, nil, data.Recv, false, false, true)
        end
      end
    end
    attaCount:SetActive(true)
    NovaAPI.SetTMPText(texAttaCount, orderedFormat(ConfigTable.GetUIText("Mail_Attachment_Count") or "", #data.Attachments))
    if data.Recv then
      objMainIconRecv:SetActive(true)
      objGrey:SetActive(true)
    elseif data.Read then
      objMainIconRead:SetActive(true)
      btnReceive.gameObject:SetActive(true)
      line_1:SetActive(true)
    else
      objMainIconNotRead:SetActive(true)
      btnReceive.gameObject:SetActive(true)
      line_1:SetActive(true)
    end
  else
    attaCount:SetActive(false)
    if data.Read then
      objMainIconRecv:SetActive(true)
      objGrey:SetActive(true)
    else
      objMainIconNotRead:SetActive(true)
      line_1:SetActive(true)
    end
  end
  
  local function ReceiveCallBack()
    self:SetMailGroup()
  end
  
  btnReceive.onClick:RemoveAllListeners()
  
  local function cbReceive()
    self:OnClickReceive(data.Id, data.Flag, ReceiveCallBack)
  end
  
  btnReceive.onClick:AddListener(cbReceive)
  
  local function ReadCallBack()
    self.isNeedRefList = true
    local cacheData = PlayerData.Mail._mapMail[data.Id]
    if cacheData then
      self:OpenMailDetail(cacheData, goGrid)
    end
  end
  
  btnRead.onClick:RemoveAllListeners()
  
  local function cbRead()
    self:OnClickRead(data.Id, data.Flag, ReadCallBack, goGrid)
  end
  
  btnRead.onClick:AddListener(cbRead)
end

function MailCtrl:OpenMailDetail(data, goGrid)
  self.detailMsg = data
  self.detailReadGo = goGrid
  local str = ""
  for i = 1, #data.Desc do
    local tmp = string.sub(data.Desc, i, i)
    if tmp == "\\" then
    else
      str = str .. tmp
    end
  end
  local haveAttachments = data.Attachments and #data.Attachments > 0
  if haveAttachments then
    self._mapNode.detailDescSc.gameObject:SetActive(true)
    NovaAPI.SetComponentEnable(self._mapNode.detailDescSc, true)
    self._mapNode.detailDescSc2.gameObject:SetActive(false)
    self._mapNode.detailDeadlineBg.transform.localPosition = Vector3(320, -225, 0)
    self._mapNode.detailItemSc_2.gameObject:SetActive(true)
  else
    self._mapNode.detailDescSc2.gameObject:SetActive(true)
    NovaAPI.SetComponentEnable(self._mapNode.detailDescSc2, true)
    self._mapNode.detailDescSc.gameObject:SetActive(false)
    self._mapNode.detailDeadlineBg.transform.localPosition = Vector3(320, -370, 0)
    self._mapNode.detailItemSc_2.gameObject:SetActive(false)
  end
  if string.find(str, "MailTemplate") ~= nil then
    local sList = string.split(str, ".")
    if 2 <= #sList and tonumber(sList[2]) then
      local dMsg = ConfigTable.GetData("MailTemplate", tonumber(sList[2]))
      if dMsg then
        str = dMsg.Desc
      end
    end
  end
  if data.DescArgs and 0 < #data.DescArgs then
    if data.TemplateId == 9999 then
      local sId = data.DescArgs[1]
      local mapPackageCfg = ConfigTable.GetData("MallPackage", sId, true)
      local mapMonthCfg = ConfigTable.GetData("MallMonthlyCard", sId, true)
      local mapGemCfg = ConfigTable.GetData("MallGem", sId, true)
      local mapReturneePackCfg = ConfigTable.GetData("ActivityReturneePack", sId, true)
      local mapReturneeCardCfg = ConfigTable.GetData("ActivityReturneeCard", sId, true)
      local mapMallActivityCfg = ConfigTable.GetData("MallActivity", sId, true)
      local sBattlePass = PlayerData.BattlePass:GetBattlePassName(sId)
      if mapPackageCfg then
        data.DescArgs[1] = mapPackageCfg.DetailName
      elseif mapMonthCfg then
        data.DescArgs[1] = mapMonthCfg.Name
      elseif mapGemCfg then
        local bMaiden = data.DescArgs[3] == "1"
        local nAll = bMaiden and mapGemCfg.MaidenBonusItemQty + mapGemCfg.BaseItemQty or mapGemCfg.ExperiencedBonusItemQty + mapGemCfg.BaseItemQty
        data.DescArgs[1] = orderedFormat(mapGemCfg.Name, nAll)
        data.DescArgs[3] = nil
      elseif sBattlePass then
        data.DescArgs[1] = sBattlePass
      elseif mapReturneePackCfg then
        data.DescArgs[1] = mapReturneePackCfg.DetailName
      elseif mapReturneeCardCfg then
        data.DescArgs[1] = mapReturneeCardCfg.Name
      elseif mapMallActivityCfg then
        data.DescArgs[1] = mapMallActivityCfg.Name
      end
    end
    local tmpFormatStr = self:MailFormat(str, data.DescArgs)
    if haveAttachments then
      NovaAPI.SetTMPText(self._mapNode.detailDesc, tmpFormatStr)
    else
      NovaAPI.SetTMPText(self._mapNode.detailDesc2, tmpFormatStr)
    end
  elseif haveAttachments then
    NovaAPI.SetTMPText(self._mapNode.detailDesc, str)
  else
    NovaAPI.SetTMPText(self._mapNode.detailDesc2, str)
  end
  if data.TemplateId == 0 then
    self:SetPngSprite(self._mapNode.detailIcon, "Icon/Head/head_999902" .. AllEnum.CharHeadIconSurfix.XL)
  else
    local mailTData = ConfigTable.GetData("MailTemplate", data.TemplateId)
    self:SetPngSprite(self._mapNode.detailIcon, mailTData.Icon .. AllEnum.CharHeadIconSurfix.XL)
  end
  local strTmpTitle = ""
  if string.find(data.Subject, "MailTemplate") ~= nil then
    local sList = string.split(data.Subject, ".")
    if 2 <= #sList and tonumber(sList[2]) then
      local dMsg = ConfigTable.GetData("MailTemplate", tonumber(sList[2]))
      if dMsg then
        strTmpTitle = dMsg.Subject
      else
        strTmpTitle = data.Subject
      end
    else
      strTmpTitle = data.Subject
    end
  else
    strTmpTitle = data.Subject
  end
  if data.SubjectArgs and 0 < #data.SubjectArgs then
    NovaAPI.SetTMPText(self._mapNode.detailTitle, self:MailFormat(strTmpTitle, data.SubjectArgs))
  else
    NovaAPI.SetTMPText(self._mapNode.detailTitle, strTmpTitle)
  end
  self._mapNode.deadLine_Icon_1:SetActive(false)
  self._mapNode.deadLine_Icon_2:SetActive(false)
  self._mapNode.deadLine_Icon_3:SetActive(false)
  if data.Deadline ~= 0 then
    local remainTime = data.Deadline - CS.ClientManager.Instance.serverTimeStamp
    if 86400 <= remainTime then
      NovaAPI.SetTMPText(self._mapNode.detailDeadline, "<color=#FEC254>" .. orderedFormat(ConfigTable.GetUIText("Mail_LeftTime_Day") or "", math.floor(remainTime / 86400)) .. "</color>")
      self._mapNode.deadLine_Icon_1:SetActive(true)
    elseif 3600 <= remainTime then
      NovaAPI.SetTMPText(self._mapNode.detailDeadline, "<color=#FB8037>" .. orderedFormat(ConfigTable.GetUIText("Mail_LeftTime_Hour") or "", math.floor(remainTime / 3600)) .. "</color>")
      self._mapNode.deadLine_Icon_2:SetActive(true)
    else
      NovaAPI.SetTMPText(self._mapNode.detailDeadline, "<color=#FF5579>" .. ConfigTable.GetUIText("Mail_LeftTime_LessThenHour") .. "</color>")
      self._mapNode.deadLine_Icon_3:SetActive(true)
    end
  else
    NovaAPI.SetTMPText(self._mapNode.detailDeadline, "")
  end
  NovaAPI.SetTMPText(self._mapNode.detailSendTime, orderedFormat(ConfigTable.GetUIText("Mail_Time") or "", tonumber(os.date("%Y", data.Time)), tonumber(os.date("%m", data.Time)), tonumber(os.date("%d", data.Time))))
  if string.find(data.Author, "MailTemplate") ~= nil then
    local sList = string.split(data.Author, ".")
    if 2 <= #sList and tonumber(sList[2]) then
      local dMsg = ConfigTable.GetData("MailTemplate", tonumber(sList[2]))
      if dMsg then
        NovaAPI.SetTMPText(self._mapNode.detailSource, dMsg.Author)
      else
        NovaAPI.SetTMPText(self._mapNode.detailSource, data.Author)
      end
    else
      NovaAPI.SetTMPText(self._mapNode.detailSource, data.Author)
    end
  else
    NovaAPI.SetTMPText(self._mapNode.detailSource, data.Author)
  end
  for _, v in ipairs(self.tbDetailItemCtrl2) do
    v.gameObject:SetActive(false)
  end
  for i, v in ipairs(self.tbDetailItemEmpty) do
    destroy(v)
  end
  self.tbDetailItemEmpty = {}
  local tmpObj = {}
  if data.Attachments and #data.Attachments > 0 then
    local nIndex = 1
    for i, v in pairs(data.Attachments) do
      local itemCtrl = self.tbDetailItemCtrl2[nIndex]
      nIndex = nIndex + 1
      if nil == itemCtrl then
        local itemObj = instantiate(self._mapNode.detailItem, self._mapNode.detailItemRoot_2)
        itemCtrl = self:BindCtrlByNode(itemObj, "Game.UI.TemplateEx.TemplateItemCtrl")
        table.insert(self.tbDetailItemCtrl2, itemCtrl)
      end
      table.insert(tmpObj, itemCtrl)
      local itemMsg = ConfigTable.GetData_Item(v.Tid)
      if itemMsg.Type == GameEnum.itemType.Char then
        itemCtrl:SetChar(v.Tid, v.Qty, data.Recv)
      else
        itemCtrl:SetItem(v.Tid, nil, v.Qty, nil, data.Recv, false, false, true)
      end
      local tmpRoot = itemCtrl.gameObject.transform:Find("root")
      local btnSelect = tmpRoot:GetComponent("UIButton")
      btnSelect.onClick:RemoveAllListeners()
      
      local function cbSelect()
        self:ShowItemDetail(v.Tid, tmpRoot:GetComponent("RectTransform"))
      end
      
      btnSelect.onClick:AddListener(cbSelect)
    end
    local emptyCount = 6 - #data.Attachments
    if 0 < emptyCount then
      for i = 1, emptyCount do
        local itemObj = instantiate(self._mapNode.detailItemEmpty, self._mapNode.detailItemRoot_2)
        table.insert(self.tbDetailItemEmpty, itemObj)
        table.insert(tmpObj, itemObj)
      end
    end
    
    local function wait()
      self._mapNode.detailItemRoot_2.gameObject.transform:DOLocalMoveX(0, 0.1)
      NovaAPI.SetComponentEnable(self._mapNode.detailItemSc_2, true)
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.1))
      if #data.Attachments < 6 then
        NovaAPI.SetComponentEnable(self._mapNode.detailItemSc_2, false)
      end
      for i, v in pairs(tmpObj) do
        v.gameObject:SetActive(true)
        v.gameObject.transform:Find("root"):GetComponent("Animator"):Play("MailPanel_detailItem_in")
        coroutine.yield(CS.UnityEngine.WaitForSeconds(0.03))
      end
    end
    
    cs_coroutine.start(wait)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.1 + 0.03 * #tmpObj)
    self._mapNode.detailBtnReceive.gameObject:SetActive(not data.Recv)
  else
    self._mapNode.detailBtnReceive.gameObject:SetActive(false)
  end
  self._mapNode.detailBtnReceive.gameObject:SetActive(data.SurveyId <= 0 and not data.Recv)
  self._mapNode.detailBtnSurvery.gameObject:SetActive(data.SurveyId > 0)
  self._mapNode.btnUnCollect.gameObject:SetActive(not data.Pin)
  self._mapNode.btnCollect.gameObject:SetActive(data.Pin)
  self.tmpPin = data.Pin
  self._mapNode.DetailPanel:SetActive(true)
  
  local function wait1()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.detailBg:SetActive(true)
    self._mapNode.detailBgAnim:Play("t_window_04_t_in")
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.2))
    if haveAttachments then
      if self._mapNode.detailDesc:GetComponent("RectTransform").sizeDelta.y < 320 then
        NovaAPI.SetComponentEnable(self._mapNode.detailDescSc, false)
      end
    elseif self._mapNode.detailDesc2:GetComponent("RectTransform").sizeDelta.y < 500 then
      NovaAPI.SetComponentEnable(self._mapNode.detailDescSc2, false)
    end
  end
  
  cs_coroutine.start(wait1)
end

function MailCtrl:ShowItemDetail(id, rtIcon)
  UTILS.ClickItemGridWithTips(id, rtIcon.transform, false, true, false)
end

function MailCtrl:OnCloseDetail()
  local isChangePin = false
  if self.detailMsg and self.detailMsg.Pin ~= self.tmpPin then
    isChangePin = true
    
    local function cb()
      self:SetMailGroup()
    end
    
    PlayerData.Mail:SendMailPin(self.detailMsg.Id, self.detailMsg.Flag, self.tmpPin, cb)
  end
  self.detailMsg = nil
  self.detailReadGo = nil
  if self.isNeedRefList and not isChangePin then
    self:SetMailGroup()
  end
  self.isNeedRefList = false
  
  local function waitCallback()
    self._mapNode.DetailPanel:SetActive(false)
    self._mapNode.detailBg:SetActive(false)
  end
  
  self._mapNode.detailBgAnim:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, waitCallback, true, true, true, nil)
end

function MailCtrl:OnClickReceive(id, flag, callBack)
  PlayerData.Mail:SendMailRecvReq(id, flag, callBack)
end

function MailCtrl:OnClickDel(id, flag, callBack)
  PlayerData.Mail:SendMailRemoveReq(id, flag, callBack)
end

function MailCtrl:OnClickRead(id, flag, callBack, goGrid)
  local cacheData = PlayerData.Mail._mapMail[id]
  if not cacheData.Read then
    PlayerData.Mail:SendMailReadReq(id, flag, callBack)
  else
    self:OpenMailDetail(cacheData, goGrid)
  end
end

function MailCtrl:OneKeyReceive()
  local tab = PlayerData.Mail._mapMail
  local currentTime = CS.ClientManager.Instance.serverTimeStamp
  local _recMailCount = 0
  for i, v in pairs(tab) do
    if v.Deadline == 0 or currentTime < v.Deadline then
      if not (not (0 < #v.Attachments) or v.Recv) or not v.Read then
        _recMailCount = _recMailCount + 1
      elseif #v.Attachments == 0 and not v.Read then
        _recMailCount = _recMailCount + 1
      end
    end
  end
  if _recMailCount == 0 then
    local sTip = ConfigTable.GetUIText("Mail_OneKeyReceiveTips")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
    return
  end
  
  local function cb()
    self:SetMailGroup()
  end
  
  self:OnClickReceive(0, 0, cb)
end

function MailCtrl:OneKeyDel()
  local tab = PlayerData.Mail._mapMail
  local currentTime = CS.ClientManager.Instance.serverTimeStamp
  local _delMailCount = 0
  for i, v in pairs(tab) do
    if v.Deadline == 0 or currentTime < v.Deadline then
      if 0 < #v.Attachments and v.Recv and not v.Pin then
        _delMailCount = _delMailCount + 1
      elseif #v.Attachments == 0 and v.Read and not v.Pin then
        _delMailCount = _delMailCount + 1
      end
    end
  end
  if _delMailCount == 0 then
    local sTip = ConfigTable.GetUIText("Mail_OneKeyDelTips")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
    return
  end
  
  local function cb()
    self:SetMailGroup()
  end
  
  self:OnClickDel(0, 0, cb)
end

function MailCtrl:OnClickDetailReceive()
  local function cb()
    self:SetMailGroup(true)
    
    local cacheData = PlayerData.Mail._mapMail[self.detailMsg.Id]
    if cacheData == nil then
      self:OnGetAllMailList()
      return
    end
    if cacheData.Attachments and #cacheData.Attachments > 0 then
      local nIndex = 1
      for i, v in pairs(cacheData.Attachments) do
        local itemCtrl = self.tbDetailItemCtrl2[nIndex]
        nIndex = nIndex + 1
        local itemMsg = ConfigTable.GetData_Item(v.Tid)
        if itemMsg.Type == GameEnum.itemType.Char then
          itemCtrl:SetChar(v.Tid, v.Qty, cacheData.Recv)
        else
          itemCtrl:SetItem(v.Tid, nil, v.Qty, nil, cacheData.Recv, false, false, true)
        end
      end
    end
    self._mapNode.detailBtnReceive.gameObject:SetActive(not cacheData.Recv)
  end
  
  self:OnClickReceive(self.detailMsg.Id, self.detailMsg.Flag, cb)
end

function MailCtrl:OnClick_Collect()
  self._mapNode.btnUnCollect.gameObject:SetActive(true)
  self._mapNode.btnCollect.gameObject:SetActive(false)
  self.tmpPin = false
end

function MailCtrl:OnClick_UnCollect()
  self._mapNode.btnUnCollect.gameObject:SetActive(false)
  self._mapNode.btnCollect.gameObject:SetActive(true)
  self.tmpPin = true
end

function MailCtrl:OnClickDetailSurvery()
  local function callBack(_, msgData)
    self:SetMailGroup(true)
    
    if msgData ~= nil and msgData.ActivityID ~= nil and msgData.NotifyUrl ~= nil then
      local nUID = PlayerData.Base:GetPlayerId()
      local SDKManager = CS.SDKManager.Instance
      if SDKManager:IsSDKInit() then
        SDKManager:ShowSurvey(msgData.ActivityID, nUID, msgData.NotifyUrl)
      else
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
      end
    end
  end
  
  PlayerData.Mail:SendMailGetSurveryMsg(self.detailMsg.SurveyId, callBack)
end

function MailCtrl:OnLinkClick_Word(link, sWordId)
  NovaAPI.OpenURL(sWordId)
end

function MailCtrl:OnGetAllMailList()
  local function callback()
    self:SetMailGroup()
  end
  
  PlayerData.Mail:SengMsgMailList(callback)
end

function MailCtrl:MailFormat(str, list)
  local count = #list
  if count == 1 then
    return orderedFormat(str, list[1])
  elseif count == 2 then
    return orderedFormat(str, list[1], list[2])
  elseif count == 3 then
    return orderedFormat(str, list[1], list[2], list[3])
  elseif count == 4 then
    return orderedFormat(str, list[1], list[2], list[3], list[4])
  elseif count == 5 then
    return orderedFormat(str, list[1], list[2], list[3], list[4], list[5])
  end
  return str
end

return MailCtrl
