_class("UICN20N49ActionPointDetail", UIController)
UICN20N49ActionPointDetail = UICN20N49ActionPointDetail

function UICN20N49ActionPointDetail:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UICN20N49ActionPointDetail:OnShow(uiParams)
  self:InitWidget()
  self._cpt = uiParams[1]
  local pos = uiParams[2]
  self._onHide = uiParams[3]
  self.go = uiParams[4]
  self.uiName = uiParams[5]
  self.uiCamera = GameGlobal.UIStateManager():GetControllerCamera(self.uiName)
  self.root.anchoredPosition = pos + Vector2(0, -100)
  self:FlushPos()
  local itemID = self._cpt:GetItemId()
  local tipCfg = Cfg.cfg_top_tips[itemID]
  self.itemName:SetText(StringTable.Get(tipCfg.Title))
  self.desText:SetText(StringTable.Get(tipCfg.Intr))
end

function UICN20N49ActionPointDetail:FlushPos()
  if self.go then
    local posScreen = self.uiCamera:WorldToScreenPoint(self.go.transform.position)
    local camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
    local res, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.root.parent, posScreen, camera, nil)
    self.root.anchoredPosition = pos
  end
end

function UICN20N49ActionPointDetail:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
  if self._onHide then
    self._onHide()
  end
end

function UICN20N49ActionPointDetail:InitWidget()
  self.itemName = self:GetUIComponent("UILocalizationText", "ItemName")
  self.desText = self:GetUIComponent("UILocalizationText", "DesText")
  self.root = self:GetUIComponent("RectTransform", "Root")
end

function UICN20N49ActionPointDetail:BgOnClick(go)
  self:CloseDialog()
end
