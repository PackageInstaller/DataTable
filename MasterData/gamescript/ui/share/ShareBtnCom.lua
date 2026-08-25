local ShareBtnCom, Super = System.NewComponent("ShareBtnCom")

function ShareBtnCom:ctor(uiNode, btnCall, BubbleUiName)
  Super.ctor(self)
  self.ui = UI_Common_Btn_ShareResource(uiNode)
  self.uiRoot = uiNode
  self.btnCall = btnCall
  self.BubbleUi = self.ui[BubbleUiName]
end

function ShareBtnCom:OnBind(binder)
  self.binder = binder
  self.ui.Image_Across:SetActive(false)
  self.ui.Image_Bg:SetActive(false)
  local list = DT.GetOriginalConstant("ShareReward")
  local itemId = list[1]
  local cnt = list[2]
  self.binder:SetImage(self.ui.Image_Icon, ItemDataUtils.GetItemIcon(itemId))
  self.binder:SetText(self.ui.Text_Price, cnt)
  self.binder:SetImage(self.ui.Image_Icon_1, ItemDataUtils.GetItemIcon(itemId))
  self.binder:SetText(self.ui.Text_Price_Across, cnt)
  self.binder:BindToVisible(self.BubbleUi, System.fn(self, self.IsFinish))
  self.binder:BindZ1Button(self.ui.Btn_Share, self.btnCall)
end

function ShareBtnCom:SetVisible(bVisible)
  self.uiRoot:SetActive(bVisible)
end

function ShareBtnCom:IsFinish()
  return not DataCenter.gameData.ShareRewardFinish
end

return ShareBtnCom
