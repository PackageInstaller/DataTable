local base = require("Game.ActivityHallowmas.UI.Bouns.UINHalloweenBounsItem")
local UINChristmasBounsItem = class("UINChristmasBounsItem", base)
local cs_MessageCommon = CS.MessageCommon

function UINChristmasBounsItem:OnInit()
  base.OnInit(self)
  UIUtil.AddButtonListener(self.ui.btn_Unlock, self, self.OnClickAVG)
  UIUtil.AddButtonListener(self.ui.btn_RewardBg, self, self.OnClickGet)
end

function UINChristmasBounsItem:SetLoopEftCreateFunc(func)
  self._eftCreateFunc = func
end

function UINChristmasBounsItem:RefreshBounsItem()
  base.RefreshBounsItem(self)
  local curLevel = self._data:GetHallowmasLv()
  local isPicked = self._data:IsHallowmasLevelReceived(self._level)
  local isCanPick = not isPicked and curLevel >= self._level
  if isCanPick then
    if self._loopEft == nil then
      self._loopEft = self._eftCreateFunc()
      self._loopEft.transform:SetParent(self.ui.loopEftRoot)
      self._loopEft.transform.localPosition = Vector3.zero
      self._loopEft.transform.localRotation = Vector3.zero
      self._loopEft.transform.localScale = Vector3.one
    end
    self._loopEft:SetActive(true)
  elseif self._loopEft ~= nil then
    self._loopEft:SetActive(false)
  end
end

function UINChristmasBounsItem:OnClickAVG()
  cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8718))
end

return UINChristmasBounsItem
