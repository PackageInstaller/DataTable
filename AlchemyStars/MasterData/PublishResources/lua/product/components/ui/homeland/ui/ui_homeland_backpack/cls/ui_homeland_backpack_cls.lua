_class("UIHomelandBackpackData", Object)
UIHomelandBackpackData = UIHomelandBackpackData
local TABLE_CLEAR = table.clear

function UIHomelandBackpackData:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.mUIHomeland = self.mHomeland:GetUIModule()
  self.homelandClient = self.mUIHomeland:GetClient()
  self.homeBuildManager = self.homelandClient:BuildManager()
  self.mItem = GameGlobal.GetModule(ItemModule)
  self.mRole = GameGlobal.GetModule(RoleModule)
  self.filters = {}
  self.list = {}
  self.mapRed = {}
  self.toolRed = {}
  self.toolTabType = 2
end

function UIHomelandBackpackData:Init()
  local clientHomelandInfo = self.mHomeland.m_homeland_info
  self:InitFilter()
  self:InitList()
end

function UIHomelandBackpackData:InitFilter()
  self.filters = {}
  self.mapRed = {}
  local cfg_item = Cfg.cfg_item()
  for _, cfgv in pairs(cfg_item) do
    local filter = cfgv.TabType
    if filter and not self.filters[filter] then
      self.filters[filter] = HomelandBackpackFilter:New(filter)
      self.mapRed[filter] = {}
    end
  end
end

function UIHomelandBackpackData:InitList()
  local listAll = self.mItem:GetAllInBagItemInfos()
  self.list = {}
  TABLE_CLEAR(self.toolRed)
  for _, item in ipairs(listAll) do
    local tpl = item:GetTemplate()
    local showType = tpl.ShowType or 1
    if showType & 2 == 2 then
      local filter = tpl.TabType
      local filteredItems = self.mapRed[filter]
      local tplId = item:GetTemplateID()
      local pstID = item:GetID()
      if filteredItems then
        local cfg_item = Cfg.cfg_item[tplId]
        if cfg_item and cfg_item.ShowNew and cfg_item.ShowNew == 1 and item:IsHomelandNew() then
          filteredItems[pstID] = true
        else
          filteredItems[pstID] = nil
        end
        table.insert(self.list, item)
      else
        Log.warn("### invalid filter. filter = ", filter)
      end
      if filter == self.toolTabType then
        if self:_CheckLevelup(tplId) == true then
          self.toolRed[pstID] = true
        else
          self.toolRed[pstID] = nil
        end
      end
    end
  end
  self.mItem:SortItems(self.list)
end

function UIHomelandBackpackData:_CheckLevelup(tplId)
  local cfg_item_tool_upgrade = Cfg.cfg_item_tool_upgrade[tplId]
  if not cfg_item_tool_upgrade then
    return false
  end
  local cfgCost = cfg_item_tool_upgrade.Cost
  if not cfgCost then
    return false
  end
  for _, value in ipairs(cfgCost) do
    local assetid = value[1]
    local cost = value[2]
    local c = self.mRole:GetAssetCount(assetid) or 0
    if cost > c then
      return false
    end
  end
  return true
end

function UIHomelandBackpackData:GetFilterById(id)
  if self.filters then
    for _, f in pairs(self.filters) do
      if f.id == id then
        return f
      end
    end
  end
end

function UIHomelandBackpackData:GetItemById(id)
  if self.list then
    for _, item in ipairs(self.list) do
      if id == item:GetID() then
        return item
      end
    end
  end
end

function UIHomelandBackpackData.IsEnough(assetId, cost)
  local count = GameGlobal.GetModule(ItemModule):GetItemCount(assetId)
  local isEnough = cost <= count
  return isEnough
end

function UIHomelandBackpackData:Compare(compValues, i)
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

function UIHomelandBackpackData.CheckCode(result)
  if result == HomeLandErrorType.E_HOME_LAND_TYPE_SUCCESS then
    return true
  end
  local msg = StringTable.Get("str_homeland_error_code_" .. result)
  ToastManager.ShowHomeToast(msg)
  return false
end

function UIHomelandBackpackData:GetHomelandBackpackToolItemByTplId(tplId)
  if not self.toolItems then
    self.toolItems = {}
  end
  local tpl = Cfg.cfg_item[tplId]
  if tpl and tpl.TabType == 2 then
    if not self.toolItems[tplId] then
      self.toolItems[tplId] = HomelandBackpackToolItem:New(tplId)
    end
    return self.toolItems[tplId]
  else
    Log.warn("### ", tplId)
  end
end

