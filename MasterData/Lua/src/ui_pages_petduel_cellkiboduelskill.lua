local this = class("cellKiBoDuelSkill", G_UIModuleBase)
local playerManager, entityTypePet, floatUtility
local playerunitHelper = C_PlayerUnitHelper

function this.bind()
  return {}
end

function this.methods()
  return {}
end

function this:created(...)
  this.super.created(self, ...)
end

function this:toBind(uiBinding)
  if C_KiboArenaSystemMgr.isInArena then
    return
  end
  self.super.toBind(self, uiBinding)
  local addModuleGeneric = xlua.get_generic_method(self.parent.csharpPage:GetType(), "AddModuleMulti")
  local addModule = addModuleGeneric(CS.Lens.Gameplay.UI.PetDuel.ModuleKiboDuelSkill, CS.UnityEngine.GameObject)
  self.transferModule = addModule(self.parent.csharpPage, self.parent.csharpPage, self.gameObject)
end

function this:open()
  playerManager = AzurWorld.playerMgr
  entityTypePet = C_EEntityType.Pet
  floatUtility = C_MyFloatUtility
end

function this:initSkillType(skillType, isPetDuel)
  if self.transferModule then
    self.transferModule:InitSkillType(skillType)
  end
end

function this:show()
end

function this:close()
  playerManager = nil
  playerunitHelper = nil
  entityTypePet = nil
  floatUtility = nil
end

function this:setMainControl()
  self:refreshSkillIcon()
end

function this:refreshSkillIcon()
  if self.skillType == nil then
    return
  end
  if playerunitHelper == nil then
    playerunitHelper = C_PlayerUnitHelper
  end
  local controlEntity = playerunitHelper.GetPlayerMainControl(playerManager.myPlayerId, false)
  if not controlEntity then
    return
  end
  if controlEntity.data.entityType ~= entityTypePet and not self.isPetDuel then
    return
  end
  local tmp = {}
  for i = 1, 3 do
    table.insert(tmp, {
      index = i,
      isUse = false,
      toggle_condition = true
    })
  end
  self.bind.list_point:clear()
  self.bind.list_point:insert_array(tmp)
  local skill = controlEntity.data.skillProperty:GetSkillBySlot(self.skillType)
  if skill then
    local skillId = skill.id
    local tpl = L_GameTpl:getSkillTpl():getTplById(skillId)
    if tpl ~= nil then
      local icon = L_GameTpl:getSkillTpl():getBattleSkillIcon(tpl)
      self.bind.img_skill = icon
    end
  end
end

function this:refresh()
end

function this:update()
  if self.skillType == nil then
    return
  end
  local controlEntity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  if not controlEntity then
    return
  end
  if controlEntity.data.entityType ~= entityTypePet and not self.isPetDuel then
    return
  end
  local skillProperty = controlEntity.data.skillProperty
  local goSkillCd = false
  local skill = skillProperty:GetSkillBySlot(self.skillType)
  if skill then
    local coolDown = skill.coolDown
    local currentChargeCount = coolDown.currentChargeCount
    local ready = coolDown:Ready()
    if self.lastCurrentCharge ~= nil and currentChargeCount < self.lastCurrentCharge then
      self:onKiBoSkillClicked(self.skillType)
    end
    if not ready and 0 < currentChargeCount then
      self.canUseSkill = false
      goSkillCd = true
      local coolTime = floatUtility.GetFloat(coolDown.coolTime)
      local coolTimeNum = floatUtility.GetFloat(coolDown.coolDown)
      self.bind.txt_skillCd = tostring(math.round(coolTime))
      self.bind.fill_maskSkill = coolTime / coolTimeNum
    elseif ready and 0 < currentChargeCount and self.canUseSkill == false then
      self.canUseSkill = true
      self.bindComponents.skillAnimator:Play("anim_petduel_skill_cd")
    end
    if coolDown.coolDownType == C_ECoolDownType.KiBoVersusCommonSkill then
      local listPoint = self.bind.list_point
      for i = 1, coolDown.chargeMaxCount do
        if currentChargeCount < listPoint:getValue(i, "index") and listPoint:getValue(i, "isUse") == false then
          listPoint:change(i, {isUse = true, toggle_condition = false})
        end
      end
      self.bind.limitText = tostring(currentChargeCount) .. "/" .. tostring(coolDown.chargeMaxCount)
    end
    if currentChargeCount <= 0 then
      goSkillCd = true
      self.bind.txt_skillCd = " "
      self.bind.fill_maskSkill = 1
      self.canUseSkill = false
    end
    self.coolDown = coolDown
    self.lastCurrentCharge = currentChargeCount
  end
  if goSkillCd ~= self.bind.go_skillCd then
    self.bind.go_skillCd = goSkillCd
  end
end

function this:onKiBoSkillClicked(type)
  if not self.isBind then
    return
  end
  if self.skillType == nil then
    return
  end
  if self.isFirstUse then
    self.canUseSkill = true
    self.isFirstUse = false
  end
  if self.skillType == type and self.coolDown ~= nil then
    printf("技能次数：", self.coolDown.currentChargeCount)
    if self.coolDown.currentChargeCount >= 0 and self.canUseSkill then
      L_TimerManager:newOrResetTimer(self, "wait", function()
        self.bindComponents.skillAnimator:Play("anim_petduel_skill_use")
        self.canUseSkill = false
        L_TimerManager:stopTimer(self, "wait")
      end, 0.015)
      return
    elseif self.coolDown.currentChargeCount <= 0 then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_duel_in_battle_03"))
      return
    end
    local ready = self.coolDown:Ready()
    if not ready then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_duel_in_battle_02"))
      return
    end
  end
end

return this
