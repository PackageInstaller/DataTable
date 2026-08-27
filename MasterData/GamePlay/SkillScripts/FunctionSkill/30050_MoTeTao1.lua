local bs_30050 = class("bs_30050", LuaSkillBase)
local base = LuaSkillBase
bs_30050.config = {
  checkBuffId = 1228,
  buffId = 1229,
  buffTier = 1,
  buffDuration = 180
}

function bs_30050:ctor()
end

function bs_30050:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_30050_3", 1, self.OnAfterBattleStart)
  self:AddAfterAddBuffTrigger("bs_30050_7", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.checkBuffId)
  self:AddBeforeBuffDispelTrigger("bs_30050_2", 2, self.BeforeBuffDispel, nil, nil, self.config.checkBuffId)
  self:AddBuffDieTrigger("bs_30050_1", 1, self.OnBuffDie, nil, nil, self.config.checkBuffId)
end

function bs_30050:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  if self.timer == nil then
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], arriveCallBack, self, -1)
  end
end

function bs_30050:OnArriveAction(target)
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 64, 10)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    if targetRole == nil then
      break
    end
    local buffTier = targetRole:GetBuffTier(self.config.checkBuffId)
    if buffTier == 0 then
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.checkBuffId, self.config.buffTier, self.config.buffDuration)
      break
    end
  end
end

function bs_30050:OnAfterAddBuff(buff, target)
  LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.config.buffTier, nil, true)
end

function bs_30050:BeforeBuffDispel(targetRole, context)
  LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId, 0)
end

function bs_30050:OnBuffDie(buff, target, removeType)
  LuaSkillCtrl:DispelBuff(target, self.config.buffId, 0)
end

function bs_30050:LuaDispose()
  base.LuaDispose(self)
  self.timer = nil
end

function bs_30050:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_30050
