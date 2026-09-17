local this = class("cellSlotDisplay", G_UIModuleBase)

function this.bind()
  return {txt_name = nil}
end

function this:open()
  self.bind.txt_name = math.isEmpty(self.bind.date) and "" or tostring(self.bind.date)
end

return this
