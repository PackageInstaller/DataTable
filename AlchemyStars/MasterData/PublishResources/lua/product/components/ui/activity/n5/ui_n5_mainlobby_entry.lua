_class("UIN5MainLobbyEntry", UICustomWidget)
UIN5MainLobbyEntry = UIN5MainLobbyEntry

function UIN5MainLobbyEntry:Constructor()
  self._campaignModule = self:GetModule(CampaignModule)
end

function UIN5MainLobbyEntry:OnShow(uiParams)
  self:_GetComponents()
  self:_InitNewFlagAndRedPoint()
end

function UIN5MainLobbyEntry:OnHide()
  if self._checkRedTask then
    GameGlobal.TaskManager():KillTask(self._checkRedTask)
    self._checkRedTask = nil
  end
end

function UIN5MainLobbyEntry:_GetComponents()
  self._redPoint = self:GetGameObject("RedPoint")
  self._newFlag = self:GetGameObject("NewFlag")
end

function UIN5MainLobbyEntry:_InitNewFlagAndRedPoint()
  if self._checkRedTask then
    GameGlobal.TaskManager():KillTask(self._checkRedTask)
    self._checkRedTask = nil
  end
  self._checkRedTask = GameGlobal.TaskManager():StartTask(function()
    local campaignData = self._campaignModule:GetN5Data()
    campaignData:RequestCampaign()
    YIELD(TT)
    self:_RefreshNewFlagAndRedPoint()
  end)
end

function UIN5MainLobbyEntry:SetData()
end

function UIN5MainLobbyEntry:EntryBtnOnClick(go)
  self:SwitchState(UIStateType.UIActivityN5)
end

function UIN5MainLobbyEntry:_RefreshNewFlagAndRedPoint()
  local data = self._campaignModule:GetN5Data()
  local showNewFlag = data:HaveNewFlag()
  local showRedPoint = data:HaveRedPoint()
  self._newFlag:SetActive(showNewFlag)
  self._redPoint:SetActive(showRedPoint and not showNewFlag)
end
