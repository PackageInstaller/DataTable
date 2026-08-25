local CompAlchemyExchangeCostItem, Super = NewViewComponent("CompAlchemyExchangeCostItem")

function CompAlchemyExchangeCostItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view, data)
  self.ui = UI_Alchemy_Popup_Permute_ItemResource(uiNode)
  self.data = data
end

function CompAlchemyExchangeCostItem:OnEnterComponent()
  if self.data.tid then
    local function numFunc()
      local costItemData = AlchemyExchangeExtModel.Instance:GetCurSelectCostItemByTid(self.data.tid)
      
      return costItemData and costItemData.num or 0
    end
    
    local viewData = {
      tid = self.data.tid,
      num = self.data.uid,
      clickCb = self.data.clickCb,
      numFunc = numFunc
    }
    self:AddViewComponentOnce(self.ui.Group_Sel, CompAlchemyBaseItem, viewData)
  end
  self.ui.Group_Sel:SetActive(self.data.tid)
  if self.data.clickCb then
    self:AddButtonClickListener(self.ui.Btn_Add1, self.data.clickCb)
  end
end

function CompAlchemyExchangeCostItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompAlchemyExchangeCostItem
