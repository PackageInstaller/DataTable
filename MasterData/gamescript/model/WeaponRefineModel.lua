local function createWeaponRefineState(weapon, awakerWeaponModel)
  local state = {}
  
  state.weapon = weapon
  state.awakerWeaponModel = awakerWeaponModel
  state.playRefineAnim = nil
  
  function state.weaponConfig()
    return DT.Item[state.weapon.tid]
  end
  
  return state
end

local function createWeaponRefineViews(data)
  local views = {}
  
  function views:GetWeaponlevel()
    if self.weapon == nil then
      return 0
    end
    return self.weapon.level or 0
  end
  
  function views:IsPlayRefineAnim()
    return self.playRefineAnim
  end
  
  function views:GetWeaponName()
    if self.weaponConfig == nil then
      return ""
    end
    do return LT.Text end
    return LT.Text, self.weaponConfig.Name
  end
  
  function views:IsLevelMax()
    if self.weapon == nil then
      return false
    end
    local refineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
    local refineStage2MaxLevel = DT.GetConstant("WeaponRefineAttrNum")
    local refineMaxLevel = refineStage1MaxLevel + refineStage2MaxLevel
    return self.weapon.level == refineMaxLevel
  end
  
  function views:GetBackTrackEndTime()
    do return end
    return BackTrackDataUtils.GetEndTime
  end
  
  function views:IsCostMoney()
    return not ZoneFeatureUtils.IsWeaponAutoRefine()
  end
  
  function views:GetMoneyCost()
    if not self:IsCostMoney() then
      return 0
    end
    return DT.GetConstant("Weapon_LevelUp_Cost") * data.awakerWeaponModel.curSelectItemNum
  end
  
  function views:IsMoneyEnough()
    local cost = self:GetMoneyCost()
    local totalMoneyItem = ItemDataUtils.GetItemByTid(CommonDefine.CurrencyType.JuniorMoney)
    local totalMoney = nil ~= totalMoneyItem and totalMoneyItem.num or 0
    return cost <= totalMoney
  end
  
  function views:GetMonenyDesc()
    if self:IsMoneyEnough() then
      do return self.GetMoneyCost end
      return self.GetMoneyCost, self, nil, nil
    else
      do return string.format, "<Color4:%d>", self:GetMoneyCost() end
      return string.format, "<Color4:%d>", self:GetMoneyCost()
    end
  end
  
  function views:IsMoneySufficient()
    local totalMoneyItem = ItemDataUtils.GetItemByTid(CommonDefine.CurrencyType.JuniorMoney)
    local totalMoney = nil ~= totalMoneyItem and totalMoneyItem.num or 0
    return totalMoney >= self:GetMoneyCost()
  end
  
  function views:GetSelectedMaterial()
    return self.awakerWeaponModel.selectedCostItemGroup
  end
  
  function views:HasLockedCostItem()
    for _, costItem in pairs(self.awakerWeaponModel.selectedCostItemGroup) do
      local checkItem = ItemDataUtils.GetItemByUid(costItem.uid)
      if checkItem.locked then
        return true
      end
    end
    return false
  end
  
  function views:GetCurLevelDesc()
    if self.weapon == nil then
      return ""
    end
    do return SkillUtils.GetWeaponStateDesc, self.weapon.tid end
    return SkillUtils.GetWeaponStateDesc, self.weapon.tid, self.weapon.level or 0
  end
  
  function views:GetLevelDesc(level)
    if self.weapon == nil or nil == level then
      return ""
    end
    do return SkillUtils.GetWeaponStateDesc, self.weapon.tid end
    return SkillUtils.GetWeaponStateDesc, self.weapon.tid, level
  end
  
  function views:GetShowTipMaterial()
    do return ItemDataUtils.GetItemByUid end
    return ItemDataUtils.GetItemByUid, self.awakerWeaponModel.showTipUid
  end
  
  function views:GetNextLevelDesc()
    if self.weapon == nil then
      return ""
    end
    local level = self.weapon.level or 0
    do return SkillUtils.GetWeaponStateDesc, self.weapon.tid end
    return SkillUtils.GetWeaponStateDesc, self.weapon.tid, level + 1
  end
  
  function views:CanBeRefined()
    local materialGroup = self:GetSelectedMaterial()
    if 0 == #materialGroup then
      return false
    end
    do return self.IsMoneySufficient end
    return self.IsMoneySufficient, self
  end
  
  function views:GetAwakerWeaponModel()
    return self.awakerWeaponModel
  end
  
  function views:GetRewardPreview(Tag)
    return data.previewReward[Tag]
  end
  
  return views
