local PotencyType = CommonDefine.AwakerPotencyType
local AwakerPotencyEffectType = CommonDefine.AwakerPotencyEffectType
local AwakerSkillMode = CommonDefine.AwakerSkillMode
local AwakerPotencyState = CommonDefine.AwakerPotencyState
local AwakerPage = CommonDefine.AwakerPage
local PotencyEffectType = CommonDefine.PotencyEffectType
local tableInsert = table.insert
local mathFloor = math.floor

local function createAwakerTalentModelState(awakerModel)
  local state = {}
  state.awakerModel = awakerModel
  
  function state.selectAwakerId()
    return state.awakerModel.selectAwakerId
  end
  
  state.lowestPotency = 1
  
  function state.curActivePotencyIndex()
    local awakerTid = state.selectAwakerId
    local awaker = state.awakerModel:GetAwakerData(awakerTid)
    if not awaker then
      return 0
    end
    local curActivePotency = AwakerDataUtils.GetAwakerPotencyIndex(awakerTid, awaker.potency)
    return curActivePotency
  end
  
  function state.nextActivePotencyIndex()
    local nextPotencyIndex = state.curActivePotencyIndex + 1
    if nextPotencyIndex > #state.totalPotencyList then
      nextPotencyIndex = #state.totalPotencyList
    end
    return nextPotencyIndex
  end
  
  state.SpecialPotencyLvs = {
    3,
    6,
    9,
    12,
    15,
    18
  }
  state.selectPotency = 0
  state.selectPotencyIndex = 0
  state.mode = AwakerSkillMode.DBG
  
  function state.maxPotencyIndex()
    do return AwakerDataUtils.GetMaxPotencyIndex end
    return AwakerDataUtils.GetMaxPotencyIndex, state.selectAwakerId
  end
  
  function state.totalPotencyList()
    local list = {}
    local awakerTid = state.selectAwakerId
    if 0 == awakerTid then
      return list
    end
    do return AwakerDataUtils.GetAwakerPotencyList end
    return AwakerDataUtils.GetAwakerPotencyList, awakerTid
  end
  
  function state.potencyList()
    local list = {}
    local tmp = state.totalPotencyList
    for _, potencyData in ipairs(tmp) do
      local potencyConfig = state:GetPotencyConfig(potencyData.tid)
      if potencyConfig and potencyConfig.PotencyType ~= PotencyType.Attr_Promote then
        table.insert(list, potencyData)
      end
    end
    return list
  end
  
  function state.potencyActiveState()
    local potencyIndex = state.selectPotencyIndex
    do return state.GetPotencyActiveState, state end
    return state.GetPotencyActiveState, state, potencyIndex
  end
  
  function state.enoughItemToActive()
    local awakerTid = state.selectAwakerId
    local potencyIndex = state.selectPotencyIndex
    local itemTid = state:GetPotencyCostItemId(awakerTid)
    local needNum = state:GetPotencyCostItemNum(potencyIndex)
    local ownNum = ItemDataUtils.GetItemNum(itemTid)
    return needNum <= ownNum
  end
  
  function state.showPotencyAddAttrs()
    local curActivePotencyIndex = state.curActivePotencyIndex
    local nextActivePotencyIndex = state.nextActivePotencyIndex
    local startIndex = state.attrPotencyStartIndex - 1
    curActivePotencyIndex = math.max(curActivePotencyIndex, startIndex)
    nextActivePotencyIndex = math.max(nextActivePotencyIndex, startIndex + 1)
    local currPotencyData = state.totalPotencyList[curActivePotencyIndex]
    local nextPotencyData = state.totalPotencyList[nextActivePotencyIndex]
    if not currPotencyData or not nextPotencyData then
      return {}
    end
    local awakerTid = state.selectAwakerId
    local currActiveAddAttrs = state:GetPotencyAddAttrs(awakerTid, currPotencyData.tid)
    local nextActiveAddAttrs = state:GetPotencyAddAttrs(awakerTid, nextPotencyData.tid)
    local showList = {}
    local attrRecordTempMap = {}
    for _, attr in ipairs(currActiveAddAttrs) do
      attrRecordTempMap[attr.tid] = table.clone(attr)
    end
    for _, nextAttr in ipairs(nextActiveAddAttrs) do
      if not attrRecordTempMap[nextAttr.tid] then
        attrRecordTempMap[nextAttr.tid] = table.clone(nextAttr)
        attrRecordTempMap[nextAttr.tid].count = 0
      end
      attrRecordTempMap[nextAttr.tid].nextLvCount = nextAttr.count
    end
    for _, attr in pairs(attrRecordTempMap) do
      table.insert(showList, attr)
    end
    
    local function attrSort(a, b)
      local cfgA = DT.ActorAttrType[a.tid]
      local cfgB = DT.ActorAttrType[b.tid]
      local sortA = cfgA.AttributeSort or 0
      local sortB = cfgB.AttributeSort or 0
      return sortA < sortB
    end
    
    table.sort(showList, attrSort)
    return showList
  end
  
  state.hasSelectAttrPotency = false
  
  function state.attrPotencyStartIndex()
    do return AwakerDataUtils.GetAwakerAttrPotencyStartIndex end
    return AwakerDataUtils.GetAwakerAttrPotencyStartIndex, state.selectAwakerId
  end
  
  return state
end

local function createAwakerTalentModellViews(model)
  local views = {}
  
  function views:CheckPotencyValid(potency)
    return potency and 0 ~= potency
  end
  
  function views:GetPotencyConfig(tid)
    do return AwakerDataUtils.GetPotencyConfig end
    return AwakerDataUtils.GetPotencyConfig, tid
  end
  
  function views:GetPotencyAddAttrs(awakerTid, potencyTid)
    if 0 == potencyTid or 0 == awakerTid then
      return {}
    end
    local attrs = AwakerDataUtils.GetPotencyAddAttrs(awakerTid, potencyTid)
    return attrs or {}
  end
  
  function views:GetAwakerPassivePotencyActiveNum(awakerTid)
    do return AwakerDataUtils.GetAwakerPassivePotencyActiveNum end
    return AwakerDataUtils.GetAwakerPassivePotencyActiveNum, awakerTid
  end
  
  function views:GetAwakerPassivePotencyMaxNum(awakerTid)
    do return AwakerDataUtils.GetAwakerPassivePotencyMaxNum end
    return AwakerDataUtils.GetAwakerPassivePotencyMaxNum, awakerTid
  end
  
  function views:GetAwakerAttrPotencyActiveNum(awakerTid)
    do return AwakerDataUtils.GetAwakerAttrPotencyActiveNum end
    return AwakerDataUtils.GetAwakerAttrPotencyActiveNum, awakerTid
  end
  
  function views:GetAwakerAttrPotencyMaxNum(awakerTid)
    do return AwakerDataUtils.GetAwakerAttrPotencyMaxNum end
    return AwakerDataUtils.GetAwakerAttrPotencyMaxNum, awakerTid
  end
  
  function views:GetPotencyActiveState(potencyIndex)
    if 0 == potencyIndex then
      return AwakerPotencyState.Locked
    end
    local nextActivePotencyIndex = self.nextActivePotencyIndex
    if potencyIndex == nextActivePotencyIndex then
      return AwakerPotencyState.Unlocked
    elseif potencyIndex < nextActivePotencyIndex then
      return AwakerPotencyState.Active
    else
      return AwakerPotencyState.Locked
    end
  end
  
  function views:GetPotencyIconPath(potency)
    if not self:CheckPotencyValid(potency) then
      return ""
    end
    local config = self:GetPotencyConfig(potency)
    return config.PotencyIcon
  end
  
  function views:GetPotencyName(potency, mode)
    if not self:CheckPotencyValid(potency) then
      return ""
    end
    local config = self:GetPotencyConfig(potency)
    do return LT.Text end
    return LT.Text, config.PotencyName
  end
  
  function views:GetPotencyDesc(awakerTid, potency, mode, skillModel)
    if not self:CheckPotencyValid(potency) then
      return ""
    end
    local desc = AwakerDataUtils.GetPotencyDesc(awakerTid, potency, mode, skillModel)
    return desc
  end
  
  function views:IsSpecialPotencyLv(potency)
    local isSpecialLv = false
    for _, lv in ipairs(self.SpecialPotencyLvs) do
      if lv == potency then
        isSpecialLv = true
        break
      end
    end
    return isSpecialLv
  end
  
  function views:GetPotencyEffectCfgs(tid, potency, mode)
    local config = self:GetPotencyConfig(tid)
    local modeStr = ""
    if mode then
      modeStr = mode == AwakerSkillMode.DBG and "" or "RPG"
    end
    local key = string.format("%sPotencyAttr%s", modeStr, potency)
    local list = config[key]
    if not list or #list < 2 then
      return
    end
    local isSpecialLv = self:IsSpecialPotencyLv(potency)
    local _effectType = PotencyEffectType.Attr
    local result = {}
    local addNum = isSpecialLv and 3 or 2
    for i = 1, #list, addNum do
      if i + 1 > #list then
        break
      end
      local typeId = list[i]
      local val = list[i + 1]
      local extraVal
      if typeId and val then
        if isSpecialLv then
          _effectType = mathFloor(typeId / 2 + 0.5)
          extraVal = #list >= i + 2 and list[i + 2] or nil
        end
        tableInsert(result, {
          tid = typeId,
          value = val,
          effectType = _effectType,
          extraValue = extraVal
        })
      end
    end
    return result
  end
  
  function views:CanShowDesc(potency)
    if not self:CheckPotencyValid(potency) then
      return false
    end
    local config = self:GetPotencyConfig(potency)
    return config and config.EffectType ~= AwakerPotencyEffectType.Attr_Promote
  end
  
  function views:GetPotencyTypeName(potencyTid)
    do return AwakerDataUtils.GetPotencyTypeName end
    return AwakerDataUtils.GetPotencyTypeName, potencyTid
  end
  
  function views:GetPotencyCostItemId(awakerTid)
    local config = self.awakerModel:GetAwakerConfig(awakerTid)
    return config.AwakerSpecialItem
  end
  
  function views:GetPotencyCostItemNum(potencyIndex)
    if not potencyIndex then
      return
    end
    local costNumList = DT.GetOriginalConstant("AwakerPotencyUpgradeConsumeNum")
    if potencyIndex > #costNumList then
      Logger.Warn("启灵序列大于启灵消耗数量列表")
      return
    end
    return costNumList[potencyIndex]
  end
  
  function views:GetVoiceTrigger()
    local voiceMap = {
      [1] = CommonDefine.AwakerVoiceTrigger.ActivatePotency_1,
      [2] = CommonDefine.AwakerVoiceTrigger.ActivatePotency_2,
      [3] = CommonDefine.AwakerVoiceTrigger.ActivatePotency_3,
      [7] = CommonDefine.AwakerVoiceTrigger.ActivatePotency_4,
      [11] = CommonDefine.AwakerVoiceTrigger.ActivatePotency_5,
      [15] = CommonDefine.AwakerVoiceTrigger.ActivatePotency_6
    }
    return voiceMap[model.curActivePotencyIndex]
  end
  
  function views:GetPotencyItemResource(potency)
    return UI_Awaker_Item_Potency_Point_SmallResource
  end
  
  function views:GetSelectPotency()
    return self.selectPotency
  end
  
  function views:GetSelectPotencyIndex()
    return self.selectPotencyIndex
  end
  
  return views
