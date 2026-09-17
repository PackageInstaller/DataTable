local this = class("cellJourneyInfoReward", G_UIModuleBase)

function this.bind()
  return {
    cellIconBag = {
      moduleName = "modulePages/cellIconBag"
    },
    active_finishMask = true
  }
end

function this:refreshAll(rewardData, isReceived)
  local cellIconBag = self.modules.cellIconBag
  local itemType = rewardData.itemType
  local itemId = rewardData.itemId
  local param = {
    itemNum = rewardData.itemNum
  }
  cellIconBag:setGeneralContent(itemType, itemId, param)
  self.bind.active_finishMask = isReceived
end

return this
