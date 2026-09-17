local this = class("cellRandReward", G_UIModuleBase)

function this.bind()
  return {
    showBg = false,
    levelIcon = "",
    list_reward = L_Const.ModuleInfo.CellIconBag
  }
end

function this.methods()
  return {}
end

function this:open()
  if self.isBind then
    self:initCell()
  end
end

function this:initCell()
  local num = string.format("%02d", tostring(self.bind.rank))
  self.bind.levelIcon = self.bind.icon
  self.bind.showBg = self.bind.showBg
  local tmp = {}
  for k, v in pairs(self.bind.reward) do
    v.isReceived = self.bind.getted
    table.insert(tmp, v)
  end
  table.insert(tmp, {active_content = false, active_empty = true})
  self.bind.list_reward:clear()
  self.bind.list_reward:insert_array(tmp)
end

return this
