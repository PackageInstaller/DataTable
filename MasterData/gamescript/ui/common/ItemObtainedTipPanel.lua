local ItemObtainedTipPanel, Super = System.NewClass("ItemObtainedTipPanel", AlertConfirm2Panel)

function ItemObtainedTipPanel:ctor(params)
  ItemObtainedTipPanel.uiResCls = UI_Main_ItemObtained_TipsResource
  self.params = params
  self.data = self:_CreateTipData()
  Super.ctor(self, self.data)
end

function ItemObtainedTipPanel:OnBind(binder)
  Super.OnBind(self, binder)
  self:_ShowItems(binder)
end

function ItemObtainedTipPanel:_CreateTipData()
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

function ItemObtainedTipPanel:_ShowItems(binder)
  local itemTidsList = self.params.items
  local ct_transform = self.ui.Items.transform
  local cnt = ct_transform.childCount
  while cnt < #itemTidsList do
    local uiNode = Instantiate(ct_transform:GetChild(0).gameObject, ct_transform)
    cnt = cnt + 1
  end
  for i = 1, #itemTidsList do
    local go = ct_transform:GetChild(i - 1).gameObject
    go:SetActive(true)
    local itemData = {
      itemTid = itemTidsList[i].tid,
      itemCount = itemTidsList[i].num or 1
    }
    binder:BindComponent(CommonIconItemType2(go, itemData))
  end
  for i = #itemTidsList + 1, cnt do
    local go = ct_transform:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
end

return ItemObtainedTipPanel
