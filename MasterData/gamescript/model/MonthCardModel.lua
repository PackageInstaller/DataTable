local function createData()
  local data = {}
  
  data.state = CommonDefine.MonthCardState.Dummy
  data.expiredTimestamp = 0
  data.rewardsReceivedState = CommonDefine.RewardState.Dummy
  data.itemInfo = MainShopDataUtils.GetMonthCardItemInfo()
  return data
end

local function createViews(data)
  local views = {}
  
  function views:GetState()
    return data.state
  end
  
  function views:GetExpiredTimestamp()
    return data.expiredTimestamp
  end
  
  function views:GetRewardsReceivedState()
    return data.rewardsReceivedState
  end
  
  function views:GetItemInfo()
    return data.itemInfo
  end
  
  return views
end

local function createActions(data)
  local actions = {}
  
  function actions:RequestMonthCardInfo(callback, monthCardType)
    MainShopDataUtils.RequestMonthCardInfo(function(svrData)
      data:_SetMonthCardInfo(svrData)
      if callback then
        callback(svrData.rewardState)
      end
    end, monthCardType)
  end
  
  function actions:_SetMonthCardInfo(svrData)
    if 0 == svrData.expireTime then
      data.state = CommonDefine.MonthCardState.NeverPurchased
    elseif TimeUtils.GetServerTime() < svrData.expireTime then
      data.state = CommonDefine.MonthCardState.InEffect
    else
      data.state = CommonDefine.MonthCardState.Expired
    end
    data.expiredTimestamp = svrData.expireTime
    data.rewardsReceivedState = svrData.rewardState
  end
  
  function actions:PurchaseMonthCard(callback, monthCardType)
    MainShopDataUtils.PurchaseMonthCard(function()
      if callback then
        callback()
      end
    end, monthCardType)
  end
  
  function actions:ReceiveRewards(callback)
    MainShopDataUtils.ReceiveRewards(function()
      if callback then
        callback()
      end
    end)
  end
  
  return actions
end

local function onSetup(_, _)
end

local MonthCardModel = Vue.model("MonthCardModel", createData):views(createViews):actions(createActions):setup(onSetup)
return MonthCardModel
