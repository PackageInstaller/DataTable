local DictionaryCtrl = class("DictionaryCtrl", BaseCtrl)
local ModuleManager = require("GameCore.Module.ModuleManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
DictionaryCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  animRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  aniEntry = {sComponentName = "Animator"},
  cvBase = {
    sNodeName = "goEntryBase",
    sComponentName = "Canvas"
  },
  cvAni = {sNodeName = "goEntryAni", sComponentName = "Canvas"},
  cgEntryAni = {
    sNodeName = "goEntryAni",
    sComponentName = "CanvasGroup"
  },
  goEmpty = {nCount = 2},
  goBottom = {},
  goType = {nCount = 4},
  imgEntry = {nCount = 2, sComponentName = "Image"},
  txtEntryTitle = {nCount = 4, sComponentName = "TMP_Text"},
  txtEntryDesc = {nCount = 4, sComponentName = "TMP_Text"},
  txtEmpty = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Dictionary_None"
  },
  rtPoint = {sComponentName = "Transform"},
  goPoint = {},
  btnPre = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Pre"
  },
  btnNext = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Next"
  },
  txtBtnPre = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dictionary_Btn_Pre"
  },
  txtBtnNext = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dictionary_Btn_Next"
  },
  inputSearch = {
    sComponentName = "TMP_InputField"
  },
  txtSearchTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dictionary_Search_Tip"
  },
  txtBtnSearch = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Btn_Search"
  },
  btnSearch = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Search"
  },
  txtSearchFail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dictionary_None"
  },
  btnClear = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Clear"
  },
  rtToggle = {sComponentName = "Transform"},
  tog = {},
  svTogSub = {
    sComponentName = "LoopScrollView"
  },
  trSvTogSub = {sNodeName = "svTogSub", sComponentName = "Transform"},
  btnAll = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_All"
  },
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Close"
  }
}
DictionaryCtrl._mapEventConfig = {
  [EventId.UIBackConfirm] = "OnEvent_Close",
  [EventId.UIHomeConfirm] = "OnEvent_Home"
}

function DictionaryCtrl:Refresh()
  self:InitSort()
  self:InitData()
  self:RefreshTogMain()
  self:RefreshTogSub()
  self:RefreshEntry(true)
end

function DictionaryCtrl:InitData()
  local bAll = ModuleManager.GetIsAdventure() == false and not self._panel.bStarTowerFastBattle
  self.tbAllEntry = PlayerData.Dictionary:GetCompletedEntry(bAll)
  self:FiliterData()
end

function DictionaryCtrl:FiliterData(sAim)
  local tbTabById = {}
  
  local function func_add(mapData)
    if not tbTabById[mapData.nTab] then
      tbTabById[mapData.nTab] = {}
      self.nTabCount = self.nTabCount + 1
    end
    table.insert(tbTabById[mapData.nTab], mapData)
  end
  
  self.tbTab = {}
  self.nTabCount = 0
  if not sAim or sAim == "" then
    for _, mapData in pairs(self.tbAllEntry) do
      func_add(mapData)
    end
  else
    for _, mapData in pairs(self.tbAllEntry) do
      local bMatch = string.find(string.lower(mapData.sTitle), string.lower(sAim))
      if bMatch then
        func_add(mapData)
      end
    end
  end
  for _, v in pairs(tbTabById) do
    table.sort(v, function(a, b)
      local a_unreceived = PlayerData.Dictionary:GetEntryStatus(a.nId) == 1
      local b_unreceived = PlayerData.Dictionary:GetEntryStatus(b.nId) == 1
      if a_unreceived ~= b_unreceived then
        return a_unreceived and not b_unreceived
      elseif a.nSort ~= b.nSort then
        return a.nSort < b.nSort
      else
        return a.nId < b.nId
      end
    end)
    table.insert(self.tbTab, v)
  end
end

