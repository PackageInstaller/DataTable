require("sp_base_inst")
_class("SkillPreviewPlayScanTrapOnPickupPosInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayScanTrapOnPickupPosInstruction = SkillPreviewPlayScanTrapOnPickupPosInstruction

function SkillPreviewPlayScanTrapOnPickupPosInstruction:GetCacheResource()
  return {}
end

function SkillPreviewPlayScanTrapOnPickupPosInstruction:DoInstruction(TT, casterEntity, previewContext)
  local previewActiveSkillService = previewContext:GetWorld():GetService("PreviewActiveSkill")
  local world = casterEntity:GetOwnerWorld()
  local scanResult = world:GetService("UtilData"):GetScanSelection()
  local trapID = scanResult.trapID
  if not trapID or not Cfg.cfg_trap[trapID] then
    return
  end
  local resPath = Cfg.cfg_trap[trapID].ResPath
  local effectEntity = world:GetService("Effect"):CreateEffectEntity()
  effectEntity:ReplaceAsset(NativeUnityPrefabAsset:New(resPath[1]))
  effectEntity:SetPosition(previewContext:GetPickUpPos())
  effectEntity:AddEffect(-1)
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  previewPickUpComponent:AddPickUpEffectEntityID(effectEntity:GetID())
end
