local UIDormCheckIn = class("UIDormCheckIn", UIBaseWindow)
local base = UIBaseWindow
local UINDmCkeckInRoomItem = require("Game.Dorm.DUI.CheckIn.UINDmCkeckInRoomItem")
local UINDmCheckInDetail = require("Game.Dorm.DUI.CheckIn.Detail.UINDmCheckInDetail")

function UIDormCheckIn:OnInit()
  UIUtil.AddButtonListener(self.ui.Btn_Close, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Info, self, self._OnClickInfo)
  UIUtil.AddButtonListener(self.ui.btn_InfoBgClose, self, self._OnClickInfoClose)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._BackAction):PushTopStatusDataToBackStack()
  self.ui.RoomItem:SetActive(false)
  self.roomItemPool = UIItemPool.New(UINDmCkeckInRoomItem, self.ui.RoomItem)
  self._ShowBindHeroNodeFunc = BindCallback(self, self._ShowBindHeroNode)
  self.dmCheckInDetailNode = UINDmCheckInDetail.New()
  self.dmCheckInDetailNode:Init(self.ui.obj_detail)
  self.dmCheckInDetailNode:Hide()
end

function UIDormCheckIn:InitDormCheckIn(dmHouseData, checkInRoomDataList, fromRoomSpos, exitFunc, dmCheckInCtrl)
  self.ui.Text_Title:SetIndex(0)
  self.dmHouseData = dmHouseData
  self.checkInRoomDataList = checkInRoomDataList
  self.exitFunc = exitFunc
  self.fromRoomSpos = fromRoomSpos
  self.dmCheckInCtrl = dmCheckInCtrl
  local checkInRoomDataDic = {}
  for index, roomData in ipairs(checkInRoomDataList) do
    checkInRoomDataDic[roomData] = index
  end
  self.checkInRoomDataDic = checkInRoomDataDic
  self:UpdDmCheckInOverView()
end

function UIDormCheckIn:UpdDmCheckInInfo()
  local checkincount = self.dmHouseData:GetDmHouseBindNum()
  local maxcheckincount = self.dmHouseData:GetHouseCanBindFntCount()
  self.ui.Text_CheckInTotalCount.text = tostring(checkincount) .. "/" .. tostring(maxcheckincount)
end

function UIDormCheckIn:UpdDmCheckInOverView()
  self:UpdDmCheckInInfo()
  self.roomItemPool:HideAll()
  for k, roomData in ipairs(self.checkInRoomDataList) do
    local selected = roomData.spos == self.fromRoomSpos
    local roomItem = self.roomItemPool:GetOne()
    roomItem:InitDmCkeckInRoomItem(roomData, selected, self._ShowBindHeroNodeFunc)
  end
end

function UIDormCheckIn:_ShowBindHeroNode(roomData)
  self.ui.obj_overView:SetActive(false)
  self.ui.obj_intro:SetActive(false)
  self.dmCheckInDetailNode:Show()
  local index = self.checkInRoomDataDic[roomData]
  self.dmCheckInDetailNode:InitDmCheckInDetail(roomData, index, self.dmHouseData, self.checkInRoomDataList, self.dmCheckInCtrl)
end

function UIDormCheckIn:HideDmCheckInDetailNode()
  self.ui.obj_overView:SetActive(true)
  self.dmCheckInDetailNode:Hide()
end

function UIDormCheckIn:_OnClickInfo()
  self.ui.Text_Title:SetIndex(1)
  self.ui.obj_intro:SetActive(true)
  self.ui.obj_overView:SetActive(false)
end

function UIDormCheckIn:_OnClickInfoClose()
  self.ui.Text_Title:SetIndex(0)
  self.ui.obj_intro:SetActive(false)
  self.ui.obj_overView:SetActive(true)
end

function UIDormCheckIn:_BackAction()
  if self.dmCheckInDetailNode.active then
    self:HideDmCheckInDetailNode()
    return false
  end
  if self.exitFunc ~= nil then
    self.exitFunc()
  end
  self.dmCheckInCtrl:CheckDmRoomEnableUnbind()
  self:Delete()
end

function UIDormCheckIn:_OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIDormCheckIn:OnDelete()
  self.roomItemPool:DeleteAll()
  self.dmCheckInDetailNode:Delete()
  base.OnDelete(self)
end

return UIDormCheckIn
