_class("UIForgeData", Object)
UIForgeData = UIForgeData
UIForgeData.qualityColors = {
  Color(0.86, 0.86, 0.86),
  Color(0.51, 0.91, 0.83),
  Color(0.33, 0.62, 0.93),
  Color(0.78, 0.49, 0.93),
  Color(0.98, 0.67, 0.16)
}

function UIForgeData:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.mUIHomeland = self.mHomeland:GetUIModule()
  self.homelandClient = self.mUIHomeland:GetClient()
  self.homeBuildManager = self.homelandClient:BuildManager()
  self.mItem = GameGlobal.GetModule(ItemModule)
  self.accItems = {}
  local cfg_item_forge_accelerate = Cfg.cfg_item_forge_accelerate()
  for _, cfgv in pairs(cfg_item_forge_accelerate) do
    table.insert(self.accItems, {
      itemId = cfgv.ID,
      accSeconds = cfgv.Time
    })
  end
  self.filters = {}
  self.sequnces = {}
  self.listRaw = {}
  self.list = {}
  self.filter = 0
  self.forgeItemPool = {}
  self.tSort = {
    ForgeSortType.Quality,
    true
  }
  self.strsWillGetable = {
    "str_homeland_forge_sequence_done_d_h",
    "str_homeland_forge_sequence_done_d",
    "str_homeland_forge_sequence_done_h_m",
    "str_homeland_forge_sequence_done_h",
    "str_homeland_forge_sequence_done_m"
  }
end

function UIForgeData:Init(clientHomelandInfo)
  self:InitFilterTree()
  local forge_info = clientHomelandInfo.forge_info
  self:InitSequence(forge_info.forge_list)
  self:InitList(forge_info.unlock_architecture_list)
end

function UIForgeData:InitFilterTree()
  local all = ForgeFilter:New()
  all.id = 0
  all.name = StringTable.Get("str_homeland_filter_0")
  self.filters = {all}
  local children = {}
  local cfg_homeland_filter = Cfg.cfg_homeland_filter()
  for _, cfgv in pairs(cfg_homeland_filter) do
    if cfgv.Type == HomelandFilterType.All or cfgv.Type == HomelandFilterType.Forge then
      local f = ForgeFilter:New()
      f.id = cfgv.Filter
      f.name = StringTable.Get(cfgv.Name)
      if cfgv.Parent then
        if not children[cfgv.Parent] then
          children[cfgv.Parent] = {}
        end
        table.insert(children[cfgv.Parent], f)
      else
        table.insert(self.filters, f)
      end
    end
  end
  for _, f in ipairs(self.filters) do
    f.children = children[f.id]
  end
end

function UIForgeData:InitSequence(forge_list)
  local visitInfo = GameGlobal.GetModule(HomelandModule):GetHomelandInfo().visit_int_info
  self.sequnces = {}
  local cfg_homeland_level = Cfg.cfg_homeland_level()
  local sequnceCount = 0
  for k, v in pairs(cfg_homeland_level) do
    if sequnceCount < v.QueueNum then
      sequnceCount = v.QueueNum
    end
  end
  local fogingOrGetables = {}
  for _, v in ipairs(forge_list) do
    fogingOrGetables[v.index] = v
  end
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  for i = 1, sequnceCount do
    local s = ForgeSequence:New()
    s.index = i
    local f = fogingOrGetables[i]
    if f then
      s.forgeItemId = f.item_id
      s.doneTimestamp = f.end_time
      if UICommonHelper.GetNowTimestamp() < f.begin_time then
        svrTimeModule:InitServerTime(f.begin_time)
      end
      if s:IsForging() then
        s.state = ForgeSequenceState.Forging
      else
        s.state = ForgeSequenceState.Getable
      end
      local helpTime = visitInfo.forge_acc_map[i]
      if helpTime then
        s.doneTimestamp = f.end_time - helpTime.offline_help_time
        s.helpRemainTime = math.min(helpTime.help_surplus_time, helpTime.help_once_time)
        local totalHelpTime = Cfg.cfg_item_architecture[s.forgeItemId].HelpAllTime
        s.helpedTime = totalHelpTime - helpTime.help_surplus_time
      end
      s.forgeCount = Cfg.cfg_item_architecture[s.forgeItemId].ForgeStack
    else
      local cfgv = Cfg.cfg_homeland_level[self.mHomeland:GetHomelandLevel()]
      if i <= cfgv.QueueNum then
        s.state = ForgeSequenceState.Idle
      else
        s.state = ForgeSequenceState.Locked
      end
    end
    local cfgs = Cfg.cfg_homeland_level({QueueNum = i})
    if cfgs then
      local level = 999
      for _, cfgv in pairs(cfgs) do
        if level > cfgv.ID then
          level = cfgv.ID
        end
      end
      s.unlockLevel = level
    end
    table.insert(self.sequnces, s)
  end
  self:SortSequence()
