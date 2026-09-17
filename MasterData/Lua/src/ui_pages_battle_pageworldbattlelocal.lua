local page = class("pageWorldBattleLocal", G_UIPageBase)
page.data = {battleProxy = nil}
local helper = CS.Lens.Tools.RuntimeDebug.RuntimeDebugActionHelper

function page.bind()
  return {
    module_hero = {
      moduleName = "pages/main/moduleBattlePlayer"
    },
    module_battleControl = {
      moduleName = "pages/battle/moduleBattleControlNew"
    },
    modulePetHideShow = {
      moduleName = "pages/battle/modulePetHideShow"
    },
    moduleBattleEnergy = {
      moduleName = "pages/battle/moduleBattleEnergy"
    },
    modulePlayerHp = {
      moduleName = "pages/battle/modulePlayerHp"
    },
    moduleBossHpList = {
      moduleName = "pages/battle/moduleBossHpList"
    },
    modulePetSkill = {
      moduleName = "pages/battle/modulePetSkill"
    },
    module_battleDialog = {
      moduleName = "pages/battle/moduleBattleDialog"
    },
    module_battleCombo = {
      moduleName = "pages/battle/moduleBattleCombo"
    },
    module_battleEffect = {
      moduleName = "pages/battle/moduleBattleEffect"
    }
  }
end

function page.methods()
  return {
    onClick_close = function(self)
      C_BattleManager.ForceOutBattle()
    end
  }
end

function page:preOpen()
end

function page:open(options)
  self.modules.moduleBossHpList:initBoss()
end

function page:show()
  L_ShortCutManager:registerShortCutMapList(self.pageName, {
    C_InputManager_KeyType.EMainSwitchHero1,
    C_InputManager_KeyType.EMainSwitchHero2,
    C_InputManager_KeyType.EMainSwitchHero3
  })
end

function page:escHandle()
end

function page:close()
end

return page
