_class("DropService", BaseService)
DropService = DropService

function DropService:Constructor(world)
end

function DropService:DoActorDrop(dropID, hostEntityID, isHide)
  local configService = self._configService
  local dropConfigData = configService:GetMonsterDropConfigData()
  local dropItemID = dropConfigData:GetMonsterDropItemID(dropID)
  local dropCount = self:_CalcRandomDropCount(dropID)
  local dropItemConfig = configService:GetMonsterDropItemConfigData(dropItemID)
  local hostEntity = self._world:GetEntityByID(hostEntityID)
  if dropItemConfig:GetPickupType(dropItemID) == DropPickUpType.Auto and dropItemConfig:GetDropEffectType(dropItemID) == DropEffectType.InBag then
    local assetID = tonumber(dropItemConfig:GetDropEffectParam(dropItemID)[1])
    local battleStatCmpt = self._world:BattleStat()
    if battleStatCmpt:AssignWaveResult() then
      self:_GetBattleStatComponent():AddDropRoleAssetNoDouble(assetID, dropCount)
    else
      self:_GetBattleStatComponent():AddDropRoleAsset(assetID, dropCount)
    end
    local retAssest = RoleAsset:New()
    retAssest.assetid = assetID
    retAssest.count = dropCount
    return retAssest
  else
  end
end

function DropService:_CalcRandomDropCount(dropID)
  local configService = self._configService
  local dropConfigData = configService:GetMonsterDropConfigData()
  local dropMinCount = dropConfigData:GetMonsterDropMinCount(dropID)
  local dropMaxCount = dropConfigData:GetMonsterDropMaxCount(dropID)
  local dropProb = dropConfigData:GetMonsterDropProbability(dropID)
  local randomNum = self:_GetRandomNumber()
  if dropProb < randomNum then
    return 0
  end
  local dropCount = self:_GetRandomNumber(dropMinCount, dropMaxCount)
  return dropCount
end
