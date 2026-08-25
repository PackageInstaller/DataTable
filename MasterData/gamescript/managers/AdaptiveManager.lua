local TypeOfUIResolutionAdaptation = typeof(CS.UIResolutionAdaptation)
local AdaptiveManager, Super = System.NewClass("AdaptiveManager", Manager)

function AdaptiveManager:ctor()
  Super.ctor(self)
  self.mainPanelFov = nil
end

function AdaptiveManager:Awake(binder)
  Super.Awake(self)
  self:UpdateCamera()
  binder:BindEvent(EventMgr.Instance.OnEnterScene, function(scene)
    if scene == CommonDefine.SceneType.Battle then
      self:_SaveCameraFovOnEnterBattleScene()
      self:ApplyBattleCameraAdaptation()
    end
  end)
  binder:BindEvent(EventMgr.Instance.OnExitScene, function(scene)
    if scene == CommonDefine.SceneType.Battle then
      self:_ResumeCameraFovWhileExitBattleScene()
      self:RemoveBattleCameraAdaptation()
    end
  end)
end

function AdaptiveManager:UpdateCamera()
  if not self.nodeMainCamera or not self.nodeUICamera then
    self.nodeMainCamera = CS.UnityEngine.GameObject.Find("Main Camera")
    self.nodeUICamera = CS.UnityEngine.GameObject.Find("UICamera")
  end
  if not self.nodeMainCamera or not self.nodeUICamera then
    Logger.Info("AdaptiveManager UpdateCamera Failed, not self.nodeMainCamera or not self.nodeUICamera")
    return
  end
  if not self.compMainCamera or not self.compUICamera then
    self.compMainCamera = self.nodeMainCamera:GetComponent(typeof(CS.UnityEngine.Camera))
    self.compUICamera = self.nodeUICamera:GetComponent(typeof(CS.UnityEngine.Camera))
  end
end

function AdaptiveManager:_SaveCameraFovOnEnterBattleScene()
  if self.compMainCamera and math.abs(self.compMainCamera.fieldOfView) > 0.001 then
    self.mainPanelFov = self.compMainCamera.fieldOfView
  end
end

function AdaptiveManager:ApplyBattleCameraAdaptation(forceApply)
  local heightRatio = self:GetHeightRatio()
  if forceApply or heightRatio < 1 then
    self:CloseOldAdaptation()
    self:ClearVerticalAreaRT()
    self:SetCameraViewportWithHeightRatio(heightRatio)
  end
end

function AdaptiveManager:RemoveBattleCameraAdaptation()
  local heightRatio = self:GetHeightRatio()
  if heightRatio < 1 or ApplicationUtils.IsEditor() or ApplicationUtils.IsWindows() then
    self:OpenOldAdaptation()
    self:DoOldAdaptation()
    self:ResetCameraViewport()
  end
end

function AdaptiveManager:_ResumeCameraFovWhileExitBattleScene()
  if self.compMainCamera and self.mainPanelFov then
    self.compMainCamera.fieldOfView = self.mainPanelFov
  end
end

function AdaptiveManager:GetHeightRatio()
  local screenRatio = MathUtils.Round(CS.UnityEngine.Screen.width / CS.UnityEngine.Screen.height, 2)
  local targetRatio = MathUtils.Round(self:GetTargetRatio(), 2)
  return screenRatio / targetRatio
end

function AdaptiveManager:IsLowerTargetRatio()
  local heightRatio = self:GetHeightRatio()
  return heightRatio < 1
end

