local LampNoticeCtrl = class("LampNoticeCtrl", BaseCtrl)
local maxWidth = 1000
local startSpace = 200
LampNoticeCtrl._mapNodeConfig = {
  root = {sNodeName = "Root"},
  animator = {sNodeName = "Root", sComponentName = "Animator"},
  txt_Content = {sComponentName = "TMP_Text"},
  content = {
    sNodeName = "txt_Content",
    sComponentName = "RectTransform"
  },
  mask = {
    sComponentName = "LayoutElement"
  },
  MoveUpdate = {
    sNodeName = "Root",
    sComponentName = "LampNoticeScroll"
  }
}
LampNoticeCtrl._mapEventConfig = {
  ShowNoticeContent = "OnEvent_ShowContent",
  CloseLampNotice = "OnEvent_HideContent"
}
LampNoticeCtrl._mapRedDotConfig = {}

function LampNoticeCtrl:Awake()
  maxWidth = self._mapNode.mask.preferredWidth
  self._mapNode.root:SetActive(false)
end

function LampNoticeCtrl:OnEvent_ShowContent(sContent, nShowTime)
  self._mapNode.MoveUpdate:StopLampNoticeMove()
  self._mapNode.root:SetActive(true)
  self._mapNode.animator:Play("LampNotice_in")
  self._mapNode.content.gameObject:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.txt_Content, sContent)
  
  local function cb()
    self._mapNode.animator:Play("LampNotice_out")
    
    local function close()
      self._mapNode.root:SetActive(false)
      self._mapNode.MoveUpdate:StopLampNoticeMove()
    end
    
    self:AddTimer(1, 0.2, close, true, true, true, nil)
  end
  
  self._mapNode.content.gameObject:SetActive(true)
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.content)
  local width = self._mapNode.content.sizeDelta.x
  if width > maxWidth then
    local startPosX = width / 2 + maxWidth / 2 - startSpace
    self._mapNode.content.anchoredPosition = Vector2(startPosX, 0)
    local nSpeed = ConfigTable.GetConfigValue("LampNoticeScrollSpeed")
    local endPosX = -startPosX
    self._mapNode.MoveUpdate:SetLampNoticeMove(self._mapNode.content, nSpeed, endPosX, cb)
  else
    self._mapNode.content.anchoredPosition = Vector2(0, 0)
    self.timer = self:AddTimer(1, nShowTime, cb, true, true, true, nil)
  end
end

function LampNoticeCtrl:OnEvent_HideContent(bIsDelay)
  if bIsDelay then
    if self.timer ~= nil then
      self.timer:_Stop()
    end
    self._mapNode.root:SetActive(false)
  end
end

return LampNoticeCtrl
