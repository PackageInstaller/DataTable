_class("UISeasonMazeRoomBase", UIController)
UISeasonMazeRoomBase = UISeasonMazeRoomBase

function UISeasonMazeRoomBase:OnShow(uiParams)
  self._uiParams = uiParams
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._seasonMazeObj = self._seasonMazeModule:CurSeasonObj()
  self._component = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self._comInfo = self._component:GetComponentInfo()
  self._comCfgID = self._seasonMazeObj:GetMazeComponent():GetComponentCfgId()
  self._nodeID = self._uiParams[1]
  self._roomInfo = self._comInfo.rooms[self._nodeID]
  self:OnShowUI()
end

function UISeasonMazeRoomBase:RefreshRoomInfo()
  self._roomInfo = self._comInfo.rooms[self._nodeID]
end

function UISeasonMazeRoomBase:OnShowUI()
end

function UISeasonMazeRoomBase:OnHideUI(...)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonMazeRoomOperationFinish, ...)
  self:CloseDialog()
end

function UISeasonMazeRoomBase:ShowLeaveBtn()
  local leave = self:GetUIComponent("UISelectObjectPath", "UISMazeRoomLeaveBtn")
  local btn = leave:SpawnObject("UISMazeRoomLeaveBtn")
  btn:SetData(function()
    self:OnlyHideUI()
  end)
end

function UISeasonMazeRoomBase:OnlyHideUI()
  self._seasonMazeModule:UIModule():SetTempRoom(self:GetName())
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTempCloseRoom, true)
  self:CloseDialog()
end
