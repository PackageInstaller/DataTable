local this = class("cellDuelTarget", G_UIModuleBase)

function this.bind()
  return {txt_content = "", toggle_condition = true}
end

function this.methods()
  return {}
end

function this:open(options)
end

function this:refresh()
  if not self.isBind or not self.bind.duelTime then
    return
  end
  if self.bind.leftTime == nil then
    self.bind.leftTime = self.bind.duelTime
  end
  self.bind.txt_content = self.bind.descShow
  self.bind.toggle_condition = self.bind.leftTime >= self.bind.time
end

return this
