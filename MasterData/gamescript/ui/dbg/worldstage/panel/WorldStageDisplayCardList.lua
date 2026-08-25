local WorldStageDisplayCardList, Super = System.NewClass("WorldStageDisplayCardList", UIBasePanel)
WorldStageDisplayCardList.uiResCls = UI_Dbgcopy_Popup_Display_CardResource

function WorldStageDisplayCardList:ctor(displayList)
  Super.ctor(self)
  self.displayList = displayList
end

function WorldStageDisplayCardList:OnBind(binder)
  local maxCardCount = 4
  for index = 1, maxCardCount do
    local cardUINode = self.ui["Card_" .. index]
    local cardUI = cardUINode and UI_Dbgcopy_Item_Select_CardResource(cardUINode)
    local data = self.displayList[index]
    if cardUI then
      cardUI.uiNode:SetActive(nil ~= data)
    end
    if data and cardUI then
      binder:BindComponent(WorldStageCardSelectItem(cardUINode, {
        runeTid = nil,
        cardUid = nil,
        cardTid = data.cfgId
      }))
    end
  end
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
end

return WorldStageDisplayCardList
