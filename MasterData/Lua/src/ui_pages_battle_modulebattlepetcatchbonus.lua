local this = class("moduleBattlePetCatchBonus", G_UIModuleBase)

function this.bind()
  return {
    moduleBattlePetCatchBonusTip = {
      moduleName = "pages/pet/new/moduleBattlePetCatchBonusTip"
    },
    moduleBattlePetCatchBonusDetailTip = {
      moduleName = "pages/pet/new/moduleBattlePetCatchBonusTipDetail"
    }
  }
end

function this.methods()
  return {
    moduleBattlePetCatchBonusTip = {
      onClick = function(self)
        self:switchTip(true)
      end
    },
    moduleBattlePetCatchBonusDetailTip = {
      onClick = function(self)
        self:switchTip(false)
      end
    }
  }
end

function this:open()
  self.isShowDetails = false
  self._onMonsterHistoryCatchInfoUpdate = handler(self, self.onMonsterHistoryCatchInfoUpdate)
  C_PetStoreEvent.instance:Listen(C_EPetStoreEvent.refreshPetCatchHistoryInfos, self._onMonsterHistoryCatchInfoUpdate)
  self._petCatchEventHandler = handler(self, self.onPetCatchEvent)
  AzurWorld.PetCatchManagerMgr:RegisterEvent(C_EPetCatchEvent.CatchBallChange, self._petCatchEventHandler)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPetCatchFoodBuff, self.onEventMessagePetCatchFoodBuff, self)
end

function this:close()
  if self.parent and self.parent.pageName ~= nil then
    L_ShortCutManager:removeShortCut(self.parent.pageName)
  else
    L_ShortCutManager:removeShortCut("pageNestCoopPetCatch")
  end
  if self._onMonsterHistoryCatchInfoUpdate ~= nil then
    C_PetStoreEvent.instance:Cancel(C_EPetStoreEvent.refreshPetCatchHistoryInfos, self._onMonsterHistoryCatchInfoUpdate)
    self._onMonsterHistoryCatchInfoUpdate = nil
  end
  if self._petCatchEventHandler ~= nil then
    AzurWorld.PetCatchManagerMgr:UnregisterEvent(C_EPetCatchEvent.CatchBallChange, self._petCatchEventHandler)
    self._petCatchEventHandler = nil
  end
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPetCatchFoodBuff, self.onEventMessagePetCatchFoodBuff, self)
end

function this:show()
  if self.parent and self.parent.pageName ~= nil then
    L_ShortCutManager:registerShortCut(self.parent.pageName, C_InputManager_KeyType.EBattleGeneTipSwitch, function()
      self:switchTip(not self.isShowDetails)
    end)
  else
    L_ShortCutManager:registerShortCut("pageNestCoopPetCatch", C_InputManager_KeyType.EBattleGeneTipSwitch, function()
      self:switchTip(not self.isShowDetails)
    end)
  end
  self:switchTip(self.isShowDetails)
end

function this:showTip()
  self.isShow = true
  self:switchTip(false)
end

function this:hideTip()
  self.isShow = false
  self.modules.moduleBattlePetCatchBonusTip:hide()
  self.modules.moduleBattlePetCatchBonusDetailTip:hide()
end

function this:setPetData(data)
  self.petInfo = data
  self.modules.moduleBattlePetCatchBonusTip:setPetData(data)
  self.modules.moduleBattlePetCatchBonusDetailTip:setPetData(data, true)
end

function this:switchTip(isShowDetails)
  if not self.isShow or table.isEmpty(self.petInfo) then
    return
  end
  self.isShowDetails = isShowDetails
  self:refreshTips()
end

function this:refreshTips()
  if self.isShowDetails then
    local rate = self.modules.moduleBattlePetCatchBonusDetailTip:setSelectMonster(true)
    if rate then
      self.modules.moduleBattlePetCatchBonusTip:setModuleRateTitle(rate)
    end
    self.modules.moduleBattlePetCatchBonusTip:hide()
  else
    local rate = self.modules.moduleBattlePetCatchBonusTip:setSelectMonster(true)
    if rate then
      self.modules.moduleBattlePetCatchBonusDetailTip:setModuleRateTitle(rate)
    end
    self.modules.moduleBattlePetCatchBonusDetailTip:hide()
  end
end

function this:onMonsterHistoryCatchInfoUpdate()
  self:SetCatchEventState(true)
  self:refreshTips()
end

function this:SetCatchEventState(state)
  self.isCatchEvent = state
end

function this:onPetCatchEvent()
  self:refreshTips()
end

function this:onEventMessagePetCatchFoodBuff()
  self:refreshTips()
end

return this
