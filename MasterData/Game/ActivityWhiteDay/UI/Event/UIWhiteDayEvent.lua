local UIWhiteDayEvent = class("UIWhiteDayEvent", UIBaseWindow)
local base = UIBaseWindow
local UINWhiteDayEventNode = require("Game.ActivityWhiteDay.UI.Event.UINWhiteDayEventNode")

function UIWhiteDayEvent:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnClickClose)
  self.__onClickClose = BindCallback(self, self.OnClickClose)
  self.eventNode = UINWhiteDayEventNode.New()
  self.eventNode:Init(self.ui.obj_eventFrame)
end

function UIWhiteDayEvent:InitWDEvent(AWDCtrl, AWDLineData)
  self.AWDCtrl = AWDCtrl
  self.AWDLineData = AWDLineData
  self.eventNode:InitWDEventNode(AWDCtrl, AWDLineData, self.__onClickClose)
end

function UIWhiteDayEvent:OnClickClose()
  UIUtil.ReShowTopStatus()
  self:Hide()
end

function UIWhiteDayEvent:OnShow()
  base.OnShow(self)
  UIUtil.HideTopStatus()
end

function UIWhiteDayEvent:OnDelete()
  base.OnDelete(self)
end

return UIWhiteDayEvent
