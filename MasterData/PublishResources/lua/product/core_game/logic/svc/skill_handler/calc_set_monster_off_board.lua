_class("SkillEffectCalc_SetMonsterOffBoard", Object)
SkillEffectCalc_SetMonsterOffBoard = SkillEffectCalc_SetMonsterOffBoard

function SkillEffectCalc_SetMonsterOffBoard:Constructor(world)
  self._world = world
end

function SkillEffectCalc_SetMonsterOffBoard:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillEffectParam = skillEffectCalcParam.skillEffectParam
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local battleCmpt = self._world:BattleStat()
  local boardEntity = self._world:GetBoardEntity()
  local boardComponent = boardEntity:Board()
  local results = {}
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  local utilData = self._world:GetService("UtilData")
  local bSetOff = skillEffectParam:GetIsSetOff()
  for _, targetID in ipairs(targets) do
    local e = self._world:GetEntityByID(targetID)
    if e then
      local offBoardMonsterCmpt = e:OffBoardMonster()
      local buffComponent = e:BuffComponent()
      if not bSetOff then
        if offBoardMonsterCmpt then
          local monsterID = offBoardMonsterCmpt:GetMonsterID()
          if monsterID then
            e:ReplaceComponent(e:GetMonsterIDComponentEnum(), monsterID)
          end
          e:RemoveOffBoardMonster()
          buffComponent:SetBuffValue("Freeze", nil)
          local result = SkillEffectResultSetMonsterOffBoard:New()
          result:SetIsSetOff(bSetOff)
          result:SetTargetEntityID(e:GetID())
          table.insert(results, result)
        end
      elseif e:HasMonsterID() then
        local monsterID = e:MonsterID()
        if not offBoardMonsterCmpt then
          e:AddOffBoardMonster(monsterID)
          offBoardMonsterCmpt = e:OffBoardMonster()
        end
        buffComponent:SetBuffValue("Freeze", 1)
        local result = SkillEffectResultSetMonsterOffBoard:New()
        result:SetIsSetOff(bSetOff)
        result:SetTargetEntityID(e:GetID())
        table.insert(results, result)
      end
    end
  end
  return results
end
