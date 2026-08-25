local PvPCamp = CommonDefine.PvPCamp
local INTERVAL_TIME = tonumber(DT.GetConstant("Role_Press_Time"))
local PvPCardRecordingItem, Super = System.NewComponent("PvPCardRecordingItem")

function PvPCardRecordingItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_AvatarResource(uiNode)
  self.clickFunc = data.clickFunc
  self.imageFunc = data.imageFunc
  self.campFunc = data.campFunc
  self.longPressFunc = data.longPressFunc
  self.pressUpFunc = data.pressUpFunc
end

function PvPCardRecordingItem:OnBind(binder)
  binder:BindLongPressButton(self.ui.Btn_Click, self.longPressFunc, self.clickFunc, INTERVAL_TIME)
  binder:BindPressUp(self.ui.Btn_Click, self.pressUpFunc)
  binder:BindToImage(self.ui.Image_Icon, self.imageFunc)
  binder:BindToVisible(self.ui.Image_Enemy, System.bind(self._CheckCamp, self, PvPCamp.Enermy))
  binder:BindToVisible(self.ui.Image_Our, System.bind(self._CheckCamp, self, PvPCamp.Player))
end

function PvPCardRecordingItem:_CheckCamp(camp)
  local rst = false
  if self.campFunc then
    rst = self.campFunc() == camp
  end
  return rst
end

return PvPCardRecordingItem