end

local function createAwakerTalentModellActions(data)
  local actions = {}
  
  function actions:SetSelectPotency(potency)
    if not potency then
      return
    end
    data.selectPotency = potency
  end
  
  function actions:SetSelectPotencyIndex(index)
    if not index then
      return
    end
    data.selectPotencyIndex = index
  end
  
  function actions:SetPotencyMode(mode)
    if not mode then
      return
    end
    data.mode = mode
  end
  
  function actions:SetSelectAttrPotency(select)
    data.hasSelectAttrPotency = select
  end
  
  function actions:ReqActivePotency(awakerTid, cb)
    if data.awakerModel.page ~= AwakerPage.PotencyDetail then
      return
    end
    if data.curActivePotencyIndex >= data.maxPotencyIndex then
      Alert.Show(10433)
      return
    end
    if not data.enoughItemToActive then
      Alert.Show(10441)
      return
    end
    local attrPotencyStartIndex = AwakerDataUtils.GetAwakerAttrPotencyStartIndex(awakerTid)
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "OnPotentiaUpgrade", function(svrData)
      local lastActivePotencyIndex = data.curActivePotencyIndex
      data.awakerModel:UpdatePotency(awakerTid, svrData.potency)
      if lastActivePotencyIndex >= attrPotencyStartIndex and data.nextActivePotencyIndex <= #data.totalPotencyList then
        local nextPotencyIndex = data.nextActivePotencyIndex
        local nextPotency = data.totalPotencyList[nextPotencyIndex]
        self:SetSelectPotency(nextPotency.tid)
        self:SetSelectPotencyIndex(nextPotencyIndex)
      end
      local awakerData = data.awakerModel:GetAwakerData(awakerTid)
      RedPointDataUtils.UpdateAwakerRed(awakerData)
      GlobalDispatcher:Dispatch(NotifyId.OnAwakerPotentiaUpgrade, awakerTid)
      if cb then
        cb()
      end
    end, function()
    end, awakerTid)
  end
  
  return actions
end

local function onSetup(binder, model)
end

local AwakerTalentModel = Vue.model("AwakerTalentModel", createAwakerTalentModelState):views(createAwakerTalentModellViews):actions(createAwakerTalentModellActions):setup(onSetup)
return AwakerTalentModel
