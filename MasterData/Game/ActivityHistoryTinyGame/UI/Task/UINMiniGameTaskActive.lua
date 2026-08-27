local UINMiniGameTaskActive = class("UINMiniGameTaskOnce", UIBaseNode)
local base = UIBaseNode
local UINMiniGameTaskActiveItem = require("Game.ActivityHistoryTinyGame.UI.Task.UINMiniGameTaskActiveItem")

function UINMiniGameTaskActive:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.down, self, self.__OnClickReviewAll)
  self._taskPool = UIItemPool.New(UINMiniGameTaskActiveItem, self.ui.cupItem)
  self.ui.cupItem:SetActive(false)
  self.__OnClickReviewSingleCallback = BindCallback(self, self.__OnClickReviewSingle)
end

function UINMiniGameTaskActive:InitMiniGameTaskActive(actTinyData)
  self._actTinyData = actTinyData
  self._taskPool:HideAll()
  local pointCfg = self._actTinyData:GetTGActiveCfg()
  self._taskPool:HideAll()
  for i, single in ipairs(pointCfg) do
    local item = self._taskPool:GetOne()
    item:InitMiniGameTaskOnceItem(self._actTinyData, single, self.__OnClickReviewSingleCallback)
  end
  self:__RefreshBtnState()
end

function UINMiniGameTaskActive:RefreshMiniGameTaskActive()
  for i, v in ipairs(self._taskPool.listItem) do
    v:RefreshMiniGameTaskOnceItem()
  end
  self:__RefreshBtnState()
end

function UINMiniGameTaskActive:__RefreshBtnState()
  local level = self._actTinyData:GetActiveLevel()
  for i = 1, level do
    if self._actTinyData:IsTinyGameActiveCanReward(i) then
      self.ui.down.gameObject:SetActive(true)
      return
    end
  end
  self.ui.down.gameObject:SetActive(false)
end

function UINMiniGameTaskActive:__OnClickReviewAll()
  self._actTinyData:ReqHTGActiveReward(true, 0, function()
    if not IsNull(self.transform) then
      self:RefreshMiniGameTaskActive()
    end
  end)
end

function UINMiniGameTaskActive:__OnClickReviewSingle(level)
  self._actTinyData:ReqHTGActiveReward(false, level, function()
    if not IsNull(self.transform) then
      self:RefreshMiniGameTaskActive()
    end
  end)
end

return UINMiniGameTaskActive
