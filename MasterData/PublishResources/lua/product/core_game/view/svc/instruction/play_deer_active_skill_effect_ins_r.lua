require("base_ins_r")
_class("PlayDeerActiveSkillEffectInstruction", BaseInstruction)
PlayDeerActiveSkillEffectInstruction = PlayDeerActiveSkillEffectInstruction

function PlayDeerActiveSkillEffectInstruction:Constructor(paramList)
  self._effectID = 2927
end

function PlayDeerActiveSkillEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local targetGridPos = phaseContext:GetCurGridPos()
  local renderPickUpComponent = casterEntity:RenderPickUpComponent()
  if renderPickUpComponent then
    local pickUpGridArray = renderPickUpComponent:GetAllValidPickUpGridPos()
    targetGridPos = pickUpGridArray[1]
  end
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local effectEntity = effectService:CreatePositionEffect(self._effectID, Vector3.New(0, 0, 1))
  local csgo = effectEntity:View():GetGameObject()
  local grass = GameObjectHelper.FindChild(csgo.transform, "caodi")
  if not grass or tostring(grass) == "null" then
    return
  end
  local csRenderer = grass.gameObject:GetComponent(typeof(UnityEngine.MeshRenderer))
  if not csRenderer then
    return
  end
  local boardServiceRender = world:GetService("BoardRender")
  local worldPos = boardServiceRender:GridPos2RenderPos(targetGridPos)
  local v4 = Vector4.zero
  v4.x = worldPos.x
  v4.y = worldPos.y
  v4.z = worldPos.z
  csRenderer.sharedMaterial:SetVector("_Location_xyz", v4)
end

function PlayDeerActiveSkillEffectInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
