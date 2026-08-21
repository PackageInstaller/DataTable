_class("BuffLogicRecordAllEnemyWeak", BuffLogicBase)
BuffLogicRecordAllEnemyWeak = BuffLogicRecordAllEnemyWeak

function BuffLogicRecordAllEnemyWeak:Constructor(buffInstance, logicParam)
  self._weakBuffEffect = logicParam.weakBuffEffect or 0
end

function BuffLogicRecordAllEnemyWeak:DoLogic(notify)
  local allEnemyWeak = true
  local hasEnemy = false
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local enemyTeam = self._world:Player():GetCurrentEnemyTeamEntity()
    if not enemyTeam:HasDeadMark() then
      local enemyBuffCmpt = enemyTeam:BuffComponent()
      if enemyBuffCmpt then
        hasEnemy = true
        if not enemyBuffCmpt:HasBuffEffect(self._weakBuffEffect) then
          allEnemyWeak = false
        end
      end
    end
  else
    local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
    for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
      if not monsterEntity:HasDeadMark() then
        local enemyBuffCmpt = monsterEntity:BuffComponent()
        if enemyBuffCmpt then
          hasEnemy = true
          if not enemyBuffCmpt:HasBuffEffect(self._weakBuffEffect) then
            allEnemyWeak = false
            break
          end
        end
      end
    end
  end
  if not hasEnemy then
    allEnemyWeak = false
  end
  local attributeCmpt = self._entity:Attributes()
  if attributeCmpt then
    attributeCmpt:SetSimpleAttribute("AllEnemyWeak", allEnemyWeak and 1 or 0)
  end
end
