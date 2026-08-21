require("sp_base_inst")
_class("SkillPreviewPlayEffectOnPickupPosInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayEffectOnPickupPosInstruction = SkillPreviewPlayEffectOnPickupPosInstruction

function SkillPreviewPlayEffectOnPickupPosInstruction:Constructor(params)
  self._effectID = tonumber(params.effectID)
  self._skinUseEffectMap = {}
  if params.skinUseEffectID then
    local splitedStrArray = string.split(params.skinUseEffectID, "|")
    local keyFlag = 1
    local key, value
    for i, v in ipairs(splitedStrArray) do
      local num = tonumber(v)
      if keyFlag == 1 then
        key = num
      else
        value = num
        self._skinUseEffectMap[key] = value
      end
      keyFlag = keyFlag + 1
      if 2 < keyFlag then
        keyFlag = 1
      end
    end
  end
  assert(Cfg.cfg_effect[self._effectID], "预览指令PlayEffectOnPickupPos需要有效的effectID")
end

function SkillPreviewPlayEffectOnPickupPosInstruction:GetCacheResource()
  local res = {}
  local effRes = {
    Cfg.cfg_effect[self._effectID].ResPath,
    1
  }
  table.insert(res, effRes)
  for i, effectID in pairs(self._skinUseEffectMap) do
    local skinEffRes = {
      Cfg.cfg_effect[effectID].ResPath,
      1
    }
    table.insert(res, skinEffRes)
  end
  return res
end

function SkillPreviewPlayEffectOnPickupPosInstruction:DoInstruction(TT, casterEntity, previewContext)
  local previewActiveSkillService = previewContext:GetWorld():GetService("PreviewActiveSkill")
  local world = casterEntity:GetOwnerWorld()
  local useEffectID = self._effectID
  local skinId = 1
  if casterEntity:MatchPet() then
    skinId = casterEntity:MatchPet():GetMatchPet():GetSkinId()
    if skinId and self._skinUseEffectMap[skinId] then
      useEffectID = self._skinUseEffectMap[skinId]
    end
  end
  local effectEntity = world:GetService("Effect"):CreateWorldPositionEffect(useEffectID, previewContext:GetPickUpPos())
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  previewPickUpComponent:AddPickUpEffectEntityID(effectEntity:GetID())
end
