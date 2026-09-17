local this = class("moduleJourneyInfoRewardPanel", G_UIModuleBase)

function this.bind()
  return {
    list_reward = {
      moduleName = "pages/journey/cellJourneyInfoReward"
    }
  }
end

function this:Init(params)
  local listTable = {}
  for i = 0, params.rewardDatas.Count - 1 do
    table.insert(listTable, {})
  end
  self.bind.list_reward:clear()
  self.bind.list_reward:insert_array(listTable)
  for i = 1, #self.bind.list_reward do
    local cellJourneyInfoReward = self.bind.list_reward:getItemCls(i)
    local rewardData = params.rewardDatas[i - 1]
    local isReceived = params.isReceived
    cellJourneyInfoReward:refreshAll(rewardData, isReceived)
  end
end

return this
