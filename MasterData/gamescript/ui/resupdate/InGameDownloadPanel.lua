local InGameDownloadPanel, Super = System.NewClass("InGameDownloadPanel", UIBasePanel)
InGameDownloadPanel.uiResCls = "UI/UI_Common/UI_Common_Prefab/UI_Login_InGameDownload_Popup.prefab"
local SetLocalScale = CS.Framework.TransformUtil.SetLocalScale
local UnityTime = CS.UnityEngine.Time

function InGameDownloadPanel:OnBind(binder)
  self.binder = binder
  self._lastDownloadSize = GroupDownloadMgr.Instance:LoadDownLoadSize()
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self.OnConfirmClick),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self.OnCancelClick),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData,
    textTitleCN = LT.Text("InGameDownloadingTitle")
  }
  self.binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_S, commonPopupConfirmTipsData))
  self.ui.Btn_Confirm:SetActive(false)
  self.ui.Btn_Cancel:SetActive(false)
  LateUpdateBeat.Instance:Add(self._UpdateDownloading, self)
  self:_UpdateDownloading()
end

function InGameDownloadPanel:OnUnbind()
  Super.OnUnbind(self)
  LateUpdateBeat.Instance:Remove(self._UpdateDownloading, self)
end

function InGameDownloadPanel:_IsDownloadFinish()
  local ingameDownloadName = GroupDownloadMgr.Instance:GetInGameDownloadGroupName()
  local hasDownload = GroupDownloadMgr.Instance:IsGroupDownload(ingameDownloadName)
  if hasDownload then
    return true
  end
  return false
end

function InGameDownloadPanel:_GetDownloadStatus()
  if self:_IsDownloadFinish() then
    return GroupDownStatus.Successed
  end
  local ingameDownloadGroup = GroupDownloadMgr.Instance:GetInGameDownloadGroup()
  local downloadStatus = ingameDownloadGroup and ingameDownloadGroup:GetDownLoadStatus() or GroupDownStatus.Init
  return downloadStatus
end

function InGameDownloadPanel:_UpdateDownloading()
  local downloadStatus = self:_GetDownloadStatus()
  if downloadStatus == GroupDownStatus.Init then
    self:_OnNotDownloading()
    return
  end
  if downloadStatus == GroupDownStatus.Failed then
    self:_OnDownloadFailed()
    return
  end
  if downloadStatus == GroupDownStatus.Successed then
    self:_OnDownloadFinished()
    return
  end
  self:_OnDownloading()
end

function InGameDownloadPanel:_OnNotDownloading()
  self.ui.Node_Downloading:SetActive(false)
  self.ui.Node_NotDownload:SetActive(true)
  self.ui.Btn_Confirm:SetActive(true)
  self.ui.Btn_Cancel:SetActive(true)
  local tipsCfg = DT.TipsType[20186]
  self.binder:SetText(self.ui.Text_NotDownLoadTips, LT.Text(tipsCfg.Desc))
end

function InGameDownloadPanel:_OnDownloadFinished()
  self.ui.Node_Downloading:SetActive(false)
  self.ui.Node_NotDownload:SetActive(true)
  self.ui.Btn_Confirm:SetActive(true)
  self.ui.Btn_Cancel:SetActive(false)
  local tipsCfg = DT.TipsType[20187]
  self.binder:SetText(self.ui.Text_NotDownLoadTips, LT.Text(tipsCfg.Desc))
end

function InGameDownloadPanel:_OnDownloadFailed()
  self.ui.Node_Downloading:SetActive(false)
  self.ui.Node_NotDownload:SetActive(true)
  self.ui.Btn_Confirm:SetActive(true)
  self.ui.Btn_Cancel:SetActive(true)
  local tipsCfg = DT.TipsType[20189]
  self.binder:SetText(self.ui.Text_NotDownLoadTips, LT.Text(tipsCfg.Desc))
end

function InGameDownloadPanel:_OnDownloading()
  self.ui.Node_Downloading:SetActive(true)
  self.ui.Node_NotDownload:SetActive(false)
  self.ui.Btn_Confirm:SetActive(true)
  self.ui.Btn_Cancel:SetActive(false)
  self.binder:SetText(self.ui.Text_DownLoadTips, LT.Text("InGameDownloadingTips"))
  local ingameDownloadGroup = GroupDownloadMgr.Instance:GetInGameDownloadGroup()
  local download_size = ingameDownloadGroup:GetDownloadSize()
  local total_size = ingameDownloadGroup:GetDownloadTotalSize()
  local pb = download_size / math.max(0.001, total_size)
  local pbInt = math.ceil(pb * 100)
  local progressText = string.format("%s/%s(%d%%)", DownLoadGroup.GetSizeFmt(download_size), DownLoadGroup.GetSizeFmt(total_size), pbInt)
  self.binder:SetText(self.ui.Text_DownloadProg, progressText)
  SetLocalScale(self.ui.DownLoadProgBar.transform, pb, 1, 1)
  self._lastDownloadSize = self._lastDownloadSize or download_size
  self._lastSpeed = self._lastSpeed or 0
  local curTime = UnityTime.unscaledTime
  self._lastCheckSpeedTime = self._lastCheckSpeedTime or curTime
  local deltaSize = math.max(0, download_size - self._lastDownloadSize)
  local speed = self._lastSpeed
  if deltaSize > 0 and curTime ~= self._lastCheckSpeedTime then
    speed = deltaSize / math.max(1.0E-5, curTime - self._lastCheckSpeedTime)
    self._lastCheckSpeedTime = curTime
    self._lastSpeed = speed
  end
  local deltaSizeFmt = DownLoadGroup.GetSizeFmt(speed)
  self.binder:SetText(self.ui.Text_DownloadSpeed, string.format("%s/S", deltaSizeFmt))
  self._lastDownloadSize = download_size
end

function InGameDownloadPanel:OnConfirmClick()
  local downloadStatus = self:_GetDownloadStatus()
  if downloadStatus == GroupDownStatus.Successed then
    self:Close()
    return
  end
  if downloadStatus == GroupDownStatus.Init or downloadStatus == GroupDownStatus.Failed then
    local ingameDownloadGroup = GroupDownloadMgr.Instance:GetInGameDownloadGroup()
    if ingameDownloadGroup then
      ingameDownloadGroup:RequestDownLoadGroup()
    else
      local isUseDelegate = GroupDownloadMgr.Instance:IsUseDownloadDelegate()
      GroupDownloadMgr.Instance:DownloadIngameGroup(isUseDelegate)
    end
    return
  end
  self:Close()
end

function InGameDownloadPanel:OnCancelClick()
  self:Close()
end

return InGameDownloadPanel
