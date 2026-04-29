_class("UISerialAutoFightSweepResultNew", UIController)
UISerialAutoFightSweepResultNew = UISerialAutoFightSweepResultNew

function UISerialAutoFightSweepResultNew:OnShow(uiParams)
  self._matchType = uiParams and uiParams[2]
  self._stageId = uiParams and uiParams[3]
  self._maxProgress = uiParams and uiParams[4]
  self._trackData = uiParams and uiParams[5]
  self._componentId = uiParams and uiParams[6]
  self._componentId = self._componentId or 0
  self._campaignMissionParams = uiParams and uiParams[7]
  self._campaignMissionParams = self._campaignMissionParams or {}
  self._curProgress = 0
  self._hideEnough = uiParams[8]
  self._againCallback = uiParams[9]
  
  function self._tipsCallback(matid, pos)
    UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
  end
  
  self:_SetLvExp()
  self:_SetTargetItem(self._trackData)
  self:_SetRewards(self._maxProgress)
  UIWidgetHelper.SetAnimationPlay(self, "_anim", "uieff_UISerialAutoFightSweepResult_in")
  self:ContinueBtnOnClick()
  self:_AttachEvents()
end

function UISerialAutoFightSweepResultNew:ShowTips(matid, pos)
  UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
end

function UISerialAutoFightSweepResultNew:OnHide()
end

function UISerialAutoFightSweepResultNew:_SetStyleUI(styleName)
  self._styleName = styleName
  UISerialAutoFightStyleHelper.FitStyle_Widget(self._styleName, "bg_di01", self, "_bg")
  UISerialAutoFightStyleHelper.FitStyle_Widget(self._styleName, "line01", self, "_line")
end

function UISerialAutoFightSweepResultNew:_Refresh(matchRes)
  if not self.view then
    return
  end
  local needPause = false
  if matchRes then
    self._curProgress = self._curProgress + 1
    self._lvExp:Refresh(matchRes)
    if self._targetItem then
      needPause = self._targetItem:Refresh()
    end
    self._rewards:Refresh(self._curProgress, matchRes)
  end
  if self._curProgress == self._maxProgress then
    self:_SetStateWithAnim(UISerialAutoFightSweepState.Fin)
    return
  end
  if needPause then
    self:_SetStateWithAnim(UISerialAutoFightSweepState.Pause, function()
      self:_ShowPauseMsgBox()
    end)
    return
  end
  self:_StartSweep()
end

function UISerialAutoFightSweepResultNew:_ShowPauseMsgBox()
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_battle_auto_fight_sweep_enough_msgbox"), function()
    local jumpData = GameGlobal.GetModule(SerialAutoFightModule):GetJumpData()
    if not jumpData:JumpBack() then
      self:SwitchState(UIStateType.UIMain)
    end
  end, nil, function(param)
  end, nil)
end

function UISerialAutoFightSweepResultNew:_SetState(state)
  local tb = {
    [UISerialAutoFightSweepState.Start] = {
      "_txtTitle_Start",
      "PauseBtn"
    },
    [UISerialAutoFightSweepState.Pause] = {
      "_txtTitle_Pause",
      "ContinueBtn",
      "CloseBtn"
    },
    [UISerialAutoFightSweepState.Fin] = {
      "_txtTitle_Fin",
      "AgainBtn",
      "CloseBtn"
    }
  }
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, tb)
  UIWidgetHelper.SetObjGroupShow(objs, state)
  self._state = state
end

function UISerialAutoFightSweepResultNew:_SetLvExp()
  self._lvExp = UIWidgetHelper.SpawnObject(self, "_lvExp", "UISerialAutoFightSweepResultLvExp")
  self._lvExp:SetStyleUI(self._styleName)
  self._lvExp:SetData()
end

function UISerialAutoFightSweepResultNew:_SetTargetItem(trackData)
  local jumpData = GameGlobal.GetModule(SerialAutoFightModule):GetJumpData()
  local isShow = jumpData:IsShowTargetItem(trackData)
  if not isShow then
    return
  end
  local itemId, itemCondition = jumpData:GetTargetItem()
  self._targetItem = UIWidgetHelper.SpawnObject(self, "_targetItem", "UISerialAutoFightSweepResultTargetItem")
  self._targetItem:SetStyleUI(self._styleName)
  self._targetItem:SetData(2, itemId, itemCondition, self._tipsCallback)
