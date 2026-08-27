local bs_215105 = class("bs_215105", LuaSkillBase)
local base = LuaSkillBase
bs_215105.config = {}

function bs_215105:ctor()
end

function bs_215105:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultStartTriggerForTable("bs_215105_1", 1, self.OnHurtResultStart, {
    target = self.caster
  })
  self:AddBeforeAddBuffTriggerForTable("bs_25105_2", 1, self.OnBeforeAddBuff, {
    target = self.caster
  })
  self.maker = self.caster.summoner.summonerMaker
  self.makerGiantHitCheck = self.maker.recordTable.giantHitCheck
  self.makerGiantBuffCheck = self.maker.recordTable.giantBuffCheck
end

function bs_215105:OnHurtResultStart(skill, context)
  if self.makerGiantHitCheck[skill] == true then
    context.active = false
    return
  end
  context.target = self.maker
end

function bs_215105:OnBeforeAddBuff(target, context)
  local buff = context.buff
  if self.makerGiantBuffCheck[buff.dataId] ~= nil and self.makerGiantBuffCheck[buff.dataId] ~= self.caster then
    context.active = false
    return
  end
  local duration
  if buff.durationTime ~= 0 then
    duration = buff.durationTime
  end
  LuaSkillCtrl:CallBuffWithOriginSkill(buff.battleSkill, self.maker, buff.dataId, buff.tier, duration, true, buff.maker)
  self.makerGiantBuffCheck[buff.dataId] = self.caster
end

function bs_215105:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_215105:LuaDispose()
  base.LuaDispose(self)
  self.maker = nil
  self.makerGiantHitCheck = nil
  self.makerGiantBuffCheck = nil
end

return bs_215105
