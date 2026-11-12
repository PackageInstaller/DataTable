local BaseCtrl = require("Game.UI.CommonTipsEx.CommonTipsBaseCtrl")
local DescTipsCtrl = class("DescTipsCtrl", BaseCtrl)
DescTipsCtrl.minTipHeight = 87
DescTipsCtrl.maxTipHeight = 557
local titleHeight = 142
DescTipsCtrl._mapNodeConfig = {
  btnCloseTips = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ClosePanel"
  },
  btnCloseWordTip = {
    sComponentName = "Button",
    callback = "OnBtnClick_CloseWord"
  },
  imgWordTipBg = {},
  TMPWordDesc = {sComponentName = "TMP_Text"},
  TMPWordTipsTitle = {sComponentName = "TMP_Text"},
  imgTipsBg = {
    sComponentName = "RectTransform"
  },
  rtContent = {
    sComponentName = "RectTransform"
  },
  TipsContent = {
    sComponentName = "RectTransform"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "RectTransform"
  },
  txtTipsName = {sComponentName = "TMP_Text"},
  txtTipsContent = {nCount = 3, sComponentName = "TMP_Text"},
  rtDescContent = {
    sComponentName = "RectTransform"
  },
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_ClosePanel"
  }
}
DescTipsCtrl._mapEventConfig = {}

function DescTipsCtrl:Awake()
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.rtTarget = tbParam[1]
    self.mapData = tbParam[2]
  end
end

function DescTipsCtrl:FadeIn()
end

function DescTipsCtrl:FadeOut()
end

function DescTipsCtrl:OnEnable()
  self:EnableGamepadUI(self._mapNode.btnShortcutClose)
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
  self.sortingOrder = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
  local btnComp = self.rtTarget:GetComponent("Button")
  if btnComp ~= nil then
    btnComp.interactable = false
  end
  NovaAPI.SetComponentEnableByName(self.rtTarget.gameObject, "TopGridCanvas", true)
  NovaAPI.SetTopGridCanvasSorting(self.rtTarget.gameObject, self.sortingOrder)
  NovaAPI.SetTMPText(self._mapNode.txtTipsName, self.mapData.Title)
  for i = 1, 3 do
    self._mapNode.txtTipsContent[i].gameObject:SetActive(self.mapData.Desc[i] and self.mapData.Desc[i] ~= "")
    if self.mapData.Desc[i] and self.mapData.Desc[i] ~= "" then
      NovaAPI.SetTMPText(self._mapNode.txtTipsContent[i], self.mapData.Desc[i])
    end
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    local nContentHeight = self._mapNode.rtDescContent.sizeDelta.y
    print(nContentHeight)
    if nContentHeight > self.maxTipHeight then
      nContentHeight = self.maxTipHeight
    end
    if nContentHeight < self.minTipHeight then
      nContentHeight = self.minTipHeight
    end
    local nTitleHeight = titleHeight
    self._mapNode.imgTipsBg.sizeDelta = Vector2(self._mapNode.imgTipsBg.sizeDelta.x, nContentHeight + nTitleHeight)
    self:SetTipsPosition(self.rtTarget, self._mapNode.rtContent, self._mapNode.safeAreaRoot)
  end
  
  cs_coroutine.start(wait)
end

function DescTipsCtrl:OnDisable()
  self:DisableGamepadUI()
end

function DescTipsCtrl:OnDestroy()
end

function DescTipsCtrl:OnRelease()
end

function DescTipsCtrl:OnBtnClick_Word(sWordId)
  local nWordId = tonumber(sWordId)
  local mapWordData = ConfigTable.GetData_World(nWordId)
  if mapWordData == nil then
    printError("wordId error:" .. sWordId)
    return
  end
  self._mapNode.btnCloseWordTip.gameObject:SetActive(true)
  self._mapNode.imgWordTipBg:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.TMPWordDesc, mapWordData.Desc)
  NovaAPI.SetTMPSourceText(self._mapNode.TMPWordTipsTitle, mapWordData.Title)
  self:SetWordTipsSize()
end

function DescTipsCtrl:OnBtnClick_CloseWord(btn)
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
end

function DescTipsCtrl:OnBtnClick_ClosePanel(btn)
  if self.rtTarget and not self.rtTarget:IsNull() then
    local btnComp = self.rtTarget:GetComponent("Button")
    if btnComp ~= nil then
      btnComp.interactable = true
    end
    NovaAPI.SetComponentEnableByName(self.rtTarget.gameObject, "TopGridCanvas", false)
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.DescTips)
end

return DescTipsCtrl
