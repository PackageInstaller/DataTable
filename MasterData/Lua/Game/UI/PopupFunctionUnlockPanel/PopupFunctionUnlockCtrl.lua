local PopupFunctionUnlockCtrl = class("PopupFunctionUnlockCtrl", BaseCtrl)
PopupFunctionUnlockCtrl._mapNodeConfig = {
  goBlur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  goContent = {
    sNodeName = "----SafeAreaRoot----"
  },
  TMPTitle = {sComponentName = "TMP_Text"},
  TMPDesc = {sComponentName = "TMP_Text"},
  btnClose = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  goSnapShot = {sNodeName = "snapshot"},
  imgUnLockIcon = {sComponentName = "Image"},
  ani = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  }
}
PopupFunctionUnlockCtrl._mapEventConfig = {}

function PopupFunctionUnlockCtrl:ShowUnlockFunc()
  if #self.tbFuncId > 0 then
    self._mapNode.ani:Play("Empty", 0, 0)
    self.nFuncId = table.remove(self.tbFuncId, 1)
    local mapFuncCfgData = ConfigTable.GetData("OpenFunc", self.nFuncId)
    if mapFuncCfgData == nil then
      printError("OpenFunc data Missing:" .. self.nFuncId)
      self._mapNode.TMPTitle.gameObject:SetActive(false)
      self._mapNode.TMPDesc.gameObject:SetActive(false)
      return
    end
    NovaAPI.SetTMPText(self._mapNode.TMPTitle, mapFuncCfgData.Name)
    NovaAPI.SetTMPText(self._mapNode.TMPDesc, mapFuncCfgData.Desc)
    self:SetPngSprite(self._mapNode.imgUnLockIcon, mapFuncCfgData.Icon)
    NovaAPI.SetImageNativeSize(self._mapNode.imgUnLockIcon)
    self._mapNode.ani:Play("PopupFunctionUnlockPanel_in", 0, 0)
    self.bAnimPlay = true
    self.animPlayTimer = self:AddTimer(1, self.nAnimLen, self.AnimPlayFinish, true, true, true, true)
    CS.WwiseAudioManager.Instance:PostEvent("ui_level_unlock")
    NovaAPI.UIEffectSnapShotCapture(self._mapNode.goSnapShot)
  else
    EventManager.Hit(EventId.ClosePanel, PanelId.PopupFunctionUnlock)
    if self.callback ~= nil then
      self.callback()
    end
  end
end

function PopupFunctionUnlockCtrl:AnimPlayFinish()
  self.bAnimPlay = false
  local stateInfo = self._mapNode.ani:GetCurrentAnimatorStateInfo()
  local nTime = stateInfo.normalizedTime
  if nTime < 1 / self.nAnimLen then
    CS.WwiseAudioManager.Instance:PostEvent("ui_level_unlock_result")
  end
end

function PopupFunctionUnlockCtrl:Awake()
end

function PopupFunctionUnlockCtrl:FadeIn()
end

function PopupFunctionUnlockCtrl:FadeOut()
end

function PopupFunctionUnlockCtrl:OnEnable()
  self.bAnimPlay = false
  self.animPlayTimer = nil
  self.nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.ani, {
    "PopupFunctionUnlockPanel_in"
  })
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.tbFuncId = tbParam[1]
    self.callback = tbParam[2]
  end
  self._mapNode.goContent.gameObject:SetActive(false)
  self._mapNode.goBlur.gameObject:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goContent.gameObject:SetActive(true)
    self:ShowUnlockFunc()
  end
  
  cs_coroutine.start(wait)
end

function PopupFunctionUnlockCtrl:OnDisable()
end

function PopupFunctionUnlockCtrl:OnDestroy()
end

function PopupFunctionUnlockCtrl:OnRelease()
end

function PopupFunctionUnlockCtrl:OnBtnClick_Close()
  if self.bAnimPlay then
    self._mapNode.ani:CrossFade("PopupFunctionUnlockPanel_in", 0, -1, 1)
    self.animPlayTimer:Cancel(true)
    return
  end
  self:ShowUnlockFunc()
end

return PopupFunctionUnlockCtrl
