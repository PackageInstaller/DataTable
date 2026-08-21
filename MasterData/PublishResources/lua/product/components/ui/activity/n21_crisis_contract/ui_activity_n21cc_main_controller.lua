_class("UIActivityN21CCMainController", UIController)
UIActivityN21CCMainController = UIActivityN21CCMainController

function UIActivityN21CCMainController:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._activityConst = UIActivityN21CCConst:New()
  self._activityConst:LoadData(TT, res)
  local challengeComponent, challengeCompInfo = self._activityConst:GetChallengeComponent()
  if challengeComponent == nil or challengeCompInfo == nil then
    res:SetSucc(false)
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return
  end
  self._levelGroupsData = UIActivityN21CCLevelGroupsData:New(challengeComponent:GetComponentCfgId(), challengeCompInfo)
end

function UIActivityN21CCMainController:OnShow()
  self:AttachEvent(GameEventType.N21CCGetScoreReward, self.ForceUpdate)
  self:AttachEvent(GameEventType.N21CCRefreshLevelStatus, self.RefreshLevelStatus)
  self:AttachEvent(GameEventType.N21CCPlayMainFocusAnim, self.PlayFocusAnim)
  self._timeLabel = self:GetUIComponent("UILocalizationText", "Time")
  self._levelLoader = self:GetUIComponent("UISelectObjectPath", "Levels")
  self._remainLevelsLabel = self:GetUIComponent("UILocalizationText", "RemainLevels")
  self._remainTimeLabel = self:GetUIComponent("UILocalizationText", "RemainTime")
  self._unOpenLevels = self:GetGameObject("UnOpenLevels")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._tasklRed = self:GetGameObject("TaskRed")
  self._topBtn = self:GetGameObject("TopBtn")
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  local backBtn = btns:SpawnObject("UICommonTopButton")
  backBtn:SetData(function()
    GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
  end, function()
    self:ShowDialog("UIActivityN21CCIntro", "UIActivityN21CCMainController")
  end, nil, false)
  self:InitUI()
  UIActivityN21CCConst.ClearEnterNewStatus()
end

function UIActivityN21CCMainController:OnHide()
  self:DetachEvent(GameEventType.N21CCRefreshLevelStatus, self.RefreshLevelStatus)
  self:DetachEvent(GameEventType.N21CCGetScoreReward, self.ForceUpdate)
  self:DetachEvent(GameEventType.N21CCPlayMainFocusAnim, self.PlayFocusAnim)
end

function UIActivityN21CCMainController:OnUpdate(deltaTimeMS)
  self:RefreshUI()
end

function UIActivityN21CCMainController:CloseCoro(TT)
  self:Lock("UIActivityN21CCMainController_CloseCoro")
  self:SwitchState(UIStateType.UIMain)
  self:UnLock("UIActivityN21CCMainController_CloseCoro")
end

function UIActivityN21CCMainController:GetPositionAndRotation(count, index)
  if not self._positionConfig then
    self._positionConfig = {
      [1] = {
        [1] = {
          position = Vector3(21.07, -75.8, 0),
          angle = -7.94
        }
      },
      [2] = {
        [1] = {
          position = Vector3(-129.53, -36, 0),
          angle = -7.94
        },
        [2] = {
          position = Vector3(168.97, -84.7, 0),
          angle = 1.75
        }
      },
      [3] = {
        [1] = {
          position = Vector3(-297.53, -36.9, 0),
          angle = -7.94
        },
        [2] = {
          position = Vector3(2.97, -86.8, 0),
          angle = 1.75
        },
        [3] = {
          position = Vector3(302.97, -73.8, 0),
          angle = -4.59
        }
      },
      [4] = {
        [1] = {
          position = Vector3(-442.23, -36.3, 0),
          angle = -7.94
        },
        [2] = {
          position = Vector3(-137.53, -86, 0),
          angle = 1.75
        },
        [3] = {
          position = Vector3(159.67, -73.9, 0),
          angle = -4.59
        },
        [4] = {
          position = Vector3(475.97, -69.6, 0),
          angle = 4.01
        }
      },
      [5] = {
        [1] = {
          position = Vector3(-573.7, -42.1, 0),
          angle = -7.94
        },
        [2] = {
          position = Vector3(-274.93, -92.6, 0),
          angle = 1.75
        },
        [3] = {
          position = Vector3(28.97, -80.7, 0),
          angle = -4.59
        },
        [4] = {
          position = Vector3(346, -76, 0),
          angle = 4.01
        },
        [5] = {
          position = Vector3(635.27, -28.9, 0),
          angle = 7.18
        }
      }
    }
  end
  local config = self._positionConfig[count]
  if not config then
    return Vector3(0, 0, 0), 0
  end
  local result = config[index]
  return result.position, result.angle
end

function UIActivityN21CCMainController:PlayEnterAnim()
  local lockLevelGroups = self._levelGroupsData:GetLockLevelGroups()
  if #lockLevelGroups <= 0 then
    self._anim:Play("UIActivityN21CCMainController_in_2")
  else
    self._anim:Play("UIActivityN21CCMainController_in")
  end
  self:StartTask(self.PlayEnterAnimCoro, self)
