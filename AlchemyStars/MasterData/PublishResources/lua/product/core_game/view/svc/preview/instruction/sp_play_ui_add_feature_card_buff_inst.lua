require("sp_base_inst")
_class("SkillPreviewPlayUIAddFeatureCardBuffInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayUIAddFeatureCardBuffInstruction = SkillPreviewPlayUIAddFeatureCardBuffInstruction

function SkillPreviewPlayUIAddFeatureCardBuffInstruction:Constructor(params)
  self._toTeamLeader = params.toTeamLeader
  self._toTeamTail = params.toTeamTail
  self._cardBuffType = tonumber(params.cardBuffType)
end

function SkillPreviewPlayUIAddFeatureCardBuffInstruction:DoInstruction(TT, casterEntity, previewContext)
  self._world = previewContext:GetWorld()
  local world = self._world
  local teamEntity = world:Player():GetCurrentTeamEntity()
  local playerPstid = 0
  if self._toTeamLeader then
    playerPstid = teamEntity:Team():GetTeamLeaderPetPstID()
  elseif self._toTeamTail then
    local cTeam = teamEntity:Team()
    local teamOrder = cTeam:GetTeamOrder()
    local finalIndex = #teamOrder
    playerPstid = teamOrder[finalIndex]
  end
  world:EventDispatcher():Dispatch(GameEventType.FeaturePetUIPreviewAddCardBuff, playerPstid, self._cardBuffType)
end
