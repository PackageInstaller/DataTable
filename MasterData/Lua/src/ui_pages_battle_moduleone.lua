local this = class("moduleOne", G_UIModuleBase)
local BOSS_NUM = 1

function this.bind()
  return {
    goRoot = false,
    moduleBossHp = {
      moduleName = "pages/battle/cellBattleBossHp"
    }
  }
end

function this:initBoss(bossList)
  self.modules.moduleBossHp:initBoss(bossList[1], 1)
end

function this:setVisible(bossNum)
  self.bind.goRoot = bossNum == BOSS_NUM
end

function this:open()
  self:openModules()
end

function this:show()
  self:showModules()
end

function this:hide()
  self:hideModules()
end

function this:close()
  self:closeModules()
end

return this
