local SoldierRecommendCtrl = class("SoldierRecommendCtrl", BaseCtrl)
local SDKManager = CS.SDKManager.Instance
SoldierRecommendCtrl._mapNodeConfig = {
  Topbar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  btnHome = {},
  txt_tips = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Recommend_GoToWebTips"
  },
  txt_CollectionProgress = {sComponentName = "TMP_Text"},
  rtCollectionProgress = {},
  sv_recommend = {
    sComponentName = "LoopScrollView"
  },
  btnRcmdSquare = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_RcmdSquare"
  },
  txtRcmdSquare = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Recommend_RcmdSquare"
  },
  btnImportRcmd = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ImportRcmd"
  },
  txtImportRcmd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Recommend_ImportRcmd"
  },
  btn_recommend = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Recommend"
  },
  go_recommend_in = {},
  go_recommend_off = {},
  txt_BtnRecommend = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Recommend_Recommend"
  },
  btn_collect = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Collect"
  },
  txt_BtnCollect = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Recommend_Collect"
  },
  go_collect_in = {},
  go_collect_off = {},
  rtEmpty = {},
  txtNoRcmd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Recommend_NoRcmd"
  },
  goImport = {},
  blurImport = {},
  btnCloseImport = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseImport"
  },
  goImportWindow = {},
  animWindow = {
    sNodeName = "---Import---",
    sComponentName = "Animator"
  },
  btnConfirmImport = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ConfirmImport"
  },
  input = {
    sComponentName = "TMP_InputField",
    callback = "OnValueChanged_Import"
  },
  txtImportWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Recommend_ImportRcmd"
  },
  txtImportTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Recommend_Import_Tips"
  },
  txtBtnConfirmImport = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Confirm"
  }
}
SoldierRecommendCtrl._mapEventConfig = {
  RefreshSoldierRecommendList = "OnEvent_RefreshRecommendList"
}
SoldierRecommendCtrl._mapRedDotConfig = {}

function SoldierRecommendCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.bInSoldier = param[1]
  end
  self.bInSoldier = self.bInSoldier or false
  self.animator = self.gameObject:GetComponent("Animator")
  self.nListState = 1
end

function SoldierRecommendCtrl:OnEnable()
  self._bListActive = true
  self._bWaitingEnterAnim = true
  self:SetListInputBlocked(true)
  self._mapNode.btnHome.gameObject:SetActive(not self.bInSoldier)
  self:RefreshListHeader()
  local canvas = self.gameObject:GetComponent("Canvas")
  NovaAPI.SetCanvasSortingOrder(canvas, self._nSortingOrder + 1)
  local bNewCache = self._tbListCache == nil
  if bNewCache then
    self.tbRecommendCellCtrl = {}
    self.tbRecommendData = {}
    self._tbListCache = {}
    self._nVisibleListState = nil
  end
  local svList = self._mapNode.sv_recommend
  self._goRecommendTemplate = svList.transform:Find("grid").gameObject
  self._goRecommendTemplate:SetActive(false)
  self._rtRecommendContent = svList.content
  self._objRecommendLayout = self._rtRecommendContent:GetComponent("GridLayoutGroup")
  self._objRecommendLayout.enabled = false
  local objFitter = self._rtRecommendContent:GetComponent("ContentSizeFitter")
  if objFitter ~= nil then
    objFitter.enabled = false
  end
  self._rtRecommendContent.pivot = Vector2(0, 1)
  self._rtRecommendContent.anchorMin = Vector2(0, 1)
  self._rtRecommendContent.anchorMax = Vector2(1, 1)
  self._rtRecommendContent.gameObject:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.txtNoRcmd, ConfigTable.GetUIText("Soldier_Recommend_Loading"))
  self._mapNode.rtEmpty.gameObject:SetActive(true)
  EventManager.Hit("SoldierRecommendPanel_Open")
  self._mapNode.goImport:SetActive(false)
  local tbListCache = self._tbListCache
  if bNewCache then
    PlayerData.SoldierData:RequestRecommendList(function()
      if self._bListActive and self._tbListCache == tbListCache then
        self:RefreshRecommendList()
      end
    end)
  end
  if tbListCache[1] ~= nil and tbListCache[1].bLoaded and tbListCache[2] ~= nil and tbListCache[2].bLoaded then
    self:ShowRecommendList()
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if not self._bListActive then
      return
    end
    while self._bListActive and self.animator ~= nil and self.animator.isActiveAndEnabled do
      local objState = self.animator:GetCurrentAnimatorStateInfo(0)
      if not objState:IsName("SoldierRecommendPanel_in") or objState.normalizedTime >= 1 then
        break
      end
      coroutine.yield(nil)
    end
    if not self._bListActive then
      return
    end
    self._bWaitingEnterAnim = false
    self:RefreshRecommendList()
  end
  
  self._coOpenList = cs_coroutine.start(wait)
