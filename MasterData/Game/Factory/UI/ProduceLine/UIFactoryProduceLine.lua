local UIFactoryProduceLine = class("UIFactoryProduceLine", UIBaseWindow)
local base = UIBaseWindow
local UINFactoryProduceLineItem = require("Game.Factory.UI.ProduceLine.UINFactoryProduceLineItem")

function UIFactoryProduceLine:OnInit()
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnClickReturn)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickReturn)
  self.lineItemPool = UIItemPool.New(UINFactoryProduceLineItem, self.ui.obj_productItem)
  self.ui.obj_productItem.gameObject:SetActive(false)
end

function UIFactoryProduceLine:InitAllLines()
  self.lineItemPool:HideAll()
  for index, processingDatas in pairs(self.factoryController.ProcessingOrders) do
    for uid, processingData in pairs(processingDatas) do
      local item = self.lineItemPool:GetOne()
      item:InitProduceLineItem(processingData)
    end
  end
  self.ui.obj_emptyState:SetActive(#self.lineItemPool.listItem <= 0)
end

function UIFactoryProduceLine:RefreshEnergey()
  for _, lineItem in ipairs(self.lineItemPool.listItem) do
    lineItem:RefreshEnergey()
  end
end

function UIFactoryProduceLine:OnTimeRefresh()
  for _, lineItem in ipairs(self.lineItemPool.listItem) do
    lineItem:OnTimeUpdate()
  end
end

function UIFactoryProduceLine:BackAction()
  self:Delete()
end

function UIFactoryProduceLine:OnClickReturn()
  UIUtil.OnClickBackByUiTab(self)
end

function UIFactoryProduceLine:OnDelete()
  if self.lineItemPool ~= nil then
    self.lineItemPool:DeleteAll()
    self.lineItemPool = nil
  end
  base.OnDelete(self)
end

return UIFactoryProduceLine
