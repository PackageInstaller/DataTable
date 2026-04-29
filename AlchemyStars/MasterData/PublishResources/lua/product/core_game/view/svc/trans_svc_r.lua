_class("TransformServiceRenderer", Object)
TransformServiceRenderer = TransformServiceRenderer

function TransformServiceRenderer:Constructor(world)
  self._world = world
  self._animName = {
    [PieceType.Blue] = "eff_BoundingBox_Blue_loop",
    [PieceType.Green] = "eff_BoundingBox_Green_loop",
    [PieceType.Red] = "eff_BoundingBox_Red_loop",
    [PieceType.Yellow] = "eff_BoundingBox_Yellow_loop",
    [PieceType.None] = "eff_BoundingBox_White_loop",
    [PieceType.AnyNone] = "eff_BoundingBox_White_loop"
  }
  self._releaseAnimName = {
    [PieceType.Blue] = "eff_BoundingBox_chain_Blue",
    [PieceType.Green] = "eff_BoundingBox_chain_Green",
    [PieceType.Red] = "eff_BoundingBox_chain_Red",
    [PieceType.Yellow] = "eff_BoundingBox_chain_Yellow",
    [PieceType.None] = "eff_BoundingBox_chain_White",
    [PieceType.AnyNone] = "eff_BoundingBox_chain_White"
  }
end

function TransformServiceRenderer:SimpleSyncLocation(e)
  local pos = e:Location().Position:Clone()
  local dir = e:Location().Direction:Clone()
  local scale = e:Location().Scale:Clone()
  self:SetEntityLocation(e, pos, dir, scale)
  if e:HasPetPstID() then
    local teamEntity = e:Pet():GetOwnerTeamEntity()
    local teamLeaderEntityId = teamEntity:Team():GetTeamLeaderEntityID()
    if e:GetID() == teamLeaderEntityId and teamEntity:Location():IsSyncToHPBar() then
      local hpCmpt = teamEntity:HP()
      hpCmpt:SetHPPosDirty(true)
    end
  elseif e:HasHP() and e:Location():IsSyncToHPBar() then
    local hpCmpt = e:HP()
    hpCmpt:SetHPPosDirty(true)
  end
end

function TransformServiceRenderer:SetEntityLocation(e, pos, dir, scale)
  local view = e:View()
  if scale == nil then
    scale = Vector3(1, 1, 1)
  end
  if view then
    view.ViewWrapper:SyncTransform(pos, dir, scale, e:GetID(), e:HasOutsideRegion())
  end
end

function TransformServiceRenderer:PlaySkillRangeAnim(e)
  local skillRangeOutlineComponent = e:SkillRangeOutline()
  local pieceType = skillRangeOutlineComponent:GetPieceType()
  local isPreview = skillRangeOutlineComponent:IsPreview()
  if pieceType ~= nil then
    local view = e:View()
    local go = view:GetGameObject()
    local anim = go:GetComponent(typeof(UnityEngine.Animation))
    anim:Stop()
    if isPreview then
      anim:Play(self._animName[pieceType])
    else
      anim:Play(self._releaseAnimName[pieceType])
    end
  end
end
