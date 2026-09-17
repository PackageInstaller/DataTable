local this = class("cellMountRidingCondition", G_UIModuleBase)

function this.bind()
  return {
    txt_desc = "",
    txt_desc_1 = "",
    go_completed = false
  }
end

function this.methods()
  return {}
end

function this:refresh()
  if self.bind.isUnLock then
    self.bind.txt_desc = ""
    self.bindComponents.anim_cellmounridinginfo:Play("anim_pagemounridinginfo_complete")
  else
    self.bind.txt_desc_1 = ""
  end
end

return this
