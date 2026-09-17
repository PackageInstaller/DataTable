local this = class("cellPetCatchBonueIcon", G_UIModuleBase)
local levelNode = {
  [0] = "active_no",
  [1] = "active_grey",
  [2] = "active_grey",
  [3] = "active_blue",
  [4] = "active_purple",
  [5] = "active_gold",
  [6] = "active_colorful"
}

function this.bind()
  return {
    active_no = false,
    active_colorful = false,
    active_gold = false,
    active_purple = false,
    active_blue = false,
    active_grey = false
  }
end

function this.methods()
  return {}
end

function this:open()
  self:hiteAll()
  self.bind[levelNode[self.bind.rank]] = true
end

function this:hiteAll()
  self.bind.active_no = false
  self.bind.active_colorful = false
  self.bind.active_gold = false
  self.bind.active_purple = false
  self.bind.active_blue = false
  self.bind.active_grey = false
end

function this:close()
end

return this
