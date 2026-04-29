require("base_ins_r")
_class("PlayShuffleTeamOrderInstruction", BaseInstruction)
PlayShuffleTeamOrderInstruction = PlayShuffleTeamOrderInstruction

function PlayShuffleTeamOrderInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local result = routineComponent:GetEffectResultByArray(SkillEffectType.ShufflePetTeamOrder)
  if not result then
    return
  end
  local eTeam = world:GetEntityByID(result:GetTargetEntityID())
  local tOldTeamOrder = result:GetOldTeamOrder()
  local tNewTeamOrder = result:GetNewTeamOrder()
  local request = BattleTeamOrderViewRequest:New(tOldTeamOrder, tNewTeamOrder, BattleTeamOrderViewType.ShuffleTeamOrder)
  local renderBattleService = world:GetService("RenderBattle")
  renderBattleService:RequestUIChangeTeamOrderView(request)
  local seqNo = request:GetRequestSequenceNo()
  local renderBattleService = world:GetService("RenderBattle")
  local renderSetTeamLeaderTriggered = false
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
