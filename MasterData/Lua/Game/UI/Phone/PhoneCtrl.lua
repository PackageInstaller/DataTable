local PhoneCtrl = class("PhoneCtrl", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
PhoneCtrl._mapNodeConfig = {
  imgBlurredBg = {sComponentName = "GameObject"},
  goContent = {},
  animContent = {sNodeName = "goContent", sComponentName = "Animator"},
  txtTime = {sComponentName = "TMP_Text"},
  txtPhoneTitle = {sComponentName = "TMP_Text"},
  PhoneList = {
    sComponentName = "RectTransform"
  },
  goTop = {
    sComponentName = "RectTransform"
  },
  addressBookListLSV = {
    sComponentName = "LoopScrollView"
  },
  addressBookListAnim = {
    sNodeName = "addressBookListLSV",
    sComponentName = "Animator"
  },
  trAddressLSV = {
    sNodeName = "addressBookListLSV",
    sComponentName = "RectTransform"
  },
  giftListLSV = {
    sComponentName = "LoopScrollView"
  },
  trGiftLSV = {
    sNodeName = "giftListLSV",
    sComponentName = "Transform"
  },
  datingListLSV = {
    sComponentName = "LoopScrollView"
  },
  trDatingLSV = {
    sNodeName = "datingListLSV",
    sComponentName = "Transform"
  },
  goChat = {
    sCtrlName = "Game.UI.Phone.Chat.PhoneChatCtrl"
  },
  goGift = {
    sCtrlName = "Game.UI.Phone.Gift.PhoneGiftCtrl"
  },
  goDating = {
    sCtrlName = "Game.UI.Phone.Dating.PhoneDatingCtrl"
  },
  btnClosePanel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnAddress = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Address"
  },
  btnDating = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Dating"
  },
  btnGift = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Gift"
  },
  togAddress = {
    sNodeName = "btnAddress",
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  togDating = {
    sNodeName = "btnDating",
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  togGift = {
    sNodeName = "btnGift",
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  rtImgBtnSelect = {
    sNodeName = "imgBtnSelect",
    sComponentName = "RectTransform"
  },
  redDotChat = {},
  redDotDating = {},
  rtImgMsgDetail = {sComponentName = "Canvas"},
  goTopTip = {},
  txtTopTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Phone_Top_Limit_Tip"
  },
  btnReceiveReward = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_ReceiveReward"
  }
}
PhoneCtrl._mapEventConfig = {
  RefreshPhoneAddress = "OnEvent_RefreshPhoneAddress",
  NewChatTrigger = "OnEvent_NewChatTrigger",
  RefreshChatRedDot = "OnEvent_RefreshRedDot",
  RefreshCharList = "OnEvent_RefreshCharList",
  RefreshSortingOrder = "OnEvent_RefreshSortingOrder",
  OpenEventDetailWindow = "OnEvent_OpenEventDetailWindow",
  ChangePhoneListTopStatus = "OnEvent_ChangePhoneListTopStatus",
  PhoneChatTopLimit = "OnEvent_PhoneChatTopLimit",
  EnableReceiveChatReward = "OnEvent_EnableReceiveChatReward",
  FreeDatingChanged = "OnEvent_FreeDatingChanged"
}
PhoneCtrl._mapRedDotConfig = {
  [RedDotDefine.Phone_New] = {sNodeName = "redDotChat"},
  [RedDotDefine.Phone_Dating] = {
    sNodeName = "redDotDating"
  }
}
local lsv_max_height = 1080
local tog_Chat = AllEnum.PhoneTogType.Chat
local tog_Dating = AllEnum.PhoneTogType.Dating
local tog_Gift = AllEnum.PhoneTogType.Gift
local tbTogSelectPosX = {
  -208,
  -0.4,
  209
}

