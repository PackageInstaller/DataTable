_class("PlaySwapSan2TeamHpInstruction", BaseInstruction)
PlaySwapSan2TeamHpInstruction = PlaySwapSan2TeamHpInstruction

function PlaySwapSan2TeamHpInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local rsvcFeature = world:GetService("FeatureRender")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SwapSan2TeamHp)
  if not resultArray then
    return
  end
  local playDamageService = world:GetService("PlayDamage")
  for _, result in ipairs(resultArray) do
    local curSan = result:GetCurSan()
    local oldSan = result:GetOldSan()
    local val = curSan - oldSan
    local deltaSan = result:GetDeltaSan()
    local modifyTimes = result:GetModifyTimes()
    rsvcFeature:NotifySanValueChange(curSan, oldSan, val)
    local nt = NTSanValueChange:New(curSan, oldSan, deltaSan, modifyTimes)
    world:GetService("PlayBuff"):PlayBuffView(TT, nt)
    if world:MatchType() == MatchType.MT_Maze then
      local damageInfo = DamageInfo:New(nil, DamageType.Invalid)
      damageInfo:SetMazeDamageList(result:GetMazeDamage())
      playDamageService:_RefreshTeamHP(TT, casterEntity, damageInfo)
    end
    if world:MatchType() == MatchType.MT_SeasonMaze then
      local teamDamageInfo = DamageInfo:New(nil, DamageType.Invalid)
      local teamDamageValue = 0
      local teamChangeHP = 0
      local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
      local petList = teamEntity:Team():GetTeamPetEntities()
      for i, petEntity in ipairs(petList) do
        if not petEntity:HasPetDeadMark() then
          local curPetValue = result:GetMazeDamage()[petEntity:GetID()]
          local petDamageInfo = DamageInfo:New(nil, DamageType.Invalid)
          petDamageInfo:SetDamageValue(-curPetValue)
          petDamageInfo:SetChangeHP(curPetValue)
          teamDamageInfo:AddMazeTeamMemberDamageInfo(petEntity:GetID(), petDamageInfo)
          teamDamageValue = teamDamageValue + petDamageInfo:GetDamageValue()
          teamChangeHP = teamChangeHP + petDamageInfo:GetChangeHP()
        end
      end
      teamDamageInfo:SetDamageValue(teamDamageValue)
      teamDamageInfo:SetChangeHP(teamChangeHP)
      playDamageService:_RefreshTeamHP(TT, teamEntity, teamDamageInfo)
    end
  end
end
