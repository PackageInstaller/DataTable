local this = class("cellHeroSoulessence", G_UIModuleBase)
local soulessenceTpl = L_GameTpl:getSoulessenceTpl()

function this.bind()
  return {txtDescribe = "", txtTitle = ""}
end

function this.methods()
  return {}
end

function this:refresh()
  local tpl = soulessenceTpl:getTplById(self.bind.spiritId)
  self.bind.txtDescribe = C_SoulEssenceMgr:GetSkillDescByConfigIDAndStar(self.bind.spiritId, self.bind.star or 1)
  self.bind.txtTitle = L_WordsTpl:getValue("ui_heroRole_23") .. soulessenceTpl:getName(tpl)
end

return this
