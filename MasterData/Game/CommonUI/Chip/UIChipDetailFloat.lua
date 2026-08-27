local base = UIBaseWindow
local UIChipDetailFloat = class("UIChipDetailFloat", base)
local UINBaseChipDetail = require("Game.CommonUI.Chip.UINBaseChipDetail")
local UINFloatUINode = require("Game.CommonUI.FloatWin.UINFloatUINode")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local cs_LeanTouch = CS.Lean.Touch.LeanTouch
local cs_InputUtility = CS.InputUtility

function UIChipDetailFloat:OnInit()
  self.__onFingerDown = BindCallback(self, self._OnFingerDown)
  self._chipDetail = UINBaseChipDetail.New()
  self._chipDetail:Init(self.ui.uINBaseChipDetail)
  self._floatNode = UINFloatUINode.New()
  self._floatNode:Init(self.ui.uINBaseChipDetail)
  self._resloader = CS.ResLoader.Create()
end

function UIChipDetailFloat:InitChipDetailFloat(chipData, targetTransform, hAType, shiftX)
  if chipData ~= self._chipData then
    self:_TriggerHideFunc()
  end
  self._chipData = chipData
  self._chipDetail:InitBaseChipDetail(nil, chipData, nil, self._resloader)
  self._floatNode:FloatTo(targetTransform, hAType, VAType.center, shiftX, 0)
end

function UIChipDetailFloat:SetChipDetailFloatHideFunc(hideFunc)
  self._hideFunc = hideFunc
end

function UIChipDetailFloat:_TriggerHideFunc()
  local func = self._hideFunc
  self._hideFunc = nil
  if func then
    func(self._chipData)
  end
end

function UIChipDetailFloat:_OnFingerDown(leanFinger)
  if not cs_InputUtility.OverUIValidTag(TagConsts.ValidTarget) then
    self:Hide()
  end
end

function UIChipDetailFloat:OnShow()
  cs_LeanTouch.OnFingerDown("+", self.__onFingerDown)
  TimerManager:StopTimer(self._autoDeleteTimer)
  base.OnShow(self)
end

function UIChipDetailFloat:OnHide()
  cs_LeanTouch.OnFingerDown("-", self.__onFingerDown)
  TimerManager:StopTimer(self._autoDeleteTimer)
  self._autoDeleteTimer = TimerManager:StartTimer(10, function()
    UIManager:DeleteWindow(UIWindowTypeID.ChipDetailFloat)
  end)
  base.OnHide(self)
  self:_TriggerHideFunc()
end

function UIChipDetailFloat:OnDelete()
  TimerManager:StopTimer(self._autoDeleteTimer)
  self._chipDetail:Delete()
  self._resloader:Put2Pool()
  self._resloader = nil
  base.OnDelete(self)
end

return UIChipDetailFloat
