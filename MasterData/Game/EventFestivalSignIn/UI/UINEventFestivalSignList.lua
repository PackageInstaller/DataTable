local UINEventFestivalSignList = class("UINEventFestivalSignList", UIBaseNode)
local base = UIBaseNode
local TaskEnum = require("Game.Task.TaskEnum")
local UINEvtFestivalSignItem = require("Game.EventFestivalSignIn.UI.UINEvtFestivalSignItem")

function UINEventFestivalSignList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickClose)
  self.signItemPool = UIItemPool.New(UINEvtFestivalSignItem, self.ui.festivalSignInItem, false)
end

function UINEventFestivalSignList:InitEventFestivalSignList(signData, isShowCloseBtn, closeFunc)
  self.ui.btn_Close.gameObject:SetActive(isShowCloseBtn or false)
  self.closeFunc = closeFunc
  local signCfg = signData:GetSignCfg()
  local headDayNumber = signCfg.Icon_day_number
  if headDayNumber ~= 0 then
    headDayNumber = headDayNumber - 1
  end
  self.ui.headImage:SetIndex(headDayNumber)
  local signRewardList = signData:GetSignRewardList()
  local canPickId
  self.signItemPool:HideAll()
  for k, v in ipairs(signRewardList) do
    local signItem = self.signItemPool:GetOne()
    signItem:InitFestivalSignItem(signData, v)
    local state = signData:GetReceiveState(v.day)
    if state == TaskEnum.eTaskState.Picked or state == TaskEnum.eTaskState.Completed then
      canPickId = k
    end
  end
  local maxNum = #signRewardList
  self.ui.scrollRect.verticalNormalizedPosition = 1 - ((canPickId or maxNum) - 1) / (maxNum - 1)
end

function UINEventFestivalSignList:UpdUIFestivalSignInList()
  for i, v in ipairs(self.signItemPool.listItem) do
    v:UpdUIFestivalSignInItem()
  end
end

function UINEventFestivalSignList:_OnClickClose()
  if self.closeFunc ~= nil then
    self.closeFunc()
  end
end

function UINEventFestivalSignList:OnDelete()
  self.signItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINEventFestivalSignList
