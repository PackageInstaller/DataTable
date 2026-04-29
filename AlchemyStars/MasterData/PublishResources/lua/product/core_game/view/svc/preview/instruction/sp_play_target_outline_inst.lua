require("sp_base_inst")
_class("SkillPreviewPlayTargetOutlineInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayTargetOutlineInstruction = SkillPreviewPlayTargetOutlineInstruction

function SkillPreviewPlayTargetOutlineInstruction:Constructor(params)
  self._downSample = params.DownSample
  self._blurNum = params.BlurNum
  self._intensity = params.Intensity
  self._outlineSize = params.OutlineSize
  self._blendType = params.BlendType
  self._outlinColorR = params.OutlinColorR
  self._outlinColorG = params.OutlinColorG
  self._outlinColorB = params.OutlinColorB
end

function SkillPreviewPlayTargetOutlineInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local targetIDList = previewContext:GetTargetEntityIDList()
  targetIDList = table.unique(targetIDList)
  for _, id in pairs(targetIDList) do
    local entity = world:GetEntityByID(id)
    if entity and entity:HasView() then
      local view = entity:View()
      local go = view:GetGameObject()
      local outlineCmpt = go:GetComponent(typeof(OutlineComponent))
      outlineCmpt = outlineCmpt or go:AddComponent(typeof(OutlineComponent))
      outlineCmpt.enabled = true
      outlineCmpt.outlinColor = Color(self._outlinColorR / 255, self._outlinColorG / 255, self._outlinColorB / 255)
      outlineCmpt.downSample = tonumber(self._downSample)
      outlineCmpt.blurNum = tonumber(self._blurNum)
      outlineCmpt.intensity = tonumber(self._intensity)
      outlineCmpt.outlineSize = tonumber(self._outlineSize)
      if self._blendType == "Add" then
        outlineCmpt.blendType = OutlineComponent.BlendType.Add
      elseif self._blendType == "Blend" then
        outlineCmpt.blendType = OutlineComponent.BlendType.Blend
      end
    end
  end
end
