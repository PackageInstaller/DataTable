local UINTDBtCoinAddItem = class("UINTDBtCoinAddItem", UIBaseNode)
local base = UIBaseNode
local headOffset = Vector3.New(0, 1.5, 0)

function UINTDBtCoinAddItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._returnFxFunc = BindCallback(self, self._OnReturnFx)
end

function UINTDBtCoinAddItem:InitTDBtCoinAddItem(coinNum, position, returnFunc)
  self.returnFunc = returnFunc
  self.ui.effectCommon:InitEffectCommon(self._returnFxFunc, self.gameObject.name)
  if 99 <= coinNum then
    error("Unsurpported num:" .. tostring(coinNum))
    return
  end
  local num1 = coinNum // 10
  local num2 = coinNum % 10
  local mat = self.ui.psRender.material
  mat:SetInt("_Count1", num1)
  mat:SetInt("_Count2", num2)
  local uiPos = UIManager:World2UIPosition(position + headOffset)
  self.transform.anchoredPosition = uiPos
end

function UINTDBtCoinAddItem:_OnReturnFx(effectCommon)
  if effectCommon ~= self.ui.effectCommon then
    return
  end
  if self.returnFunc ~= nil then
    self.returnFunc(self)
  end
end

function UINTDBtCoinAddItem:OnDelete()
  base.OnDelete(self)
end

return UINTDBtCoinAddItem
