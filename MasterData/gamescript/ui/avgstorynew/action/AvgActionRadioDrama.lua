local AvgDialogType = cd.AvgDialogType
local Vector3 = CS.UnityEngine.Vector3
local Vector2 = CS.UnityEngine.Vector2
local POS_FAR = Vector3(9999, 9999, 0)
local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local AvgActionRadioDrama, Super = System.NewClass("AvgActionRadioDrama", AvgActionBase)

function AvgActionRadioDrama:ctor(...)
  Super.ctor(self, ...)
end

function AvgActionRadioDrama:DoAction(_, content, finishCb)
  if not self.avgModel:IsDialogType(AvgDialogType.RadioDrama) then
    finishCb()
    return
  end
  local dialogInfo = self.avgModel:GetDialogInfo()
  local audioEvent = dialogInfo.ShortAudioEffect and dialogInfo.ShortAudioEffect[1] or "nil"
  local duration = AudioManager.Instance:GetEventDuration(audioEvent)
  if duration > 0 then
    self.binder:BindTimer(duration, 0, nil, function()
      EventMgr.Instance.SkipDialog:Dispatch()
    end)
  end
  finishCb()
end

function AvgActionRadioDrama:IsWaiting()
end

return AvgActionRadioDrama
