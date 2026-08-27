local UINDmCkeckInRoomItem = class("UINDmCkeckInRoomItem", UIBaseNode)
local base = UIBaseNode
local DormUtil = require("Game.Dorm.DormUtil")
local UINDmCheckInRoomSlotItem = require("Game.Dorm.DUI.CheckIn.UINDmCheckInRoomSlotItem")
local cs_MessageCommon = CS.MessageCommon

function UINDmCkeckInRoomItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_CheckOut, self, self._OnClickCheckOut)
  UIUtil.AddValueChangedListener(self.ui.tog_canVisit, self, self._OnTogCanVisitChanged)
  self.ui.obj_RoomHeroItem:SetActive(false)
  self.slotItemPool = UIItemPool.New(UINDmCheckInRoomSlotItem, self.ui.obj_RoomHeroItem)
end

function UINDmCkeckInRoomItem:InitDmCkeckInRoomItem(roomData, selected, clickSlotFunc)
  self.roomData = roomData
  self.clickSlotFunc = clickSlotFunc
  local roomIdx = roomData:GetDmRoomIndex()
  local roomName = roomData:GetName()
  self.ui.text_RoomName:SetIndex(0, string.format("%02d", roomIdx), roomName)
  self.ui.tex_RoomName:SetIndex(roomIdx)
  self.ui.tran_OnSelect.gameObject:SetActive(selected)
  local uipos = DormUtil.ToRectTransformPos(roomData.x, roomData.y)
  self.ui.img_bluepos.transform.localPosition = uipos
  self.ui.tog_canVisit.isOn = roomData:GetEnableUnbind()
  self:_UpdAllBindSlot()
end

function UINDmCkeckInRoomItem:_UpdAllBindSlot()
  local curNum = self.roomData:GetRoomBindCount()
  local allNum = self.roomData:GetRoomCanBindFntCount()
  self.ui.tex_CheckInCount.text = tostring(curNum) .. "/" .. tostring(allNum)
  self.ui.img_checkout.color = curNum == 0 and Color.gray or Color.white
  local canBindFntList = self.roomData:GetRoomCanBindList()
  self.slotItemPool:HideAll()
  for i = 1, DormUtil:GetBedCount() do
    local fntData = canBindFntList[i]
    local slotItem = self.slotItemPool:GetOne()
    slotItem:InitDmCheckInRoomSlotItem(self.clickSlotFunc, self.roomData, fntData)
  end
end

function UINDmCkeckInRoomItem:_OnClickCheckOut()
  if self.roomData:GetRoomBindCount() == 0 then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(2024))
    return
  end
  local msgWin = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
  msgWin:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(2026), function()
    local msgList = {}
    local fntDataList = self.roomData:GetRoomCanBindList()
    for k, fntData in ipairs(fntDataList) do
      local param = fntData:GetFntParam()
      if 0 < param then
        local msg = {
          heroId = param,
          houseId = self.roomData.belongtohouseid,
          roomPos = self.roomData.spos,
          elemIdx = self.roomData:GetFntDataIndex(fntData),
          bindHero = false
        }
        table.insert(msgList, msg)
      end
    end
    self._OnCheckOutFunc = BindCallback(self, self._OnCheckOut)
    NetworkManager:GetNetwork(NetworkTypeID.Dorm):CS_DORM_OneKeyBindUnbindHero(msgList, self._OnCheckOutFunc)
  end)
end

function UINDmCkeckInRoomItem:_OnCheckOut()
  self.roomData:UnbindAllRoomFntData()
  self:_UpdAllBindSlot()
  local checkinWindow = UIManager:GetWindow(UIWindowTypeID.DormCheckIn)
  if checkinWindow ~= nil then
    checkinWindow:UpdDmCheckInInfo()
  end
  MsgCenter:Broadcast(eMsgEventId.DormBindRoleChanged)
end

function UINDmCkeckInRoomItem:_OnTogCanVisitChanged(isOn)
  self.ui.tog_canVisit.isOn = isOn
  self.roomData:SetEnableUnbind(isOn)
end

function UINDmCkeckInRoomItem:OnDelete()
  self.slotItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINDmCkeckInRoomItem
