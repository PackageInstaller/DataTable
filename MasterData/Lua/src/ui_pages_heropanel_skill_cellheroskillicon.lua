local module = class("cellHeroSkillIcon", G_UIModuleBase)

function module.bind()
  return {
    isActive = false,
    iconPath = "",
    isLock = false,
    isblankBg = false,
    glowAcitve = false,
    txtLv = ""
  }
end

function module.methods()
  return {
    onClick = function(self)
      if not self.bind.isActive then
        C_AudioManager.Play("Play_SFX_System_UI_CHAR_Skill_Click")
        self.bindComponents.selectAnimation:Play("anim_heroes_skill_cell_select_show")
        self:emit("onClick", self.bind)
      end
    end
  }
end

function module:open()
  self.bindComponents.redot.gameObject:SetActive(false)
  Timer.once(0.5, function()
    self:bindRed()
  end, self)
end

function module:bindRed()
  if not self.isBind then
    return
  end
  local heroId = self.bind.heroId
  local skillId = self.bind.skillId
  self.bindComponents.redot.gameObject:SetActive(false)
  if heroId and skillId and self.bind.showRed then
    if self.bind.isPreview then
      self.bindComponents.redot.gameObject:SetActive(false)
    else
      L_ReddotManager:registerReddot(self.bindComponents.redot, string.format(L_ReddotManager.DotDef.HeroSkill, heroId .. "_" .. skillId))
    end
  end
end

function module:refresh()
  if not self.isBind then
    return
  end
  local skillId = self.bind.skillId
  local skillTpl = L_GameTpl:getSkillTpl()
  local tplSkill = skillTpl:getTplById(skillId)
  local elementId = 1
  local elementList = skillTpl:getSkillElement(tplSkill)
  if not table.isEmpty(elementList) and 0 < #elementList then
    elementId = elementList[1]
  end
  self.bind.txtLv = self.bind.levelText
  self.bind.glowAcitve = self.bind.isActive
  if self.bind.isLock then
    self.bind.txtLv = ""
  end
end

function module:playLevelUpAni()
  if self.bindComponents == nil then
    return
  end
  self.bindComponents.skill_cell:Stop()
  C_AudioManager.Play("Play_SFX_System_UI_CHAR_Skill_Upgrade")
  self.bindComponents.skill_cell:Play("anim_heroes_skill_cell_levelup")
end

return module
