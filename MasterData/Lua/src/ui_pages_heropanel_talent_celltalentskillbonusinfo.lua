local module = class("cellTalentSkillBonusInfo", G_UIModuleBase)

function module.bind()
  return {
    skillList = {
      moduleName = "pages/HeroPanel/talent/cellTalentSkillLevel"
    }
  }
end

function module:refresh()
  if not self.isBind then
    return
  end
end

function module:initData(data)
  self.bind.skillList:clear()
  self.bind.skillList:insert_array(data)
end

return module
