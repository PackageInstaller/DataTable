local this = class("cellProfessionDescription", G_UIModuleBase)
local professionTpl = L_GameTpl:getProfessionTpl()

function this.bind()
  return {
    professionIcon = "",
    professionName = "",
    professionDes = "",
    selectedActive = false
  }
end

function this:refresh()
  if not self.isBind then
    return
  end
  local tpl = professionTpl:getTplById(self.bind.id)
  local professionIcon = professionTpl:getIcon(tpl, self.bind.isHighLight and 4 or 1)
  self.bind.professionIcon = professionIcon
  self.bind.professionName = professionTpl:getName(tpl)
  self.bind.professionDes = professionTpl:getDesc(tpl)
  self.bind.selectedActive = self.bind.isHighLight
end

return this