end

function UIForgeData:InitList(unlock_architecture_list)
  self.listRaw = {}
  local cfg_item_architecture = Cfg.cfg_item_architecture()
  if cfg_item_architecture then
    for id, cfgv in pairs(cfg_item_architecture) do
      if cfgv.IsForge > 0 then
        local item = self.forgeItemPool[cfgv.ID]
        if not item then
          item = ForgeInfoItem:New()
          self.forgeItemPool[cfgv.ID] = item
        end
        item.id = cfgv.ID
        local cfg_itemv = Cfg.cfg_item[cfgv.ID]
        if cfg_itemv == nil then
          Log.error("UIForgeData:InitList cant find ", cfgv.ID)
        end
        item.name = StringTable.Get(cfg_itemv.Name)
        item.icon = cfgv.Icon
        item.quality = cfg_itemv.Color
        item.filter = cfgv.Filter
        item.size.x = cfgv.Size[1]
        item.size.y = cfgv.Size[2]
        item.livableValue = cfgv.LivableValue
        item.forgeSecond = cfgv.CostTime
        item.max = cfgv.ForgeMaxCount
        if cfgv.SubType == ArchitectureSubType.Dormitory then
          local levelCfg = Cfg.cfg_homeland_level[self.mHomeland:GetHomelandLevel()]
          item.max = math.min(item.max, levelCfg.ForgeDormitoryLimit)
        elseif cfgv.SubType == ArchitectureSubType.Land then
          local levelCfg = Cfg.cfg_homeland_level[self.mHomeland:GetHomelandLevel()]
          item.max = math.min(item.max, levelCfg.ForgeLandLimit)
        end
        item.firstExp = cfgv.ExtraExp or 0
        if cfgv.UnlockDrawing and 0 < cfgv.UnlockDrawing then
          local raUnlock = RoleAsset:New()
          raUnlock.assetid = cfgv.UnlockDrawing
          raUnlock.count = 1
          item.unlockCosts = {raUnlock}
        end
        item.forgeCosts = {}
        if cfgv.Cost then
          for index, cost in ipairs(cfgv.Cost) do
            local ra = RoleAsset:New()
            ra.assetid = cost[1]
            ra.count = cost[2]
            table.insert(item.forgeCosts, ra)
          end
        end
        item.unlocked = false
        if item.unlockCosts and 0 < table.count(item.unlockCosts) then
          for _, unlock_architecture in ipairs(unlock_architecture_list) do
            if unlock_architecture == cfgv.ID then
              item.unlocked = true
              break
            end
          end
        else
          item.unlocked = true
        end
        item.forgeCount = cfgv.ForgeStack
        item:CheckUnlockCostsEnough()
        table.insert(self.listRaw, item)
      end
    end
  end
end

function UIForgeData:GetForgeAccItem()
  local e = self.accItems[1]
  local id = e.itemId
  local seconds = e.accSeconds
  return id, seconds
end

function UIForgeData:GetForgeFilterById(id)
  if self.filters then
    for _, f in ipairs(self.filters) do
      if f.id == id then
        return f
      end
    end
  end
end

function UIForgeData:GetForgeSequenceByIndex(index)
  if self.sequnces then
    for _, s in ipairs(self.sequnces) do
      if s.index == index then
        return s
      end
    end
  end
end

function UIForgeData:HasCanUnlockItem()
  if self.listRaw then
    for _, item in ipairs(self.listRaw) do
      if self:CanItemUnlock(item.id) then
        return true
      end
    end
  end
  return false
end

function UIForgeData:CanItemUnlock(tplId)
  local item = self:GetForgeInfoItemById(tplId)
  if not item.unlocked and item:IsUnlockCostsEnough() then
    return true
  end
  return false
end

