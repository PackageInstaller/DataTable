local BattleCustomMoveCtrl = class("BattleCustomMoveCtrl")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local CS_ResLoader = CS.ResLoader

function BattleCustomMoveCtrl:ctor()
end

function BattleCustomMoveCtrl.CreateCustomMoveCtrl(bdCtrl)
  local ctrl = BattleCustomMoveCtrl.New()
  ctrl:InitCustomMoveCtrl(bdCtrl)
  ctrl.resloader = CS_ResLoader.Create()
  return ctrl
end

function BattleCustomMoveCtrl:InitCustomMoveCtrl(bdCtrl)
  ConfigData:LoadDynCfg(eDynConfigData.brotato_role_amend)
  ConfigData:LoadDynCfg(eDynConfigData.brotato_monster_team)
  ConfigData:LoadDynCfg(eDynConfigData.brotato_sector_stage_extra)
  ConfigData:LoadDynCfg(eDynConfigData.brotato_role_skill_change)
  ConfigData:LoadDynCfg(eDynConfigData.brotato_summoner_amend)
end

function BattleCustomMoveCtrl:OnBattleStateInit(battleCtrl)
  local roles = battleCtrl.EnemyTeamController.battleOriginRoleList
  for i = 0, roles.Count - 1 do
    roles[i].battleRoleView:SetRoleVisible(false)
    LuaSkillCtrl:ChangeRoleHeadInfoWorldOffest(roles[i], 10000)
  end
  local roles = battleCtrl.PlayerTeamController.battleOriginRoleList
  if 0 < roles.Count then
    self.moveEnity = roles[0]
  end
  self:ChangeEntityAnimator()
  LuaSkillCtrl:RegisterLuaTrigger(eSkillLuaTrigger.OnSkillInit, BindCallback(self, self.OnSkillInit))
end

function BattleCustomMoveCtrl:BeginCustomControl(battleCtrl, dungeonId)
  if self.moveEnity == nil then
    return
  end
  local challCfg = ConfigData.brotato_challenge[dungeonId]
  if challCfg ~= nil then
    battleCtrl.GlobalHealFactor = challCfg.heal_factor
  end
  battleCtrl:ShowCustomMoveInputUI()
  self:AmendEntityProperty()
  self:AddBrotatoCharacterSkill()
  self:ActiveEntityCustomComponent()
  self.moveEnity.collider:SetRadius(25)
  battleCtrl:ChangeCmaeraSmoothFollw(true)
end

function BattleCustomMoveCtrl:AmendEntityProperty()
  if self.moveEnity == nil then
    return
  end
  local roleAmendConfig = ConfigData.brotato_role_amend[self.moveEnity.roleDataId]
  if roleAmendConfig == nil then
    return
  end
  local moveSpeedFactor = roleAmendConfig.move_speed_factor * 0.01
  if moveSpeedFactor ~= 1 then
    local moveSpeed = self.moveEnity.moveSpeed
    local value = math.ceil(moveSpeed * (moveSpeedFactor - 1))
    self.moveEnity:AddRoleProperty(eHeroAttr.moveSpeed, value, eHeroAttrType.Origin)
  end
  local attackSpeedFactor = roleAmendConfig.attack_speed_factor * 0.01
  if attackSpeedFactor ~= 1 then
    local attackSpeed = self.moveEnity.speed
    local value = math.ceil(attackSpeed * (attackSpeedFactor - 1))
    self.moveEnity:AddRoleProperty(eHeroAttr.speed, value, eHeroAttrType.Origin)
  end
  local attackRangeFactor = roleAmendConfig.attack_range_factor * 0.01
  if attackRangeFactor ~= 1 then
    local attackRange = self.moveEnity.attackRange
    local value = math.ceil(attackRange * (attackRangeFactor - 1))
    self.moveEnity:AddRoleProperty(eHeroAttr.attackRange, value, eHeroAttrType.Origin)
  end
  local skillRangeFactor = roleAmendConfig.skill_range_factor * 0.01
  if skillRangeFactor ~= 1 then
    local skills = self.moveEnity:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local csSkill = skills[j]
          if not csSkill.isCommonAttack then
            local skillRange = csSkill.SkillRange
            local value = math.ceil(skillRange * (skillRangeFactor - 1))
            csSkill.SkillRange = value
          end
        end
      end
    end
  end
end

function BattleCustomMoveCtrl:ChangeEntityAnimator()
  if self.moveEnity == nil then
    return
  end
  local animatorCtrlPath = PathConsts:GetBrotatoCharCtrlPath(self.moveEnity.resName)
  self.resloader:LoadABAssetAsyncAwait(animatorCtrlPath, function(animatorCtrl)
    if not IsNull(animatorCtrl) then
      local roleActionComponent = self.moveEnity:GetActionComponent()
      local animator = roleActionComponent.Animator
      animator.runtimeAnimatorController = animatorCtrl
    end
  end)
