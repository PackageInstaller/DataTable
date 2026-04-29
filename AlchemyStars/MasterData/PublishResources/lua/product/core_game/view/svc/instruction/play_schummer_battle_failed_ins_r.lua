require("base_ins_r")
_class("PlaySchummerBattleFailedInstruction", BaseInstruction)
PlaySchummerBattleFailedInstruction = PlaySchummerBattleFailedInstruction

function PlaySchummerBattleFailedInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
end

function PlaySchummerBattleFailedInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local cMainCamera = world:MainCamera()
  local csTex2d = cMainCamera:GetScreenCameraScreenshot()
  if not csTex2d or tostring(csTex2d) == "null" then
    return
  end
  local effectService = world:GetService("Effect")
  local efx = effectService:CreateScreenEffPointEffect(self._effectID)
  local csGoFx = efx:View():GetGameObject()
  local csTransform = GameObjectHelper.FindChild(csGoFx.transform, "Staticframe")
  csTransform.gameObject.name = "__Staticframe"
  local csMeshRenderer = csTransform.gameObject:GetComponent("MeshRenderer")
  local csMaterial = csMeshRenderer.material
  csMaterial:SetTexture("_MainTex", csTex2d)
  csMeshRenderer.material = csMaterial
end

function PlaySchummerBattleFailedInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  table.insert(t, {
    "eff_2000571_zz.mat",
    1
  })
  return t
end
