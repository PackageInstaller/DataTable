local bs_100702 = require("GamePlay.SkillScripts.RoleSkill.100702_ChelseaSkill")
local bs_100705 = class("bs_100705", bs_100702)
local base = bs_100702
bs_100705.config = {
  weaponLv = 2,
  buffId_Dj = 100701,
  HurtConfigId = 2,
  buffId_BingDong = 1178,
  buffId_cs = 100702,
  configId = 2
}
bs_100705.config = setmetatable(bs_100705.config, {
  __index = base.config
})

function bs_100705:ctor()
end

function bs_100705:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_100705_1", 1, self.OnBeforeAddBuff, nil, nil, nil, not self.caster.belongNum, nil, nil, eBuffFeatureType.BeatBack)
  self:AddAfterAddBuffTrigger("bs_100705_2", 2, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId_BingDong)
  self:AddLuaTrigger(eSkillLuaTrigger.OnChelseaStun, self.OnChelseaStun)
  self.targetlist = {}
  self.extar_time = self.caster.recordTable["100706_time"]
end

function bs_100705:OnBeforeAddBuff(target, context)
  if target.belongNum ~= self.caster.belongNum and target:GetBuffTier(self.config.buffId_Dj) > 0 then
    context.active = false
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
      self.arglist[4]
    }, true)
    skillResult:EndResult()
  end
end

function bs_100705:OnAfterAddBuff(buff, target)
  if target:GetBuffTier(self.config.buffId_cs) > 0 then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_Dj, 1, nil)
    if self.targetlist[target] ~= nil then
      self.targetlist[target].left = self.arglist[6]
    else
      self.targetlist[target] = LuaSkillCtrl:StartTimer(nil, self.arglist[6], function()
        if target:GetBuffTier(self.config.buffId_Dj) > 0 then
          LuaSkillCtrl:DispelBuff(target, self.config.buffId_Dj)
          self.targetlist[target] = nil
        end
      end)
    end
  end
end

function bs_100705:OnChelseaStun(target)
  if target ~= nil and target.hp > 0 then
    local time = self.targetlist[target].left + self.extar_time
    self.targetlist[target].left = time
  end
end

function bs_100705:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_100705:LuaDispose()
  base.LuaDispose(self)
  self.targetlist = nil
end

return bs_100705
