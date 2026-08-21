_class("LLBuffConfigData", Object)
LLBuffConfigData = LLBuffConfigData

function LLBuffConfigData:Constructor(buffID)
  self._cfg = Cfg.cfg_luckland_client_buff[buffID]
  if not self._cfg then
    Log.exception("[LuckLand] buff config is nil buff id=", buffID)
  end
end

function LLBuffConfigData:GetData()
  return self._cfg
end

function LLBuffConfigData:GetBuffID()
  return self._cfg.ID
end

function LLBuffConfigData:GetTargetType()
  return self._cfg.TargetType
end

function LLBuffConfigData:GetTargetParam()
  return self._cfg.TargetParam
end

function LLBuffConfigData:GetNotifyCfgData()
  return self._cfg.Notify
end

function LLBuffConfigData:GetTriggerCfgData()
  return self._cfg.Trigger
end

function LLBuffConfigData:GetLogicCfgData()
  return self._cfg.Logic
end

function LLBuffConfigData:GetName()
  return self._cfg.Name
end

function LLBuffConfigData:GetIcon()
  return self._cfg.Icon
end

function LLBuffConfigData:GetDesc()
  return self._cfg.Desc
end
