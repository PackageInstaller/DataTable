_class("SummonerComponent", Object)
SummonerComponent = SummonerComponent

function SummonerComponent:Constructor(entityID)
  self._summonerEntityID = entityID
end

function SummonerComponent:GetSummonerEntityID()
  return self._summonerEntityID
end

function Entity:Summoner()
  return self:GetComponent(self.WEComponentsEnum.Summoner)
end

function Entity:AddSummoner(entityID)
  local index = self.WEComponentsEnum.Summoner
  local component = SummonerComponent:New(entityID)
  self:AddComponent(index, component)
end

function Entity:GetSummonerEntity()
  local index = self.WEComponentsEnum.Summoner
  local cmpt = self:GetComponent(index)
  if not cmpt then
    return
  end
  local entityID = cmpt:GetSummonerEntityID()
  local entity = self._world:GetEntityByID(entityID)
  return entity
end

function Entity:HasSummoner()
  local index = self.WEComponentsEnum.Summoner
  return self:HasComponent(index)
end
