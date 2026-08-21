require("play_skill_phase_base_r")
_class("PlaySkillScreenShakePhase", PlaySkillPhaseBase)
PlaySkillScreenShakePhase = PlaySkillScreenShakePhase

function PlaySkillScreenShakePhase:PlayFlight(TT, casterEntity, phaseParam)
  local screenShakePhaseParam = phaseParam
  local cameraService = self._world:GetService("Camera")
  local cameraShakeParam = CameraShakeParams:New(screenShakePhaseParam:GetDelay(), screenShakePhaseParam:GetIntensity(), screenShakePhaseParam:GetMainVibAngle(), screenShakePhaseParam:GetDuration(), screenShakePhaseParam:GetVibrato(), screenShakePhaseParam:GetDecayRate(), screenShakePhaseParam:GetAngleRandomness(), screenShakePhaseParam:GetIntenseRandomness())
  cameraService:PlayCameraShake(cameraShakeParam)
end
