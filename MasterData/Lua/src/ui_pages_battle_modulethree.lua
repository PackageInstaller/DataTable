local this = class("moduleThree", G_UIModuleBase)
local BOSS_NUM = 3

function this.bind()
  return {
    goRoot = false,
    moduleBossHpA = {
      moduleName = "pages/battle/cellBattleBossHp"
    },
    moduleBossHpB = {
      moduleName = "pages/battle/cellBattleBossHp"
    },
    moduleBossHpC = {
      moduleName = "pages/battle/cellBattleBossHp"
    }
  }
end

function this:initBoss(bossList)
  self.modules.moduleBossHpA:initBoss(bossList[1], 1)
  self.modules.moduleBossHpB:initBoss(bossList[2], 2)
  self.modules.moduleBossHpB:initBoss(bossList[3], 3)
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