function AdaptiveManager:SetCameraViewportWithHeightRatio(heightRatio)
  self:UpdateCamera()
  if not self.compMainCamera or not self.compUICamera then
    Logger.Info("AdaptiveManager SetCameraViewportWithHeightRatio Failed, not self.compMainCamera or not self.compUICamera")
    return
  end
  if ApplicationUtils.IsWindowsOrEditor() then
    local adjRatioH = 1
    local adjRatioV = 1
    if heightRatio < 1 then
      local rect = CS.UnityEngine.Rect(0, (1 - heightRatio) * 0.5, 1, heightRatio)
      self.compMainCamera.rect = rect
      self.compUICamera.rect = rect
      return
    else
      local screenWidth = CS.UnityEngine.Screen.width
      local screenHeight = CS.UnityEngine.Screen.height
      local sreenRatio = screenWidth / screenHeight
      local designedRatio = 2.1666666666666665
      adjRatioH = designedRatio / sreenRatio
    end
    local hRect = math.min(1, math.max(0, adjRatioH))
    local vRect = math.min(1, math.max(0, adjRatioV))
    local rect = CS.UnityEngine.Rect((1.0 - hRect) * 0.5, (1 - vRect) * 0.5, hRect, vRect)
    self.compMainCamera.rect = rect
    self.compUICamera.rect = rect
  else
    local rect = CS.UnityEngine.Rect(0, (1 - heightRatio) * 0.5, 1, heightRatio)
    self.compMainCamera.rect = rect
    self.compUICamera.rect = rect
  end
end

function AdaptiveManager:ResetCameraViewport()
  self:UpdateCamera()
  if not self.compMainCamera or not self.compUICamera then
    Logger.Info("AdaptiveManager ResetCameraViewport Failed, not self.compMainCamera or not self.compUICamera")
    return
  end
  self.compMainCamera.rect = CS.UnityEngine.Rect(0, 0, 1, 1)
  self.compUICamera.rect = CS.UnityEngine.Rect(0, 0, 1, 1)
end

function AdaptiveManager:ClearVerticalAreaRT()
  local safeAreaRT, topAreaRT, bottomAreaRT, leftAreaRT, rightAreaRT = UIRootMgr.GetAllAreaRT()
  self:ClearAreaRT(leftAreaRT)
  self:ClearAreaRT(rightAreaRT)
  self:ClearAreaRT(topAreaRT)
  self:ClearAreaRT(bottomAreaRT)
  self:ClearAreaRT(safeAreaRT)
end

function AdaptiveManager:ClearAreaRT(rectTransform)
  rectTransform.offsetMin = CS.UnityEngine.Vector2(0, 0)
  rectTransform.offsetMax = CS.UnityEngine.Vector2(0, 0)
end

function AdaptiveManager:GetTargetRatio()
  return 1.7777777777777777
end

function AdaptiveManager:OnDestroy()
  Super.OnDestroy(self)
end

function AdaptiveManager:DoOldAdaptation()
  local adaptationScript = self:GetOldAdaptation()
  if not adaptationScript then
    Logger.Info("AdaptiveManager DoOldAdaptation Failed, not adaptationScript")
    return
  end
  adaptationScript:DoAdaptation("special")
end

function AdaptiveManager:GetOldAdaptation()
  local safeAreaComp = CS.UnityEngine.GameObject.Find("SafeArea")
  if not safeAreaComp then
    Logger.Info("AdaptiveManager GetOldAdaptation Failed, not safeAreaComp")
    return
  end
  do return safeAreaComp.GetComponent, safeAreaComp end
  return safeAreaComp.GetComponent, safeAreaComp, TypeOfUIResolutionAdaptation
end

function AdaptiveManager:OpenOldAdaptation()
  local adaptationScript = self:GetOldAdaptation()
  if not adaptationScript then
    Logger.Info("AdaptiveManager OpenOldAdaptation Failed, not adaptationScript")
    return
  end
  adaptationScript.enabled = true
end

function AdaptiveManager:CloseOldAdaptation()
  local adaptationScript = self:GetOldAdaptation()
  if not adaptationScript then
    Logger.Info("AdaptiveManager OpenOldAdaptation Failed, not adaptationScript")
    return
  end
  adaptationScript.enabled = false
end

return AdaptiveManager
