local AnnouncementCtrl = class("AnnouncementCtrl", BaseCtrl)
local SDKManager = CS.SDKManager.Instance
local Data = PlayerData.AnnouncementData
local titleText = {
  "Ann_Activity",
  "Ann_System",
  "Ann_Activity",
  "Ann_Activity"
}
local titleStartIndex = {
  [2] = 1,
  [3] = 3,
  [4] = 6
}
local titleNormalColor = Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764)
local titleSelectedColor = Color(0.9803921568627451, 0.9803921568627451, 0.9803921568627451)
AnnouncementCtrl._mapNodeConfig = {
  title = {nCount = 9},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Announcement"
  },
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnClose = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  loosv = {
    sNodeName = "sv",
    sComponentName = "LoopScrollView"
  },
  content = {sNodeName = "UIWebView", sComponentName = "UIWebView"},
  go_tab2 = {sNodeName = "---Tab2---"},
  go_tab3 = {sNodeName = "---Tab3---"},
  go_tab4 = {sNodeName = "---Tab4---"},
  txt_tips = {sComponentName = "TMP_Text", sLanguageId = "Ann_Tips"},
  img_done2 = {},
  img_done4 = {},
  btn_Auto = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Auto"
  }
}
AnnouncementCtrl._mapEventConfig = {
  AnnContentReady = "OnEvent_UpdateContent",
  AnnInit = "Init",
  OpenSDKWebView = "OnEvent_OpenSDKWebView"
}
AnnouncementCtrl._mapRedDotConfig = {}

function AnnouncementCtrl:Awake()
  self.tbTitleCache = {}
  self.tbInfoList = {}
  self.nCurTitleType = 0
  self.nCurAnnId = 0
  self.tbGridGo = {}
  self.nTotalType = 0
  self.canvasGroup = self.gameObject:GetComponent("CanvasGroup")
  self.bAutoInit = false
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.bAutoInit = param[1]
  end
  if self.bAutoInit then
    self:Init()
  else
    NovaAPI.SetCanvasGroupAlpha(self.canvasGroup, 0)
    NovaAPI.SetCanvasGroupInteractable(self.canvasGroup, false)
    NovaAPI.SetCanvasGroupBlocksRaycasts(self.canvasGroup, false)
    
    local function callback()
    end
    
    self._mapNode.content:InitIWebView(callback)
  end
  self._mapNode.txt_tips.gameObject:SetActive(not self.bAutoInit)
  self._mapNode.img_done2.gameObject:SetActive(not self.bAutoInit)
  self._mapNode.img_done4.gameObject:SetActive(not self.bAutoInit)
  self._mapNode.btn_Auto.gameObject:SetActive(not self.bAutoInit)
end

function AnnouncementCtrl:Init()
  self:InitTitle()
  local bIsAuto = Data:GetAutoOpen()
  self._mapNode.img_done2.gameObject:SetActive(not bIsAuto)
  self._mapNode.img_done4.gameObject:SetActive(bIsAuto)
  
  local function callback()
    EventManager.Hit(EventId.BlockInput, false)
    local nIndex = titleStartIndex[self.nTotalType]
    self:SelectedGrid(nIndex, 1)
  end
  
  EventManager.Hit(EventId.BlockInput, true)
  self._mapNode.content:InitIWebView(callback)
  NovaAPI.SetCanvasGroupAlpha(self.canvasGroup, 1)
  NovaAPI.SetCanvasGroupInteractable(self.canvasGroup, true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self.canvasGroup, true)
  Data:UpdateLastAnnData()
end

