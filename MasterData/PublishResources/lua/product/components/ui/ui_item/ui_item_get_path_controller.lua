_class("UIItemGetPathController", UIController)
UIItemGetPathController = UIItemGetPathController
local GetWayItemType = {
  Jump = 1,
  Text = 2,
  Use = 3,
  EC = 4,
  GetWayIntroduce = 5
}
_enum("GetWayItemType", GetWayItemType)

function UIItemGetPathController:OnShow(uiParams)
  self._itemModule = GameGlobal.GetModule(ItemModule)
  self._itemid = uiParams[1]
  self._itemCondition = uiParams[4]
  self._txtItemName = self:GetUIComponent("UILocalizationText", "txt_item_name")
  self._imageItemIcon = self:GetUIComponent("RawImageLoader", "image_item_icon")
  self._txtItemSimpleDesc = self:GetUIComponent("UILocalizationText", "txt_item_simple_desc")
  self._itemCount = self:GetUIComponent("UILocalizationText", "itemCount")
  self._itemCountPerRow = 1
  self._noPath = self:GetGameObject("noPath")
  self._poolGo = self:GetGameObject("GetWayList")
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "GetWayList")
  local cfg = Cfg.cfg_item[self._itemid]
  if cfg == nil then
    Log.fatal("[item] error --> cfg_item is nil ! id --> " .. self._itemid)
    return
  end
  self._imageItemIcon:LoadImage(cfg.Icon)
  self._txtItemName:SetText(StringTable.Get(cfg.Name))
  self._txtItemSimpleDesc:SetText(StringTable.Get(cfg.Intro))
  self:AttachEvent(GameEventType.CloseUIBackPackBox, self.OnValue)
  self:AttachEvent(GameEventType.OnSerialAutoFightSweepFinish, self.OnSweepFinish)
  self:OnValue()
  local jumpData = GameGlobal.GetModule(SerialAutoFightModule):GetJumpData()
  jumpData:Track_Item(self._itemid, self._itemCondition)
end

function UIItemGetPathController:OnSweepFinish()
  self:OnValue()
end

function UIItemGetPathController:_InitSrollView()
  if self._scrollviewInited then
    self._scrollView:SetListItemCount(self._listItemTotalCount)
    self._scrollView:MovePanelToItemIndex(0, 0)
  else
    self._scrollView:InitListView(self._listItemTotalCount, function(scrollView, index)
      return self:InitPathListInfo(scrollView, index)
    end)
    self._scrollviewInited = true
  end
end

