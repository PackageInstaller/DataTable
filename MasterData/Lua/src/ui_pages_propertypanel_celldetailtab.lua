local this = class("cellDetailTab", G_UIModuleBase)
local detailsTabTpl = L_GameTpl:getDetailsTabTpl()

function this.bind()
  return {
    rightLineActive = false,
    tabName = "",
    nameText = "",
    go_active = false,
    go_normal = true
  }
end

function this.methods()
  return {
    onClick_tab = function(self)
      self:emit("onTabId", self.bind.id)
    end
  }
end

function this:refresh()
  local tpl = detailsTabTpl:getTplById(self.bind.id)
  self.bind.tabName = detailsTabTpl:getTabName(tpl)
  self.bind.nameText = detailsTabTpl:getTabName(tpl)
end

function this:setSelected(isSelected)
  self.bind.go_active = isSelected
  self.bind.go_normal = not isSelected
end

return this
