local UIDormOperate = class("UIDormOperate", UIBaseWindow)
local base = UIBaseWindow

function UIDormOperate:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Recycle, self, self.OnRecycleClicked)
  UIUtil.AddButtonListener(self.ui.btn_Decompose, self, self.OnDecomposeClicked)
  UIUtil.AddButtonListener(self.ui.btn_RecycleFnt, self, self.OnRecycleFntClicked)
  UIUtil.AddButtonListener(self.ui.btn_Rote, self, self.OnRotateFntClicked)
  self.dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
end

function UIDormOperate:InitDormHouseOperate(position, isBpRoom)
  self.ui.panel_House:SetActive(true)
  self.ui.panel_Room:SetActive(false)
  local uiPosition = UIManager:World2UIPosition(position)
  self.ui.panel_House.transform.localPosition = Vector3.New(uiPosition.x, uiPosition.y, 0)
  self.ui.btn_Decompose.gameObject:SetActive(not isBpRoom)
end

function UIDormOperate:ShowFntOperate(show, rotEnable)
  self.ui.panel_House:SetActive(false)
  self.ui.panel_Room:SetActive(show)
  self.ui.btn_Rote.gameObject:SetActive(rotEnable)
end

function UIDormOperate:UpdateFntOpPos(position)
  if self.ui.panel_Room.activeSelf then
    local uiPosition = UIManager:World2UIPosition(position)
    self.ui.panel_Room.transform.localPosition = Vector3.New(uiPosition.x, uiPosition.y, 0)
  end
end

function UIDormOperate:OnRecycleClicked()
  self.dormCtrl.houseCtrl:RecycleHouseRoom()
end

function UIDormOperate:OnDecomposeClicked()
  CS.MessageCommon.ShowMessageBox(ConfigData:GetTipContent(TipContent.dorm_ConfirmDecomposeRoom), function()
    self.dormCtrl.houseCtrl:DecomposeHouseRoom()
  end, nil)
end

function UIDormOperate:OnRecycleFntClicked()
  self.dormCtrl.roomCtrl:RecycleFntSelect()
end

function UIDormOperate:OnRotateFntClicked()
  self.dormCtrl.roomCtrl:RotateFnt()
end

function UIDormOperate:OnDelete()
  base.OnDelete(self)
end

return UIDormOperate
