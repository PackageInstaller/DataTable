_class("UIMedalGroupListController", UIController)
UIMedalGroupListController = UIMedalGroupListController

function UIMedalGroupListController:Constructor()
  local medalModule = GameGlobal.GetModule(MedalModule)
  local medalBgList = medalModule:GetMedalBoardVec()
  self.medalBgdata = UIMedalBgListData:New()
  self.medalBgdata:Init(medalBgList)
  self.medalData = UIMedalListData.New()
  self.medalData:Init(medalModule:GetMedalVec())
  self._itemModule = GameGlobal.GetModule(ItemModule)
  self.medalModule = GameGlobal.GetModule(MedalModule)
  self.editData = self.medalModule:GetN22MedalEditData()
end

function UIMedalGroupListController:OnShow(uiParams)
  self._openID = uiParams[1]
  self:InitWidget()
  self:GetMedalBoardVal()
  self:OnValue()
end

function UIMedalGroupListController:OnValue()
  self:InitScrollView()
  self._curIdx = 1
  if self._openID then
    Log.debug("###[UIMedalGroupListController] have open id :", self._openID)
    if self._data and next(self._data) then
      for index, value in ipairs(self._data) do
        if value.ID == self._openID then
          self._curIdx = index
          Log.debug("###[UIMedalGroupListController] set open idx :", self._curIdx)
          break
        end
      end
    end
  end
  self._curData = self._data[self._curIdx]
  self:_ReflashRight()
  self:_ReflashMedalList()
end

function UIMedalGroupListController:GetMedalBoardVal()
  local cfgs = Cfg.cfg_item_medal_group({})
  local loginModule = GameGlobal.GetModule(LoginModule)
  local svrTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  self._data = {}
  for key, value in pairs(cfgs) do
    local insert = true
    if not GameSingle and value.UnLockTime then
      local type = value.TimeTransform
      local timeType = Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
      if type and type == 0 then
        timeType = Enum_DateTimeZoneType.E_ZoneType_GMT
      end
      local openTime = loginModule:GetTimeStampByTimeStr(value.UnLockTime, timeType)
      if svrTime < openTime then
        insert = false
      end
    end
    if insert then
      table.insert(self._data, value)
    end
  end
  table.sort(self._data, function(a, b)
    return a.Sort < b.Sort
  end)
end

function UIMedalGroupListController:InitWidget()
  self.topTitle = self:GetUIComponent("UILocalizationText", "topTitle")
  self.topInfo1 = self:GetUIComponent("UILocalizationText", "topInfo1")
  self.topInfo2 = self:GetUIComponent("UILocalizationText", "topInfo2")
  self.mainImg = self:GetUIComponent("RawImageLoader", "mainImg")
  self.mainRawImg = self:GetUIComponent("RawImage", "mainImg")
  self.preRawImage = self:GetUIComponent("RawImage", "preImg")
  self.preImg = self:GetUIComponent("RawImageLoader", "preImg")
  self.preImgRect = self:GetUIComponent("RectTransform", "preImg")
  self.contentTitle = self:GetUIComponent("UILocalizationText", "contentTitle")
  self.contentInfo = self:GetUIComponent("UILocalizationText", "contentInfo")
  self.contentGet = self:GetUIComponent("RollingText", "contentGet")
  self.scrollViewContent = self:GetUIComponent("UISelectObjectPath", "scrollViewContent")
  self.contentGetParent = self:GetUIComponent("RectTransform", "contentGetParent")
  self._anim = self:GetUIComponent("Animation", "safeArea")
  local topButton = self:GetUIComponent("UISelectObjectPath", "topbtn")
  self.topButtonWidget = topButton:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    self:CloseDialog()
  end)
  self._bg_collect = self:GetUIComponent("UILocalizationText", "bg_collect")
  self._medal_collect = self:GetUIComponent("UILocalizationText", "medal_collect")
  self._collectView = self:GetGameObject("collectView")
  self._medalPool = self:GetUIComponent("UISelectObjectPath", "medalPool")
  self._bgWidth = self.preImgRect.rect.width
  self.atlas = self:GetAsset("UIMedal.spriteatlas", LoadType.SpriteAtlas)
end

