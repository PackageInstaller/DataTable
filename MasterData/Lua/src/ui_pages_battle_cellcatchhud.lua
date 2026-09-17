local this = class("cellCatchHud", G_UIModuleBase)

function this.bind()
  return {}
end

function this:open()
  self._onMonsterHistoryCatchInfoUpdate = handler(self, self.onMonsterHistoryCatchInfoUpdate)
  C_PetStoreEvent.instance:Listen(C_EPetStoreEvent.refreshPetCatchHistoryInfos, self._onMonsterHistoryCatchInfoUpdate)
end

function this:close()
  C_PetStoreEvent.instance:Cancel(C_EPetStoreEvent.refreshPetCatchHistoryInfos, self._onMonsterHistoryCatchInfoUpdate)
end

function this:onMonsterHistoryCatchInfoUpdate()
end

function this:refresh()
  self.bindComponents.cellCapturetHud:SetTargetMonster(self.bind.monster)
end

return this
