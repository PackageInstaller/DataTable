require("sp_base_inst")
_class("SkillPreviewPlayCreateGhostOrSummonOnPickupPosInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayCreateGhostOrSummonOnPickupPosInstruction = SkillPreviewPlayCreateGhostOrSummonOnPickupPosInstruction

function SkillPreviewPlayCreateGhostOrSummonOnPickupPosInstruction:Constructor(params)
  self._trapID = tonumber(params.trapID)
  self._effectID = tonumber(params.effectID)
  self._prefab = params.Prefab
  self._anim = params.Anim or "AtkUltPreview"
  self._scopeParam = {
    TargetType = tonumber(params.scopeTargetType),
    ScopeType = tonumber(params.scopeType),
    ScopeParam = {
      tonumber(params.scopeParam)
    },
    ScopeCenterType = tonumber(params.scopeCenterType)
  }
end

function SkillPreviewPlayCreateGhostOrSummonOnPickupPosInstruction:GetCacheResource()
  return {
    {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    }
  }
end

function SkillPreviewPlayCreateGhostOrSummonOnPickupPosInstruction:DoInstruction(TT, casterEntity, previewContext)
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
  if 0 < #traps then
    entitySvc:CreateGhost(pickUpPos, casterEntity, self._anim, self._prefab)
    local configSvc = world:GetService("Config")
    local helper = configSvc._skillConfigHelper
    local parser = helper._scopeParamParser
    local scopeParam = SkillPreviewScopeParam:New(self._scopeParam)
    local param = parser:ParseScopeParam(self._scopeParam.ScopeType, self._scopeParam.ScopeParam)
    scopeParam:SetScopeParamData(param)
    local previewActiveSkillService = world:GetService("PreviewActiveSkill")
    local scopeResult = previewActiveSkillService:CalcScopeResult(scopeParam, casterEntity)
    previewContext:SetScopeResult(scopeResult:GetAttackRange())
    local utilScopeSvc = world:GetService("UtilScopeCalc")
    local targetIDList = utilScopeSvc:SelectSkillTarget(casterEntity, self._scopeParam.TargetType, scopeResult)
    previewContext:SetTargetEntityIDList(targetIDList)
  else
    local effectEntity = world:GetService("Effect"):CreateWorldPositionEffect(self._effectID, pickUpPos)
    local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
    previewPickUpComponent:AddPickUpEffectEntityID(effectEntity:GetID())
    previewContext:SetScopeResult(nil)
    local targetList = {}
    previewContext:SetTargetEntityIDList(targetList)
  end
end
