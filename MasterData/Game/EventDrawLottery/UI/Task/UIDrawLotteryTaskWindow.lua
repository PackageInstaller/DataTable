local UIDrawLotteryTaskWindow = class("UIDrawLotteryTaskWindow", UIBaseWindow)
local UINDrawLotteryTaskWindowItemGroupDoing = require("Game.EventDrawLottery.UI.Task.UINDrawLotteryTaskWindowItemGroupDoing")
local UINDrawLotteryTaskWindowItemGroupCompleted = require("Game.EventDrawLottery.UI.Task.UINDrawLotteryTaskWindowItemGroupCompleted")
local base = UIBaseWindow

function UIDrawLotteryTaskWindow:OnInit()
  UIUtil.SetTopStatus(self, self.Delete, nil, nil, nil, true)
  self.itemGroupDoingNode = UINDrawLotteryTaskWindowItemGroupDoing.New()
  self.itemGroupDoingNode:Init(self.ui.obj_top)
  self.itemGroupCompletedNode = UINDrawLotteryTaskWindowItemGroupCompleted.New()
  self.itemGroupCompletedNode:Init(self.ui.itemGroupCompleted)
  UIUtil.AddButtonListener(self.ui.btn_bk, self, self.OnClickTaskWindowBk)
end

function UIDrawLotteryTaskWindow:InitDrawLotteryTaskWindow(actData)
  self.actData = actData
  self:RefreshTaskWindow()
end

function UIDrawLotteryTaskWindow:RefreshTaskWindow()
  self.itemGroupDoingNode:InitDrawLotteryTaskWindowItemGroupDoing(self.actData)
  self.itemGroupCompletedNode:InitDrawLotteryTaskWindowItemGroupCompleted(self.actData)
end

function UIDrawLotteryTaskWindow:OnClickTaskWindowBk()
  UIUtil.OnClickBackByWinId(UIWindowTypeID.EventDrawLotteryTaskWindow)
end

function UIDrawLotteryTaskWindow:OnDelete()
  self.itemGroupDoingNode:Delete()
  self.itemGroupCompletedNode:Delete()
end

return UIDrawLotteryTaskWindow
