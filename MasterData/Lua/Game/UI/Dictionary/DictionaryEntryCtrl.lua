local DictionaryEntryCtrl = class("DictionaryEntryCtrl", BaseCtrl)
local AdventureModuleHelper = CS.AdventureModuleHelper
local Time = CS.UnityEngine.Time
local ModuleManager = require("GameCore.Module.ModuleManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
DictionaryEntryCtrl._mapNodeConfig = {
  Mask = {sComponentName = "Image"},
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtTop = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dictionary_Included_Desc"
  },
  imgTop = {},
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Close"
  },
  imgClose = {},
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
  goType = {nCount = 4},
  imgEntry = {nCount = 2, sComponentName = "Image"},
  txtEntryTitle = {nCount = 4, sComponentName = "TMP_Text"},
  txtEntryDesc = {nCount = 4, sComponentName = "TMP_Text"},
  rtPoint = {sComponentName = "Transform"},
  goPoint = {},
  btnPre = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Pre"
  },
  btnNext = {
    sComponentName = "NaviButton",
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
  aniRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  }
}
DictionaryEntryCtrl._mapEventConfig = {}

function DictionaryEntryCtrl:Open()
  NovaAPI.SetImageColor(self._mapNode.Mask, self.bGuide and Color(0, 0, 0, 0.6509803921568628) or Color(0.25098039215686274, 0.2784313725490196, 0.2980392156862745, 0.34901960784313724))
  local bHasEntry = ConfigTable.GetData("DictionaryEntry", self.nEntryId, true) ~= nil
  self._mapNode.imgTop:SetActive(bHasEntry)
  self:InitSort()
  self:Pause()
  self:PlayInAni()
  self:RefreshData()
  self:RefreshPoint()
  self:RefreshDiagram()
end

function DictionaryEntryCtrl:PlayInAni()
  self._mapNode.blur:SetActive(true)
  self._mapNode.aniRoot:Play("DictionaryEntry_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function DictionaryEntryCtrl:RefreshData()
  local mapCfg = ConfigTable.GetData("DictionaryTopBarEntry", self.nEntryId)
  self.tbDiagram = mapCfg.DiagramList
  self.nDiagramCount = #self.tbDiagram
  self.nPage = 1
  self.tbPoint = {}
end

function DictionaryEntryCtrl:RefreshDiagram()
  local mapCfg = ConfigTable.GetData("DictionaryDiagram", self.tbDiagram[self.nPage])
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
  self._mapNode.btnPre.gameObject:SetActive(self.nPage ~= 1)
  if self.nPage == self.nDiagramCount then
    self._mapNode.btnNext.gameObject:SetActive(false)
    self._mapNode.btnShortcutClose.gameObject:SetActive(GamepadUIManager.GetInputState())
  else
    self._mapNode.btnShortcutClose.gameObject:SetActive(false)
    self._mapNode.btnNext.gameObject:SetActive(true)
  end
  if 1 < self.nDiagramCount then
    for i = 1, self.nDiagramCount do
      local imgOn = self.tbPoint[i].transform:Find("imgOn").gameObject
      local imgOff = self.tbPoint[i].transform:Find("imgOff").gameObject
      imgOn:SetActive(i == self.nPage)
      imgOff:SetActive(i ~= self.nPage)
    end
  end
  if GamepadUIManager.GetInputState() then
    self._mapNode.btnClose.gameObject:SetActive(self.nDiagramCount == 1)
    self._mapNode.imgClose.gameObject:SetActive(self.nDiagramCount == 1)
  else
    NovaAPI.SetNaviButtonAction(self._mapNode.btnNext, false)
    NovaAPI.SetNaviButtonAction(self._mapNode.btnPre, false)
  end
end

function DictionaryEntryCtrl:RefreshAniDiagram(bNext)
  self:RefreshSort(bNext)
  local mapCfg = ConfigTable.GetData("DictionaryDiagram", self.tbDiagram[self.nPage])
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

function DictionaryEntryCtrl:RefreshPoint()
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

function DictionaryEntryCtrl:Pause()
  if ModuleManager.GetIsAdventure() then
    EventManager.Hit(EventId.BattleDashboardVisible, false)
    PanelManager.InputDisable()
  else
    Time.timeScale = 0
  end
end

function DictionaryEntryCtrl:Resume()
  if ModuleManager.GetIsAdventure() then
    EventManager.Hit(EventId.BattleDashboardVisible, true)
    PanelManager.InputEnable()
  else
    Time.timeScale = 1
  end
end

function DictionaryEntryCtrl:InitSort()
  self.sortingOrder = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
  local nId = CS.UnityEngine.SortingLayer.NameToID(AllEnum.SortingLayerName.UI_Top)
  NovaAPI.SetCanvasSortingId(self._mapNode.cvBase, nId)
  NovaAPI.SetCanvasSortingId(self._mapNode.cvAni, nId)
  self:RefreshSort(true)
end

function DictionaryEntryCtrl:RefreshSort(bNext)
  NovaAPI.SetCanvasSortingOrder(self._mapNode.cvBase, bNext and self.sortingOrder or self.sortingOrder + 1)
  NovaAPI.SetCanvasSortingOrder(self._mapNode.cvAni, bNext and self.sortingOrder + 1 or self.sortingOrder)
end

function DictionaryEntryCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nEntryId = tbParam[1]
    self.bGuide = tbParam[2]
    self.callback = tbParam[3]
  end
  self.tbGamepadUINode = self:GetGamepadUINode()
  local bGamepad = GamepadUIManager.GetInputState()
  self._mapNode.btnClose.gameObject:SetActive(not bGamepad)
  self._mapNode.imgClose.gameObject:SetActive(not bGamepad)
  self._mapNode.btnShortcutClose.gameObject:SetActive(bGamepad)
end

function DictionaryEntryCtrl:OnEnable()
  self:Open()
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.EnableGamepadUI("DictionaryEntryCtrl", self.tbGamepadUINode)
  else
    for _, v in pairs(self.tbGamepadUINode) do
      if v.sComponentName == "NaviButton" then
        NovaAPI.SetNaviButtonAction(v.mapNode, false)
      end
    end
  end
end

function DictionaryEntryCtrl:OnDisable()
  if not ModuleManager.GetIsAdventure() then
    Time.timeScale = 1
  end
  EventManager.Hit("CloseDictionaryEntry")
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.DisableGamepadUI("DictionaryEntryCtrl")
  end
end

function DictionaryEntryCtrl:OnDestroy()
end

function DictionaryEntryCtrl:OnBtnClick_Close()
  self._mapNode.aniRoot:Play("DictionaryEntry_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.3, function()
    self:Resume()
    if self.callback ~= nil and type(self.callback) == "function" then
      self.callback()
    end
    EventManager.Hit(EventId.ClosePanel, PanelId.DictionaryEntry)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function DictionaryEntryCtrl:OnBtnClick_Pre(btn)
  self:RefreshAniDiagram(false)
  self.nPage = self.nPage - 1
  self:RefreshDiagram()
  self._mapNode.aniEntry:Play("DictionaryPanel_turn_up", 0, 0)
  WwiseAudioMgr:PlaySound("ui_dictionary_page")
end

function DictionaryEntryCtrl:OnBtnClick_Next(btn)
  self:RefreshAniDiagram(true)
  self.nPage = self.nPage + 1
  self:RefreshDiagram()
  self._mapNode.aniEntry:Play("DictionaryPanel_turn_down", 0, 0)
  WwiseAudioMgr:PlaySound("ui_dictionary_page")
end

return DictionaryEntryCtrl