function AnnouncementCtrl:InitTitle()
  self._mapNode.go_tab2:SetActive(false)
  self._mapNode.go_tab3:SetActive(false)
  self._mapNode.go_tab4:SetActive(false)
  self.nTotalType = 0
  local tbTypeList = {}
  for i = 1, #titleText do
    local typeListData = Data:GetAnnInfoByType(i)
    if typeListData ~= nil then
      self.nTotalType = self.nTotalType + 1
      table.insert(tbTypeList, i)
    end
  end
  if self.nTotalType == 2 then
    self._mapNode.go_tab2:SetActive(true)
  elseif self.nTotalType == 3 then
    self._mapNode.go_tab3:SetActive(true)
  elseif self.nTotalType == 4 then
    self._mapNode.go_tab4:SetActive(true)
  else
    printError("公告的标题栏不支持显示" .. self.nTotalType .. "种")
  end
  local nTypeListIndex = 1
  local nStartIndex = titleStartIndex[self.nTotalType]
  for i = nStartIndex, nStartIndex + self.nTotalType - 1 do
    local nType = tbTypeList[nTypeListIndex]
    local go_btn = self._mapNode.title[i]
    self.tbTitleCache[i] = nType
    local txtTitle = go_btn.transform:Find("AnimRoot/txtBtn")
    NovaAPI.SetTMPText(txtTitle:GetComponent("TMP_Text"), ConfigTable.GetUIText(titleText[nType]))
    local btn = go_btn:GetComponent("UIButton")
    local nIndex = i
    btn.onClick:RemoveAllListeners()
    btn.onClick:AddListener(function()
      self:SelectedGrid(nIndex, 1)
    end)
    local reddot = go_btn.transform:Find("AnimRoot/t_red_dot_01")
    RedDotManager.RegisterNode(RedDotDefine.Announcement_Tab, nType, reddot)
    nTypeListIndex = nTypeListIndex + 1
  end
end

function AnnouncementCtrl:RefreshAnnInfoByType(nType)
  self.tbInfoList = Data:GetAnnInfoByType(nType)
end