end

function BattleCustomMoveCtrl:AddBrotatoCharacterSkill()
  local battleSkill = LuaSkillCtrl:CallNewSkill(60501, 1, CS.BattleSkillType.Chip)
  self.moveEnity:AddBattleSkill(battleSkill)
  local battleSkill2 = LuaSkillCtrl:CallNewSkill(70038, 1, CS.BattleSkillType.Chip)
  self.moveEnity:AddBattleSkill(battleSkill2)
  local battleSkill3 = LuaSkillCtrl:CallNewSkill(70039, 1, CS.BattleSkillType.Chip)
  self.moveEnity:AddBattleSkill(battleSkill3)
  local battleSkill4 = LuaSkillCtrl:CallNewSkill(70040, 1, CS.BattleSkillType.Chip)
  self.moveEnity:AddBattleSkill(battleSkill4)
  local battleSkill6 = LuaSkillCtrl:CallNewSkill(70045, 1, CS.BattleSkillType.Chip)
  self.moveEnity:AddBattleSkill(battleSkill6)
  LuaSkillCtrl:OnBattleStartWithTriggerHandle(battleSkill2, true)
  LuaSkillCtrl:OnBattleStartWithTriggerHandle(battleSkill3, true)
  LuaSkillCtrl:OnBattleStartWithTriggerHandle(battleSkill4, true)
end

function BattleCustomMoveCtrl:OnSkillInit(luaSkill)
  if self.moveEnity == nil or self.moveEnity.character == nil or luaSkill.caster == nil then
    return
  end
  if self.moveEnity.roleDataId == luaSkill.caster.roleDataId and LuaSkillCtrl:IsOriginalSkill(luaSkill) then
    local roleSkillChangeCfg = ConfigData.brotato_role_skill_change[self.moveEnity.roleDataId]
    if roleSkillChangeCfg ~= nil then
      local change
      local csSkill = luaSkill.cskill
      if csSkill.isNormalSkill then
        local skillSrc = roleSkillChangeCfg.normal_skill
        if skillSrc ~= "" then
          change = require("GamePlay.SkillScripts.BrotatoSkill." .. skillSrc)
        end
      elseif csSkill.isUltSkill then
        local skillSrc = roleSkillChangeCfg.ult_skill
        if skillSrc ~= "" then
          change = require("GamePlay.SkillScripts.BrotatoSkill." .. skillSrc)
        end
      elseif csSkill.isCommonAttack then
        local skillSrc = roleSkillChangeCfg.attack_skill
        if skillSrc ~= "" then
          change = require("GamePlay.SkillScripts.BrotatoSkill." .. skillSrc)
        end
      elseif csSkill.isPassive then
        local skillSrc = roleSkillChangeCfg.passive_skill
        if skillSrc ~= "" then
          change = require("GamePlay.SkillScripts.BrotatoSkill." .. skillSrc)
        end
      end
      if change ~= nil then
        for k, v in pairs(change.config) do
          luaSkill.config[k] = v
        end
        for k, v in pairs(change) do
          if v ~= change.config then
            luaSkill[k] = v
          end
        end
      end
    end
  end
end

function BattleCustomMoveCtrl:EndCustomControl(battleCtrl)
  battleCtrl:HideCutomMoveInputUI()
  battleCtrl:ChangeCmaeraSmoothFollw(false)
end

function BattleCustomMoveCtrl:ActiveEntityCustomComponent()
  if IsNull(self.moveEnity) then
    return
  end
  self.moveEnity:ActiveCustomMoveComponent()
end

function BattleCustomMoveCtrl:DisactiveEntityCustomComponent()
  if IsNull(self.moveEnity) then
    return
  end
  self.moveEnity:DisactiveCustomMoveComponent()
end

function BattleCustomMoveCtrl:OnDelete()
  self.__inputWindow = nil
  self.moveEnity = nil
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  ConfigData:ForceReleaseDynCfg(eDynConfigData.brotato_role_amend)
  ConfigData:ForceReleaseDynCfg(eDynConfigData.brotato_monster_team)
  ConfigData:ForceReleaseDynCfg(eDynConfigData.brotato_sector_stage_extra)
  ConfigData:ForceReleaseDynCfg(eDynConfigData.brotato_role_skill_change)
  ConfigData:ForceReleaseDynCfg(eDynConfigData.brotato_summoner_amend)
end

return BattleCustomMoveCtrl
