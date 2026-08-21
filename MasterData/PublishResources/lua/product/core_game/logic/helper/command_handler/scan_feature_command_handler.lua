require("command_base_handler")
require("match_message")
require("scan_feature_command")
_class("ScanFeatureCommandHandler", CommandBaseHandler)
ScanFeatureCommandHandler = ScanFeatureCommandHandler

function ScanFeatureCommandHandler:DoHandleCommand(cmd)
  local scanSkillType = cmd:GetActiveSkillType()
  local trapID = cmd:GetScanTrapID()
  local globalLogicFeatureEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.LogicFeature)
  local e = globalLogicFeatureEntities[1]
  if not e then
    Log.exception("ScanFeatureCommandHandler: no LogicFeatureComponent found. ")
    return
  end
  if not self._world:GetService("FeatureLogic"):HasFeatureType(FeatureType.Scan) then
    Log.exception("ScanFeatureCommandHandler: no FeatureType.Scan in current match. ")
    return
  end
  local cLogicFeature = e:LogicFeature()
  cLogicFeature:SetScanResult(scanSkillType, trapID)
  local activeSkillID = cLogicFeature:GetScanSummonTrapSkillID()
  local skillConfigData
  local globalMatchPetGroup = self._world:GetGroupEntities(self._world.BW_WEMatchers.MatchPet)
  for _, petEntity in ipairs(globalMatchPetGroup) do
    local matchPet = petEntity:MatchPet():GetMatchPet()
    local featureList = matchPet:GetFeatureList() or {
      feature = {}
    }
    if featureList.feature[FeatureType.Scan] then
      if scanSkillType == ScanFeatureActiveSkillType.SummonTrap then
        activeSkillID = cLogicFeature:GetScanSummonTrapSkillID()
        skillConfigData = self._world:GetService("Config"):GetSkillConfigData(activeSkillID)
      elseif scanSkillType == ScanFeatureActiveSkillType.ForceMovement then
        activeSkillID = cLogicFeature:GetScanForceMovementSkillID()
        skillConfigData = self._world:GetService("Config"):GetSkillConfigData(activeSkillID)
      elseif scanSkillType == ScanFeatureActiveSkillType.SummonScanTrap then
        activeSkillID = cLogicFeature:GetScanSummonScanTrapSkillID()
        local cfgTrapScan = Cfg.cfg_trap_scan[trapID]
        if not cfgTrapScan then
          Log.exception("ScanFeatureCommandHandler: invalid trapID: ", tostring(trapID))
          return
        end
        local templateSkillConfigData = self._world:GetService("Config"):GetSkillConfigData(activeSkillID, petEntity, true)
        local tmpSkillConfig = {
          PickUpScopeType = cfgTrapScan.PickUpScopeType,
          PickUpInvalidScopeList = cfgTrapScan.PickUpInvalidScopeList,
          PreviewList = cfgTrapScan.PreviewList or templateSkillConfigData.PreviewList
        }
        local cfgDecoSvc = self._world:GetService("ConfigDecoration")
        skillConfigData = cfgDecoSvc:GenerateSkillConfigData(activeSkillID, {
          _skillDesc = cfgTrapScan.Desc,
          _triggerParam = cfgTrapScan.Energy
        })
        skillConfigData:ParsePreview(tmpSkillConfig)
      else
        Log.exception("ScanFeatureCommandHandler: invalid active skill type: ", tostring(scanSkillType))
        return
      end
      petEntity:SkillInfo():SetActiveSkillID(skillConfigData:GetID())
      cLogicFeature:SetActiveSkillConfigData(skillConfigData)
      local matchPet = petEntity:MatchPet():GetMatchPet()
      local featureList = matchPet:GetFeatureList() or {
        feature = {}
      }
      if featureList.feature[FeatureType.Scan] then
        petEntity:SkillInfo():SetActiveSkillID(skillConfigData:GetID())
      end
      local requiredEnergy = skillConfigData:GetSkillTriggerParam()
      local currentEnergy = petEntity:Attributes():GetAttribute("LegendPower")
      local isReady = requiredEnergy <= currentEnergy and 1 or 0
      local blsvc = self._world:GetService("BuffLogic")
      blsvc:ChangePetActiveSkillReady(petEntity, isReady)
      local oldActiveSkillConfig = cLogicFeature:GetActiveSkillConfigData()
      oldActiveSkillConfig = oldActiveSkillConfig or self._world:GetService("Config"):GetSkillConfigData(petEntity:SkillInfo():GetActiveSkillID())
      local previouslyReady = requiredEnergy <= oldActiveSkillConfig:GetSkillTriggerParam()
      if self._world:RunAtClient() then
        local pstID = petEntity:PetPstID():GetPstID()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.ScanFeatureReplaceUIActiveSkillID, pstID, skillConfigData:GetID(), isReady, previouslyReady)
      end
      break
    end
  end
end
