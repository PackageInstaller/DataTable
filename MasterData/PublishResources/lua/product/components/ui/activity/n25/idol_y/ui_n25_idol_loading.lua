_class("UIN25IdolLoading", UIController)
UIN25IdolLoading = UIN25IdolLoading

function UIN25IdolLoading:Constructor()
  self._countArchive = 5
  self._id2type = {
    IdolProcessType.IdolProcessType_First,
    IdolProcessType.IdolProcessType_Second,
    IdolProcessType.IdolProcessType_Third,
    IdolProcessType.IdolProcessType_Forth,
    IdolProcessType.IdolProcessType_Fifth
  }
end

function UIN25IdolLoading:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N25)
  self._idolComponent = self._localProcess:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL)
end

function UIN25IdolLoading:OnShow(uiParams)
  self._arContentPath = self:GetUIComponent("UISelectObjectPath", "arContent")
  self._arContentPool = self._arContentPath:SpawnObjects("UIN25IdolArchiveFixed", self._countArchive)
  self._animation = self:GetUIComponent("Animation", "animation")
  self:FlushArchive()
end

function UIN25IdolLoading:OnHide()
end

function UIN25IdolLoading:FlushArchive()
  local idolInfo = self._idolComponent:GetComponentInfo()
  local processInfo = idolInfo.process_info
  if processInfo == nil then
    processInfo = {}
  end
  for i = 1, self._countArchive do
    local ui = self._arContentPool[i]
    ui:Flush(self, self._id2type[i], processInfo[self._id2type[i]])
  end
end

function UIN25IdolLoading:BtnCloseOnClick(go)
  local lockName = "UIN25IdolLoading:_backAnim"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("uieff_UIN25IdolLoading_out")
    YIELD(TT, 333)
    self:UnLock(lockName)
    self:CloseDialog()
  end)
end

function UIN25IdolLoading:IdolComponent()
  return self._idolComponent
end
