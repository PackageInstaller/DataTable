require("sp_base_inst")
_class("SkillPreviewPlayHudEffectInScopeInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayHudEffectInScopeInstruction = SkillPreviewPlayHudEffectInScopeInstruction

function SkillPreviewPlayHudEffectInScopeInstruction:Constructor(params)
  self._effectPrefabName = params.effectPrefabName
end

function SkillPreviewPlayHudEffectInScopeInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local renderEntitySvc = world:GetService("RenderEntity")
  local activePickUpComponent = casterEntity:ActiveSkillPickUpComponent()
  local scopeGridList = previewContext:GetScopeResult()
  local entityService = world:GetService("RenderEntity")
  local boardSvcR = world:GetService("BoardRender")
  for index, pos in ipairs(scopeGridList) do
    local gridWorldPos = boardSvcR:GridPos2RenderPos(pos)
    local effectEntity = effectService:CreateEffectEntity()
    effectEntity:ReplaceAsset(NativeUnityPrefabAsset:New(self._effectPrefabName, true))
    effectEntity:RemoveLocation()
    effectEntity:AddHUD()
    activePickUpComponent:AddPickUpEffectEntityID(effectEntity:GetID())
    local num = index
    local go = effectEntity:View().ViewWrapper.GameObject
    local uiview = go:GetComponent("UIView")
    if uiview and num then
      local numText = uiview:GetUIComponent("UILocalizationText", "LevelNumText")
      if numText then
        numText:SetText(num)
      end
    end
    local hudPos = entityService:_CalcGridHUDWorldPos(gridWorldPos)
    go.transform.position = hudPos
  end
end
