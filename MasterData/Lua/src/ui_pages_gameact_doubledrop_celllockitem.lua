local this = class("cellLockItem", G_UIModuleBase)

function this:bind()
  return {txtLockLabel = ""}
end

function this:SetText(txt)
  self.bind.txtLockLabel = txt
end

return this
