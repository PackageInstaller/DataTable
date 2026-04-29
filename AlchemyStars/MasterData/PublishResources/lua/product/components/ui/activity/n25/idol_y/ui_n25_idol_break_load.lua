_class("UIN25IdolBreakLoad", UIController)
UIN25IdolBreakLoad = UIN25IdolBreakLoad

function UIN25IdolBreakLoad:Constructor()
end

function UIN25IdolBreakLoad:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N25)
  self._idolComponent = self._localProcess:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL)
end

function UIN25IdolBreakLoad:OnShow(uiParams)
  self._archivePreviewPath = self:GetUIComponent("UISelectObjectPath", "archivePreview")
  self._archivePreview = self._archivePreviewPath:SpawnObject("UIN25IdolArchiveBreak")
  self._animation = self:GetUIComponent("Animation", "animation")
  local idolInfo = self._idolComponent:GetComponentInfo()
  local breakInfo = idolInfo.break_info
  self._archivePreview:Flush(breakInfo)
end

function UIN25IdolBreakLoad:OnHide()
end

function UIN25IdolBreakLoad:BtnCloseOnClick(go)
  local lockName = "UIN25IdolBreakLoad:_backAnim"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("uieff_UIN25IdolBreakLoad_out")
    YIELD(TT, 333)
    self:UnLock(lockName)
    self:CloseDialog()
  end)
end

function UIN25IdolBreakLoad:BtnNewGameOnClick(go)
  PopupManager.Alert("UIN25IdolMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_n25_idol_y_break_new_game_second_confirm"), function(param)
    self:DispatchEvent(GameEventType.N25IdolStartPlayGame, IdolStartType.IdolStartType_New)
  end, nil, function(param)
  end, nil)
end

function UIN25IdolBreakLoad:BtnContinueGameOnClick(go)
  self:DispatchEvent(GameEventType.N25IdolStartPlayGame, IdolStartType.IdolStartType_Break)
end