end

function UISerialAutoFightSweepResultNew:_SetRewards(maxProgress)
  self._rewards = UIWidgetHelper.SpawnObject(self, "_rewards", "UISerialAutoFightSweepResultRewards")
  self._rewards:SetStyleUI(self._styleName)
  self._rewards:SetData(maxProgress, self._tipsCallback)
end

function UISerialAutoFightSweepResultNew:_SetNotEnough()
  local resModule = self:GetModule(ResDungeonModule)
  local total = resModule:GetDoubleResNum()
  local isShow = total <= 0
  if self._matchType == MatchType.MT_Season then
    isShow = false
  elseif self._matchType == MatchType.MT_BlackFist then
    isShow = false
  elseif self._hideEnough then
    isShow = false
  end
  self:GetGameObject("_notEnough"):SetActive(isShow)
end

function UISerialAutoFightSweepResultNew:_StartSweep()
  self:StartTask(function(TT)
    local duration = UISerialAutoFightConst.GetSweepDuration()
    YIELD(TT, duration)
    if self.view and self._waitForPause then
      self._waitForPause = false
      self:_SetStateWithAnim(UISerialAutoFightSweepState.Pause)
      return
    end
    if self.view and self._state == UISerialAutoFightSweepState.Start then
      local matchType = self._matchType
      local stageId = self._stageId
      local sweepTimes = 1
      local gameMatchModule = GameGlobal.GetModule(GameMatchModule)
      gameMatchModule:Start_MatchSweep(matchType, stageId, sweepTimes, self._componentId, self._campaignMissionParams, function(res, matchResult)
        if res:GetSucc() then
          self:_Refresh(matchResult)
        end
      end)
    end
  end)
end

function UISerialAutoFightSweepResultNew:PauseBtnOnClick()
  self._waitForPause = true
end

function UISerialAutoFightSweepResultNew:ContinueBtnOnClick()
  self:_SetStateWithAnim(UISerialAutoFightSweepState.Start, function()
    self:_StartSweep()
  end)
end

function UISerialAutoFightSweepResultNew:AgainBtnOnClick()
  if self._againCallback then
    self:_CloseDialogWithAnim(function()
      self._againCallback()
    end)
  else
    self:_CloseDialogWithAnim(function()
      local jumpData = GameGlobal.GetModule(SerialAutoFightModule):GetJumpData()
      jumpData:OpenOptionAgain(true)
    end)
  end
end

function UISerialAutoFightSweepResultNew:CloseBtnOnClick()
  self:_CloseDialogWithAnim()
end

function UISerialAutoFightSweepResultNew:_AttachEvents()
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
end

function UISerialAutoFightSweepResultNew:_DetachEvents()
end

function UISerialAutoFightSweepResultNew:_CloseDialogWithAnim(callback)
  UIWidgetHelper.PlayAnimation(self, "_anim", "uieff_UISerialAutoFightSweepResult_out", 200, function()
    if callback then
      callback()
    end
    self:CloseDialog()
    self:DispatchEvent(GameEventType.OnSerialAutoFightSweepFinish)
  end)
end

function UISerialAutoFightSweepResultNew:_SetStateWithAnim(state, callback)
  if state == self._state then
    return
  end
  if state == UISerialAutoFightSweepState.Fin then
    self:_SetNotEnough()
  end
  if self._state == nil then
    self:_SetState(state)
    if callback then
      callback()
    end
    return
  end
  local animInfo = {
    [UISerialAutoFightSweepState.Start] = {
      animName = "uieff_UISerialAutoFightSweepResult_start",
      duration = 367
    },
    [UISerialAutoFightSweepState.Pause] = {
      animName = "uieff_UISerialAutoFightSweepResult_pause",
      duration = 333
    },
    [UISerialAutoFightSweepState.Fin] = {
      animName = "uieff_UISerialAutoFightSweepResult_finish",
      duration = 333
    }
  }
  local animName, duration = animInfo[state].animName, animInfo[state].duration
  UIWidgetHelper.PlayAnimation(self, "_anim", animName, duration, function()
    self:_SetState(state)
    if callback then
      callback()
    end
  end)
end
