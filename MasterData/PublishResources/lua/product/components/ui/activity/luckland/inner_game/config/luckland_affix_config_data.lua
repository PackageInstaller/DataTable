_class("LLAffixConfigData", Object)
LLAffixConfigData = LLAffixConfigData

function LLAffixConfigData:Constructor(ID)
  self._cfg = Cfg.cfg_luckland_client_affix[ID]
  if not self._cfg then
    Log.exception("[LuckLand] affix config is nil, id=", ID)
  end
end

function LLAffixConfigData:GetData()
  return self._cfg
end

function LLAffixConfigData:GetID()
  return self._cfg.ID
end

function LLAffixConfigData:GetAffixType()
  return self._cfg.Type
end

function LLAffixConfigData:GetTypeParam()
  return self._cfg.Param
end
