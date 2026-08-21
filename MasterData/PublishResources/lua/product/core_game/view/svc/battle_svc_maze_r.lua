require("battle_svc_r")
_class("RenderBattleService_Maze", RenderBattleService)
RenderBattleService_Maze = RenderBattleService_Maze

function RenderBattleService_Maze:HideUIPetInfo(TT)
end

function RenderBattleService_Maze:ShowUIPetInfo(TT)
end

function RenderBattleService_Maze:SetAllTeamMemberVisible(teamEntity)
  local teamLeaderEntity = teamEntity:GetTeamLeaderPetEntity()
  local petEntities = teamEntity:Team():GetTeamPetEntities()
  for id, entity in ipairs(petEntities) do
    if entity:GetID() ~= teamLeaderEntity:GetID() then
      entity:SetViewVisible(false)
    end
  end
end

function RenderBattleService_Maze:ChangeTeamLeaderRender(TT, teamEntity)
  local teamLeaderEntity = teamEntity:GetTeamLeaderPetEntity()
  if teamEntity:HasPetDeadFlag() then
    self._world:GetService("PlayBuff"):PlayBuffView(TT, NTBeforeMazeTeamLeaderSucceed:New(teamLeaderEntity))
    local renderEntityService = self._world:GetService("RenderEntity")
    renderEntityService:SetTeamLeaderRender(teamLeaderEntity, true)
    teamLeaderEntity:SetViewVisible(true)
    self:SetAllTeamMemberVisible(teamEntity)
    teamEntity:RemovePetDeadFlag()
  end
end
