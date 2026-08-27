local UINDmCheckInDetail = class("UINDmCheckInDetail", UIBaseNode)
local base = UIBaseNode
local UINDmCheckInDetailSlot = require("Game.Dorm.DUI.CheckIn.Detail.UINDmCheckInDetailSlot")
local UINDmCheckInDetailHero = require("Game.Dorm.DUI.CheckIn.Detail.UINDmCheckInDetailHero")
local DormUtil = require("Game.Dorm.DormUtil")
local cs_MessageCommon = CS.MessageCommon

function UINDmCheckInDetail:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Last, self, self._OnClickLastRoom)
  UIUtil.AddButtonListener(self.ui.btn_Next, self, self._OnClickNextRoom)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnClickConfim)
  self.ui.roomSlotItem:SetActive(false)
  self.slotPool = UIItemPool.New(UINDmCheckInDetailSlot, self.ui.roomSlotItem)
  self._UnbindSlotFunc = BindCallback(self, self._UnbindSlot)
  self._OnHeroListItemClickFunc = BindCallback(self, self._OnHeroListItemClick)
  self.heroItemDic = {}
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self._OnInstantiateItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self._OnChangeItem)
end

function UINDmCheckInDetail:InitDmCheckInDetail(roomData, index, houseData, checkInRoomDataList, dmCheckInCtrl)
  self.houseData = houseData
  self.checkInRoomDataList = checkInRoomDataList
  self.dmCheckInCtrl = dmCheckInCtrl
  self.heroList = {}
  for k, v in pairs(PlayerDataCenter.heroDic) do
    table.insert(self.heroList, v)
  end
  self.bindHeroIdFntDic, self.fntHeroIdDic = dmCheckInCtrl.dormCtrl.allDormData:GetDmBindHeroIdFntAllDic()
  self.bindInfoDic = {}
  self:_InitRoom(roomData, index)
end

function UINDmCheckInDetail:_InitRoom(roomData, index)
  self.roomData = roomData
  self.roomIdx = index
  local roomIdx = roomData:GetDmRoomIndex()
  local roomName = roomData:GetName()
  self.ui.tex_RoomName:SetIndex(0, string.format("%02d", roomIdx), roomName)
  local canBindFntList = roomData:GetRoomCanBindList()
  self.canBindFntList = canBindFntList
  self.slotPool:HideAll()
  for i = 1, DormUtil:GetBedCount() do
    local fntData = canBindFntList[i]
    local heroId
    if fntData ~= nil then
      heroId = self.fntHeroIdDic[fntData]
    end
    local slotItem = self.slotPool:GetOne()
    slotItem:InitDmCheckInDetailSlot(i, heroId, self._UnbindSlotFunc)
  end
  table.sort(self.heroList, function(a, b)
    local fntDataA = self.bindHeroIdFntDic[a.dataId]
    local fntDataB = self.bindHeroIdFntDic[b.dataId]
    local binda = fntDataA ~= nil
    local bindb = fntDataB ~= nil
    local inCurRoomA = binda and fntDataA:GetFntRoom() == self.roomData
    local inCurRoomB = bindb and fntDataB:GetFntRoom() == self.roomData
    if inCurRoomA ~= inCurRoomB then
      return inCurRoomA
    end
    if binda ~= bindb then
      return bindb
    end
    return a.dataId < b.dataId
  end)
  self:_RefillScrollRect(true)
end

function UINDmCheckInDetail:_UnbindSlot(index)
  local fntData = self.canBindFntList[index]
  if fntData == nil then
    return
  end
  local heroId = self.fntHeroIdDic[fntData]
  if heroId == nil or heroId == 0 then
    return
  end
  self:_UpdBindInfo(fntData, heroId, false)
end

function UINDmCheckInDetail:_RefillScrollRect(isRefill)
  if isRefill then
    self.ui.scrollRect.totalCount = #self.heroList
    self.ui.scrollRect:RefillCells()
  else
    self.ui.scrollRect:RefreshCells()
  end
end

function UINDmCheckInDetail:_OnInstantiateItem(go)
  local item = UINDmCheckInDetailHero.New()
  item:Init(go)
  self.heroItemDic[go] = item
end

