local bs_214104 = class("bs_214104", LuaSkillBase)
local base = LuaSkillBase
bs_214104.config = {}

function bs_214104:ctor()
end

function bs_214104:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_214104_1", 10, self.OnAfterBattleStart)
  self.effectGrid = {}
end

function bs_214104:OnAfterBattleStart()
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

function bs_214104:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_214104:LuaDispose()
  base.LuaDispose(self)
  self.effectGrid = nil
end

return bs_214104
