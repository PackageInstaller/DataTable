local DatingEventItemCtrl = class("DatingEventItemCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
DatingEventItemCtrl._mapNodeConfig = {
  goTag = {},
  txtTag = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dating_Event_Special"
  },
  goTxtHeight = {},
  rtGoTxtHeight = {
    sNodeName = "goTxtHeight",
    sComponentName = "RectTransform"
  },
  txtHeight = {sComponentName = "TMP_Text"},
  rtTxtHeight = {
    sNodeName = "txtHeight",
    sComponentName = "RectTransform"
  },
  txtEvent = {sComponentName = "TMP_Text"},
  txtEventSpecial = {sComponentName = "TMP_Text"},
  goFavor = {},
  imgCG = {sComponentName = "Image"},
  rtImgCG = {
    sComponentName = "RectTransform"
  },
  txtFavorCount = {sComponentName = "TMP_Text"},
  goTime = {},
  goWait = {},
  animWaiting = {sNodeName = "imgWait", sComponentName = "Animator"},
  imgTimeBar = {sComponentName = "Image"}
}
DatingEventItemCtrl._mapEventConfig = {
  DatingEventRefreshTip = "OnEvent_DatingEventRefreshTip"
}
DatingEventItemCtrl._mapRedDotConfig = {}
local replace_str = "==DATING_CHARACTER=="
local sEventCgPath = "Icon/DatingEventCG/"

function DatingEventItemCtrl:InitItem(data)
  self.data = data
  self.bCG = false
  self._mapNode.rtImgCG.gameObject:SetActive(false)
  if data.sCG ~= nil then
    self.bCG = true
    self.nItemTime = self.nItemTime / 4
    self._mapNode.rtImgCG.gameObject:SetActive(true)
    local btn = self._mapNode.rtImgCG.gameObject:GetComponent("UIButton")
    local sCgPath = sEventCgPath .. data.sCG
    btn.onClick:AddListener(function()
      EventManager.Hit("DatingShowImgMsg", sCgPath)
    end)
    self:SetPngSprite(self._mapNode.imgCG, sCgPath)
  end
  self._mapNode.goFavor.gameObject:SetActive(data.bLast and data.nAffinity > 0)
  NovaAPI.SetTMPText(self._mapNode.txtFavorCount, "+" .. data.nAffinity)
  local charCfg = ConfigTable.GetData_Character(self._panel.nCharId)
  if charCfg ~= nil then
    local sCharName = self:_temp_proc_name(charCfg.Name)
    local sDesc = string.gsub(data.sDesc, replace_str, sCharName)
    local mapKrTag = ConfigTable.GetData("DatingCharTag", self._panel.nCharId)
    if mapKrTag ~= nil and mapKrTag.KrTag ~= nil then
      local tbKr = AllEnum.DatingKrTags[mapKrTag.KrTag]
      if tbKr ~= nil then
        for k, v in pairs(tbKr) do
          sDesc = string.gsub(sDesc, k, v)
        end
      end
    end
    NovaAPI.SetTMPText(self._mapNode.txtEvent, sDesc)
    NovaAPI.SetTMPText(self._mapNode.txtEventSpecial, sDesc)
    NovaAPI.SetTMPText(self._mapNode.txtHeight, sDesc)
  end
  self._mapNode.goTag.gameObject:SetActive(data.bSpecial)
  self._mapNode.txtEventSpecial.gameObject:SetActive(data.bSpecial)
  self._mapNode.txtEvent.gameObject:SetActive(not data.bSpecial)
  self._mapNode.goTime.gameObject:SetActive(false)
  self._mapNode.goWait.gameObject:SetActive(false)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtTxtHeight)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtTxtHeight)
  local nH = self._mapNode.rtTxtHeight.rect.height
  self._mapNode.rtGoTxtHeight.sizeDelta = Vector2(self._mapNode.rtGoTxtHeight.sizeDelta.x, nH)
end

function DatingEventItemCtrl:_temp_proc_name(sName)
  local _sName = string.gsub(sName, "（.-）", "")
  _sName = string.gsub(_sName, "%(.-%)", "")
  return _sName
end

function DatingEventItemCtrl:StartEvent(nSpeed, bAuto)
  self.nCurTime = 0
  local sAnim = "DatingPanel_Event_in"
  if self.bCG then
    sAnim = "DatingPanel_SpCGEvent_in"
  elseif self.bSpecial then
    sAnim = "DatingPanel_SpEvent_in"
  end
  self.anim:Play(sAnim)
  self.bAuto = bAuto
  if bAuto or self.bCG then
    self._mapNode.goWait.gameObject:SetActive(false)
    self._mapNode.goTime.gameObject:SetActive(true)
    NovaAPI.SetImageFillAmount(self._mapNode.imgTimeBar, 0)
    self.eventTimer = self:AddTimer(0, 0.034, function()
      self.nCurTime = self.nCurTime + 0.034
      NovaAPI.SetImageFillAmount(self._mapNode.imgTimeBar, self.nCurTime / self.nItemTime)
      if self.nCurTime >= self.nItemTime then
        self.eventTimer:Cancel()
        self.eventTimer = nil
        self._mapNode.goTime.gameObject:SetActive(false)
        if self.bAuto then
          EventManager.Hit("DatingEventNext")
        end
      end
    end)
    self.eventTimer:SetSpeed(nSpeed)
  else
    self._mapNode.goWait.gameObject:SetActive(true)
    self._mapNode.animWaiting:SetTrigger("tManual")
    self._mapNode.goTime.gameObject:SetActive(false)
  end
end

function DatingEventItemCtrl:ChangeSpeed(nSpeed)
  if self.eventTimer ~= nil then
    self.eventTimer:SetSpeed(nSpeed)
  end
end

function DatingEventItemCtrl:FinishImmediately(bCancelAuto)
  self._mapNode.goWait.gameObject:SetActive(false)
  if self.eventTimer ~= nil then
    self.bAuto = not bCancelAuto
    if not self.bAuto then
      self._mapNode.goTime.gameObject:SetActive(false)
      self._mapNode.goWait.gameObject:SetActive(true)
      self._mapNode.animWaiting:SetTrigger("tManual")
    end
    self.nCurTime = self.nItemTime + 0.5
  end
end

function DatingEventItemCtrl:GetAuto()
  return self.eventTimer ~= nil
end

function DatingEventItemCtrl:GetBranch()
  return false
end

function DatingEventItemCtrl:SkipTimer()
  self._mapNode.goWait.gameObject:SetActive(false)
  if self.eventTimer ~= nil then
    self.eventTimer:Cancel()
    self.eventTimer = nil
    self._mapNode.goTime.gameObject:SetActive(false)
  end
end

function DatingEventItemCtrl:Awake()
  self.anim = self.gameObject:GetComponent("Animator")
  self.nItemTime = ConfigTable.GetConfigNumber("Dating_Single_Event_Time")
end

function DatingEventItemCtrl:OnEvent_DatingEventRefreshTip()
  self._mapNode.goWait.gameObject:SetActive(false)
end

return DatingEventItemCtrl
