local UIFactoryQuickProduce = class("UIFactoryQuickProduce", UIBaseWindow)
local base = UIBaseWindow
local UINFactoryOrderNode = require("Game.Factory.UI.UINFactoryOrderNode")

function UIFactoryQuickProduce:OnInit()
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnclickClose)
  self.ui.tween_factoryOrderNode.onRewind:AddListener(BindCallback(self, self.Delete))
  self.ui.tween_factoryOrderNode.onComplete:AddListener(BindCallback(self, self.OnTweenComplete))
  self.factoryOrderNode = UINFactoryOrderNode.New(true)
  self.factoryOrderNode:Init(self.ui.factoryOrderNode)
  self.factoryOrderNode.ui.quickPurchaseRoot = self.ui.quickPurchaseRoot
  self.factoryOrderNode.closeQuickProduceNode = BindCallback(self, self.OnclickClose)
end

function UIFactoryQuickProduce:OpenQuickProduce(targetOrderData, closeCallback)
  self.ui.tween_factoryOrderNode:DOPlayForward()
  self.ui.fade.blocksRaycasts = false
  AudioManager:PlayAudioById(1070)
  self.factoryOrderNode:InitOrderNode(targetOrderData:GetOrderRoomIndex())
  self.factoryOrderNode:ShowOrder(targetOrderData)
  self.factoryOrderNode:SetCloseCommonRewardCallback(function()
    self:OnclickClose()
    if closeCallback ~= nil then
      closeCallback()
    end
  end)
end

function UIFactoryQuickProduce:BackAction()
  self:OrderNodesPlayOver()
end

function UIFactoryQuickProduce:OnclickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIFactoryQuickProduce:OrderNodesPlayOver()
  self.ui.tween_factoryOrderNode:DOPlayBackwards()
  self.ui.fade.blocksRaycasts = false
  AudioManager:PlayAudioById(1071)
end

function UIFactoryQuickProduce:OnTweenComplete()
  self.ui.fade.blocksRaycasts = true
end

function UIFactoryQuickProduce:OnDelete()
  self.factoryOrderNode:Delete()
  self.ui.fade.blocksRaycasts = true
  base.OnDelete(self)
end

return UIFactoryQuickProduce
