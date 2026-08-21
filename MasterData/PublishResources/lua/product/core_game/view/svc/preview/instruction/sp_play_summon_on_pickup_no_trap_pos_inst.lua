require("sp_base_inst")
_class("SkillPreviewPlaySummonOnPickupNoTrapPosInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlaySummonOnPickupNoTrapPosInstruction = SkillPreviewPlaySummonOnPickupNoTrapPosInstruction

function SkillPreviewPlaySummonOnPickupNoTrapPosInstruction:Constructor(params)
  self._trapID = tonumber(params.trapID)
  self._effectID = tonumber(params.effectID)
end

function SkillPreviewPlaySummonOnPickupNoTrapPosInstruction:GetCacheResource()
  return {
    {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    }
  }
end

function SkillPreviewPlaySummonOnPickupNoTrapPosInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = casterEntity:GetOwnerWorld()
  local entitySvc = world:GetService("RenderEntity")
  local pickUpPos = previewContext:GetPickUpPos()
  local boardCmpt = world:GetBoardEntity():Board()
  local traps = boardCmpt:GetPieceEntities(pickUpPos, function(e)
    local isOwner = false
    if e:HasSummoner() then
      if e:Summoner():GetSummonerEntityID() == casterEntity:GetID() then
        isOwner = true
      end
    else
      isOwner = true
    end
    return isOwner and e:HasTrapRender() and e:TrapRender():GetTrapID() == self._trapID and not e:HasDeadMark()
  end)
  if 0 < #traps then
  else
    local effectEntity = world:GetService("Effect"):CreateWorldPositionEffect(self._effectID, pickUpPos)
    local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
    previewPickUpComponent:AddPickUpEffectEntityID(effectEntity:GetID())
  end
end