function PhoneCtrl:PlayGridOutAnim()
  local sv
  local sAnim = "PhonePanel_char_out"
  if self.nLastTog == tog_Chat then
    sv = self._mapNode.addressBookListLSV
  elseif self.nLastTog == tog_Gift then
    sv = self._mapNode.giftListLSV
  elseif self.nLastTog == tog_Dating then
    sv = self._mapNode.datingListLSV
  end
  if sv == nil then
    return
  end
  local listInUse = sv:GetInUseGridIndex()
  self.tbGridInUse = {}
  for i = 0, listInUse.Count - 1 do
    local nIndex = listInUse[i]
    local goGrid = sv.transform:Find("Viewport/Content/" .. nIndex)
    if goGrid then
      local animRoot = goGrid.transform:Find("btnGrid/AnimRoot"):GetComponent("Animator")
      animRoot:Play(sAnim, 0, 0)
    end
  end
end

function PhoneCtrl:PlayGridItemAnim()
  local sv
  local sAnim = ""
  local nAnimTime = 0.1
  local nItemAnimLen = 0
  if self._panel.nCurTog == tog_Chat then
    sv = self._mapNode.addressBookListLSV
    sAnim = "PhonePanel_char_move"
  elseif self._panel.nCurTog == tog_Gift then
    sv = self._mapNode.giftListLSV
    sAnim = "PhonePanel_char_move"
  elseif self._panel.nCurTog == tog_Dating then
    sv = self._mapNode.datingListLSV
    sAnim = "PhonePanel_char_scale"
    nAnimTime = 0.04
  end
  if sv == nil then
    return
  end
  local listInUse = sv:GetInUseGridIndex()
  self.tbGridInUse = {}
  for i = 0, listInUse.Count - 1 do
    table.insert(self.tbGridInUse, listInUse[i])
  end
  if self.gridItemAnimTimer ~= nil then
    self.gridItemAnimTimer:Cancel()
    self.gridItemAnimTimer = nil
  end
  for k, v in ipairs(self.tbGridInUse) do
    local goGrid = sv.transform:Find("Viewport/Content/" .. v)
    local animRoot = goGrid.transform:Find("btnGrid/AnimRoot"):GetComponent("Animator")
    if animRoot ~= nil then
      animRoot.gameObject:SetActive(false)
    end
    if k == 1 then
      animRoot.gameObject:SetActive(true)
      nItemAnimLen = NovaAPI.GetAnimClipLength(animRoot, {sAnim})
      animRoot:Play(sAnim, 0, 0)
    end
  end
  local nCurIndex = 1
  EventManager.Hit(EventId.BlockInput, true)
  self.gridItemAnimTimer = self:AddTimer(0, nAnimTime, function()
    nCurIndex = nCurIndex + 1
    if nCurIndex > #self.tbGridInUse and self.gridItemAnimTimer ~= nil then
      self.gridItemAnimTimer:Cancel()
      self.gridItemAnimTimer = nil
      EventManager.Hit(EventId.BlockInput, false)
      return
    end
    local goGrid = sv.transform:Find("Viewport/Content/" .. self.tbGridInUse[nCurIndex])
    if goGrid ~= nil then
      local animRoot = goGrid.transform:Find("btnGrid/AnimRoot"):GetComponent("Animator")
      animRoot.gameObject:SetActive(true)
      animRoot:Play(sAnim, 0, 0)
    end
  end, true, true, true)
  return nAnimTime * #self.tbGridInUse + nItemAnimLen
end

function PhoneCtrl:PlayTogAnim()
  local sAnim = ""
  if self._panel.nCurTog == tog_Chat then
    sAnim = "PhonePanel_goChat_in"
  elseif self._panel.nCurTog == tog_Gift then
    sAnim = "PhonePanel_goGift_in"
  elseif self._panel.nCurTog == tog_Dating then
    sAnim = "PhonePanel_goDating_in"
  end
  local nAnimeLen = NovaAPI.GetAnimClipLength(self._mapNode.animContent, {sAnim})
  self._mapNode.animContent:Play(sAnim)
  return nAnimeLen
end

