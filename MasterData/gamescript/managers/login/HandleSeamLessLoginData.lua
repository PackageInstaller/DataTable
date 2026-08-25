return function(loginResponseData)
  local playerProfileData = loginResponseData.playerProfile
  local recoverWorld = playerProfileData.recoverWorld
  local recoverWorldType = playerProfileData.worldType
  if 0 == WorldRecoveryManager.Instance:GetWorldTid() and recoverWorld and recoverWorld > 0 then
    WorldRecoveryManager.Instance:SetRecoverData(recoverWorld, recoverWorldType)
    Logger.Info("OnLoginSuccess Recover Copies", recoverWorld, recoverWorldType)
  end
end
