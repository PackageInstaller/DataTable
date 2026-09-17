local module = class("cellSkillPropertyItem", G_UIModuleBase)

function module.bind()
  return {
    propertyNameTxt = "",
    changedValueTxt = "",
    bgEnabled = true,
    arrowActive = true
  }
end

function module:refresh()
  if self.bindComponents.afterValue_txt then
    self.bindComponents.afterValue_txt.text = self.bind.txt_afterValue
  end
  self.bind.arrowActive = not string.isEmpty(self.bind.changedValueTxt)
end

function module:tryInitModule(nameText, afterText, beforText)
  self.bind.propertyNameTxt = nameText
  self.bind.changedValueTxt = afterText
  if self.bindComponents.afterValue_txt then
    self.bindComponents.afterValue_txt.text = beforText
  end
end

function module:open()
  self.timer = nil
end

function module:close()
  if self.timer then
    Timer.remove(self.timer)
  end
  self.timer = nil
end

function module:playLevelUpAni(count)
  if not self.isBind then
    return
  end
  if self.timer then
    Timer.remove(self.timer)
  end
  self.timer = Timer.once(0.034 * count, handler(self, self.playLevelUpAniInter), self, nil, true)
end

function module:playLevelUpAniInter()
  if not self.isBind then
    return
  end
  if self.bindComponents == nil then
    return
  end
  self.bindComponents.property_cell:Stop()
  self.bindComponents.property_cell:Play("anim_heroes_skill_levelupcell_up")
  self.timer = nil
end

return module
