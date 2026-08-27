local bs_20301 = class("bs_20301", LuaSkillBase)
local base = LuaSkillBase
bs_20301.config = {}

function bs_20301:ctor()
end

function bs_20301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if self.caster.roleDataId ~= 20141 then
    return
  end
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20301_1", 10, self.OnAfterBattleStart)
  self.effectGrid = {}
end

function bs_20301:OnAfterBattleStart()
  local pos = LuaSkillCtrl:GetTargetWithGrid(2, 2)
  local GridList = LuaSkillCtrl:FindAllGridsWithUnityRange(pos, 10)
  if GridList ~= nil and GridList ~= nil then
    for k, v in pairs(GridList) do
      if self.effectGrid[v] == nil then
        local EfcGrid = LuaSkillCtrl:CallCreateEfcGrid(v.coord.x, v.coord.y, 1137)
        if EfcGrid ~= nil then
          EfcGrid:BindNeutralBattleSkill(self.cskill)
        end
        self.effectGrid[v] = true
      end
    end
  end
end

function bs_20301:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_20301:LuaDispose()
  base.LuaDispose(self)
  self.effectGrid = nil
end

return bs_20301
