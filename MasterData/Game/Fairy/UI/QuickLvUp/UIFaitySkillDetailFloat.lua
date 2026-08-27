local base = UIBaseWindow
local UIFaitySkillDetailFloat = class("UIFaitySkillDetailFloat", base)
local UINFairySkillUpgradeItem = require("Game.Fairy.UI.UINFairySkillUpgradeItem")
local UINFloatUINode = require("Game.CommonUI.FloatWin.UINFloatUINode")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local cs_LeanTouch = CS.Lean.Touch.LeanTouch
local cs_InputUtility = CS.InputUtility

function UIFaitySkillDetailFloat:OnInit()
  self._skillDetail = UINFairySkillUpgradeItem.New()
  self._skillDetail:Init(self.ui.uINFairySkillCard)
  self._floatNode = UINFloatUINode.New()
  self._floatNode:Init(self.ui.uINFairySkillCard)
  self.__onFingerDown = BindCallback(self, self._OnFingerDown)
  self._resloader = CS.ResLoader.Create()
end

function UIFaitySkillDetailFloat:InitFaitySkillDetailFloat(fairySkillData, targetTransform)
  self._skillDetail:InitFairySkillUpgradeItem(fairySkillData, self._resloader)
  self._floatNode:FloatTo(targetTransform, HAType.autoTightLeft, VAType.center)
end

function UIFaitySkillDetailFloat:_OnFingerDown(leanFinger)
  if not cs_InputUtility.OverUIValidTag(TagConsts.ValidTarget) then
    self:Hide()
  end
end

function UIFaitySkillDetailFloat:OnShow()
  cs_LeanTouch.OnFingerDown("+", self.__onFingerDown)
  TimerManager:StopTimer(self._autoDeleteTimer)
  base.OnShow(self)
end

function UIFaitySkillDetailFloat:OnHide()
  cs_LeanTouch.OnFingerDown("-", self.__onFingerDown)
  TimerManager:StopTimer(self._autoDeleteTimer)
  self._autoDeleteTimer = TimerManager:StartTimer(10, function()
    UIManager:DeleteWindow(UIWindowTypeID.FairySkillDetailFloat)
  end)
  base.OnHide(self)
end

function UIFaitySkillDetailFloat:OnDelete()
  TimerManager:StopTimer(self._autoDeleteTimer)
  self._resloader:Put2Pool()
  self._resloader = nil
  self._skillDetail:Delete()
  self._floatNode:Delete()
  base.OnDelete(self)
end

return UIFaitySkillDetailFloat
