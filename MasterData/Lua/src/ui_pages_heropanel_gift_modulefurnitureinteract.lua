local this = class("moduleFurnitureInteract", G_UIModuleBase)

function this.bind()
  return {go_interact = false, txt_interact = ""}
end

function this.methods()
  return {}
end

function this:open()
  self:setInteractUI(self.bind.interact)
end

function this:refresh()
  self:setInteractUI(self.bind.interact)
end

function this:setInteractUI(interact)
  if interact then
    if interact == 0 then
      self.bind.go_interact = false
    elseif interact == 1 then
      self.bind.go_interact = true
      self.bind.txt_interact = L_WordsTpl:getValue("residual_code_modulefurnitureinteract_01")
    elseif interact == 2 then
      self.bind.go_interact = true
      self.bind.txt_interact = L_WordsTpl:getValue("residual_code_modulefurnitureinteract_02")
    end
  else
    self.bind.go_interact = false
  end
end

return this
