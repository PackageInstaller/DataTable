_class("LLPetConfigData", Object)
LLPetConfigData = LLPetConfigData

function LLPetConfigData:Constructor(ID)
  self._cfg = Cfg.cfg_luckland_client_card[ID]
  if not self._cfg then
    Log.fatal("LLPetConfigData not find PetID:", ID)
  end
end

function LLPetConfigData:GetPetTemplateID()
  return self._cfg.ID
end

function LLPetConfigData:GetPetLevel()
  return self._cfg.CardStar
end

function LLPetConfigData:GetPetType()
  return self._cfg.CardAttribute
end

function LLPetConfigData:GetPetCamp()
  return self._cfg.CardCamp
end

function LLPetConfigData:GetPetResType()
  return self._cfg.CardGameRes[1]
end

function LLPetConfigData:GetPetResBase()
  return self._cfg.CardGameRes[2]
end

function LLPetConfigData:GetBuffIDList()
  return self._cfg.CardBuff
end

function LLPetConfigData:GetCountDown()
  return self._cfg.CountDown
end

function LLPetConfigData:IsPetUnique()
  return self._cfg.IsUnique == 1
end

function LLPetConfigData:GetPetName()
  return self._cfg.CardName
end