end

local function createWeaponRefineActions(data)
  local actions = {}
  
  function actions:SetWeapon(weapon)
    data.weapon = weapon
  end
  
  function actions:SetPlayRefineAnim(playing)
    data.playRefineAnim = playing
  end
  
  function actions:SetPreviewData(serverData)
    local weaponList = {}
    local advanceList = {}
    data.previewReward = {}
    data.previewReward[CommonDefine.BackTrackWeaponType.Weapon] = weaponList
    data.previewReward[CommonDefine.BackTrackWeaponType.Advance] = advanceList
    for tag, tagData in pairs(serverData) do
      local mergedItems = {}
      for itemTid, itemData in pairs(tagData) do
        if itemData.num > 0 then
          local tid = itemData.tid
          if mergedItems[tid] then
            mergedItems[tid].itemCount = mergedItems[tid].itemCount + itemData.num
          else
            mergedItems[tid] = {
              tid = tid,
              itemTid = tid,
              itemCount = itemData.num
            }
          end
        end
      end
      for _, item in pairs(mergedItems) do
        table.insert(data.previewReward[tag], item)
      end
    end
    table.sort(weaponList, function(a, b)
      do return ItemDataUtils.CommonItemSortFunc, a end
      return ItemDataUtils.CommonItemSortFunc, a, b
    end)
    table.sort(advanceList, function(a, b)
      do return ItemDataUtils.CommonItemSortFunc, a end
      return ItemDataUtils.CommonItemSortFunc, a, b
    end)
  end
  
  function actions:ReqPreviewWeaponBacktrackItems(callback)
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "PreviewWeaponBacktrackItems", function(serverData)
      if serverData then
        self:SetPreviewData(serverData)
        if callback then
          callback()
        end
      end
    end, function(_, code)
      Logger.Error("[命轮回溯] 预览奖励失败！错误码: %s", code.code)
    end, data.weapon.uid)
  end
  
  function actions:ReqRefineWeapon(callback)
    local sendParam = {}
    for _, costItem in pairs(data.awakerWeaponModel.selectedCostItemGroup) do
      sendParam[costItem.uid] = costItem.num
    end
    local weaponMtrlUid = {}
    local nonWeaponMtrlCountInfo = {}
    for uid, num in pairs(sendParam) do
      local item = ItemDataUtils.GetItemByUid(uid)
      local itemCfg = DT.Item[item.tid]
      if itemCfg.Type == CommonDefine.ItemType.Weapon then
        table.insert(weaponMtrlUid, uid)
      elseif itemCfg.Type == CommonDefine.ItemType.Material then
        table.insert(nonWeaponMtrlCountInfo, {
          tid = item.tid,
          totalCnt = ItemDataUtils.GetItemNum(item.tid),
          selectCnt = num
        })
      end
    end
    ProtoManager.Instance:ReqServer("GameRequest", "OnAdvanceWeapon", function(svrData)
      local itemList = svrData.itemlist
      for _, uid in ipairs(weaponMtrlUid) do
        local item = ItemDataUtils.GetItemByUid(uid)
        if item then
          itemList = itemList or {}
          table.insert(itemList, {
            tid = item.tid,
            num = item.num,
            uid = item.uid
          })
        end
      end
      for _, info in ipairs(nonWeaponMtrlCountInfo) do
        local consumedCnt = info.totalCnt - ItemDataUtils.GetItemNum(info.tid)
        if consumedCnt < info.selectCnt then
          itemList = itemList or {}
          table.insert(itemList, {
            tid = info.tid,
            num = info.selectCnt - consumedCnt
          })
        end
      end
      self:SetPlayRefineAnim(true)
      if callback then
        callback(itemList)
        if data.awakerWeaponModel.refineSuccessCallback then
          data.awakerWeaponModel.refineSuccessCallback()
        end
      end
    end, function()
    end, data.weapon.uid, sendParam)
  end
  
  return actions
end

local function onSetup(binder, model)
  model.awakerWeaponModel:SetShowTipUid(0)
end

local WeaponRefineModel = Vue.model("WeaponRefineModel", createWeaponRefineState):views(createWeaponRefineViews):actions(createWeaponRefineActions):setup(onSetup)
return WeaponRefineModel
