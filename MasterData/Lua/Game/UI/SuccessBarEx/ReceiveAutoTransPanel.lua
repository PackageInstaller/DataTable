local ReceiveAutoTransPanel = class("ReceiveAutoTransPanel", BasePanel)
ReceiveAutoTransPanel._bIsMainPanel = false
ReceiveAutoTransPanel._tbDefine = {
  {
    sPrefabPath = "SuccessBarEx/ReceiveAutoTransPanel.prefab",
    sCtrlName = "Game.UI.SuccessBarEx.ReceiveAutoTransCtrl"
  }
}

function ReceiveAutoTransPanel:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.tbSrc = tbParam[1]
    self.tbDst = tbParam[2]
    self.callback = tbParam[3]
    
    local function sort(a, b)
      local cfgA = ConfigTable.GetData_Item(a.Tid)
      local cfgB = ConfigTable.GetData_Item(b.Tid)
      local rarityA = cfgA.Rarity
      local rarityB = cfgB.Rarity
      local typeA = cfgA.Type
      local typeB = cfgB.Type
      if rarityA ~= rarityB then
        return rarityA < rarityB
      elseif typeA ~= typeB then
        return typeA < typeB
      elseif a.Qty ~= b.Qty then
        return a.Qty > b.Qty
      else
        return a.Tid < b.Tid
      end
    end
    
    table.sort(self.tbSrc, sort)
    table.sort(self.tbDst, sort)
  end
end

function ReceiveAutoTransPanel:OnEnable()
end

function ReceiveAutoTransPanel:OnDisable()
end

function ReceiveAutoTransPanel:OnDestroy()
end

return ReceiveAutoTransPanel
