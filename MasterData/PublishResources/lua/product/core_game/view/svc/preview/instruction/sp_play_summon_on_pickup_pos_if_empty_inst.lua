require("sp_base_inst")
_class("SkillPreviewPlaySummonOnPickupPosIfEmptyInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlaySummonOnPickupPosIfEmptyInstruction = SkillPreviewPlaySummonOnPickupPosIfEmptyInstruction

function SkillPreviewPlaySummonOnPickupPosIfEmptyInstruction:Constructor(params)
  self._trapID = tonumber(params.trapID)
  self._effectID = tonumber(params.effectID)
end

function SkillPreviewPlaySummonOnPickupPosIfEmptyInstruction:GetCacheResource()
  return {
    {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    }
  }
end

function SkillPreviewPlaySummonOnPickupPosIfEmptyInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = casterEntity:GetOwnerWorld()
  local entitySvc = world:GetService("RenderEntity")
  local pickUpPos = previewContext:GetPickUpPos()
  local boardCmpt = world:GetBoardEntity():Board()
  local traps = boardCmpt:GetPieceEntities(pickUpPos, function(e)
    local isOwner = false
    if e:HasSummoner() then
      if e:Summoner():GetSummonerEntityID() == casterEntity:GetID() then
        isOwner = true
      else
        local summonerID = e:Summoner():GetSummonerEntityID()
        if casterEntity:HasPet() then
          local cTeam = casterEntity:Pet():GetOwnerTeamEntity():Team()
          local entities = cTeam:GetTeamPetEntities()
          for _, petEntity in ipairs(entities) do
            if summonerID == petEntity:GetID() then
              isOwner = true
              break
            end
          end
        end
      end
    else
      isOwner = true
    end
    return isOwner and e:HasTrapRender() and e:TrapRender():GetTrapID() == self._trapID and not e:HasDeadMark()
  end)
  if #traps == 0 then
    local effectEntity = world:GetService("Effect"):CreateWorldPositionEffect(self._effectID, pickUpPos)
    local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
    previewPickUpComponent:AddPickUpEffectEntityID(effectEntity:GetID())
    previewContext:SetScopeResult(nil)
    local targetList = {}
    previewContext:SetTargetEntityIDList(targetList)
  end
end