function UIForgeData:IsForgeable(item)
  if not item.unlocked then
    return false
  end
  local mapStateCount = self:GetSequenceStateCountMap()
  local countIdle = mapStateCount[ForgeSequenceState.Idle]
  if countIdle == 0 then
    return false
  end
  if not item:IsForgeCostsEnough() then
    return false
  end
  local canCount, max = self:GetCanForgeCountAndMax(item)
  if 0 < max and canCount < 1 then
    return false
  end
  return true
end

function UIForgeData.IsEnough(assetId, cost)
  local count = GameGlobal.GetModule(ItemModule):GetItemCount(assetId)
  local isEnough = cost <= count
  return isEnough
end

function UIForgeData:SortSequence()
  table.sort(self.sequnces, function(a, b)
    local lockeda = a.state == ForgeSequenceState.Locked
    local lockedb = b.state == ForgeSequenceState.Locked
    local idlea = a.state == ForgeSequenceState.Idle
    local idleb = b.state == ForgeSequenceState.Idle
    if lockeda ~= lockedb then
      return not lockeda
    end
    if lockeda then
      return a.unlockLevel < b.unlockLevel
    end
    if idlea ~= idleb then
      return not idlea
    end
    return a.index < b.index
  end)
end

function UIForgeData:FilterList()
  self.list = {}
  for i, v in ipairs(self.listRaw) do
    if self.filter == 0 then
      table.insert(self.list, v)
    elseif v.filter == self.filter then
      table.insert(self.list, v)
    end
  end
  self:SortList()
end

function UIForgeData:SortList()
  table.sort(self.list, function(a, b)
    local aCostEnought = a:IsUnlockCostsEnough() and 0 or 1
    local bCostEnought = b:IsUnlockCostsEnough() and 0 or 1
    if aCostEnought ~= bCostEnought then
      return aCostEnought < bCostEnought
    end
    local compValues = {}
    local ia = a.unlocked and 0 or 1
    local ib = b.unlocked and 0 or 1
    table.insert(compValues, {
      ia,
      ib,
      false
    })
    if self.tSort[1] == ForgeSortType.Quality then
      table.insert(compValues, {
        a.quality,
        b.quality,
        self.tSort[2]
      })
    elseif self.tSort[1] == ForgeSortType.Size then
      local sizea = a.size.x * a.size.y
      local sizeb = b.size.x * b.size.y
      table.insert(compValues, {
        sizea,
        sizeb,
        self.tSort[2]
      })
    end
    table.insert(compValues, {
      a.id,
      b.id,
      false
    })
    return self:Compare(compValues, 1)
  end)
end

function UIForgeData:Compare(compValues, i)
  local cv = compValues[i]
  local l, r, asc = cv[1], cv[2], cv[3]
  if l == r then
    i = i + 1
    if compValues[i] then
      return self:Compare(compValues, i)
    else
      return false
    end
  elseif asc then
    return l > r
  else
    return l < r
  end
end

function UIForgeData:GetForgeInfoItemById(id)
  if self.listRaw then
    for _, item in ipairs(self.listRaw) do
      if item.id == id then
        return item
      end
    end
  end
end

function UIForgeData:Get1stIdleSequence()
  if self.sequnces then
    for _, s in ipairs(self.sequnces) do
      if s.state == ForgeSequenceState.Idle then
        return s
      end
    end
  end
end

function UIForgeData:GetSequenceStateCountMap()
  local mapStateCount = {}
  for _, value in pairs(ForgeSequenceState) do
    mapStateCount[value] = 0
  end
  local using, unlock = 0, 0
  if self.sequnces then
    for _, s in ipairs(self.sequnces) do
      mapStateCount[s.state] = mapStateCount[s.state] + 1
    end
  end
  return mapStateCount
end

function UIForgeData.GetOwnPlaceCount(tplId)
  local own = GameGlobal.GetModule(ItemModule):GetItemCount(tplId)
  local place = 0
  local placedBuildings = GameGlobal.GetModule(HomelandModule):GetUIModule():GetClient():BuildManager():GetBuildings()
  if placedBuildings then
    for _, b in pairs(placedBuildings) do
      if b:GetBuildId() == tplId then
        place = place + 1
      end
    end
  end
  return own, place
end