function DictionaryCtrl:RefreshTogMain(nMain)
  self.nCurTogMain = nMain or 1
  self.ctrlTogMain = {}
  delChildren(self._mapNode.rtToggle)
  self._mapNode.txtSearchFail.gameObject:SetActive(self.nTabCount == 0)
  if self.nTabCount == 0 then
    return
  end
  for i = 1, self.nTabCount do
    local goToggle = instantiate(self._mapNode.tog, self._mapNode.rtToggle)
    goToggle:SetActive(true)
    local btn = goToggle.transform:GetComponent("UIButton")
    local func_Handler = ui_handler(self, self.OnBtnClick_ChangeTogMain, goToggle, i)
    btn.onClick:AddListener(func_Handler)
    self.ctrlTogMain[i] = self:BindCtrlByNode(goToggle, "Game.UI.TemplateEx.TemplateToggleCtrl")
    self.ctrlTogMain[i]:SetDefault(i == self.nCurTogMain)
    local nTabId = self.tbTab[i][1].nTab
    local mapCfg = ConfigTable.GetData("DictionaryTab", nTabId)
    self.ctrlTogMain[i]:SetText(mapCfg.Title)
    local imgOff = goToggle.transform:Find("AnimRoot/AnimSwitch/imgOff"):GetComponent("Image")
    local imgOn = goToggle.transform:Find("AnimRoot/AnimSwitch/imgOn"):GetComponent("Image")
    self:SetPngSprite(imgOff, mapCfg.Icon)
    self:SetPngSprite(imgOn, mapCfg.Icon2)
    imgOn.gameObject:SetActive(i == self.nCurTogMain)
    imgOff.gameObject:SetActive(i ~= self.nCurTogMain)
    local red = goToggle.transform:Find("AnimRoot/AnimSwitch/redDotTog2").gameObject
    RedDotManager.RegisterNode(RedDotDefine.Dictionary_Main, nTabId, red, 2)
  end
end

function DictionaryCtrl:RefreshTogSub(nSub)
  self.nCurTogSub = nSub or 1
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgEntryAni, 0)
  if self.nTabCount == 0 then
    self._mapNode.svTogSub.gameObject:SetActive(false)
    return
  end
  self.nEntryCount = #self.tbTab[self.nCurTogMain]
  if 0 < self.nEntryCount then
    self._mapNode.svTogSub.gameObject:SetActive(true)
    for nInstanceID, objCtrl in pairs(self.ctrlTogSub) do
      self:UnbindCtrlByNode(objCtrl)
      self.ctrlTogSub[nInstanceID] = nil
    end
    self._mapNode.svTogSub:Init(self.nEntryCount, self, self.OnGridRefresh_TogSub, self.OnGridBtnClick_TogSub)
  else
    self._mapNode.svTogSub.gameObject:SetActive(false)
  end
end