function UIHomelandBackpackData:GetHomelandPathItemDataListByTplId(tplId)
  if not self.mapItemGetPaths then
    self.mapItemGetPaths = {}
  end
  local itemGetPaths = self.mapItemGetPaths[tplId]
  if itemGetPaths then
    return itemGetPaths
  else
    self.mapItemGetPaths[tplId] = {}
    local cfg_item_gift = Cfg.cfg_item_gift({
      ItemGiftType = ItemGiftType.ItemGiftType_Choose
    })
    if cfg_item_gift then
      for key, cfgv in pairs(cfg_item_gift) do
        local tplId = cfgv.ID
        local count = self.mItem:GetItemCount(tplId)
        if 0 < count then
          local itemList = cfgv.ItemList
          for _, ids in ipairs(itemList) do
            local id = ids[1]
            if id == tplId then
              local t = UIHomelandGetPathItemData:New()
              t:SetGiftWay(tplId)
              table.insert(self.mapItemGetPaths[tplId], t)
              break
            end
          end
        end
      end
    end
    local cfg_item_getway = Cfg.cfg_item_getway[tplId]
    if cfg_item_getway then
      local count = table.count(cfg_item_getway)
      for i = 1, count - 1 do
        local cfgv = cfg_item_getway["Getway" .. i]
        if cfgv then
          local t = UIHomelandGetPathItemData:New()
          t:SetData(cfgv)
          if t:CheckChapter() then
            table.insert(self.mapItemGetPaths[tplId], t)
          end
        end
      end
    end
  end
  return self.mapItemGetPaths[tplId]
end

function UIHomelandBackpackData:IsNew()
  if self.mapRed then
    for filter, red in pairs(self.mapRed) do
      if self:IsFilterNew(filter) then
        return true
      end
    end
  end
  return false
end

function UIHomelandBackpackData:IsFilterNew(filter)
  if self.mapRed then
    local mapFilter = self.mapRed[filter]
    if mapFilter then
      for pstId, b in pairs(mapFilter) do
        if self:IsItemNew(filter, pstId) then
          return true
        end
      end
    end
  end
  if filter == self.toolTabType then
    for _, item in ipairs(self.list) do
      local tpl = item:GetTemplate()
      if tpl.TabType == filter then
        local pstId = item:GetID()
        if self:IsItemNew(filter, pstId) then
          return true
        end
      end
    end
  end
end

function UIHomelandBackpackData:IsItemNew(filter, pstId)
  if self.mapRed then
    local mapFilter = self.mapRed[filter]
    if mapFilter then
      local b = mapFilter[pstId]
      if b then
        return true
      end
    end
  end
  if filter == self.toolTabType and self.toolRed[pstId] then
    return true
  end
  return false
end

function UIHomelandBackpackData:IsItemLvSatisfy(pstId)
  if self.toolRed[pstId] then
    return true
  end
  return false
end

function UIHomelandBackpackData:UnnewItem(filter, pstId)
  if self.mapRed then
    local mapFilter = self.mapRed[filter]
    if mapFilter then
      mapFilter[pstId] = nil
    end
  end
end

_class("HomelandBackpackFilter", Object)
HomelandBackpackFilter = HomelandBackpackFilter

function HomelandBackpackFilter:Constructor(filter)
  self.id = filter
  self.name = StringTable.Get("str_homeland_backpack_filter_" .. filter)
end

_class("HomelandBackpackToolItem", Object)
HomelandBackpackToolItem = HomelandBackpackToolItem

function HomelandBackpackToolItem:Constructor(tplId)
  self.tplId = tplId
  local cfg_item_tool_upgrade = Cfg.cfg_item_tool_upgrade[tplId]
  if not cfg_item_tool_upgrade then
    Log.error("### no data in cfg_item_tool_upgrade.", tplId)
    return
  end
  self.type = cfg_item_tool_upgrade.ToolType
  self.param = cfg_item_tool_upgrade.param
  self.lv = cfg_item_tool_upgrade.Level
  self.tplIdNextLv = cfg_item_tool_upgrade.Output
  self.cost = {}
  local cfgCost = cfg_item_tool_upgrade.Cost
  if cfgCost then
    for index, value in ipairs(cfgCost) do
      local ra = RoleAsset:New()
      ra.assetid = value[1]
      ra.count = value[2]
      table.insert(self.cost, ra)
    end
  end
end

function HomelandBackpackToolItem:IsLevelMax()
  if self.tplIdNextLv then
    local b = self.tplIdNextLv <= 0
    return b
  end
end

function HomelandBackpackToolItem:IsCostEnough()
  if self.cost and table.count(self.cost) > 0 then
    for _, c in ipairs(self.cost) do
      if not UIForgeData.IsEnough(c.assetid, c.count) then
        return false
      end
    end
  end
  return true
end

