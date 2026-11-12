local TemplateTips = class("TemplateTips", BaseCtrl)
TemplateTips._mapNodeConfig = {
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
  rtConetnt = {
    sComponentName = "RectTransform"
  },
  TipsContent = {
    sComponentName = "RectTransform"
  }
}
TemplateTips._mapEventConfig = {}

function TemplateTips:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.rtTarget = tbParam[1]
    self.mapData = tbParam[2]
  end
end

function TemplateTips:FadeIn()
end

function TemplateTips:FadeOut()
end

function TemplateTips:OnEnable()
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    local nContentHeight = self._mapNode.TipsContent.sizeDelta.y
    if nContentHeight > self.maxTipHeight then
      nContentHeight = self.maxTipHeight
    end
    if nContentHeight < self.minTipHeight then
      nContentHeight = self.minTipHeight
    end
    self._mapNode.imgTipsBg.sizeDelta = Vector2(self._mapNode.imgTipsBg.sizeDelta.x, nContentHeight)
    self:SetTipsPosition(self.rtTarget, self._mapNode.rtContent)
  end
  
  cs_coroutine.start(wait)
end

function TemplateTips:OnDisable()
end

function TemplateTips:OnDestroy()
end

function TemplateTips:OnRelease()
end

function TemplateTips:OnBtnClick_Word(sWordId)
  local nWordId = tonumber(sWordId)
  local mapWordData = ConfigTable.GetData("Word", nWordId)
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

function TemplateTips:OnBtnClick_CloseWord(btn)
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
end

function TemplateTips:OnBtnClick_ClosePanel(btn)
  EventManager.Hit(EventId.CloesCurPanel)
end

return TemplateTips