function DictionaryCtrl:OnGridRefresh_TogSub(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceID = goGrid:GetInstanceID()
  local mapEntry = self.tbTab[self.nCurTogMain][nIndex]
  if not self.ctrlTogSub[nInstanceID] then
    self.ctrlTogSub[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.TemplateEx.TemplateToggleCtrl")
  end
  self.ctrlTogSub[nInstanceID]:SetText(mapEntry.sTitle)
  self.ctrlTogSub[nInstanceID]:SetDefault(nIndex == self.nCurTogSub)
  local red = goGrid.transform:Find("tog2/AnimRoot/AnimSwitch/redDotTog1").gameObject
  RedDotManager.RegisterNode(RedDotDefine.Dictionary_Sub, {
    mapEntry.nTab,
    mapEntry.nIndex
  }, red)
end

function DictionaryCtrl:OnGridBtnClick_TogSub(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceID = goGrid:GetInstanceID()
  if nIndex == self.nCurTogSub then
    return
  end
  WwiseAudioMgr:PlaySound("ui_dictionary_page")
  self.ctrlTogSub[nInstanceID]:SetDefault(true)
  if self.nCurTogSub then
    self:RefreshAniDiagram(nIndex > self.nCurTogSub)
    if nIndex > self.nCurTogSub then
      self._mapNode.aniEntry:Play("DictionaryPanel_turn_down_last", 0, 0)
    else
      self._mapNode.aniEntry:Play("DictionaryPanel_turn_up_first", 0, 0)
    end
    local goSelect = self._mapNode.trSvTogSub:Find("Viewport/Content/" .. self.nCurTogSub - 1)
    if goSelect then
      self.ctrlTogSub[goSelect.gameObject:GetInstanceID()]:SetDefault(false)
    end
  end
  self.nCurTogSub = nIndex
  self:RefreshEntry(true)
end

function DictionaryCtrl:RefreshEntry(bFirst)
  self:RefreshReceiveBtn()
  self._mapNode.goType[1].gameObject:SetActive(self.nTabCount > 0)
  self._mapNode.goType[2].gameObject:SetActive(self.nTabCount > 0)
  self._mapNode.goBottom.gameObject:SetActive(self.nTabCount > 0)
  self._mapNode.goEmpty[1].gameObject:SetActive(self.nTabCount == 0)
  if self.nTabCount == 0 then
    return
  end
  local mapEntry = self.tbTab[self.nCurTogMain][self.nCurTogSub]
  local mapCfg = ConfigTable.GetData("DictionaryEntry", mapEntry.nId)
  self.tbDiagram = mapCfg.DiagramList
  self.nDiagramCount = #self.tbDiagram
  self.nPage = bFirst and 1 or self.nDiagramCount
  self.tbPoint = {}
  self:RefreshPoint()
  self:RefreshDiagram()
end

function DictionaryCtrl:RefreshReceiveBtn()
  local bAble = false
  if self.nTabCount > 0 then
    for _, mapEntry in pairs(self.tbTab[self.nCurTogMain]) do
      if PlayerData.Dictionary:GetEntryStatus(mapEntry.nId) == 1 then
        bAble = true
        break
      end
    end
  end
end

function DictionaryCtrl:RefreshPoint()
  delChildren(self._mapNode.rtPoint)
  if self.nDiagramCount == 1 then
    return
  end
  for i = 1, self.nDiagramCount do
    local goItemObj = instantiate(self._mapNode.goPoint, self._mapNode.rtPoint)
    goItemObj:SetActive(true)
    self.tbPoint[i] = goItemObj
  end
end

function DictionaryCtrl:RefreshDiagram()
  local mapCfg = ConfigTable.GetData("DictionaryDiagram", self.tbDiagram[self.nPage])
  if mapCfg then
    for i = 1, 2 do
      NovaAPI.SetTMPText(self._mapNode.txtEntryTitle[i], mapCfg.Title)
      NovaAPI.SetTMPText(self._mapNode.txtEntryDesc[i], mapCfg.Desc)
    end
    if mapCfg.Icon ~= "" then
      self._mapNode.goType[1]:SetActive(true)
      self._mapNode.goType[2]:SetActive(false)
      self:SetPngSprite(self._mapNode.imgEntry[1], mapCfg.Icon)
    else
      self._mapNode.goType[1]:SetActive(false)
      self._mapNode.goType[2]:SetActive(true)
    end
  end
  self:RefreshSwitchBtn()
  if 1 < self.nDiagramCount then
    for i = 1, self.nDiagramCount do
      local imgOn = self.tbPoint[i].transform:Find("imgOn").gameObject
      local imgOff = self.tbPoint[i].transform:Find("imgOff").gameObject
      imgOn:SetActive(i == self.nPage)
      imgOff:SetActive(i ~= self.nPage)
    end
  end
  self:RefreshProgress()
end

function DictionaryCtrl:RefreshAniDiagram(bNext)
  self:RefreshSort(bNext)
  self._mapNode.goType[3].gameObject:SetActive(self.nTabCount > 0)
  self._mapNode.goType[4].gameObject:SetActive(self.nTabCount > 0)
  self._mapNode.goEmpty[2].gameObject:SetActive(self.nTabCount == 0)
  if self.nTabCount == 0 then
    return
  end
  local mapCfg = ConfigTable.GetData("DictionaryDiagram", self.tbDiagram[self.nPage])
  if mapCfg then
    for i = 3, 4 do
      NovaAPI.SetTMPText(self._mapNode.txtEntryTitle[i], mapCfg.Title)
      NovaAPI.SetTMPText(self._mapNode.txtEntryDesc[i], mapCfg.Desc)
    end
    if mapCfg.Icon ~= "" then
      self._mapNode.goType[3]:SetActive(true)
      self._mapNode.goType[4]:SetActive(false)
      self:SetPngSprite(self._mapNode.imgEntry[2], mapCfg.Icon)
    else
      self._mapNode.goType[3]:SetActive(false)
      self._mapNode.goType[4]:SetActive(true)
    end
  end
end

function DictionaryCtrl:RefreshSwitchBtn()
  self._mapNode.btnPre.gameObject:SetActive(self.nCurTogSub ~= 1 or self.nPage ~= 1)
  self._mapNode.btnNext.gameObject:SetActive(self.nCurTogSub ~= self.nEntryCount or self.nPage ~= self.nDiagramCount)
end

function DictionaryCtrl:RefreshProgress()
  local mapEntry = self.tbTab[self.nCurTogMain][self.nCurTogSub]
  local bUnreceived = PlayerData.Dictionary:GetEntryStatus(mapEntry.nId) == 1
  if not bUnreceived then
    return
  end
  local nId = mapEntry.nId
  local mapCfg = ConfigTable.GetData("DictionaryEntry", nId)
  if not mapCfg then
    return
  end
  
  local function callback(mapReward)
    self:RefreshReward(mapReward.tbReward)
    self:RefreshReceiveBtn()
  end
  
  PlayerData.Dictionary:SendDictRewardReq(mapCfg.Tab, mapCfg.Index, callback)
end

function DictionaryCtrl:RefreshReward(tbReward)
  if not self.mapReward then
    self.mapReward = tbReward[1]
    self.mapReward.total = 1
  else
    self.mapReward.count = self.mapReward.count + tbReward[1].count
    self.mapReward.total = self.mapReward.total + 1
  end
end

function DictionaryCtrl:InitSort()
  self.sortingOrder = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
  local nId = CS.UnityEngine.SortingLayer.NameToID(AllEnum.SortingLayerName.UI)
  NovaAPI.SetCanvasSortingId(self._mapNode.cvBase, nId)
  NovaAPI.SetCanvasSortingId(self._mapNode.cvAni, nId)
  self:RefreshSort(true)
end

function DictionaryCtrl:RefreshSort(bNext)
  NovaAPI.SetCanvasSortingOrder(self._mapNode.cvBase, bNext and self.sortingOrder or self.sortingOrder + 1)
  NovaAPI.SetCanvasSortingOrder(self._mapNode.cvAni, bNext and self.sortingOrder + 1 or self.sortingOrder)
end

function DictionaryCtrl:FindTog(nId)
  for nMain, v in pairs(self.tbTab) do
    for nSub, mapEntry in pairs(v) do
      if mapEntry.nId == nId then
        return nMain, nSub
      end
    end
  end
end

function DictionaryCtrl:FadeIn()
  EventManager.Hit(EventId.SetTransition)
  self._mapNode.animRoot:Play("DictionaryPanel_in")
end

function DictionaryCtrl:Awake()
  self._mapNode.btnClear.gameObject:SetActive(false)
  self.ctrlTogSub = {}
  self.ctrlTogMain = {}
end

function DictionaryCtrl:OnEnable()
  self:Refresh()
  self._mapNode.btnShortcutClose.gameObject:SetActive(GamepadUIManager.GetInputState())
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.EnableGamepadUI("DictionaryCtrl", self:GetGamepadUINode(), nil, true)
  end
end

function DictionaryCtrl:OnDisable()
  if self.ctrlTogMain then
    for nInstanceId, objCtrl in pairs(self.ctrlTogMain) do
      self:UnbindCtrlByNode(objCtrl)
      self.ctrlTogMain[nInstanceId] = nil
    end
    self.ctrlTogMain = {}
  end
  if self.ctrlTogSub then
    for nInstanceId, objCtrl in pairs(self.ctrlTogSub) do
      self:UnbindCtrlByNode(objCtrl)
      self.ctrlTogSub[nInstanceId] = nil
    end
    self.ctrlTogSub = {}
  end
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.DisableGamepadUI("DictionaryCtrl")
  end
end

function DictionaryCtrl:OnDestroy()
end

function DictionaryCtrl:OnBtnClick_ChangeTogMain(btn, nIndex)
  if nIndex == self.nCurTogMain then
    return
  end
  WwiseAudioMgr:PlaySound("ui_dictionary_page")
  self:RefreshAniDiagram(nIndex > self.nCurTogMain)
  if nIndex > self.nCurTogMain then
    self._mapNode.aniEntry:Play("DictionaryPanel_turn_down_last", 0, 0)
  else
    self._mapNode.aniEntry:Play("DictionaryPanel_turn_up_first", 0, 0)
  end
  self.ctrlTogMain[nIndex]:SetDefault(true)
  self.ctrlTogMain[self.nCurTogMain]:SetDefault(false)
  self.ctrlTogMain[nIndex].gameObject.transform:Find("AnimRoot/AnimSwitch/imgOff").gameObject:SetActive(false)
  self.ctrlTogMain[nIndex].gameObject.transform:Find("AnimRoot/AnimSwitch/imgOn").gameObject:SetActive(true)
  self.ctrlTogMain[self.nCurTogMain].gameObject.transform:Find("AnimRoot/AnimSwitch/imgOff").gameObject:SetActive(true)
  self.ctrlTogMain[self.nCurTogMain].gameObject.transform:Find("AnimRoot/AnimSwitch/imgOn").gameObject:SetActive(false)
  self.nCurTogMain = nIndex
  self:RefreshTogSub()
  self:RefreshEntry(true)
end

function DictionaryCtrl:OnBtnClick_Pre(btn)
  self:RefreshAniDiagram(false)
  WwiseAudioMgr:PlaySound("ui_dictionary_page")
  if self.nPage == 1 then
    local goPre = self._mapNode.trSvTogSub:Find("Viewport/Content/" .. self.nCurTogSub - 2)
    if goPre then
      self.ctrlTogSub[goPre.gameObject:GetInstanceID()]:SetDefault(true)
    end
    local goCur = self._mapNode.trSvTogSub:Find("Viewport/Content/" .. self.nCurTogSub - 1)
    if goCur then
      self.ctrlTogSub[goCur.gameObject:GetInstanceID()]:SetDefault(false)
    end
    self.nCurTogSub = self.nCurTogSub - 1
    self:RefreshEntry(false)
    self._mapNode.aniEntry:Play("DictionaryPanel_turn_up_first", 0, 0)
    self._mapNode.svTogSub:SetScrollGridPos(self.nCurTogSub - 1, 0, 1)
  else
    self.nPage = self.nPage - 1
    self:RefreshDiagram()
    self._mapNode.aniEntry:Play("DictionaryPanel_turn_up", 0, 0)
  end
end

function DictionaryCtrl:OnBtnClick_Next(btn)
  self:RefreshAniDiagram(true)
  WwiseAudioMgr:PlaySound("ui_dictionary_page")
  if self.nPage == self.nDiagramCount then
    local goNext = self._mapNode.trSvTogSub:Find("Viewport/Content/" .. self.nCurTogSub)
    if goNext then
      self.ctrlTogSub[goNext.gameObject:GetInstanceID()]:SetDefault(true)
    end
    local goCur = self._mapNode.trSvTogSub:Find("Viewport/Content/" .. self.nCurTogSub - 1)
    if goCur then
      self.ctrlTogSub[goCur.gameObject:GetInstanceID()]:SetDefault(false)
    end
    self.nCurTogSub = self.nCurTogSub + 1
    self:RefreshEntry(true)
    self._mapNode.aniEntry:Play("DictionaryPanel_turn_down_last", 0, 0)
    self._mapNode.svTogSub:SetScrollGridPos(self.nCurTogSub - 1, 0, 1)
  else
    self.nPage = self.nPage + 1
    self:RefreshDiagram()
    self._mapNode.aniEntry:Play("DictionaryPanel_turn_down", 0, 0)
  end
end

function DictionaryCtrl:OnBtnClick_Search(btn)
  local sAim = NovaAPI.GetTMPInputFieldText(self._mapNode.inputSearch)
  if sAim == "" then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Dictionary_SearchNone"))
    return
  end
  self:RefreshAniDiagram(false)
  self._mapNode.aniEntry:Play("DictionaryPanel_turn_up_first", 0, 0)
  self:FiliterData(sAim)
  self:RefreshTogMain()
  self:RefreshTogSub()
  self:RefreshEntry(true)
  self._mapNode.btnClear.gameObject:SetActive(true)
  self._mapNode.btnSearch.gameObject:SetActive(false)
end

function DictionaryCtrl:OnBtnClick_Clear(btn)
  NovaAPI.SetTMPInputFieldText(self._mapNode.inputSearch, "")
  if self.nTabCount > 0 then
    local mapEntry = self.tbTab[self.nCurTogMain][self.nCurTogSub]
    self:FiliterData()
    local nMain, nSub = self:FindTog(mapEntry.nId)
    self:RefreshTogMain(nMain)
    self:RefreshTogSub(nSub)
    self:RefreshSwitchBtn()
  else
    self:RefreshAniDiagram(false)
    self._mapNode.aniEntry:Play("DictionaryPanel_turn_up_first", 0, 0)
    self:FiliterData()
    self:RefreshTogMain()
    self:RefreshTogSub()
    self:RefreshEntry(true)
  end
  self._mapNode.btnClear.gameObject:SetActive(false)
  self._mapNode.btnSearch.gameObject:SetActive(true)
end

function DictionaryCtrl:OnBtnClick_All(btn)
  local nTabId = ConfigTable.GetData("DictionaryEntry", self.tbTab[self.nCurTogMain][1].nId).Tab
  
  local function callback(mapReward)
    self:RefreshReceiveBtn()
    UTILS.OpenReceiveByReward(mapReward)
  end
  
  PlayerData.Dictionary:SendDictRewardReq(nTabId, 0, callback)
end

function DictionaryCtrl:OnBtnClick_Close()
  EventManager.Hit(EventId.ClosePanel, PanelId.DictionaryFR)
end

function DictionaryCtrl:OnEvent_Close(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if ModuleManager.GetIsAdventure() or self._panel.bStarTowerFastBattle then
    EventManager.Hit(EventId.ClosePanel, PanelId.DictionaryFR)
  else
    EventManager.Hit(EventId.CloesCurPanel)
    if self.mapReward and self.mapReward.count > 0 then
      EventManager.Hit("OpenSideBanner", {
        {
          nType = AllEnum.SideBaner.DictionaryReward,
          mapReward = self.mapReward,
          nOtherCount = self.mapReward.total
        }
      })
    end
  end
end

function DictionaryCtrl:OnEvent_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  PanelManager.Home()
  if self.mapReward and self.mapReward.count > 0 then
    EventManager.Hit("OpenSideBanner", {
      {
        nType = AllEnum.SideBaner.DictionaryReward,
        mapReward = self.mapReward,
        nOtherCount = self.mapReward.total
      }
    })
  end
end

return DictionaryCtrl
