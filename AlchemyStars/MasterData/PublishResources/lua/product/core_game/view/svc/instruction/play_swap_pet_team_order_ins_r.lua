require("base_ins_r")
_class("PlaySwapPetTeamOrderInstruction", BaseInstruction)
PlaySwapPetTeamOrderInstruction = PlaySwapPetTeamOrderInstruction

function PlaySwapPetTeamOrderInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local result = routineComponent:GetEffectResultByArray(SkillEffectType.SwapPetTeamOrder)
  if not result then
    return
  end
  local oldOrder = result:GetOldTeamOrder()
  local newOrder = result:GetNewTeamOrder()
  local oldLeaderPstID = oldOrder[1]
  local newLeaderPstID = newOrder[1]
  if oldLeaderPstID and newLeaderPstID and oldLeaderPstID ~= newLeaderPstID then
    local battleRenderSvc = world:GetService("RenderBattle")
    battleRenderSvc:RenderChangeTeamLeader(newLeaderPstID, oldLeaderPstID)
  end
  local request = BattleTeamOrderViewRequest:New(result:GetOldTeamOrder(), result:GetNewTeamOrder(), BattleTeamOrderViewType.Exchange_SwapTeamOrder)
  local renderBattleService = world:GetService("RenderBattle")
  renderBattleService:RequestUIChangeTeamOrderView(request)
  local eTarget = world:GetEntityByID(result:GetTargetEntityID())
  local eTeam = eTarget:Pet():GetOwnerTeamEntity()
  local playBuffSvc = world:GetService("PlayBuff")
  local ntTeamOrderChange = NTTeamOrderChange:New(eTeam, oldOrder, newOrder)
  playBuffSvc:PlayBuffView(TT, ntTeamOrderChange)
  local playDamageService = world:GetService("PlayDamage")
  playDamageService:OnTeamOrderChangeRefresh()
end