function UIItemGetPathController:InitPathListInfo(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIItemGetPathControllerItem", 1)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, #rowList do
    local item = rowList[i]
    local itemIndex = index * 1 + i
    if itemIndex > self._listItemTotalCount then
      item:GetGameObject():SetActive(false)
    else
      item:GetGameObject():SetActive(true)
      self:ShowPathItem(item, itemIndex)
    end
  end
  return item
end

function UIItemGetPathController:ShowPathItem(item, index)
  local way = self:_GetGetWay(index)
  if way then
    self._needNum = self._needNum == nil and 1 or self._needNum
    item:SetData(way, index, self._itemid, self._needNum, self._needNumRawData)
  end
end

function UIItemGetPathController:OnHide()
  self:DetachEvent(GameEventType.CloseUIBackPackBox, self.OnValue)
  local jumpData = GameGlobal.GetModule(SerialAutoFightModule):GetJumpData()
  jumpData:Track_Item()
end

function UIItemGetPathController:_CalcNeedItem()
  if self._itemCondition then
    self._needNum = self:GetGapValue()
    self._needNumRawData = self._needNum
  end
end

function UIItemGetPathController:GetTargetItem()
  return {
    self._itemid,
    self._itemCondition
  }
end

function UIItemGetPathController:OnValue()
  self:_CalcNeedItem()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local c = roleModule:GetAssetCount(self._itemid)
  self._itemCount:SetText(c)
  local ways = self:GetWay()
  self._itemGetWay = {}
  for i = 1, #ways do
    local v = ways[i]
    local _useItemId = v.useItemId
    local _useItemCount = v.useItemCount
    local tmp = StringTable.Get(v.desc)
    if v.type == GetWayItemType.EC then
      tmp = v.desc
    else
      tmp = StringTable.Get(v.desc)
    end
    local jumpid = v.jumpId
    local tmp_desc = self:CreateGetWayString(tmp, jumpid)
    local _enable, extraStr = self:CheckEnable(jumpid)
    local randomText
    if v.type == GetWayItemType.Use or v.type == GetWayItemType.EC then
      local count = self._itemModule:GetItemCount(_useItemId)
      randomText = StringTable.Get("str_item_public_get_path_owned", count)
    else
      randomText = UIEnum.ItemRandomStr(v.randomType)
    end
    if not string.isnullorempty(randomText) then
      randomText = "【" .. randomText .. "】"
    end
    local isSmeltRoom, str, conform = self:SpecialGetWayInfo(jumpid, self._itemid)
    local smeltRoomInfo
    if isSmeltRoom then
      randomText = str
      _enable = true
      smeltRoomInfo = {}
      smeltRoomInfo.isSmeltRoom = isSmeltRoom
      smeltRoomInfo.conform = conform
    else
      tmp_desc = tmp_desc .. extraStr
    end
    table.insert(self._itemGetWay, {
      way = v.type,
      useItemId = _useItemId,
      useItemCount = _useItemCount,
      desc = tmp_desc,
      enabled = _enable,
      jumpId = jumpid,
      randomText = randomText,
      smeltRoomInfo = smeltRoomInfo
    })
  end
  self._listItemTotalCount = table.count(self._itemGetWay)
  self._noPath:SetActive(self._listItemTotalCount <= 0)
  self._poolGo:SetActive(self._listItemTotalCount > 0)
  if self._itemCondition then
    self._needNum = self:GetGapValue()
  end
  self:_InitSrollView()
end

function UIItemGetPathController:SpecialGetWayInfo(jumpId, useItemId)
  local randomText = ""
  local cfg = Cfg.cfg_jump[jumpId]
  local isSmeltRoom = false
  local conform = false
  local spaceId
  if cfg then
    local jumpType = cfg.JumpID
    if jumpType == UIJumpType.UI_JumpAircraft then
      local jumpSpace = cfg.JumpParam[1]
      if jumpSpace == OpenAircraftParamType.Spaceid then
        spaceId = cfg.JumpParam[2]
        if spaceId == AircraftLayer.Smelt then
          isSmeltRoom = true
        end
      end
    end
  end
  if isSmeltRoom then
    local aircraftModule = self:GetModule(AircraftModule)
    local state = aircraftModule:GetSpaceStatus(spaceId)
    if state and state >= SpaceState.SpaceStateFull then
      local lv, param = aircraftModule:GetMaterialInfoByOutPutId(useItemId)
      local room = aircraftModule:GetSmeltRoom()
      if param ~= nil and param > room:Level() then
        randomText = StringTable.Get("str_item_public_smeltroom_lv_limit", param)
      else
        conform = true
        randomText = StringTable.Get("str_item_public_smeltroom_unlock_tip")
      end
    else
      randomText = StringTable.Get("str_item_public_smeltroom_lock_tip")
    end
  end
  local module = GameGlobal.GetModule(RoleModule)
  local unLock = module:CheckModuleUnlock(GameModuleID.MD_Aircraft)
  if not unLock then
    randomText = StringTable.Get("str_item_public_aircraft_lock_tip")
  end
  return isSmeltRoom, randomText, conform
end

function UIItemGetPathController:GetWay()
  local ways = {}
  self:InsertGiftWay(ways)
  local cfg = Cfg.cfg_item_getway[self._itemid]
  if cfg then
    local count = table.count(cfg)
    for i = 1, count - 1 do
      local id = cfg["Getway" .. tostring(i)]
      if id then
        local t = UIItemGetWayData:New()
        t:SetData(id)
        if t:CheckChapter() then
          table.insert(ways, t)
        end
      end
    end
  end
  self:InsertCommonEC(ways)
  return ways
end

function UIItemGetPathController:InsertCommonEC(ways)
  local cfg = Cfg.cfg_petawakening_common_exchange[self._itemid]
  if cfg then
    local needRoleAsset = cfg.NeedRoleAsset
    if needRoleAsset and table.count(needRoleAsset) > 0 then
      for i = 1, #needRoleAsset do
        local data = needRoleAsset[i]
        local id = data[1]
        local count = data[2]
        local t = UIItemGetWayData:New()
        t:SetECWay(id, count)
        table.insert(ways, t)
      end
    end
  end
end

function UIItemGetPathController:InsertGiftWay(ways)
  local cfg_item_gift = Cfg.cfg_item_gift({
    ItemGiftType = ItemGiftType.ItemGiftType_Choose
  })
  if cfg_item_gift and 0 < #cfg_item_gift then
    for i = 1, #cfg_item_gift do
      local cfg = cfg_item_gift[i]
      local itemid = cfg.ID
      local count = self._itemModule:GetItemCount(itemid)
      if 0 < count then
        local itemList = cfg.ItemList
        for j = 1, #itemList do
          local itemListData = itemList[j]
          local openItemId = itemListData[1]
          if openItemId == self._itemid then
            local t = UIItemGetWayData:New()
            t:SetGiftWay(itemid)
            table.insert(ways, t)
            break
          end
        end
      end
    end
  end
end

function UIItemGetPathController:_FormatItemCount(itemCount)
  return HelperProxy:GetInstance():FormatItemCount(itemCount)
end

local random = math.random

function UIItemGetPathController:_GetGetWay(index)
  if index > #self._itemGetWay then
    return nil
  else
    return self._itemGetWay[index]
  end
end

function UIItemGetPathController:bgOnClick()
  self:CloseDialog()
end

function UIItemGetPathController:CreateGetWayString(str, jumpId)
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

function UIItemGetPathController:CheckEnable(jumpId)
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
                  local matid = self._itemid
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

function UIItemGetPathController:GetItemCondition()
  return self._itemCondition
end

function UIItemGetPathController:GetGapValue()
  local haveCount = GameGlobal.GetModule(ItemModule):GetItemCount(self._itemid)
  return math.max(0, self._itemCondition - haveCount)
end

_class("UIItemGetWayData", Object)
UIItemGetWayData = UIItemGetWayData

function UIItemGetWayData:Constructor()
end

function UIItemGetWayData:SetData(cfg)
  self.type = tonumber(cfg[1])
  if self.type == GetWayItemType.Text then
    self.desc = cfg[2]
  elseif self.type == GetWayItemType.Jump then
    self.desc = cfg[2]
    self.jumpId = tonumber(cfg[3])
  elseif self.type == GetWayItemType.GetWayIntroduce then
    self.desc = cfg[2]
  end
  self.randomType = tonumber(cfg[4])
end

function UIItemGetWayData:SetGiftWay(giftid)
  self.type = GetWayItemType.Use
  self.useItemId = giftid
  local cfg = Cfg.cfg_item[self.useItemId]
  if not cfg then
    Log.error("###[UIItemGetWayData] cfg is nil ! id --> ", self.useItemId)
  end
  self.desc = cfg.Name
end

function UIItemGetWayData:SetECWay(itemid, count)
  self.type = GetWayItemType.EC
  self.useItemId = itemid
  self.useItemCount = count
  local cfg = Cfg.cfg_item[self.useItemId]
  if not cfg then
    Log.error("###[UIItemGetWayData] cfg is nil ! id --> ", self.useItemId)
  end
  self.desc = StringTable.Get("str_item_public_exchange_path_desc", StringTable.Get(cfg.Name), self.useItemCount)
end

function UIItemGetWayData:CheckChapter()
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
