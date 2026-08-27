local StorySkillBase = require("GamePlay.SkillScripts.StorySkill.StorySkillBase")
local sc_2 = class("sc_2", StorySkillBase)
local base = StorySkillBase
sc_2.config = {
  cast_skill = 11006,
  hurt = 11007,
  battle_start = 11008
}
sc_2.config = setmetatable(sc_2.config, {
  __index = base.config
})

function sc_2:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function sc_2:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  self:SwitchSpeedMode(1.0)
  LuaSkillCtrl:StartTimer(nil, 7, function()
    self:call_ep_dialog(self.config.battle_start, function()
      LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost)
    end)
  end)
  self.suer = self:GetRole(1003)
  self.sp_suer = self:GetRole(9011090)
  self.cast_skill_flag = true
  self.hurt_skill_flag = true
  self.suer_hurt_count = 0
  self:AddAfterHurtTrigger("sc_2_1", 1, self.OnAfterHurt, nil, nil)
  self:AddLuaTrigger(eSkillLuaTrigger.OnUltSkillPlayed, self.OnUltSkillPlayed)
  self.ep_cd_flag = true
  self.timer = LuaSkillCtrl:StartTimer(nil, 45, function()
    self.ep_cd_flag = true
  end, nil, -1)
  self.isCanUlt = true
  self:SetUndead(self.suer)
end

function sc_2:OnAfterPlaySkill(skill, role)
  if role.roleDataId == 9011090 and self.cast_skill_flag then
    self:call_ep_dialog(self.config.cast_skill, function()
      self.cast_skill_flag = false
    end)
  end
end

function sc_2:OnUltSkillPlayed(role)
  if not self.isCanUlt then
    return
  end
  local ultSkill = self.suer:GetSkillComponent().ultSkill
  ultSkill:ResetCDTimeRatio(90)
  MsgCenter:Broadcast(eMsgEventId.OnShowSpeicalUltHearoEffect, self.cskill.dataId, self.suer.roleDataId)
  LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost)
end

function sc_2:reset_ult()
  local ultSkill = self.suer:GetSkillComponent().ultSkill
  ultSkill:ResetCDTimeRatio(70)
  MsgCenter:Broadcast(eMsgEventId.OnShowSpeicalUltHearoEffect, self.cskill.dataId, self.suer.roleDataId)
  LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost)
end

function sc_2:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.roleDataId == 9011090 and self.hurt_skill_flag and target.hp <= target.maxHp // 2 then
    self.isCanUlt = false
    LuaSkillCtrl:StartTimer(nil, 30, function()
      self:call_ep_dialog(self.config.hurt, function()
        self.hurt_skill_flag = false
        self:flow()
        self.isCanUlt = true
      end)
    end)
  end
  if target.roleDataId == 1003 and self.cast_skill_flag then
    self.suer_hurt_count = self.suer_hurt_count + 1
    if self.suer_hurt_count > 5 then
      self:call_ep_dialog(self.config.cast_skill, function()
        self.cast_skill_flag = false
      end)
    end
  end
end

function sc_2:flow()
  LuaSkillCtrl:StartTimer(nil, 7, function()
    LuaSkillCtrl:CallHeal(self.sp_suer.maxHp // 10, self, self.sp_suer)
  end, nil, 7)
  LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 4, 50)
end

function sc_2:call_ep_dialog(epId, cb)
  if self.ep_cd_flag ~= true then
    return
  end
  LuaSkillCtrl:CallPlayEpTipDialogInBattle(epId)
  self.ep_cd_flag = false
  if cb ~= nil then
    cb()
  end
end

function sc_2:OnCasterDie()
  base.OnCasterDie(self)
end

return sc_2