function AnnouncementCtrl:RefreshGrid()
  self._mapNode.loosv:SetAnim(0.1)
  self._mapNode.loosv:Init(#self.tbInfoList, self, self.OnGridRefresh)
end

function AnnouncementCtrl:OnGridRefresh(gridGo, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = gridGo:GetInstanceID()
  if self.tbGridGo[nInstanceId] == nil then
    self.tbGridGo[nInstanceId] = gridGo
  end
  local btn = gridGo:GetComponent("UIButton")
  local reddot = gridGo.transform:Find("AnimRoot/t_red_dot_01")
  RedDotManager.RegisterNode(RedDotDefine.Announcement_Content, {
    self.nCurTitleType,
    self.tbInfoList[nIndex].Id
  }, reddot)
  local go_shadow = gridGo.transform:Find("AnimRoot/imgBgMask")
  local txt_title = gridGo.transform:Find("AnimRoot/txtBtn")
  local go_bg = gridGo.transform:Find("AnimRoot/imgBg")
  local bIsCur = self.tbInfoList[nIndex].Id == self.nCurAnnId
  go_shadow.gameObject:SetActive(bIsCur)
  go_bg.gameObject:SetActive(not bIsCur)
  if bIsCur then
    NovaAPI.SetTMPColor(txt_title:GetComponent("TMP_Text"), titleSelectedColor)
  else
    NovaAPI.SetTMPColor(txt_title:GetComponent("TMP_Text"), titleNormalColor)
  end
  local title = gridGo.transform:Find("AnimRoot/txtBtn")
  NovaAPI.SetTMPText(title:GetComponent("TMP_Text"), self.tbInfoList[nIndex].Title)
  btn.onClick:RemoveAllListeners()
  local nTitleIndex = table.keyof(self.tbTitleCache, self.nCurTitleType)
  btn.onClick:AddListener(function()
    self:SelectedGrid(nTitleIndex, nIndex, gridGo)
  end)
end

function AnnouncementCtrl:UpdateTitle(nIndex)
  local nStartIndex = titleStartIndex[self.nTotalType]
  for i = nStartIndex, nStartIndex + self.nTotalType - 1 do
    local go = self._mapNode.title[i]
    local go_shadow = go.transform:Find("AnimRoot/img_shadow")
    local txt_title = go.transform:Find("AnimRoot/txtBtn")
    local go_bg = go.transform:Find("AnimRoot/imgBg")
    go_shadow.gameObject:SetActive(i == nIndex)
    go_bg.gameObject:SetActive(i == nIndex)
    if i == nIndex then
      NovaAPI.SetTMPColor(txt_title:GetComponent("TMP_Text"), titleSelectedColor)
    else
      NovaAPI.SetTMPColor(txt_title:GetComponent("TMP_Text"), titleNormalColor)
    end
  end
end

function AnnouncementCtrl:SelectedGrid(nTitleIndex, nAnnIndex, gridGo)
  if self.nCurTitleType ~= self.tbTitleCache[nTitleIndex] then
    Data:SetAnnRead(self.nCurTitleType, 0)
    self.nCurTitleType = self.tbTitleCache[nTitleIndex]
    self:UpdateTitle(nTitleIndex)
    self:RefreshAnnInfoByType(self.nCurTitleType)
  end
  if self.nCurAnnId ~= self.tbInfoList[nAnnIndex].Id then
    self.nCurAnnId = self.tbInfoList[nAnnIndex].Id
  end
  if gridGo == nil then
    self:RefreshGrid()
  else
    for _, value in pairs(self.tbGridGo) do
      local go_shadow = value.transform:Find("AnimRoot/imgBgMask")
      local txt_title = value.transform:Find("AnimRoot/txtBtn")
      local go_bg = value.transform:Find("AnimRoot/imgBg")
      if value == gridGo then
        go_shadow.gameObject:SetActive(true)
        go_bg.gameObject:SetActive(false)
        NovaAPI.SetTMPColor(txt_title:GetComponent("TMP_Text"), titleSelectedColor)
      else
        go_shadow.gameObject:SetActive(false)
        go_bg.gameObject:SetActive(true)
        NovaAPI.SetTMPColor(txt_title:GetComponent("TMP_Text"), titleNormalColor)
      end
    end
  end
  self:UpdateContent(self.nCurAnnId)
  Data:SetAnnRead(self.nCurTitleType, self.tbInfoList[nAnnIndex].Id)
end

function AnnouncementCtrl:UpdateContent(nId)
  local htmlContent = Data:GetHtmlData(nId)
  local htmlFrame = Data:GetHtmlFrame()
  if htmlContent ~= nil then
    self._mapNode.content:LoadHTML(htmlFrame, htmlContent)
  else
    self._mapNode.content:LoadURL("about:blank")
  end
end

function AnnouncementCtrl:OnBtnClick_Close()
  Data:SetAnnRead(self.nCurTitleType, 0)
  if self.bAutoInit then
    EventManager.Hit(EventId.ClosePanel, PanelId.AnnouncementPanel)
  else
    NovaAPI.SetCanvasGroupAlpha(self.canvasGroup, 0)
    NovaAPI.SetCanvasGroupInteractable(self.canvasGroup, false)
    NovaAPI.SetCanvasGroupBlocksRaycasts(self.canvasGroup, false)
    EventManager.Hit("AnnPanelClose")
  end
end

function AnnouncementCtrl:OnBtnClick_Auto()
  local bAuto = Data:GetAutoOpen()
  Data:SetAutoOpen(not bAuto)
  self._mapNode.img_done2.gameObject:SetActive(bAuto)
  self._mapNode.img_done4.gameObject:SetActive(not bAuto)
end

function AnnouncementCtrl:OnEvent_UpdateContent(nId)
  if nId ~= self.nCurAnnId then
    return
  end
  self:UpdateContent(nId)
end

function AnnouncementCtrl:OnEvent_OpenSDKWebView(url)
  if string.find(url, "https") == nil then
    return
  end
  if SDKManager:IsSDKInit() then
    SDKManager:ShowWebView(false, "", url, 1, 1, true)
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
  end
end

return AnnouncementCtrl