end

function SoldierRecommendCtrl:OnPreExit()
  if self._bListActive and self._nVisibleListState ~= nil then
    local mapCache = self._tbListCache[self._nVisibleListState]
    mapCache.v2Position = self._rtRecommendContent.anchoredPosition
    mapCache.v2Size = self._rtRecommendContent.sizeDelta
  end
  self._bListActive = false
  self._bWaitingEnterAnim = false
  if self._coOpenList ~= nil then
    cs_coroutine.stop(self._coOpenList)
    self._coOpenList = nil
  end
  self:StopListLoading()
  self:SetListInputBlocked(false)
end

function SoldierRecommendCtrl:SetListInputBlocked(bBlocked)
  if self._bListInputBlocked == true == bBlocked then
    return
  end
  self._bListInputBlocked = bBlocked
  EventManager.Hit(EventId.BlockInput, bBlocked)
end

function SoldierRecommendCtrl:StopListLoading()
  if self._coLoadList ~= nil then
    cs_coroutine.stop(self._coLoadList)
    self._coLoadList = nil
  end
end

function SoldierRecommendCtrl:OnDisable()
  self:OnPreExit()
  EventManager.Hit("SoldierRecommendPanel_Close")
end

function SoldierRecommendCtrl:OnDestroy()
  self:OnPreExit()
  self:ClearListCache()
end

function SoldierRecommendCtrl:ClearListCache()
  self._tbListCache = nil
  self._nVisibleListState = nil
  self.tbRecommendCellCtrl = nil
  self.tbRecommendData = nil
  self._goRecommendTemplate = nil
  self._rtRecommendContent = nil
  self._objRecommendLayout = nil
end

function SoldierRecommendCtrl:RefreshListHeader()
  self._mapNode.rtCollectionProgress.gameObject:SetActive(self.nListState == 2)
  if self.nListState == 2 then
    local tbCollectData = PlayerData.SoldierData:GetCollectRecommendList()
    local nMaxFavorite = ConfigTable.GetConfigNumber("SoldierBattleReportFavoriteLimit")
    local nFavoriteCount = tbCollectData and #tbCollectData or 0
    local sText = orderedFormat(ConfigTable.GetUIText("Soldier_Recommend_Favored"), nFavoriteCount, nMaxFavorite)
    NovaAPI.SetTMPText(self._mapNode.txt_CollectionProgress, sText)
  end
  self._mapNode.go_recommend_in:SetActive(self.nListState == 1)
  self._mapNode.go_recommend_off:SetActive(self.nListState ~= 1)
  self._mapNode.go_collect_in:SetActive(self.nListState == 2)
  self._mapNode.go_collect_off:SetActive(self.nListState ~= 2)
end

