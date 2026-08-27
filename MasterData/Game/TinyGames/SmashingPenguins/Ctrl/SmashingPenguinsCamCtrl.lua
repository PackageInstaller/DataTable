local SmashingPenguinsCtrlBase = require("Game.TinyGames.SmashingPenguins.Ctrl.SmashingPenguinsCtrlBase")
local SmashingPenguinsCamCtrl = class("SmashingPenguinsCamCtrl", SmashingPenguinsCtrlBase)
local SmashingPenguinsConfig = require("Game.TinyGames.SmashingPenguins.Config.SmashingPenguinsConfig")

function SmashingPenguinsCamCtrl:OnGamePrepare()
  local mainUI = UIManager:GetWindow(UIWindowTypeID.SmashingPenguins)
  if IsNull(mainUI) then
    return
  end
  mainUI.mainGameItems.transform.localPosition = Vector3.zero
  self.prefTargetPosX = nil
  self.fakeCamPosX = 0
  local halfScreen = self:GetScreentWidth() * 0.5
  self.fakeCamDeadPosX = -halfScreen + SmashingPenguinsConfig.MaxXPos
end

function SmashingPenguinsCamCtrl:FollowTargetPos(targetEntity)
  local mainUI = UIManager:GetWindow(UIWindowTypeID.SmashingPenguins)
  if IsNull(mainUI) then
    return
  end
  local targetWorldPos = targetEntity.transform.position
  targetWorldPos.x = targetWorldPos.x + SmashingPenguinsConfig.DeltaCamFloowXPos
  if self.limitPos ~= nil and self.startSetLimitPos ~= nil then
    if (self.limitPos.x - self.startSetLimitPos.x) * (self.limitPos.x - targetWorldPos.x) > 0 then
      return
    else
      self.limitPos = nil
      self.startSetLimitPos = nil
    end
  end
  local targetPos = mainUI.mainGameItems.transform:InverseTransformPoint(targetWorldPos)
  local targetPosX = targetPos.x
  if self.prefTargetPosX ~= nil and math.abs(self.prefTargetPosX - targetPosX) < 0.1 then
    return
  end
  local halfScreen = self:GetScreentWidth() * 0.5
  local deltaCamX = targetPosX - self.fakeCamPosX
  if self.fakeCamPosX + deltaCamX > self.fakeCamDeadPosX then
    deltaCamX = self.fakeCamDeadPosX - self.fakeCamPosX
  end
  self:MoveFakeCam(deltaCamX, mainUI)
  self.prefTargetPosX = targetPosX
end

function SmashingPenguinsCamCtrl:SetFollowLimit(limitPos, startSetLimitPos)
  limitPos.x = limitPos.x + SmashingPenguinsConfig.DeltaCamFloowXPos
  self.limitPos = limitPos
  startSetLimitPos.x = startSetLimitPos.x + SmashingPenguinsConfig.DeltaCamFloowXPos
  self.startSetLimitPos = startSetLimitPos
end

function SmashingPenguinsCamCtrl:MoveFakeCam(deltaCamX, mainUI)
  local localItemsPosition = mainUI.mainGameItems.transform.localPosition
  localItemsPosition.x = localItemsPosition.x - deltaCamX
  mainUI.mainGameItems.transform.localPosition = localItemsPosition
  self.fakeCamPosX = self.fakeCamPosX + deltaCamX
end

function SmashingPenguinsCamCtrl:GetScreentWidth()
  local width = UIManager.csUIManager.BackgroundStretchSize.x
  return width
end

return SmashingPenguinsCamCtrl
