local NullSceneState, Super = System.NewClass("NullSceneState", BaseSceneState)

function NullSceneState:OnEnterScene()
  Super.OnEnterScene(self)
  self:_InitCameraPos()
  self:StopPopupQueTimer()
  self._popupQueEnabledTimer = TimerManager.Instance:CreateTimer(1, 0, nil, function()
    PopupQueManager.Instance:SetEnabled(true)
  end)
  self:_StartReleaseResTimer()
end

function NullSceneState:StopPopupQueTimer()
  if self._popupQueEnabledTimer then
    TimerManager.Instance:StopTimer(self._popupQueEnabledTimer)
    self._popupQueEnabledTimer = nil
  end
end

function NullSceneState:OnExitScene()
  Super.OnExitScene(self)
  self:StopPopupQueTimer()
  if PopupQueManager.Instance then
    PopupQueManager.Instance:SetEnabled(false)
  end
end

function NullSceneState:_InitCameraPos()
  self.cameraComp = CS.UnityEngine.GameObject.Find("Main Camera")
  if not self.cameraComp then
    return
  end
  CS.Framework.TransformUtil.SetPos(self.cameraComp.transform, 0, 0, 0)
  CS.Framework.TransformUtil.SetLocalEulerAngles(self.cameraComp.transform, 0, 0, 0)
end

return NullSceneState