function PhoneCtrl:RefreshTogInfo(bResetChar)
  self._mapNode.goChat.gameObject:SetActive(self._panel.nCurTog == tog_Chat)
  self._mapNode.goGift.gameObject:SetActive(self._panel.nCurTog == tog_Gift)
  self._mapNode.goDating.gameObject:SetActive(self._panel.nCurTog == tog_Dating)
  self._mapNode.addressBookListLSV.gameObject:SetActive(self._panel.nCurTog == tog_Chat)
  self._mapNode.giftListLSV.gameObject:SetActive(self._panel.nCurTog == tog_Gift)
  self._mapNode.datingListLSV.gameObject:SetActive(self._panel.nCurTog == tog_Dating)
  if bResetChar then
    self._panel.nSelectCharId = nil
  end
  if self._panel.nCurTog == tog_Chat then
    if self.nSelectAddressId == nil then
      self.nSelectIndex = nil
    end
    NovaAPI.SetTMPText(self._mapNode.txtPhoneTitle, ConfigTable.GetUIText("Phone_Tog_Chat"))
    self.tbAddressBookList = PlayerData.Phone:GetAddressBookList()
    self:RefreshAddressBookList(false, false)
    self:RefreshSelectChat()
    for _, v in pairs(self.tbAddressGridCtrl) do
      v:RefreshRedDotShow()
    end
  elseif self._panel.nCurTog == tog_Gift or self._panel.nCurTog == tog_Dating then
    self.nSelectIndex = 1
    self._mapNode.goChat:ResetPhone()
    if self._panel.nCurTog == tog_Gift then
      NovaAPI.SetTMPText(self._mapNode.txtPhoneTitle, ConfigTable.GetUIText("Phone_Tog_Gift"))
      self:RefreshCharList(false)
    else
      NovaAPI.SetTMPText(self._mapNode.txtPhoneTitle, ConfigTable.GetUIText("Phone_Tog_Dating"))
      self:RefreshDatingCharList()
    end
  end
end

function PhoneCtrl:ChangeTog(bInit)
  self._mapNode.goChat:ResetPhone()
  if not bInit and self.nLastTog ~= nil then
    self:PlayGridOutAnim()
    local sAnim = ""
    if self.nLastTog == tog_Chat then
      sAnim = "PhonePanel_List_out"
    else
      sAnim = "PhonePanel_GiftDating_out"
    end
    local nAnimLength = NovaAPI.GetAnimClipLength(self._mapNode.animContent, {sAnim})
    self._mapNode.animContent:Play(sAnim)
    EventManager.Hit(EventId.TemporaryBlockInput, nAnimLength)
    self:AddTimer(1, nAnimLength, function()
      self:PlayTogAnim()
      self:RefreshTogInfo(not bInit)
      self:PlayGridItemAnim()
    end, true, true, true)
  else
    self:RefreshTogInfo(not bInit)
    self:PlayGridItemAnim()
  end
  self.nLastTog = self._panel.nCurTog
  local nPosX = tbTogSelectPosX[self._panel.nCurTog]
  if not bInit then
    self._mapNode.rtImgBtnSelect:DOLocalMoveX(nPosX, 0.1):SetUpdate(true):SetEase(Ease.OutSine)
  else
    self._mapNode.rtImgBtnSelect:DOLocalMoveX(nPosX, 0):SetUpdate(true)
  end
  self._mapNode.togAddress:SetDefault(self._panel.nCurTog == tog_Chat)
  self._mapNode.togGift:SetDefault(self._panel.nCurTog == tog_Gift)
  self._mapNode.togDating:SetDefault(self._panel.nCurTog == tog_Dating)
end

