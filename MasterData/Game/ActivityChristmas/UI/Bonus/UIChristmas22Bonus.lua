local UIHalloween22Bouns = require("Game.ActivityHallowmas.UI.Bouns.UIHalloween22Bouns")
local UIChristmas22Bonus = class("UIChristmas22Bonus", UIHalloween22Bouns)
local base = UIHalloween22Bouns

function UIChristmas22Bonus:BindHalloweenBtn()
  UIUtil.SetTopStatus(self, self.OnCloseBouns)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnClickBuy)
  UIUtil.AddButtonListener(self.ui.btn_ReceiveAll, self, self.OnClickPickedAll)
  UIUtil.AddButtonListener(self.ui.btn_Icon, self, self.OnClickIconTip)
  self.__GetEftLoopCallback = BindCallback(self, self.__GetEftLoop)
end

function UIChristmas22Bonus:SethalloweenItemClass()
  self._itemClass = require("Game.ActivityChristmas.UI.Bonus.UINChristmasBounsItem")
  self._cycleClass = require("Game.ActivityHallowmas.UI.Bouns.UINHalloweenBounsCycleItem")
  self._emetyElement = require("Game.ActivityChristmas.UI.Bonus.UINChristmasBoundsItemEmptyElement")
end

function UIChristmas22Bonus:__RefreshAllGet()
  base.__RefreshAllGet(self)
  self.ui.uI_Christmas22Bonus_yjlq:SetActive(self._data:IsHallowmasExpAllReceive())
end

function UIChristmas22Bonus:__OnInstantiateItem(go)
  base.__OnInstantiateItem(self, go)
  self._goItem[go]:SetBoundsItemLoopEft(self.__GetEftLoopCallback)
end

function UIChristmas22Bonus:__GetEftLoop()
  return self.ui.uI_Christmas22Bonus_lq:Instantiate()
end

return UIChristmas22Bonus
