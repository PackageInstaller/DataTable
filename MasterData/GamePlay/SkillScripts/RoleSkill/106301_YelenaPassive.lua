local bs_106301 = class("bs_106301", LuaSkillBase)
local base = LuaSkillBase
bs_106301.config = {
  buffId_red = 106301,
  buffId_blue = 106302,
  buffId_yellow = 106303,
  buffId_att = 106304,
  buffId_def = 106305,
  effectId_trail = 106303,
  effectId_get_1 = 106307,
  effectId_get_2 = 106308,
  effectId_get_3 = 106309,
  HurtConfigID = 17
}
bs_106301.colorInfo = {
  [1] = {
    colorName = "red_num",
    buffId = 106301,
    effectId = 106307
  },
  [2] = {
    colorName = "blue_num",
    buffId = 106302,
    effectId = 106308
  },
  [3] = {
    colorName = "yellow_num",
    buffId = 106303,
    effectId = 106309
  }
}

function bs_106301:ctor()
end

function bs_106301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.RedAtkDam = self.arglist[8]
  self.caster.recordTable.YellowAtkDam = self.arglist[10]
  self:AddBeforePlaySkillTrigger("bs_106301_1", 1, self.OnBeforePlaySkill, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self:AddAfterPlaySkillTrigger("bs_106301_2", 1, self.OnAfterPlaySkill, nil, nil, self.caster.belongNum, nil, eBattleRoleType.character)
  self:AddAfterHurtTrigger("bs_106301_3", 1, self.OnAfterHurt, nil, nil, self.caster.belongNum, nil, nil, nil, nil, eSkillTag.commonAttack)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_106301_4", 1, self.OnAfterBattleStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnPlayYelenaSkill, self.OnPlayYelenaSkill, self)
  self.caster.recordTable.beforeAttackColor = 0
  self.caster.recordTable.colorTable = {}
  self:ResetColorTable()
end

function bs_106301:OnBeforePlaySkill(role, context)
  if role == self.caster and context.skill.isCommonAttack then
    local random = LuaSkillCtrl:CallRange(1, 10000)
    local index = 1
    local colorTable = self.caster.recordTable.colorTable
    if random <= colorTable[1].per then
      index = 1
    elseif random - colorTable[1].per < colorTable[2].per then
      index = 2
    else
      index = 3
    end
    local colorId = colorTable[index].colorId
    local colorInfo = self.colorInfo[colorId]
    self.caster.recordTable.beforeAttackColor = colorId
  end
end

function bs_106301:OnAfterPlaySkill(skill, role)
  if skill.maker.belongNum ~= self.caster.belongNum or skill.maker.roleType ~= eBattleRoleType.character then
    return
  end
  if skill.isNormalSkill then
    local random = LuaSkillCtrl:CallRange(1, 10000)
    if random <= self.arglist[2] then
      self:AddColor(2)
    end
  end
end

function bs_106301:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isTriggerSet then
    return
  end
  if skill.isCommonAttack and sender.roleType == eBattleRoleType.character and target.belongNum == eBattleRoleBelong.enemy then
    local random = LuaSkillCtrl:CallRange(1, 10000)
    if random <= self.arglist[1] then
      self:AddColor(1)
    end
  end
  local colorId = self.caster.recordTable.beforeAttackColor
  if colorId == 0 then
    return
  end
  if sender ~= self.caster or isMiss then
    return
  end
  if colorId == 1 then
    local originAttrList = self.caster.originAttrList
    local pow_max = originAttrList[eHeroAttr.pow] * self.arglist[11] // 1000
    local pow_tar = target.pow * self.arglist[4] // 1000
    local pow_up = math.min(pow_max, pow_tar)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_att, pow_up, self.arglist[5], true)
  end
  if colorId == 2 then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 71, 10)
    if 2 > targetList.Count then
      return
    end
    for i = 0, targetList.Count - 1 do
      if targetList[i].targetRole ~= nil and targetList[i].targetRole ~= target then
        LuaSkillCtrl:CallEffectWithArgOverride(targetList[i].targetRole, self.config.effectId_trail, self, target, false, false, self.SkillEventFunc)
        break
      end
    end
  end
  if colorId == 3 then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_def, 1, self.arglist[7], true)
  end
end

function bs_106301:SkillEventFunc(effect, eventId, target)
  if effect.dataId == self.config.effectId_trail and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
      self.arglist[9]
    })
    skillResult:EndResult()
  end
end

function bs_106301:OnAfterBattleStart()
  self.addYellowTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[3], function()
    self:AddColor(3)
  end, self, -1, 0)
end

function bs_106301:ResetColorTable()
  local colorTable = self.caster.recordTable.colorTable
  colorTable[1] = {
    colorId = 1,
    num = 0,
    per = 3334
  }
  colorTable[2] = {
    colorId = 2,
    num = 0,
    per = 3333
  }
  colorTable[3] = {
    colorId = 3,
    num = 0,
    per = 3333
  }
end

function bs_106301:AddColor(colorId)
  local colorInfo = self.colorInfo[colorId]
  local colorName = colorInfo.colorName
  local buffId = colorInfo.buffId
  local effectId = colorInfo.effectId
  LuaSkillCtrl:CallBuff(self, self.caster, buffId, 1, nil, true)
  LuaSkillCtrl:CallEffect(self.caster, effectId, self)
  self:OnAddColor(colorId)
end

function bs_106301:OnAddColor(colorId)
  local colorTable = self.caster.recordTable.colorTable
  for i = 1, 3 do
    if colorTable[i].colorId == colorId then
      local num = colorTable[i].num
      colorTable[i].num = num + 1
      local curNum = colorTable[i].num
      if 1 < i then
        for k = i - 1, 1, -1 do
          local lastTable = colorTable[k]
          if curNum > lastTable.num then
            colorTable[i].colorId = colorTable[k].colorId
            colorTable[i].num = colorTable[k].num
            colorTable[k].colorId = colorId
            colorTable[k].num = curNum
            i = k
          end
        end
      end
      break
    end
  end
  self:CalculatePer()
end

function bs_106301:OnPlayYelenaSkill(role, colorId)
  if role == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_red)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_blue)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_yellow)
    self:ResetColorTable()
    self:AddColor(colorId)
  end
end

function bs_106301:CalculatePer()
  local colorTable = self.caster.recordTable.colorTable
  if colorTable[1].num > colorTable[2].num then
    colorTable[1].per = 6000
    if colorTable[2].num > colorTable[3].num then
      colorTable[2].per = 3000
      colorTable[3].per = 1000
    else
      colorTable[2].per = 2000
      colorTable[3].per = 2000
    end
  elseif colorTable[2].num > colorTable[3].num then
    colorTable[1].per = 4500
    colorTable[2].per = 4500
    colorTable[3].per = 1000
  else
    colorTable[1].per = 3334
    colorTable[2].per = 3333
    colorTable[3].per = 3333
  end
end

function bs_106301:OnCasterDie()
  base.OnCasterDie(self)
  if self.addYellowTimer ~= nil then
    self.addYellowTimer:Stop()
    self.addYellowTimer = nil
  end
end

function bs_106301:LuaDispose()
  base.LuaDispose(self)
end

return bs_106301
