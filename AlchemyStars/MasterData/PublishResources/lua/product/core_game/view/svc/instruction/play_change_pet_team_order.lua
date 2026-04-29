require("base_ins_r")
_class("PlayChangePetTeamOrderInstruction", BaseInstruction)
PlayChangePetTeamOrderInstruction = PlayChangePetTeamOrderInstruction

function PlayChangePetTeamOrderInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local result = routineComponent:GetEffectResultByArray(SkillEffectType.ChangePetTeamOrder)
  if not result then
    return
  end
  local eTarget = world:GetEntityByID(result:GetTargetEntityID())
  local eTeam = eTarget:Pet():GetOwnerTeamEntity()
  local tOldTeamOrder = result:GetOldTeamOrder()
  local tNewTeamOrder = result:GetNewTeamOrder()
  local request = BattleTeamOrderViewRequest:New(tOldTeamOrder, tNewTeamOrder, BattleTeamOrderViewType.FillVacancies_Skill)
  local renderBattleService = world:GetService("RenderBattle")
  renderBattleService:RequestUIChangeTeamOrderView(request)
  local seqNo = request:GetRequestSequenceNo()
  local renderSetTeamLeaderTriggered = false
  local renderBattleService = world:GetService("RenderBattle")
  while not world:RenderBattleStat():IsChangeTeamOrderRequestFinished(seqNo) do
    local currentRequest = renderBattleService:GetCurrentChangeTeamOrderViewRequest()
    local currentSeqNo = currentRequest and currentRequest:GetRequestSequenceNo() or nil
    if not renderSetTeamLeaderTriggered and (not currentSeqNo or currentSeqNo == seqNo) and tOldTeamOrder[1] ~= tNewTeamOrder[1] then
      renderSetTeamLeaderTriggered = true
      local battleRenderSvc = world:GetService("RenderBattle")
      battleRenderSvc:RenderChangeTeamLeader(tNewTeamOrder[1], tOldTeamOrder[1])
    end
    YIELD(TT)
    if world:RenderBattleStat():IsChangeTeamOrderViewDisabled() then
      break
    end
  end
  local playBuffSvc = world:GetService("PlayBuff")
  local ntTeamOrderChange = NTTeamOrderChange:New(eTeam, tOldTeamOrder, tNewTeamOrder)
  playBuffSvc:PlayBuffView(TT, ntTeamOrderChange)
  local playDamageService = world:GetService("PlayDamage")
  playDamageService:OnTeamOrderChangeRefresh()
end
