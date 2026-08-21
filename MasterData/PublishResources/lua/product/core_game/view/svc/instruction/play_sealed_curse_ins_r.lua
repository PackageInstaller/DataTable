require("base_ins_r")
_class("PlaySealedCurseInstruction", BaseInstruction)
PlaySealedCurseInstruction = PlaySealedCurseInstruction

function PlaySealedCurseInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local result = routineComponent:GetEffectResultByArray(SkillEffectType.SealedCurse)
  if not result then
    return
  end
  local oldLeaderPstID = result:GetOldLeaderPstID()
  local newLeaderPstID = result:GetNewLeaderPstID()
  if oldLeaderPstID and newLeaderPstID then
    local battleRenderSvc = world:GetService("RenderBattle")
    battleRenderSvc:RenderChangeTeamLeader(newLeaderPstID, oldLeaderPstID)
    YIELD(TT, 1000)
  end
  local targetEntity = world:GetEntityByID(result:GetTargetID())
  local buffViewInst = targetEntity:BuffView():GetBuffViewInstance(result:GetBuffInsSeq())
  local playBuffService = world:GetService("PlayBuff")
  playBuffService:PlayAddBuff(TT, buffViewInst, casterEntity:GetID())
  if not newLeaderPstID then
    return
  end
  local request = BattleTeamOrderViewRequest:New(result:GetOldTeamOrder(), result:GetNewTeamOrder(), BattleTeamOrderViewType.Exchange_ChangeTeamLeader)
  local ePet = world:GetEntityByID(result:GetTargetID())
  local eTeam = ePet:Pet():GetOwnerTeamEntity()
  local tOldTeamOrder = result:GetOldTeamOrder()
  local tNewTeamOrder = result:GetNewTeamOrder()
  local playBuffSvc = world:GetService("PlayBuff")
  local ntTeamOrderChange = NTTeamOrderChange:New(eTeam, tOldTeamOrder, tNewTeamOrder)
  playBuffSvc:PlayBuffView(TT, ntTeamOrderChange)
  local renderBattleService = world:GetService("RenderBattle")
  renderBattleService:RequestUIChangeTeamOrderView(request)
  local playDamageService = world:GetService("PlayDamage")
  playDamageService:OnTeamOrderChangeRefresh()
end