function SoldierRecommendCtrl:RefreshRecommendList()
  if not self._bListActive then
    return
  end
  self:RefreshListHeader()
  if self._bWaitingEnterAnim then
    return
  end
  local tbSources = {
    PlayerData.SoldierData:GetSystemRecommendList(),
    PlayerData.SoldierData:GetCollectRecommendList()
  }
  local tbPending = {}
  for nState = 1, 2 do
    local mapCache = self._tbListCache[nState]
    if mapCache == nil then
      mapCache = {
        tbCellCtrl = {},
        tbData = {}
      }
      self._tbListCache[nState] = mapCache
    end
    if not mapCache.bLoaded or mapCache.tbSource ~= tbSources[nState] then
      table.insert(tbPending, nState)
    end
  end
  if #tbPending == 0 and self._nVisibleListState == self.nListState then
    self:SetListInputBlocked(false)
    return
  end
  self:StopListLoading()
  self._mapNode.sv_recommend:StopMovement()
  local mapPrevious = self._tbListCache[self._nVisibleListState]
  if mapPrevious ~= nil then
    mapPrevious.v2Position = self._rtRecommendContent.anchoredPosition
    mapPrevious.v2Size = self._rtRecommendContent.sizeDelta
  end
  self._rtRecommendContent.gameObject:SetActive(false)
  if #tbPending == 0 then
    self:ShowRecommendList()
    self:SetListInputBlocked(false)
    return
  end
  self:SetListInputBlocked(true)
  NovaAPI.SetTMPText(self._mapNode.txtNoRcmd, ConfigTable.GetUIText("Soldier_Recommend_Loading"))
  self._mapNode.rtEmpty.gameObject:SetActive(true)
  self._coLoadList = cs_coroutine.start(function()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(nil)
    if not self._bListActive then
      self:SetListInputBlocked(false)
      return
    end
    local bSuccess, sError = pcall(function()
      for _, nState in ipairs(tbPending) do
        self:LoadRecommendList(self._tbListCache[nState], tbSources[nState])
      end
      self:ShowRecommendList()
    end)
    self._coLoadList = nil
    self:SetListInputBlocked(false)
    if not bSuccess then
      printError(sError)
    end
  end)
end

function SoldierRecommendCtrl:ShowRecommendList()
  local mapCache = self._tbListCache[self.nListState]
  for nState, mapTabCache in pairs(self._tbListCache) do
    for nIndex, objCell in ipairs(mapTabCache.tbCellCtrl) do
      local bActive = nState == self.nListState and nIndex <= #mapTabCache.tbData
      if objCell.gameObject.activeSelf ~= bActive then
        objCell.gameObject:SetActive(bActive)
      end
    end
  end
  self._nVisibleListState = self.nListState
  self.tbRecommendCellCtrl = mapCache.tbCellCtrl
  self.tbRecommendData = mapCache.tbData
  self._rtRecommendContent.sizeDelta = mapCache.v2Size
  self._rtRecommendContent.anchoredPosition = mapCache.v2Position
  local bHasData = #mapCache.tbData > 0
  self._rtRecommendContent.gameObject:SetActive(bHasData)
  if not mapCache.bAnimationReady then
    for nIndex = 1, #mapCache.tbData do
      local objAnimator = mapCache.tbCellCtrl[nIndex].gameObject:GetComponent("Animator")
      if objAnimator ~= nil then
        objAnimator.enabled = true
        objAnimator:Play("go", 0, 1)
        objAnimator:Update(0)
        objAnimator.enabled = false
      end
    end
    mapCache.bAnimationReady = true
  end
  NovaAPI.SetTMPText(self._mapNode.txtNoRcmd, ConfigTable.GetUIText("Soldier_Recommend_NoRcmd"))
  self._mapNode.rtEmpty.gameObject:SetActive(not bHasData)
end

function SoldierRecommendCtrl:LoadRecommendList(mapCache, tbSource)
  mapCache.bLoaded = false
  mapCache.bAnimationReady = false
  mapCache.tbData = {}
  for _, mapData in ipairs(tbSource or {}) do
    table.insert(mapCache.tbData, mapData)
  end
  local mapApplyData = PlayerData.SoldierData:GetRecommendData(self.bInSoldier)
  if mapApplyData ~= nil then
    table.sort(mapCache.tbData, function(mapFirst, mapSecond)
      if mapFirst.nRecommendId == mapSecond.nRecommendId then
        return false
      end
      if mapFirst.nRecommendId == mapApplyData.nRecommendId then
        return true
      end
      if mapSecond.nRecommendId == mapApplyData.nRecommendId then
        return false
      end
      return mapFirst.nRecommendId < mapSecond.nRecommendId
    end)
  end
  local objLayout = self._objRecommendLayout
  local v2CellSize = objLayout.cellSize
  local nSpacing = objLayout.spacing.y
  local nTop = objLayout.padding.top
  for nIndex, mapData in ipairs(mapCache.tbData) do
    local objCell = mapCache.tbCellCtrl[nIndex]
    if objCell == nil then
      local goItem = instantiate(self._goRecommendTemplate, self._rtRecommendContent)
      local rtItem = goItem:GetComponent("RectTransform")
      rtItem.pivot = Vector2(0, 1)
      rtItem.anchorMin = Vector2(0, 1)
      rtItem.anchorMax = Vector2(0, 1)
      rtItem.localScale = Vector3.one
      rtItem.sizeDelta = v2CellSize
      rtItem.anchoredPosition = Vector2(objLayout.padding.left, -nTop - (nIndex - 1) * (v2CellSize.y + nSpacing))
      objCell = self._panel:BindRecommendCtrl(goItem, "Game.UI.Soldier.Recommend.SoldierRecommendCellCtrl")
      mapCache.tbCellCtrl[nIndex] = objCell
      objCell:SetDetailCallback(self, nIndex)
    end
    objCell:SetItemData(mapData, self.bInSoldier)
  end
  local nCount = #mapCache.tbData
  mapCache.v2Size = Vector2(0, nTop + nCount * v2CellSize.y + math.max(0, nCount - 1) * nSpacing + objLayout.padding.bottom)
  mapCache.v2Position = Vector2.zero
  mapCache.tbSource = tbSource
  mapCache.bLoaded = true
