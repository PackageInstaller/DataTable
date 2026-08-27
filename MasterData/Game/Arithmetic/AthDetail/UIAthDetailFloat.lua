local UIAthDetailFloat = class("UIAthDetailFloat", UIBaseWindow)
local base = UIBaseWindow
local UINAthDetailItem = require("Game.Arithmetic.AthDetail.UINAthDetailItem")
local cs_LeanTouch = CS.Lean.Touch.LeanTouch
local cs_InputUtility = CS.InputUtility

function UIAthDetailFloat:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.detailItem = UINAthDetailItem.New()
  self.detailItem:Init(self.ui.aTHDetailItem)
  self._itemPosDefault = self.detailItem.transform.anchoredPosition
end

function UIAthDetailFloat:InitAthDetailFloat(athData, isCenter, hideLockBtn)
  AudioManager:PlayAudioById(1072)
  self.detailItem:InitAthDetailItem(nil, athData, nil, false, false, true)
  self.__onFingerDown = BindCallback(self, self.OnFingerDown)
  cs_LeanTouch.OnFingerDown("+", self.__onFingerDown)
  if isCenter then
    self.detailItem.transform.anchoredPosition = Vector2.Temp(-240, self._itemPosDefault.y)
  else
    self.detailItem.transform.anchoredPosition = self._itemPosDefault
  end
  self.detailItem:SetAthDetailItemLockBtnShow(not hideLockBtn)
end

function UIAthDetailFloat:OnFingerDown(leanFinger)
  if not cs_InputUtility.OverUIValidTag(TagConsts.ValidTarget) then
    self:Hide()
  end
end

function UIAthDetailFloat:OnHide()
  cs_LeanTouch.OnFingerDown("-", self.__onFingerDown)
  base.OnHide(self)
end

function UIAthDetailFloat:OnDelete()
  self.detailItem:Delete()
  base.OnDelete(self)
end

return UIAthDetailFloat
