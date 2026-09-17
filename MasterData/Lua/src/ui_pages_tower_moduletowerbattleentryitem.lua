local module = class("moduleTowerBattleEntryItem", G_UIModuleBase)

function module.bind()
  return {
    cellOffset = C_Vector2.zero,
    battleLevelText = "",
    activeLock = false,
    activeGotMark = false
  }
end

function module.methods()
  return {
    onClick_enterBtn = function(self)
      if L_TowerManager:isBattleUnlocked(self.bind.battleData.order) then
        L_UI:open("pageTowerFormation", self.bind.battleData)
      else
        L_FlyMsgManager:showNormalMsgByKey(L_TowerConst.text.locked_tips)
      end
    end
  }
end

function module:refresh()
  self.bind.battleLevelText = tostring(self.bind.battleData.order)
  self.bind.activeLock = not L_TowerManager:isBattleUnlocked(self.bind.battleData.order)
  self.bind.activeGotMark = L_TowerManager:isBattlePassed(self.bind.battleData.order)
end

return module
