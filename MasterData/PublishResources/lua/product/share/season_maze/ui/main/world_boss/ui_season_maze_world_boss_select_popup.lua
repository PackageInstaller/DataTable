_class("UISeasonMazeWorldBossSelectPopUp", UIController)
UISeasonMazeWorldBossSelectPopUp = UISeasonMazeWorldBossSelectPopUp

function UISeasonMazeWorldBossSelectPopUp:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeWorldBossSelectPopUp:OnShow(uiParams)
  local fromBattle = uiParams[1]
  self:InitWidget()
  self:InitUI()
  if fromBattle then
    self:ShowDialog("UISeasonMazeWorldBossDetailPopUp", false)
  end
end

function UISeasonMazeWorldBossSelectPopUp:InitWidget()
  self._anim = self:GetGameObject("_anim")
  self.backBtns = UIWidgetHelper.SpawnObject(self, "backBtns", "UINewCommonTopButton")
end

function UISeasonMazeWorldBossSelectPopUp:InitUI()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._sample = self._seasonMazeModule:GetCurSample()
  self._seasonMazeObj = self._seasonMazeModule:CurSeasonObj()
  self._component = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self._componentInfo = self._component:GetComponentInfo()
  self._progressComponent = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.TOTAL_PROCESS)
  self._endTime = self._sample.end_time
end

function UISeasonMazeWorldBossSelectPopUp:CheckSeasonMazeClosed()
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  local endTime = self._endTime
  if curTime > endTime then
    ToastManager.ShowToast(StringTable.Get("str_activity_common_state_over"))
    return true
  else
    return false
  end
end

function UISeasonMazeWorldBossSelectPopUp:BgOnClick(go)
end

function UISeasonMazeWorldBossSelectPopUp:ResultBtnOnClick(go)
  if self:CheckSeasonMazeClosed() then
    local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
    seasonMazeModule:UIModule():ExitTo(UIStateType.UIMain)
    return
  end
  PopupManager.Alert("UISeasonMazeMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, StringTable.Get("str_collect_card_pop_title"), StringTable.Get("str_season_maze_world_boss_end_select_tips"), function(param)
    self:ShowDialog("UISeasonMazeCompleteResult")
  end, nil, nil, nil)
end

function UISeasonMazeWorldBossSelectPopUp:BattleBtnOnClick(go)
  if self:CheckSeasonMazeClosed() then
    local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
    seasonMazeModule:UIModule():ExitTo(UIStateType.UIMain)
    return
  end
  self:ShowDialog("UISeasonMazeWorldBossDetailPopUp", false)
end
