require("sp_base_inst")
_class("SkillPreviewPlayTetrisInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayTetrisInstruction = SkillPreviewPlayTetrisInstruction

function SkillPreviewPlayTetrisInstruction:Constructor(params)
  local strList = params.tetrisEffectList
  local strIDs = string.split(strList, "|")
  self._tetrisEffectList = {}
  for i = 1, #strIDs do
    local effectID = tonumber(strIDs[i])
    table.insert(self._tetrisEffectList, effectID)
  end
  self._time = params.Time
end

function SkillPreviewPlayTetrisInstruction:GetCacheResource()
  local res = {}
  for i, effectID in pairs(self._tetrisEffectList) do
    local skinEffRes = {
      Cfg.cfg_effect[effectID].ResPath,
      1
    }
    table.insert(res, skinEffRes)
  end
  return res
end

function SkillPreviewPlayTetrisInstruction:DoInstruction(TT, casterEntity, previewContext)
  self._world = previewContext:GetWorld()
  local utilDataSvc = self._world:GetService("UtilData")
  local tetrisIndex = utilDataSvc:GetFeatureTetrisIndex()
  local tetrisDir = utilDataSvc:GetFeatureTetrisDir()
  local effectID = self._tetrisEffectList[tetrisIndex]
  local effectEntity = self._world:GetService("Effect"):CreateWorldPositionDirectionEffect(effectID, previewContext:GetPickUpPos(), tetrisDir)
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  previewPickUpComponent:AddPickUpEffectEntityID(effectEntity:GetID())
  local effectGO = effectEntity:View():GetGameObject()
  local anim = effectGO.gameObject:GetComponent("Animation")
  if self._time then
    YIELD(TT, self._time)
  end
end