_enum("HomelandBackpackToolItemType", {
  Axe = 1,
  FishingRod = 2,
  End = -1
})
HomelandBackpackToolItemType = HomelandBackpackToolItemType
_class("UIHomelandGetPathItemData", UICustomWidget)
UIHomelandGetPathItemData = UIHomelandGetPathItemData

function UIHomelandGetPathItemData:Constructor()
end

function UIHomelandGetPathItemData:SetData(cfg)
  self.type = tonumber(cfg[1])
  if self.type == GetWayItemType.Text then
    self.desc = cfg[2]
  elseif self.type == GetWayItemType.Jump then
    self.desc = cfg[2]
    self.jumpId = tonumber(cfg[3])
  end
  self.randomType = tonumber(cfg[4])
end

function UIHomelandGetPathItemData:SetGiftWay(tplId)
  self.type = GetWayItemType.Use
  self.useItemId = tplId
  local cfg = Cfg.cfg_item[self.useItemId]
  if not cfg then
    Log.error("###[UIHomelandGetPathItemData] cfg is nil ! id --> ", self.useItemId)
  end
  self.desc = cfg.Name
end

function UIHomelandGetPathItemData:CheckChapter()
  if self.type == GetWayItemType.Jump then
    local mMission = GameGlobal.GetModule(MissionModule)
    local discoveryData = mMission:GetDiscoveryData()
    if self.desc == "str_item_get_discovery" then
      local chapter = discoveryData:GetChapterByStageId(self.jumpId)
      if chapter then
        return true
      else
        return false
      end
    end
  end
  return true
end

function UIHomelandGetPathItemData:GetDesc()
  local strDesc = StringTable.Get(self.desc)
  local strDesc1 = self:CreateGetWayString(strDesc, self.jumpId)
  local enable, extraStr = self:CheckEnable(self.jumpId)
  local randomText
  if self.type == GetWayItemType.Use then
    local count = self.mItem:GetItemCount(self.useItemId)
    randomText = StringTable.Get("str_item_public_get_path_owned", count)
  else
    randomText = UIEnum.ItemRandomStr(self.randomType)
  end
  if not string.isnullorempty(randomText) then
    randomText = "【" .. randomText .. "】"
  end
  local strDesc1 = strDesc1 .. extraStr
  return strDesc1
end

function UIHomelandGetPathItemData:CreateGetWayString(str, jumpId)
  local cfg = Cfg.cfg_jump[jumpId]
  if cfg and cfg.JumpID == UIJumpType.UI_JumpMission then
    local missionId = cfg.JumpParam[1]
    local cfg_mission = Cfg.cfg_mission[missionId]
    local strStageIdx = DiscoveryStage.GetStageIndexString(missionId)
    local strStageName = StringTable.Get(cfg_mission.Name)
    local args = {
      strStageIdx .. " " .. strStageName
    }
    if args then
      for i = 1, #args do
        local p = "{" .. tostring(i - 1) .. "}"
        str = string.gsub(str, p, args[i])
      end
    end
  end
  return str
end

function UIHomelandGetPathItemData:CheckEnable(jumpId)
  local cfg = Cfg.cfg_jump[jumpId]
  local unlock = true
  local extraStr = ""
  if cfg then
    local jumpType = cfg.JumpID
    if jumpType == UIJumpType.UI_JumpMission then
      local missionId = cfg.JumpParam[1]
      local mission_md = self:GetModule(MissionModule)
      local _, _unlock = mission_md:GetMissionGetWayDetails(missionId)
      unlock = _unlock
    else
      local jumpModule = self:GetModule(QuestModule).uiModule
      local unLockIDs = jumpModule:GetUnLockId(jumpType)
      if unLockIDs then
        local module = GameGlobal.GetModule(RoleModule)
        for index, unLockID in ipairs(unLockIDs) do
          local u = module:CheckModuleUnlock(unLockID)
          if u == false then
            unlock = false
            break
          end
        end
        if unlock and jumpType == UIJumpType.UI_JumpAircraft then
          local jumpSpace = cfg.JumpParam[1]
          if jumpSpace == OpenAircraftParamType.Spaceid then
            local spaceId = cfg.JumpParam[2]
            local aircraftModule = self:GetModule(AircraftModule)
            if 0 < spaceId then
              local state = aircraftModule:GetSpaceStatus(spaceId)
              if state and state == SpaceState.SpaceStateFull then
                local room = aircraftModule:GetRoom(spaceId)
                if room and room:GetRoomType() == AirRoomType.SmeltRoom then
                  local matid = self.tplId
                  local lock = aircraftModule:IsSmeltItemLock(matid)
                  if lock then
                    unlock = false
                  end
                end
              else
                unlock = false
              end
            end
          end
        end
      end
    end
  end
  if not unlock then
    extraStr = StringTable.Get("str_item_get_lock")
  end
  return unlock, extraStr
end
