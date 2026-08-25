local GotoStageItem, Super = NewClass("GotoStageItem", ViewComponent)

function GotoStageItem:ctor(uiNode, view, itemGetId)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Item_ExchangeResource(uiNode)
  self.itemGetId = itemGetId
end

function GotoStageItem:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:RefreshView()
end

function GotoStageItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnBtnClick))
end

function GotoStageItem:RefreshView()
  local itemGetCfg = DT.ItemGets[self.itemGetId]
  self:SetText(self.ui.Text_Name, itemGetCfg.Desc)
  self:SetActive(self.ui.Image_Arrow, true)
  if self:IsCanJum() then
    self:SetTextColorType(self.ui.Text_Name, cd.ColorType.Light)
    self:SetActive(self.ui.Group_Select, true)
    self:SetActive(self.ui.Group_Normal, false)
  else
    self:SetTextColorType(self.ui.Text_Name, cd.ColorType.Dark)
    self:SetActive(self.ui.Group_Select, false)
    self:SetActive(self.ui.Group_Normal, true)
  end
end

function GotoStageItem:IsCanJum()
  do return FuncJumpManager.Instance.CanJump, FuncJumpManager.Instance end
  return FuncJumpManager.Instance.CanJump, FuncJumpManager.Instance, self.itemGetId
end

function GotoStageItem:_OnBtnClick()
  if self:IsCanJum() then
    UIManager.Instance:CloseByUrl(Urls.BestExpeirenceMsgView)
  end
  FuncJumpManager.Instance:JumpFunc(self.itemGetId)
end

return GotoStageItem
