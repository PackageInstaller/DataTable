local this = class("moduleEntryTip", G_UIModuleBase)
local enemyTpl = L_GameTpl:getEnemyTpl()

function this.bind()
  return {
    txt_left_bossName = "",
    txt_right_bossName = "",
    toggle_isLeftTip = false,
    tipBoxAnchorPos = nil,
    go_tipBox = false
  }
end

return this
