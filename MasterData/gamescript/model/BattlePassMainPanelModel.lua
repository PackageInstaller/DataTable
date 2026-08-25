local BpPage = CommonDefine.BpPage
local BpRewardState = CommonDefine.BpRewardState
local BpPrivilegeLevel = CommonDefine.BpPrivilegeLevel
local TaskServerIndex = CommonDefine.TaskServerIndex

local function createBattlePassMainPanelModelState()
  local state = {}
  state.animController = nil
  state.page = BattlePassDataUtils.GetIsFirstEnterBp() and BpPage.Review or BpPage.ItemReward
  state.lastPage = BpPage.ItemReward
  state.showExp = table.deepclone(BattlePassDataUtils.GetExp())
  state.showLevel = table.deepclone(BattlePassDataUtils.GetLevel())
  state.showWeeklyExp = table.deepclone(BattlePassDataUtils.GetWeeklyExp())
  state.taskTabList = {
    [1] = TaskServerIndex.Daily,
    [2] = TaskServerIndex.Weekly,
    [3] = TaskServerIndex.Period
  }
  state.rewardListToTail = false
  state.bigRewardLevel = 5
  state.showRewardItemNum = 6
  state.rewardListIdx = 1
  
  function state.canReceive()
    local rst = false
    for _, data in pairs(BattlePassDataUtils.GetRewardList()) do
      local rewardState = BattlePassDataUtils.GetRewardItemState(data.unlockLevel, data.bpRewardType, data.tid)
      if rewardState == BpRewardState.CanReceive and 0 ~= data.unlockLevel then
        rst = true
        break
      end
    end
    return rst
  end
  
  function state.countDown()
    local endCountDown = BattlePassDataUtils.GetEndCountDown()
    if endCountDown then
      do return LT.Text end
      return LT.Text, endCountDown
    else
      do return LT.Text end
      return LT.Text, ""
    end
  end
  
  function state.showItemRewards()
    return DT.Constant.BPBaseRewardTotal.Data
  end
  
  function state.showWeaponRewards()
    local rst = {}
    local dropId = DT.Item[DT.GetConstant("BPWeaponBoxId")].SpParam[1]
    local dropCfg = DT.Drop[dropId]
    for _, data in pairs(dropCfg.data_list) do
      table.insert(rst, data.DropItem)
    end
    table.sort(rst, function(a, b)
      local aSort = DT.Item[a].BaseSortID
      local bSort = DT.Item[b].BaseSortID
      return aSort < bSort
    end)
    return rst
  end
  
  function state.chargeAdvanceRewards()
    local rst = {}
    local cfgGroup = DT.Constant.BPBaseRewardTotal.Data
    for idx = 1, #cfgGroup - 1, 2 do
      local tid = cfgGroup[idx]
      local num = cfgGroup[idx + 1]
      table.insert(rst, {tid = tid, num = num})
    end
    return rst
  end
  
  function state.chargeDLCRewards()
    local rst = {}
    local bpCfg = BattlePassDataUtils.GetBPConfig()
    if not bpCfg or not bpCfg.BPSeniorRewardTotal then
      return rst
    end
    local cfgGroup = bpCfg.BPSeniorRewardTotal
    for idx = 1, #cfgGroup - 1, 2 do
      local tid = cfgGroup[idx]
      local num = cfgGroup[idx + 1]
      table.insert(rst, {tid = tid, num = num})
    end
    return rst
  end
  
  function state.bpRwardList()
    local rst = {}
    for _, rewardData in pairs(BattlePassDataUtils.GetRewardList()) do
      local level = rewardData.unlockLevel
      if 0 ~= level then
        if not rst[level] then
          rst[level] = {}
        end
        if rewardData.bpRewardType == BpPrivilegeLevel.Ordinary then
          table.insert(rst[level], 1, rewardData)
        else
          table.insert(rst[level], rewardData)
        end
      end
    end
    return rst
  end
  
  state.rollWeaponIdx = 1
  return state
end

local function createBattlePassMainPanelModelViews(data)
  local views = {}
  
  function views.GetPayCodeCfgTid(payCode)
    if not payCode then
      return nil
    end
    local chargeConfig = ShopDataUtils.GetChargeConfig()
    for _, cfg in pairs(chargeConfig) do
      if cfg.PayCode == payCode then
        return cfg.ID
      end
    end
    return nil
  end
  
  function views.GetRewardListByLevel(numLevel)
    if 0 == numLevel or numLevel > #data.bpRwardList then
      return {}
    end
    return data.bpRwardList[numLevel]
  end
  
  function views.CanPlayExpAnim()
    local perLevelExp = BattlePassDataUtils.GetLevelUpExp()
    local svrExp = BattlePassDataUtils.GetExp()
    local svrLevel = BattlePassDataUtils.GetLevel()
    local finalSvrExp = svrExp + svrLevel * perLevelExp
    local finalShowExp = data.showExp + data.showLevel * perLevelExp
    return finalSvrExp > finalShowExp
  end
  
  return views
end

local function createBattlePassMainPanelModelActions(data)
  local actions = {}
  
  function actions:SetRewardListToTail(boolVal)
    if nil == boolVal then
      return
    end
    data.rewardListToTail = boolVal
  end
  
  function actions:SetUIAnimController(val)
    data.animController = val
  end
  
  function actions.SetPage(numVal)
    if not numVal then
      return
    end
    print("BP SetPage new old ", numVal, data.page)
    data.lastPage = data.page
    data.page = numVal
  end
  
  function actions.SetRewardListIdx(numVal)
    if not numVal then
      return
    end
    if numVal < data.rewardListIdx - data.showRewardItemNum + 1 then
      data.rewardListIdx = numVal + data.showRewardItemNum
      return
    end
    data.rewardListIdx = numVal
  end
  
  function actions.SetBigRewardLevel(numVal)
    if not numVal then
      return
    end
    data.bigRewardLevel = numVal
  end
  
  function actions.SetShowLevel(numVal)
    if not numVal then
      return
    end
    data.showLevel = numVal
  end
  
  function actions.SetRollWeaponIdx(numVal)
    if not numVal then
      return
    end
    if numVal > #data.showWeaponRewards then
      data.rollWeaponIdx = 1
      return
    end
    data.rollWeaponIdx = numVal
  end
  
  function actions.SetShowExp(numVal)
    if not numVal then
      return
    end
    data.showExp = numVal
  end
  
  function actions.SetShowWeeklyExp(numVal)
    if not numVal then
      return
    end
    numVal = math.min(numVal, BattlePassDataUtils.GetWeeklyExp(), DT.GetConstant("BPExpWeeklyLimit"))
    data.showWeeklyExp = numVal
  end
  
  function actions.SetRollWeaponIdx(numVal)
    if not numVal then
      return
    end
    if numVal > #data.showWeaponRewards then
      data.rollWeaponIdx = 1
      return
    end
    data.rollWeaponIdx = numVal
  end
  
  return actions
end

local function onSetup(binder, model)
  if BattlePassDataUtils.GetIsFirstEnterBp() then
    RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.BattlePass, RedPointDataUtils.RedAttrType.IsNew)
  end
  binder:BindToRaw(function(_, nVal)
    local interval = DT.GetConstant("BPBigRewardInterval")
    model.SetBigRewardLevel(math.ceil(nVal / interval) * interval)
  end, function()
    return model.rewardListIdx
  end)
end

local BattlePassMainPanelModel = Vue.model("BattlePassMainPanelModel", createBattlePassMainPanelModelState):views(createBattlePassMainPanelModelViews):actions(createBattlePassMainPanelModelActions):setup(onSetup)
return BattlePassMainPanelModel