function UINDmCheckInDetail:_OnChangeItem(go, index)
  local item = self.heroItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local heroData = self.heroList[index + 1]
  if heroData == nil then
    error("Can't find heroData by index, index = " .. tonumber(index))
  end
  local inCurRoom, inOtherRoom = false, false
  local fntData = self.bindHeroIdFntDic[heroData.dataId]
  if fntData ~= nil then
    inCurRoom = fntData:GetFntRoom() == self.roomData
    inOtherRoom = not inCurRoom
  end
  item:InitDmCheckInDetailHero(heroData, inCurRoom, inOtherRoom, self._OnHeroListItemClickFunc)
end

function UINDmCheckInDetail:_OnHeroListItemClick(heroItem, heroData)
  local isAdd = false
  local inCurRoom, inOtherRoom = false, false
  local fntData = self.bindHeroIdFntDic[heroData.dataId]
  if fntData == nil then
    isAdd = true
  elseif fntData:GetFntRoom() == self.roomData then
    inCurRoom = true
    isAdd = false
  else
    inOtherRoom = true
    isAdd = true
  end
  if isAdd then
    local curNum = 0
    local allNum = #self.canBindFntList
    local emptyFnt
    for k, fntData in ipairs(self.canBindFntList) do
      local heroId = self.fntHeroIdDic[fntData]
      if 0 < heroId then
        curNum = curNum + 1
      elseif emptyFnt == nil then
        emptyFnt = fntData
      end
    end
    if allNum <= curNum then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(2028))
      return
    end
    if inOtherRoom then
      local otherRoomData = fntData.roomData
      
      local function confimFunc()
        self:_UpdBindInfo(fntData, heroData.dataId, false)
        self:_UpdBindInfo(emptyFnt, heroData.dataId, true)
      end
      
      UIManager:ShowWindowAsync(UIWindowTypeID.DormReplaceHero, function(window)
        if window == nil then
          return
        end
        window:InitDmReplaceHero(otherRoomData, heroData, self.roomData, confimFunc)
      end)
      return
    end
    self:_UpdBindInfo(emptyFnt, heroData.dataId, true)
  else
    self:_UpdBindInfo(fntData, heroData.dataId, false)
    return
  end
end

function UINDmCheckInDetail:_UpdBindInfo(fntData, heroId, bindHero)
  local bindInfo = self.bindInfoDic[fntData]
  local fntRoomData = fntData:GetFntRoom()
  if bindInfo == nil then
    bindInfo = {
      heroId = heroId,
      houseId = self.houseData.id,
      roomPos = fntRoomData.spos,
      elemIdx = fntRoomData:GetFntDataIndex(fntData),
      bindHero = bindHero
    }
    self.bindInfoDic[fntData] = bindInfo
  end
  bindInfo.heroId = heroId
  bindInfo.bindHero = bindHero
  local newHeroId = bindHero and heroId or 0
  if fntRoomData == self.roomData then
    local index
    for k, fnt in ipairs(self.canBindFntList) do
      if fnt == fntData then
        index = k
        break
      end
    end
    local slotItem = self.slotPool.listItem[index]
    if slotItem ~= nil then
      slotItem:UpdDmCheckInDetailSlot(newHeroId)
    end
  end
  if bindHero then
    self.bindHeroIdFntDic[heroId] = fntData
  else
    self.bindHeroIdFntDic[heroId] = nil
  end
  self.fntHeroIdDic[fntData] = newHeroId
  self:_RefillScrollRect()
end

function UINDmCheckInDetail:_OnClickLastRoom()
  self:_ChangeRoom(false)
end

function UINDmCheckInDetail:_OnClickNextRoom()
  self:_ChangeRoom(true)
end

function UINDmCheckInDetail:_ChangeRoom(isNext)
  local offset = isNext and 1 or -1
  local newIdx = self.roomIdx + offset
  if newIdx > #self.checkInRoomDataList then
    newIdx = 1
  elseif newIdx < 1 then
    newIdx = #self.checkInRoomDataList
  end
  local roomData = self.checkInRoomDataList[newIdx]
  self:_InitRoom(roomData, newIdx)
end

function UINDmCheckInDetail:_OnClickConfim()
  self.dmCheckInCtrl:ChangeDmBindInfo(self.bindInfoDic)
end

function UINDmCheckInDetail:OnDelete()
  self.slotPool:DeleteAll()
  for k, v in pairs(self.heroItemDic) do
    v:Delete()
  end
  base.OnDelete(self)
end

return UINDmCheckInDetail
