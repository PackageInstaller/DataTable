local BaseCtrl = require("Game.UI.CommonTipsEx.CommonTipsBaseCtrl")
local DiscSkillTipsCtrl = class("DiscSkillTipsCtrl", BaseCtrl)
DiscSkillTipsCtrl._mapNodeConfig = {
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
  rtContentCanvasGroup = {
    sNodeName = "rtContent",
    sComponentName = "CanvasGroup"
  },
  TipsContent = {
    sComponentName = "RectTransform"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "RectTransform"
  },
  ScrollView = {sComponentName = "ScrollRect"},
  rtDescContent = {
    sComponentName = "RectTransform"
  },
  srDesc = {
    sComponentName = "RectTransform"
  },
  txtSkillName = {sComponentName = "TMP_Text"},
  imgIcon = {sComponentName = "Image"},
  imgIconBg = {sComponentName = "Image"},
  txtSubSkillDesc = {sComponentName = "TMP_Text"},
  TMP_Link = {
    sNodeName = "txtSubSkillDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnLinkClick_Word"
  },
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_ClosePanel"
  },
  exId = {sComponentName = "TMP_Text"}
}
DiscSkillTipsCtrl._mapEventConfig = {}
DiscSkillTipsCtrl._mapRedDotConfig = {}
DiscSkillTipsCtrl.minTipHeight = 59.13
DiscSkillTipsCtrl.maxTipHeight = 481.4
local titleHeight = 140.2

function DiscSkillTipsCtrl:Refresh(mapData)
  self.nSkillId = mapData.nSkillId
  self:RefreshSubSkill()
end

function DiscSkillTipsCtrl:RefreshSubSkill()
  local skillCfg = ConfigTable.GetData("SecondarySkill", self.nSkillId)
  if not skillCfg then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtSkillName, skillCfg.Name)
  self:SetPngSprite(self._mapNode.imgIcon, skillCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
  self:SetPngSprite(self._mapNode.imgIconBg, skillCfg.IconBg .. AllEnum.DiscSkillIconSurfix.Small)
  local sDesc = UTILS.ParseParamDesc(skillCfg.Desc, skillCfg)
  NovaAPI.SetTMPText(self._mapNode.txtSubSkillDesc, sDesc)
end

function DiscSkillTipsCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.rtTarget = tbParam[1]
    self.mapData = tbParam[2]
  end
end

function DiscSkillTipsCtrl:OnEnable()
  self:EnableGamepadUI(self._mapNode.btnShortcutClose)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.rtContentCanvasGroup, 0)
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
  self.sortingOrder = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
  local btnComp = self.rtTarget:GetComponent("Button")
  if btnComp ~= nil then
    btnComp.interactable = false
  end
  NovaAPI.SetComponentEnableByName(self.rtTarget.gameObject, "TopGridCanvas", true)
  NovaAPI.SetTopGridCanvasSorting(self.rtTarget.gameObject, self.sortingOrder)
  self:Refresh(self.mapData)
  self._mapNode.exId.gameObject:SetActive(false)
  EventManager.Hit("TipsId", self._mapNode.exId, self.nSkillId)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if self._mapNode == nil then
      return
    end
    local nContentHeight = self._mapNode.rtDescContent.sizeDelta.y
    print(nContentHeight)
    if nContentHeight > self.maxTipHeight then
      nContentHeight = self.maxTipHeight
      NovaAPI.SetScrollRectVertical(self._mapNode.ScrollView, true)
    end
    if nContentHeight < self.minTipHeight then
      nContentHeight = self.minTipHeight
      NovaAPI.SetScrollRectVertical(self._mapNode.ScrollView, false)
    end
    self._mapNode.srDesc.sizeDelta = Vector2(self._mapNode.srDesc.sizeDelta.x, nContentHeight)
    self._mapNode.imgTipsBg.sizeDelta = Vector2(self._mapNode.imgTipsBg.sizeDelta.x, nContentHeight + titleHeight)
    self:SetTipsPosition(self.rtTarget, self._mapNode.rtContent, self._mapNode.safeAreaRoot)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.rtContentCanvasGroup, 1)
  end
  
  cs_coroutine.start(wait)
end

function DiscSkillTipsCtrl:OnDisable()
  self:DisableGamepadUI()
end

function DiscSkillTipsCtrl:OnBtnClick_CloseWordTips()
  self._mapNode.btn_CloseWordTips.gameObject:SetActive(false)
  self._mapNode.go_WordTip:SetActive(false)
  if self.funcCloseTips ~= nil and self.mapParent ~= nil then
    self.funcCloseTips(self.mapParent)
  end
end

function DiscSkillTipsCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

function DiscSkillTipsCtrl:OnBtnClick_ClosePanel(btn)
  if self.rtTarget and not self.rtTarget:IsNull() then
    local btnComp = self.rtTarget:GetComponent("Button")
    if btnComp ~= nil then
      btnComp.interactable = true
    end
    NovaAPI.SetComponentEnableByName(self.rtTarget.gameObject, "TopGridCanvas", false)
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.DiscSkillTips)
end

function DiscSkillTipsCtrl:OnBtnClick_CloseWord(btn)
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
end

return DiscSkillTipsCtrl
