local ItemObtainedTipView, Super = NewClass("ItemObtainedTipView", AlertConfirm2View)
ItemObtainedTipView.uiResCls = UI_Main_ItemObtained_TipsResource

function ItemObtainedTipView:ctor(params)
  self.params = params
  self.data = self:_CreateTipData()
  Super.ctor(self, self.data)
end

function ItemObtainedTipView:OnEnterView()
  Super.OnEnterView(self)
  self:_ShowItems()
end

function ItemObtainedTipView:_CreateTipData()
  local tipTid = self.params.tipTid
  local tipConfig = DT.TipsType[tipTid]
  return {
    tipTid = tipTid,
    title = self.params.title or LT.Text(tipConfig.Title),
    desc = self.params.desc or LT.Text(tipConfig.Desc),
    bottomDesc = tipConfig.BottomDesc and LT.Text(tipConfig.BottomDesc),
    btnLeftDesc = LT.Text(tipConfig.LeftBtnDesc),
    btnRightDesc = LT.Text(tipConfig.RightBtnDesc),
    icon = tipConfig.Icon,
    dontRemind = tipConfig.DonotRemind,
    funcs = {
      leftBtnFunc = nil,
      rightBtnFunc = function()
        if self.params.callback then
          self.params.callback()
        end
      end
    }
  }
end

function ItemObtainedTipView:_ShowItems()
  local itemTidsList = self.params.items
  local ctTransform = self.ui.Items.transform
  local cnt = ctTransform.childCount
  while cnt < #itemTidsList do
    Instantiate(ctTransform:GetChild(0).gameObject, ctTransform)
    cnt = cnt + 1
  end
  for i = 1, #itemTidsList do
    local go = ctTransform:GetChild(i - 1).gameObject
    go:SetActive(true)
    local itemData = {
      itemTid = itemTidsList[i].tid,
      itemCount = itemTidsList[i].num or 1
    }
    self:AddViewComponent(go, CompPublicIconItemType2, itemData)
  end
  for i = #itemTidsList + 1, cnt do
    local go = ctTransform:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
end

return ItemObtainedTipView
