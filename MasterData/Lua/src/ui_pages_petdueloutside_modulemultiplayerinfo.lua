local this = class("moduleMultiPlayerInfo", G_UIModuleBase)

function this.bind()
  return {
    txt_playerName = "",
    txt_playerLv = "",
    tab_teamPos = -1
  }
end

function this.methods()
  return {}
end

function this:initModule(options)
  self.bind.txt_playerName = options.name
  self.bind.txt_playerLv = tostring(options.lv)
  self.bind.tab_teamPos = options.pos
end

return this
