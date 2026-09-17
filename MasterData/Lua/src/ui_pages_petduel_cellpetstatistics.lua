local this = class("cellPetStatistics", G_UIModuleBase)

function this.bind()
  return {
    cellPlayerPetStatistics = {
      moduleName = "pages/petDuel/cellOnePetStatistics"
    },
    cellEnemyPetStatistics = {
      moduleName = "pages/petDuel/cellOnePetStatistics"
    },
    cellPlayerActive = true,
    cellEnemyActve = true
  }
end

function this.methods()
  return {}
end

function this:open()
end

function this:refresh()
  if not self.isBind then
    return
  end
  self.bind.cellPlayerActive = self.bind.playerData ~= nil
  self.bind.cellEnemyActve = self.bind.enemyData ~= nil
  if self.bind.cellPlayerActive then
    self.modules.cellPlayerPetStatistics:refreshData(self.bind.playerData)
  end
  if self.bind.cellEnemyActve then
    self.modules.cellEnemyPetStatistics:refreshData(self.bind.enemyData, true)
  end
end

function this:close()
end

return this
