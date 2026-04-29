_class("FeatureServiceHelper", Object)
FeatureServiceHelper = FeatureServiceHelper

local function getLogicService()
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  local lsvcFeature = mainWorld:GetService("FeatureLogic")
  return lsvcFeature
end

local function getWorld()
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  return mainWorld
end

function FeatureServiceHelper.GetLogicSanValue()
  local lsvcFeature = getLogicService()
  return lsvcFeature:GetSanValue()
end

function FeatureServiceHelper.IsActiveSkillCanCast(casterEntity, skillID, context)
  local lsvcFeature = getLogicService()
  return lsvcFeature:IsActiveSkillCanCast(casterEntity, skillID, context)
end

function FeatureServiceHelper.IsActiveSkillCanCastByPstID(pstID, skillID, context)
  local lsvcFeature = getLogicService()
  local eLocalTeam = lsvcFeature._world:Player():GetLocalTeamEntity()
  local cTeam = eLocalTeam:Team()
  local casterEntity = cTeam:GetPetEntityByPetPstID(pstID)
  return lsvcFeature:IsActiveSkillCanCast(casterEntity, skillID, context)
end

function FeatureServiceHelper.GetFeatureData(featureType)
  local lsvcFeature = getLogicService()
  return lsvcFeature:GetFeatureData(featureType)
end

function FeatureServiceHelper.HasFeatureType(featureType)
  return getLogicService():HasFeatureType(featureType)
end

function FeatureServiceHelper.GetFeatureSkillHolderEntity(featureType)
  local lsvcFeature = getLogicService()
  if lsvcFeature then
    return lsvcFeature:GetFeatureSkillHolderEntity(featureType)
  end
  return nil
end

function FeatureServiceHelper.GetCards()
  local lsvcFeature = getLogicService()
  return lsvcFeature:GetCards()
end

function FeatureServiceHelper.CaclCardCompositionType(cardList)
  local lsvcFeature = getLogicService()
  return lsvcFeature:CaclCardCompositionType(cardList)
end

function FeatureServiceHelper.GetCurCardCount()
  local lsvcFeature = getLogicService()
  return lsvcFeature:GetCurCardCount()
end

function FeatureServiceHelper.CheckFeatureSkillCastCondition(featureType, skillID)
  local lsvcFeature = getLogicService()
  return lsvcFeature:CheckFeatureSkillCastCondition(featureType, skillID)
end

function FeatureServiceHelper.FeatureScanGetScanTrapIDList()
  local lsvcFeature = getLogicService()
  local featureData = lsvcFeature:GetFeatureData(FeatureType.Scan)
  if not featureData then
    return {}
  end
  local utilData = getWorld():GetService("UtilData")
  if featureData:IsDiedTrapIncluded() then
    return utilData:ScanTrapInMatch()
  else
    return utilData:ScanTrapOnBoard()
  end
end

function FeatureServiceHelper.FeatureScanGetCurrentSelection()
  local utilData = getWorld():GetService("UtilData")
  return utilData:GetScanSelection()
end

function FeatureServiceHelper.FeatureScanIsPetHasFeatureScan(pstID)
  local world = getWorld()
  local utilData = world:GetService("UtilData")
  local eid = utilData:GetEntityIDByPstID(pstID)
  if eid <= 0 then
    return false
  end
  local e = world:GetEntityByID(eid)
  if not e or not e:HasMatchPet() then
    return false
  end
  local matchPet = e:MatchPet():GetMatchPet()
  local featureList = matchPet:GetFeatureList() or {
    feature = {}
  }
  return featureList.feature[FeatureType.Scan] ~= nil
end

function FeatureServiceHelper.GetBanPetSkillCastRoundList()
  local lsvcFeature = getLogicService()
  local logicFeatureCmpt = lsvcFeature:GetLogicCmpt()
  local roundList = logicFeatureCmpt:GetBanPetSkillCastRoundList()
  return roundList
end

function FeatureServiceHelper.GetShopSelectedCellList()
  local lsvcFeature = getLogicService()
  return lsvcFeature:GetShopSelectedCellList()
end

function FeatureServiceHelper.GetShopCoinCount()
  local lsvcFeature = getLogicService()
  return lsvcFeature:GetShopCoinCount()
end

function FeatureServiceHelper.GetShopUIHadSeeUnlockCellList()
  local lsvcFeature = getLogicService()
  return lsvcFeature:GetShopUIHadSeeUnlockCellList()
end

function FeatureServiceHelper.SetShopUIHadSeeUnlockCellList(unlockCellList)
  local lsvcFeature = getLogicService()
  return lsvcFeature:SetShopUIHadSeeUnlockCellList(unlockCellList)
end

function FeatureServiceHelper.GetCurStepPoint()
  local lsvcFeature = getLogicService()
  return lsvcFeature:GetCurStepPoint()
end

function FeatureServiceHelper.GetFeatureSkillCurPower(featureType)
  local lsvcFeature = getLogicService()
  return lsvcFeature:GetFeatureSkillCurPower(featureType)
end

function FeatureServiceHelper.GetFeatureAUActiveRelics()
  local lsvcFeature = getLogicService()
  return lsvcFeature:GetFeatureAUActiveRelics()
end

function FeatureServiceHelper.GetFeatureAUOverloadEnergyInfo()
  local lsvcFeature = getLogicService()
  return lsvcFeature:GetFeatureAUOverloadEnergyInfo()
end

function FeatureServiceHelper.GetFeatureTetrisInfo()
  local lsvcFeature = getLogicService()
  local tetrisPower = lsvcFeature:GetTetrisPower()
  local tetrisMainColorCount = lsvcFeature:GetTetrisMainColorCount()
  local tetrisIndex = lsvcFeature:GetTetrisIndex()
  local tetrisLock = lsvcFeature:GetTetrisLock()
  local tetrisCostPower = lsvcFeature:GetTetrisCostPower()
  return tetrisIndex, tetrisLock, tetrisPower, tetrisMainColorCount, tetrisCostPower
end