end

function UIActivityN21CCMainController:PlayEnterAnimCoro(TT)
  self:Lock("UIActivityN21CCMainController_PlayEnterAnimCoro")
  local levelItems = self._levelLoader:GetAllSpawnList()
  for i = 1, #levelItems do
    local item = levelItems[i]
    item:PlayAnim()
    YIELD(TT, 100)
  end
  self:UnLock("UIActivityN21CCMainController_PlayEnterAnimCoro")
end

function UIActivityN21CCMainController:PlayFocusAnim()
  self._anim:Play("UIActivityN21CCMainController_in_1")
end

function UIActivityN21CCMainController:InitUI()
  self:InitLevels()
  self:RefreshUI()
  self:RefreshRedAndNew()
  self:PlayEnterAnim()
end

function UIActivityN21CCMainController:InitLevels()
  if not self._activityConst:IsChallengeEnable() then
    return
  end
  self:RefreshLevelStatus()
end

function UIActivityN21CCMainController:RefreshLevelStatus()
  self._levelGroupsData:Refresh()
  local openLevelGroups = self._levelGroupsData:GetOpenLevelGroups()
  self._levelLoader:SpawnObjects("UIActivityN21CCItem", #openLevelGroups)
  local levelItems = self._levelLoader:GetAllSpawnList()
  for i = 1, #levelItems do
    local item = levelItems[i]
    item:Refresh(openLevelGroups[i], false, function(levelGroupData)
      self:OpenLevelGroup(item, levelGroupData, #levelItems, i)
    end)
    local pos, angle = self:GetPositionAndRotation(#levelItems, i)
    item:SetTransform(pos, angle, 0.65)
  end
  local lockLevelGroups = self._levelGroupsData:GetLockLevelGroups()
  if #lockLevelGroups <= 0 then
    self._unOpenLevels:SetActive(false)
    self._unlockLevelGroup = nil
  else
    self._unlockLevelGroup = lockLevelGroups[#lockLevelGroups]
    self._unOpenLevels:SetActive(true)
    self._remainLevelsLabel:SetText(StringTable.Get("str_n20_crisis_contract_remain_boss_count", #lockLevelGroups))
    self:RefreshUnOpenLevelStatus()
  end
end

function UIActivityN21CCMainController:RefreshUI()
  self:RefreshActivityRemainTime()
  self:RefreshUnOpenLevelStatus()
end

function UIActivityN21CCMainController:RefreshUnOpenLevelStatus()
  if not self._unlockLevelGroup then
    return
  end
  local seconds = self._unlockLevelGroup:GetUnlockSeconds()
  local timeStr = UIActivityN21CCConst.GetTimeString(seconds)
  self._remainTimeLabel:SetText(StringTable.Get("str_n20_crisis_contract_level_unlock_time", timeStr))
  if seconds <= 0 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.N21CCRefreshLevelStatus)
  end
end

function UIActivityN21CCMainController:RefreshActivityRemainTime()
  local endTime = self._activityConst:GetActiveEndTime()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(endTime - nowTime)
  if seconds < 0 then
    seconds = 0
  end
  if self._activityConst:IsActivityEnd() then
    self._timeLabel:SetText(StringTable.Get("str_n20_crisis_contract_activity_end"))
    return
  end
  local timeStr = UIActivityN21CCConst.GetTimeString(seconds)
  self._timeLabel:SetText(StringTable.Get("str_n20_crisis_contract_activity_remain_time", timeStr))
end

function UIActivityN21CCMainController:RefreshRedAndNew()
  self:RefreshEventRedAndNew()
end

function UIActivityN21CCMainController:RefreshEventRedAndNew()
  self._tasklRed:SetActive(self._activityConst:IsShowEventnRed())
end

function UIActivityN21CCMainController:OpenLevelGroup(item, levelGroupData, count, index)
  if self._activityConst:IsActivityEnd() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  self:ShowDialog("UIActivityN21CCShowCardController", levelGroupData, self._activityConst, item, count, index)
end

function UIActivityN21CCMainController:ForceUpdate()
  self:StartTask(self.ReLoadData, self)
end

function UIActivityN21CCMainController:ReLoadData(TT)
  self:Lock("UIActivityN21CCMainController_ReLoadData")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._activityConst:LoadData(TT, res)
  self:RefreshRedAndNew()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.N21CCRefreshRedAndNew)
  self:UnLock("UIActivityN21CCMainController_ReLoadData")
end

function UIActivityN21CCMainController:BtnTaskOnClick()
  if self._activityConst:IsActivityEnd() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  if not self._activityConst:IsProgressEnable() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return
  end
  self:ShowDialog("UIActivityN21CCShop")
end

function UIActivityN21CCMainController:UnOpenBtnOnClick()
  if not self._unlockLevelGroup then
    return
  end
  local timeStr = UIActivityN21CCConst.GetTimeString(self._unlockLevelGroup:GetUnlockSeconds())
  ToastManager.ShowToast(StringTable.Get("str_n20_crisis_contract_level_unlock_tips", timeStr))
end
