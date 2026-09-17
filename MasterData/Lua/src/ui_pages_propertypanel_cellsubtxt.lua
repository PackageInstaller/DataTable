local this = class("cellSubtxt", G_UIModuleBase)
local skillLevelTpl = L_GameTpl:getSkillLevelTpl()

function this.bind()
  return {bgActive = false, txtDesc = ""}
end

function this.methods()
  return {}
end

function this:refresh()
  self.bind.bgActive = self.bind.isShowBg
  self.bind.txtDesc = L_GameUtil.getSkillDesc(self.bind.skillId, self.bind.skillLevel)
end

return this