function UIForgeData.CheckCode(result)
  if result == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    return true
  end
  local msg = StringTable.Get("str_homeland_error_code_" .. result)
  ToastManager.ShowHomeToast(msg)
  return false
end

function UIForgeData:GetCanForgeCountAndMax(item)
  local max = item.max
  local curCount = self:GetItemCount(item)
  local countInSequence = self:GetItemCountInSequence(item)
  local canCount = max - curCount - countInSequence
  return canCount, max
end

function UIForgeData:GetItemCount(item)
  local count = self.mItem:GetItemCount(item.id)
  return count
end

function UIForgeData:GetItemCountInSequence(item)
  local count = 0
  if self.sequnces then
    for _, s in ipairs(self.sequnces) do
      if s.forgeItemId == item.id then
        count = count + 1
      end
    end
  end
  return count
end

function UIForgeData:ResetSort()
  self.tSort = {
    ForgeSortType.Quality,
    true
  }
end

function UIForgeData:IsUnforged(id)
  local homelandInfo = self.mHomeland:GetHomelandInfo()
  local already_forge_list = homelandInfo.forge_info.already_forge_list
  if already_forge_list and table.ikey(already_forge_list, id) then
    return false
  end
  for i = 1, #self.sequnces do
    if self.sequnces[i].forgeItemId == id then
      return false
    end
  end
  return true
end

function UIForgeData:GetAllUnlockableItem()
  local items = {}
  for _, item in ipairs(self.listRaw) do
    if not item.unlocked and item:IsUnlockCostsEnough() then
      items[#items + 1] = item
    end
  end
  return items
end

_enum("ForgeSortType", {Quality = 1, Size = 2})
ForgeSortType = ForgeSortType
_class("ForgeFilter", Object)
ForgeFilter = ForgeFilter

function ForgeFilter:Constructor()
  self.id = 0
  self.name = ""
  self.children = {}
end

function ForgeFilter:GetChildById(id)
  if self.children then
    for _, c in ipairs(self.children) do
      if c.id == id then
        return c
      end
    end
  end
end

function ForgeFilter:HasChildren()
  if self.children and table.count(self.children) > 0 then
    return true
  end
end

_class("ForgeSequence", Object)
ForgeSequence = ForgeSequence

function ForgeSequence:Constructor()
  self.index = 0
  self.state = ForgeSequenceState.Locked
  self.unlockLevel = 0
  self.doneTimestamp = 0
  self.forgeItemId = 0
  self.forgeCount = 1
end

function ForgeSequence:IsForging()
  if self.doneTimestamp > 0 then
    local leftSecond = UICommonHelper.CalcLeftSeconds(self.doneTimestamp)
    if 0 < leftSecond then
      return true
    end
  end
  return false
end

_enum("ForgeSequenceState", {
  Locked = 1,
  Idle = 2,
  Forging = 3,
  Getable = 4
})
ForgeSequenceState = ForgeSequenceState
_class("ForgeInfoItem", Object)
ForgeInfoItem = ForgeInfoItem

function ForgeInfoItem:Constructor()
  self.id = 0
  self.name = ""
  self.icon = ""
  self.quality = 0
  self.filter = 0
  self.size = Vector2.zero
  self.livableValue = 0
  self.forgeSecond = 0
  self.unlockCosts = {}
  self.forgeCosts = {}
  self.unlocked = false
  self.max = -1
  self.firstExp = 0
  self._unlockCostEnought = false
end

function ForgeInfoItem:IsUnlockCostsEnough()
  return self._unlockCostEnought
end

function ForgeInfoItem:CheckUnlockCostsEnough()
  if self.unlocked then
    self._unlockCostEnought = false
    return self._unlockCostEnought
  end
  if self.unlockCosts and table.count(self.unlockCosts) > 0 then
    for _, cost in ipairs(self.unlockCosts) do
      if not UIForgeData.IsEnough(cost.assetid, cost.count) then
        self._unlockCostEnought = false
        return self._unlockCostEnought
      end
    end
  end
  self._unlockCostEnought = true
  return self._unlockCostEnought
end

function ForgeInfoItem:IsForgeCostsEnough()
  if self.forgeCosts and table.count(self.forgeCosts) > 0 then
    for _, cost in ipairs(self.forgeCosts) do
      if not UIForgeData.IsEnough(cost.assetid, cost.count) then
        return false
      end
    end
  end
  return true
end
