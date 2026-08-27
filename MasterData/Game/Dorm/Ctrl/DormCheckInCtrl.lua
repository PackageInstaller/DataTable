local DormCtrlBase = require("Game.Dorm.Ctrl.DormCtrlBase")
local DormCheckInCtrl = class("DormCheckInCtrl", DormCtrlBase)

function DormCheckInCtrl:InitDmCheckInCtrl(fromRoomSpos, enterFunc, exitFunc)
  local checkInRoomDataList = {}
  local dmHouseData = self.dormCtrl.houseCtrl.curHouse
  local roomList = dmHouseData:GetDmHouseRoomList()
  local roomEnableUnbindList = {}
  for k, v in ipairs(roomList) do
    table.insert(checkInRoomDataList, v)
    roomEnableUnbindList[k] = v:GetEnableUnbind()
  end
  table.sort(checkInRoomDataList, function(a, b)
    local isFromA = a.spos == fromRoomSpos
    local isFromB = b.spos == fromRoomSpos
    local indexA = a:GetDmRoomIndex()
    local indexB = b:GetDmRoomIndex()
    if isFromA ~= isFromB then
      return isFromA
    end
    return indexA < indexB
  end)
  self.dmHouseData = dmHouseData
  self.roomEnableUnbindList = roomEnableUnbindList
  self.checkInRoomDataList = checkInRoomDataList
  UIManager:ShowWindowAsync(UIWindowTypeID.DormCheckIn, function(window)
    if window == nil then
      return
    end
    if enterFunc ~= nil then
      enterFunc()
    end
    window:InitDormCheckIn(dmHouseData, checkInRoomDataList, fromRoomSpos, exitFunc, self)
  end)
end

function DormCheckInCtrl:CheckDmRoomEnableUnbind()
  local opDic = {}
  local num = 0
  local roomList = self.dmHouseData:GetDmHouseRoomList()
  for k, oldEnableUnbind in ipairs(self.roomEnableUnbindList) do
    local roomData = roomList[k]
    local curEnableUnbind = roomData:GetEnableUnbind()
    if curEnableUnbind ~= oldEnableUnbind then
      opDic[roomData.spos] = curEnableUnbind
      num = num + 1
    end
  end
  if num == 0 then
    return
  end
  self.dormCtrl.dormNetwork:CS_DORM_HouseRoomBindUnbind(self.dmHouseData.id, opDic)
  MsgCenter:Broadcast(eMsgEventId.DormUnbindSwitchChanged, opDic)
end

function DormCheckInCtrl:ChangeDmBindInfo(bindInfoDic)
  local sendList = {}
  local sendDic = {}
  for fntData, bindInfo in pairs(bindInfoDic) do
    local oldHeroId = fntData:GetFntParam()
    if bindInfo.bindHero then
      if bindInfo.heroId ~= oldHeroId then
        table.insert(sendList, bindInfo)
        sendDic[fntData] = bindInfo
      end
    else
      if bindInfo.heroId == oldHeroId then
        table.insert(sendList, bindInfo)
      end
      sendDic[fntData] = bindInfo
    end
  end
  if #sendList == 0 then
    local win = UIManager:GetWindow(UIWindowTypeID.DormCheckIn)
    if win ~= nil then
      win:HideDmCheckInDetailNode()
    end
  end
  self._sendBindDic = sendDic
  self._OnChangeDmBindInfoFunc = self._OnChangeDmBindInfoFunc or BindCallback(self, self._OnChangeDmBindInfo)
  NetworkManager:GetNetwork(NetworkTypeID.Dorm):CS_DORM_OneKeyBindUnbindHero(sendList, self._OnChangeDmBindInfoFunc)
end

function DormCheckInCtrl:_OnChangeDmBindInfo()
  for fntData, bindInfo in pairs(self._sendBindDic) do
    if bindInfo.bindHero then
      fntData:SetFntParam(bindInfo.heroId, true)
    else
      fntData:SetFntParam(0, true)
    end
  end
  self.dormCtrl:SetAllBindFntDataDirty()
  MsgCenter:Broadcast(eMsgEventId.DormBindRoleChanged)
  local win = UIManager:GetWindow(UIWindowTypeID.DormCheckIn)
  if win ~= nil then
    win:UpdDmCheckInOverView()
    win:HideDmCheckInDetailNode()
  end
end

function DormCheckInCtrl:OnDelete()
end

return DormCheckInCtrl
