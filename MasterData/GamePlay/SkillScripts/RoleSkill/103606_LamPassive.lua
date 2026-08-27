local bs_103601 = require("GamePlay.SkillScripts.RoleSkill.103601_LamPassive")
local bs_103606 = class("bs_103606", bs_103601)
local base = bs_103601
bs_103606.config = {
  weaponLv = 3,
  buffId_jisu = 103602,
  buffId_ranjie = 107101
}
bs_103606.config = setmetatable(bs_103606.config, {
  __index = base.config
})

function bs_103606:ctor()
end

function bs_103606:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("103606_1", 1, self.OnAfterAddBuff, nil, nil, eBattleRoleBelong.player, nil, self.config.buffId_ranjie)
  self.buff_num = 0
  self.timerList = {}
end

function bs_103606:OnAfterAddBuff(buff, target)
  self.buff_num = self.buff_num + 1
  if self.buff_num >= self.arglist[4] then
    self.buff_num = 0
    local BuffNum = self.caster:GetBuffTier(self.config.buffId_jisu)
    if BuffNum < 5 then
      self:StartBuffTimer()
    else
      self:StopAndStartBuffTimer()
    end
  end
end

function bs_103606:StartBuffTimer()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_jisu, 1)
  local timer = LuaSkillCtrl:StartTimer(nil, self.arglist[6], function()
    self:CheckAndDispelBuff()
  end, self)
  table.insert(self.timerList, timer)
end

function bs_103606:StopAndStartBuffTimer()
  self.timerList[1]:Stop()
  table.remove(self.timerList, 1)
  self:StartBuffTimer()
end

function bs_103606:CheckAndDispelBuff()
  if self.caster ~= nil and not self.caster.isDead and self.caster:GetBuffTier(self.config.buffId_jisu) > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_jisu, 1)
    table.remove(self.timerList, 1)
  end
end

function bs_103606:LuaDispose()
  if self.timerList ~= nil then
    self.timerList = nil
  end
  base.LuaDispose(self)
end

function bs_103606:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103606