function UIMedalGroupListController:InitScrollView()
  self.scrollViewContent:SpawnObjects("UIMedalGroupListItem", #self._data)
  local pools = self.scrollViewContent:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    local data = self._data[i]
    item:SetData(i, data, function(idx)
      self:OnItemClicked(idx)
    end)
  end
end

function UIMedalGroupListController:OnItemClicked(idx)
  self._curIdx = idx
  self._curData = self._data[self._curIdx]
  self:_ReflashRight()
  self:_ReflashMedalList()
  self._anim:Play("uieff_UIMedalBgListController_switch")
end

function UIMedalGroupListController:_ReflashMedalList()
  local pools = self.scrollViewContent:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    item:Select(self._curIdx)
  end
end

function UIMedalGroupListController:_ReflashRight()
  self:CollectStatus()
  self:TextInfo()
  self:MedalGroupNum()
  self:MedalBgIcon()
  self:ShowMedal()
end

function UIMedalGroupListController:TextInfo()
  self.contentTitle:SetText(StringTable.Get(self._curData.Title))
  self.contentInfo:SetText(StringTable.Get(self._curData.Des))
  self.contentGet:RefreshText(StringTable.Get(self._curData.GetWay))
end

function UIMedalGroupListController:MedalGroupNum()
  local collectNum = 0
  for i = 1, #self._data do
    local collect = self:CheckGroupCollect(self._data[i])
    if collect then
      collectNum = collectNum + 1
    end
  end
  self.topInfo1:SetText(collectNum)
  self.topInfo2:SetText("/" .. #self._data)
end

function UIMedalGroupListController:MedalBgIcon()
  local boardid = self._curData.BoardID
  local boardIconHD = UIN22MedalEdit.GetMedalBoardBgHd(boardid)
  self.preImg:LoadImage(boardIconHD)
  local collect = self:CheckBgCollect(self._curData)
  self.preRawImage.color = collect and Color(1, 1, 1, 1) or Color(1, 1, 1, 0.5)
end

function UIMedalGroupListController:BgCollectNum()
  local boardid = self._curData.BoardID
  local items = self._itemModule:GetItemByTempId(boardid)
  local have = items and next(items)
  local haveCount = have and 1 or 0
  local allCount = 1
  if GameSingle then
    haveCount = allCount
  end
  self._bg_collect:SetText(haveCount .. "/" .. allCount)
end

function UIMedalGroupListController:MedalCollectNum()
  local medals = self._curData.MedalIDList
  local allCount = #medals
  local haveCount = 0
  for key, value in pairs(medals) do
    local medalid = value[1]
    local items = self._itemModule:GetItemByTempId(medalid)
    local have = items and next(items)
    if have then
      haveCount = haveCount + 1
    end
  end
  self._medal_collect:SetText(haveCount .. "/" .. allCount)
end

function UIMedalGroupListController:CollectStatus()
  self:BgCollectNum()
  self:MedalCollectNum()
  local finish = self:CheckGroupCollect(self._curData)
  self._collectView:SetActive(finish)
end

function UIMedalGroupListController:CheckGroupCollect(data)
  local bg_collect = self:CheckBgCollect(data)
  local medalList_collect = self:CheckMedalListCollect(data)
  return bg_collect and medalList_collect
end

function UIMedalGroupListController:CheckBgCollect(data)
  local boardid = data.BoardID
  local bg_items = self._itemModule:GetItemByTempId(boardid)
  local bg_have = bg_items and next(bg_items)
  local bg_haveCount = bg_have and 1 or 0
  local bg_allCount = 1
  return bg_haveCount >= bg_allCount
end

function UIMedalGroupListController:CheckMedalCollect(id)
  local items = self._itemModule:GetItemByTempId(id)
  if items and next(items) then
    return true
  end
  return false
end

function UIMedalGroupListController:CheckMedalListCollect(data)
  local medals = data.MedalIDList
  local allCount = #medals
  local haveCount = 0
  for key, value in pairs(medals) do
    local medalid = value[1]
    local have = self:CheckMedalCollect(medalid)
    if have then
      haveCount = haveCount + 1
    end
  end
  return allCount <= haveCount
end

function UIMedalGroupListController:ShowMedal()
  local medalList = self._curData.MedalIDList
  self._medalPool:SpawnObjects("UIMedalGroupMedalItem", #medalList)
  local pools = self._medalPool:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    local data = medalList[i]
    local id = data[1]
    local sprite = UIN22MedalEditItem.GetSprite(self.atlas, BoardMedal.IconMedalById(id))
    local collect = self:CheckMedalCollect(id)
    item:SetData(data, sprite, collect, self._bgWidth, self.editData)
  end
end

function UIMedalGroupListController:MedalBgOnClick(go)
  local boardid = self._curData.BoardID
  local collect = self:CheckBgCollect(self._curData)
  self:ShowDialog("UIMedalGroupTipsController", boardid, true, collect)
end