end

function SoldierRecommendCtrl:InitData()
  self:RefreshRecommendList()
end

function SoldierRecommendCtrl:OnRecommendGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapRecommendData = self.tbRecommendData[nIndex]
  self.animator:Play("SoldierRecommendPanel_out")
  self:AddTimer(1, 0.26, function()
    EventManager.Hit(EventId.OpenPanel, PanelId.SoldierRecommendDetailPanel, mapRecommendData, self.bInSoldier)
  end, true, true, true)
end

function SoldierRecommendCtrl:OnBtnClick_Recommend()
  if self.nListState == 1 then
    return
  end
  self.nListState = 1
  self:RefreshRecommendList()
end

function SoldierRecommendCtrl:OnBtnClick_Collect()
  if self.nListState == 2 then
    return
  end
  self.nListState = 2
  self:RefreshRecommendList()
end

function SoldierRecommendCtrl:OnBtnClick_ImportRcmd()
  self._mapNode.goImport:SetActive(true)
  self._mapNode.blurImport:SetActive(true)
  self._mapNode.animWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function SoldierRecommendCtrl:OnBtnClick_CloseImport()
  self._mapNode.animWindow:Play("t_window_04_t_out")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, function()
    self._mapNode.goImport:SetActive(false)
  end, true, true, true)
end

function SoldierRecommendCtrl:OnValueChanged_Import(_, sContent)
  if sContent == nil or sContent == "" then
    return
  end
  local sFiltered = string.gsub(sContent, "[^A-Za-z0-9+/=]", "")
  if sFiltered ~= sContent then
    NovaAPI.SetTMPInputFieldText(self._mapNode.input, sFiltered)
  end
end

function SoldierRecommendCtrl:OnBtnClick_ConfirmImport()
  local sCode = NovaAPI.GetTMPInputFieldText(self._mapNode.input)
  if sCode == "" then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("BUILD_05"))
    return
  end
  PlayerData.SoldierData:SendFavoriteRecommend(sCode, function()
    if not self._bListActive then
      return
    end
    PlayerData.SoldierData:RequestRecommendList(function()
      if not self._bListActive then
        return
      end
      self.nListState = 2
      NovaAPI.SetTMPInputFieldText(self._mapNode.input, "")
      self:OnBtnClick_CloseImport()
      self:RefreshRecommendList()
    end)
  end)
end

function SoldierRecommendCtrl:OnBtnClick_RcmdSquare()
  local bHasUrl, sUrl = UTILS.GetToolBoxUrl()
  if not (bHasUrl and sUrl) or sUrl == "" then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    return
  end
  sUrl = sUrl .. "/auto-chess"
  local bSuccess, bOpened = pcall(function()
    if NovaAPI.IsEditorPlatform() then
      NovaAPI.OpenURL(sUrl)
      return true
    end
    if not SDKManager:IsSDKInit() then
      return false
    end
    SDKManager:ShowWebView(false, "", sUrl, 1, 0, true)
    return true
  end)
  if not bSuccess then
    printError(bOpened)
  end
  if not bSuccess or not bOpened then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
  end
end

function SoldierRecommendCtrl:OnEvent_RefreshRecommendList()
  if self.nListState == 2 then
    self:RefreshRecommendList()
  end
end

return SoldierRecommendCtrl
