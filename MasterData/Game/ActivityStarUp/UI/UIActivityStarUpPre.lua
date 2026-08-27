local UIActivityStarUpPre = class("UIActivityStarUpPre", UIBaseWindow)
local base = UIBaseWindow
local UINActivityStarUpPreItem = require("Game.ActivityStarUp.UI.UINActivityStarUpPreItem")

function UIActivityStarUpPre:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.__OnCloseFunc)
  UIUtil.AddButtonListener(self.ui.btn_Bg, self, self.__OnCloseFunc)
  self.ui.scroll_preview.onInstantiateItem = BindCallback(self, self.OnInstantiateItem)
  self.ui.scroll_preview.onChangeItem = BindCallback(self, self.OnTaskChangeItem)
  self.taskItemDic = {}
end

function UIActivityStarUpPre:InitView(activityInfo)
  self.activityInfo = activityInfo
  self.ui.scroll_preview.totalCount = #self.activityInfo.cfg.phase
  self.ui.scroll_preview:RefillCells()
  local index = self.activityInfo.curStageId ~= nil and self.activityInfo.curStageId or #self.activityInfo.cfg.phase
  self.ui.scroll_preview:SrollToCell(index - 1, 0)
  UIUtil.HideTopStatus()
end

function UIActivityStarUpPre:OnInstantiateItem(go)
  local item = UINActivityStarUpPreItem.New()
  item:Init(go)
  self.taskItemDic[go] = item
end

function UIActivityStarUpPre:OnTaskChangeItem(go, index)
  self.taskItemDic[go]:InitItem(self.activityInfo, index + 1)
end

function UIActivityStarUpPre:BackAction()
  UIUtil.ReShowTopStatus()
  self:Delete()
end

function UIActivityStarUpPre:__OnCloseFunc()
  UIUtil.OnClickBackByUiTab(self)
end

return UIActivityStarUpPre