function PhoneCtrl:RefreshAddressBookList(bSetTop, bTrackPos)
  for nInstanceId, objCtrl in pairs(self.tbAddressGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbAddressGridCtrl[nInstanceId] = nil
  end
  for k, v in ipairs(self.tbAddressBookList) do
    if nil == self.tbChatHistorySelect[v.nAddressId] then
      local tbChatList = v.tbChatList
      self.tbChatHistorySelect[v.nAddressId] = tbChatList[1].nChatId
    end
    if nil ~= self.nSelectAddressId and v.nAddressId == self.nSelectAddressId then
      self.nSelectIndex = k
    end
  end
  if nil == self.nSelectAddressId and nil ~= self.nSelectIndex then
    self.nSelectAddressId = self.tbAddressBookList[self.nSelectIndex].nAddressId
  end
  local bKeepPos = self.nSelectIndex ~= 1 or bSetTop
  self._mapNode.addressBookListLSV:Init(#self.tbAddressBookList, self, self.OnAddressGridRefresh, self.OnAddressGridBtnClick, bKeepPos)
  if bTrackPos then
    self._mapNode.addressBookListLSV:SetScrollGridPos(self.nSelectIndex - 1, 0.5)
  end
end

function PhoneCtrl:RefreshSelectChat()
  local mapAddressData = self.tbAddressBookList[self.nSelectIndex]
  if nil ~= mapAddressData then
    self._mapNode.goChat.gameObject:SetActive(true)
    self._mapNode.goChat:SetChatContent(mapAddressData, self.tbChatHistorySelect[self.nSelectAddressId])
  end
end

function PhoneCtrl:OnAddressGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbAddressGridCtrl[nInstanceID] then
    self.tbAddressGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.Phone.Chat.AddressBookItemCtrl")
  end
  local addressData = self.tbAddressBookList[nIndex]
  if nil ~= addressData then
    local nAddressId = addressData.nAddressId
    self.tbAddressGridCtrl[nInstanceID]:SetAddressData(nAddressId, self.tbChatHistorySelect[nAddressId], nIndex == #self.tbAddressBookList, addressData.bTop)
    if addressData.nAddressId == self.nSelectAddressId then
      self.tbAddressGridCtrl[nInstanceID]:SetSelect(true)
    end
  end
end

function PhoneCtrl:OnAddressGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  if nIndex == self.nSelectIndex then
    return
  end
  if self.nSelectIndex ~= nil then
    local goSelect = self._mapNode.trAddressLSV:Find("Viewport/Content/" .. self.nSelectIndex - 1)
    if goSelect then
      self.tbAddressGridCtrl[goSelect.gameObject:GetInstanceID()]:SetSelect(false)
    end
  end
  self.nSelectIndex = nIndex
  local nInstanceId = goGrid:GetInstanceID()
  self.tbAddressGridCtrl[nInstanceId]:SetSelect(true)
  local addressData = self.tbAddressBookList[self.nSelectIndex]
  self.nSelectAddressId = addressData.nAddressId
  self._mapNode.goChat.gameObject:SetActive(true)
  self._mapNode.goChat:RecordProcess()
  self._mapNode.goChat:SetChatContent(addressData, self.tbChatHistorySelect[self.nSelectAddressId])
end

function PhoneCtrl:RefreshCharList(bMax)
  self.mapCharList = {}
  local charList = PlayerData.Char:GetDataForCharList()
  for nCharId, v in pairs(charList) do
    local mapCfg = ConfigTable.GetData_Character(nCharId)
    if mapCfg ~= nil and mapCfg.Visible then
      local affinityData = PlayerData.Char:GetCharAffinityData(nCharId)
      local data = {nCharId = nCharId, affinityData = affinityData}
      table.insert(self.mapCharList, data)
    end
  end
  table.sort(self.mapCharList, function(a, b)
    if a.affinityData.Level == b.affinityData.Level then
      if a.affinityData.Exp == b.affinityData.Exp then
        return a.nCharId < b.nCharId
      end
      return a.affinityData.Exp > b.affinityData.Exp
    end
    return a.affinityData.Level > b.affinityData.Level
  end)
  if self._panel.nSelectCharId == nil and #self.mapCharList > 0 then
    self._panel.nSelectCharId = self.mapCharList[1].nCharId
  end
  for k, v in ipairs(self.mapCharList) do
    if self._panel.nSelectCharId ~= nil and self._panel.nSelectCharId == v.nCharId then
      self.nSelectIndex = k
    end
  end
  if not bMax then
    for nInstanceId, objCtrl in pairs(self.tbGiftGridCtrl) do
      self:UnbindCtrlByNode(objCtrl)
      self.tbGiftGridCtrl[nInstanceId] = nil
    end
    local bKeepPos = self.nSelectIndex ~= 1
    self._mapNode.giftListLSV:Init(#self.mapCharList, self, self.OnGiftGridRefresh, self.OnGiftGridBtnClick, bKeepPos)
  end
  self._mapNode.goGift:Refresh(self._panel.nSelectCharId)
  if self._panel.nSelectCharId ~= nil then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
      
      self:SetGiftScrollGridPos()
    end
    
    cs_coroutine.start(wait)
  end
end

function PhoneCtrl:OnGiftGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGiftGridCtrl[nInstanceID] then
    self.tbGiftGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.Phone.Gift.GiftCharItemCtrl")
  end
  if self.mapCharList[nIndex] ~= nil then
    local nCharId = self.mapCharList[nIndex].nCharId
    self.tbGiftGridCtrl[nInstanceID]:SetGiftCharItem(nCharId)
  end
  if nIndex == self.nSelectIndex then
    self.tbGiftGridCtrl[nInstanceID]:SetSelect(true)
  end
end

function PhoneCtrl:OnGiftGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  if nIndex == self.nSelectIndex then
    return
  end
  local goSelect = self._mapNode.trGiftLSV:Find("Viewport/Content/" .. self.nSelectIndex - 1)
  if goSelect then
    self.tbGiftGridCtrl[goSelect.gameObject:GetInstanceID()]:SetSelect(false)
  end
  self.nSelectIndex = nIndex
  local nInstanceId = goGrid:GetInstanceID()
  self.tbGiftGridCtrl[nInstanceId]:SetSelect(true)
  self._panel.nSelectCharId = self.mapCharList[self.nSelectIndex].nCharId
  self._mapNode.goGift:Refresh(self._panel.nSelectCharId)
end

function PhoneCtrl:RefreshDatingCharList()
  self.mapCharList = {}
  local charList = PlayerData.Char:GetDataForCharList()
  for nCharId, v in pairs(charList) do
    local mapCfg = ConfigTable.GetData_Character(nCharId)
    if mapCfg ~= nil and mapCfg.Visible then
      local affinityData = PlayerData.Char:GetCharAffinityData(nCharId)
      local data = {nCharId = nCharId, affinityData = affinityData}
      table.insert(self.mapCharList, data)
    end
  end
  table.sort(self.mapCharList, function(a, b)
    if a.affinityData.Level == b.affinityData.Level then
      if a.affinityData.Exp == b.affinityData.Exp then
        return a.nCharId < b.nCharId
      end
      return a.affinityData.Exp > b.affinityData.Exp
    end
    return a.affinityData.Level > b.affinityData.Level
  end)
  for nInstanceId, objCtrl in pairs(self.tbDatingGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbDatingGridCtrl[nInstanceId] = nil
  end
  if self._panel.nSelectCharId == nil and #self.mapCharList > 0 then
    self._panel.nSelectCharId = self.mapCharList[1].nCharId
  end
  for k, v in ipairs(self.mapCharList) do
    if self._panel.nSelectCharId == v.nCharId then
      self.nSelectIndex = k
    end
  end
  local bKeepPos = self.nSelectIndex ~= 1
  self._mapNode.datingListLSV:Init(#self.mapCharList, self, self.OnDatingGridRefresh, self.OnDatingGridBtnClick, bKeepPos)
  self._mapNode.goDating:Refresh(self._panel.nSelectCharId)
end

function PhoneCtrl:SetGiftScrollGridPos()
  if self.nSelectIndex ~= nil then
    self._mapNode.giftListLSV:SetScrollGridPos(self.nSelectIndex - 1, 0.5)
  end
end

function PhoneCtrl:OnDatingGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbDatingGridCtrl[nInstanceID] then
    self.tbDatingGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.Phone.Dating.DatingCharItemCtrl")
  end
  if self.mapCharList[nIndex] ~= nil then
    local nCharId = self.mapCharList[nIndex].nCharId
    self.tbDatingGridCtrl[nInstanceID]:SetDatingCharItem(nCharId)
  end
  if nIndex == self.nSelectIndex then
    self.tbDatingGridCtrl[nInstanceID]:SetSelect(true)
  end
end

function PhoneCtrl:OnDatingGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  if nIndex == self.nSelectIndex then
    return
  end
  local goSelect = self._mapNode.trDatingLSV:Find("Viewport/Content/" .. self.nSelectIndex - 1)
  if goSelect then
    self.tbDatingGridCtrl[goSelect.gameObject:GetInstanceID()]:SetSelect(false)
  end
  self.nSelectIndex = nIndex
  local nInstanceId = goGrid:GetInstanceID()
  self.tbDatingGridCtrl[nInstanceId]:SetSelect(true)
  self._panel.nSelectCharId = self.mapCharList[self.nSelectIndex].nCharId
  self._mapNode.goDating:Refresh(self._panel.nSelectCharId)
end

function PhoneCtrl:ShowPhoneTime()
  self:SetTime()
  if nil == self.phoneTimer then
    self.phoneTimer = self:AddTimer(0, 1, "SetTime", true, true, true)
  end
end

function PhoneCtrl:SetTime()
  local curTime = ClientManager.serverTimeStamp
  NovaAPI.SetTMPText(self._mapNode.txtTime, (os.date("%H:%M", curTime)))
end

function PhoneCtrl:FadeIn()
  local function func()
    PlayerData.SideBanner:TryOpenSideBanner()
    
    local mapDelay = PlayerData.Dating:GetCharFavourLevelUpDelay()
    if mapDelay ~= nil then
      EventManager.Hit(EventId.OpenPanel, PanelId.CharFavourLevelUp, mapDelay.nCharId, mapDelay.nCurLevel, mapDelay.nLastLevel, mapDelay.nCurExp, mapDelay.nLastExp)
      PlayerData.Dating:SetCharFavourLevelUpDelay(nil)
    end
  end
  
  EventManager.Hit(EventId.SetTransition, nil, func)
end

function PhoneCtrl:Awake()
  self.canvas = self.gameObject:GetComponent("Canvas")
  local bottomScreenPos = Vector2(0, 0)
  local localPos = GameUIUtils.ScreenPointToLocalPoint(bottomScreenPos, self._mapNode.goTop)
  local nHeight = math.abs(localPos.y)
  nHeight = nHeight > lsv_max_height and lsv_max_height or nHeight
  self._mapNode.trAddressLSV.sizeDelta = Vector2(self._mapNode.trAddressLSV.sizeDelta.x, nHeight)
  self._mapNode.trGiftLSV.sizeDelta = Vector2(self._mapNode.trGiftLSV.sizeDelta.x, nHeight)
  self._mapNode.trDatingLSV.sizeDelta = Vector2(self._mapNode.trDatingLSV.sizeDelta.x, nHeight)
  self._mapNode.togAddress:SetText(ConfigTable.GetUIText("Phone_Tog_Chat"))
  self._mapNode.togDating:SetText(ConfigTable.GetUIText("Phone_Tog_Dating"))
  self._mapNode.togGift:SetText(ConfigTable.GetUIText("Phone_Tog_Gift"))
  self.nLastTog = nil
  local tbParam = self:GetPanelParam()
  if nil ~= tbParam and nil ~= tbParam[1] then
    if self._panel.nCurTog == nil then
      self._panel.nCurTog = tbParam[1]
    end
    if nil ~= tbParam[2] and self._panel.nSelectCharId == nil then
      self._panel.nSelectCharId = tbParam[2]
    end
  end
end

function PhoneCtrl:OnEnable()
  PanelManager.SetMainViewSkipAnimIn(true)
  local sortingOrder = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
  local nId = CS.UnityEngine.SortingLayer.NameToID(AllEnum.SortingLayerName.UI)
  NovaAPI.SetCanvasSortingId(self._mapNode.rtImgMsgDetail, nId)
  NovaAPI.SetCanvasSortingOrder(self._mapNode.rtImgMsgDetail, sortingOrder + 1)
  self.tbAddressBookList = {}
  self.tbAddressGridCtrl = {}
  self.tbGiftGridCtrl = {}
  self.tbDatingGridCtrl = {}
  self.tbChatHistorySelect = {}
  self.phoneTimer = nil
  self._mapNode.goContent.gameObject:SetActive(false)
  self._mapNode.imgBlurredBg.gameObject:SetActive(false)
  self._mapNode.btnReceiveReward.gameObject:SetActive(false)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goContent.gameObject:SetActive(true)
    if self._panel.nCurTog == nil then
      self._panel.nCurTog = tog_Chat
    end
    if self._panel.nCurTog == tog_Chat then
      self._mapNode.animContent:Play("PhonePanel_in", 0, 0)
    elseif self._panel.nCurTog == tog_Dating then
      self._mapNode.animContent:Play("PhonePanel_Dating_in", 0, 0)
    elseif self._panel.nCurTog == tog_Gift then
      self._mapNode.animContent:Play("PhonePanel_Gift_in", 0, 0)
    end
    local nAnimLength = NovaAPI.GetAnimClipLength(self._mapNode.animContent, {
      "PhonePanel_in"
    })
    EventManager.Hit(EventId.TemporaryBlockInput, nAnimLength)
    self._mapNode.goChat.gameObject:SetActive(false)
    self:ChangeTog(true)
    self:ShowPhoneTime()
  end
  
  cs_coroutine.start(wait)
end

function PhoneCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbAddressGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbAddressGridCtrl[nInstanceId] = nil
  end
  self.tbAddressGridCtrl = {}
  for nInstanceId, objCtrl in pairs(self.tbGiftGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGiftGridCtrl[nInstanceId] = nil
  end
  self.tbGiftGridCtrl = {}
  for nInstanceId, objCtrl in pairs(self.tbDatingGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbDatingGridCtrl[nInstanceId] = nil
  end
  self.tbDatingGridCtrl = {}
  self.phoneTimer = nil
end

function PhoneCtrl:OnDestroy()
end

function PhoneCtrl:OnBtnClick_Close()
  local nAnimLength = NovaAPI.GetAnimClipLength(self._mapNode.animContent, {
    "PhonePanel_out"
  })
  self._mapNode.animContent:Play("PhonePanel_out")
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimLength)
  self:AddTimer(1, nAnimLength, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.Phone)
  end, true, true, true, true)
end

function PhoneCtrl:OnBtnClick_Address()
  if self._panel.nCurTog == tog_Chat then
    return
  end
  self._panel.nCurTog = tog_Chat
  self:ChangeTog()
end

function PhoneCtrl:OnBtnClick_Dating()
  if self._panel.nCurTog == tog_Dating then
    return
  end
  self._panel.nCurTog = tog_Dating
  self:ChangeTog()
end

function PhoneCtrl:OnEvent_FreeDatingChanged()
  if self._panel.nCurTog == tog_Dating then
    self:RefreshDatingCharList()
  end
end

function PhoneCtrl:OnBtnClick_Gift()
  if self._panel.nCurTog == tog_Gift then
    return
  end
  self._panel.nCurTog = tog_Gift
  self:ChangeTog()
end

function PhoneCtrl:OnEvent_RefreshPhoneAddress(nChatId, bRefreshContent)
  self.tbChatHistorySelect[self.nSelectAddressId] = nChatId
  if bRefreshContent == true then
    self._mapNode.goChat:RefreshChatContent(nChatId, true)
  end
  if self.nSelectIndex == nil then
    return
  end
  local goSelect = self._mapNode.trAddressLSV:Find("Viewport/Content/" .. self.nSelectIndex - 1)
  if goSelect then
    self.tbAddressGridCtrl[goSelect.gameObject:GetInstanceID()]:RefreshChatContent(nChatId)
  end
  for _, v in pairs(self.tbAddressGridCtrl) do
    v:RefreshRedDotShow()
  end
end

function PhoneCtrl:OnEvent_NewChatTrigger(nAddressId, nChatId)
  if self._panel.nCurTog ~= tog_Chat then
    return
  end
  self._mapNode.goChat:ResetPhone()
  local newAddressData = PlayerData.Phone:GetAddressBookData(nAddressId)
  local tbNewAddress = {}
  if newAddressData.bTop == true then
    tbNewAddress = PlayerData.Phone:GetAddressBookList()
  else
    for _, v in ipairs(self.tbAddressBookList) do
      if v.nAddressId ~= nAddressId then
        table.insert(tbNewAddress, v)
      end
    end
    local nTopCount = PlayerData.Phone:GetTopCount()
    table.insert(tbNewAddress, nTopCount + 1, newAddressData)
  end
  self.nSelectAddressId = nAddressId
  self.tbAddressBookList = tbNewAddress
  self:RefreshAddressBookList(false, true)
  self._mapNode.goChat:SetChatContent(newAddressData, nChatId)
  self:OnEvent_RefreshPhoneAddress(nChatId, false)
  WwiseAudioMgr:PostEvent("ui_cellphone_message_pop")
end

function PhoneCtrl:OnEvent_RefreshRedDot()
  for _, v in pairs(self.tbAddressGridCtrl) do
    v:RefreshRedDotShow()
  end
end

function PhoneCtrl:OnEvent_RefreshCharList(bMax)
  if self._panel.nCurTog == tog_Gift then
    self:RefreshCharList(bMax)
  end
end

function PhoneCtrl:OnEvent_RefreshSortingOrder(nValue)
  if nValue ~= nil then
    NovaAPI.SetCanvasSortingOrder(self.canvas, nValue)
  else
    NovaAPI.SetCanvasSortingOrder(self.canvas, self._nSortingOrder)
  end
end

function PhoneCtrl:OnEvent_OpenEventDetailWindow(bOpen)
  self._mapNode.btnClosePanel.gameObject:SetActive(not bOpen)
end

function PhoneCtrl:OnEvent_ChangePhoneListTopStatus(nAddressId, bTop)
  PlayerData.Phone:SetPhoneTopStatus(nAddressId, bTop)
  self.tbAddressBookList = PlayerData.Phone:GetAddressBookList()
  self:RefreshAddressBookList(true, false)
  for nIdx, v in ipairs(self.tbAddressBookList) do
    if v.nAddressId == nAddressId and bTop == true then
      self._mapNode.addressBookListLSV:SetScrollGridPos(nIdx - 1, 0.5)
      return
    end
  end
end

function PhoneCtrl:OnEvent_PhoneChatTopLimit()
  if self._mapNode.goTopTip.activeInHierarchy then
    return
  end
  self._mapNode.goTopTip:SetActive(true)
  self._mapNode.addressBookListAnim:Play("TemplateTip_in")
  self:AddTimer(1, 1, function()
    self._mapNode.addressBookListAnim:Play("TemplateTip_out")
  end, true, true, true)
end

function PhoneCtrl:OnEvent_EnableReceiveChatReward(bEnable)
  self._mapNode.btnReceiveReward.gameObject:SetActive(bEnable)
end

function PhoneCtrl:OnBtnClick_ReceiveReward()
  EventManager.Hit("ReceiveChatReward")
end

return PhoneCtrl
