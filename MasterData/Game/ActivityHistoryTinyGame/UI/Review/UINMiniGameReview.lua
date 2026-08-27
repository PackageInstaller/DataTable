local UINMiniGameReview = class("UINMiniGameReview", UIBaseNode)
local base = UIBaseNode
local UINCommonPlotReviewCharpt = require("Game.CommonUI.PlotReview.UINCommonPlotReviewCharpt")
local UINCommonPlotReviewLockCharpt = require("Game.CommonUI.PlotReview.UINCommonPlotReviewLockCharpt")

function UINMiniGameReview:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.unlockedCharptPool = UIItemPool.New(UINCommonPlotReviewCharpt, self.ui.obj_plotGroup)
  self.ui.obj_plotGroup:SetActive(false)
  self.lockedCharptPool = UIItemPool.New(UINCommonPlotReviewLockCharpt, self.ui.obj_btn_DropDown)
  self.ui.obj_btn_DropDown:SetActive(false)
  self.__AvgPlayedCallBack = BindCallback(self, self.RefreshMGRAVGList)
  MsgCenter:AddListener(eMsgEventId.AVGLogicPlayed, self.__AvgPlayedCallBack)
end

function UINMiniGameReview:InitMiniGameReview(actTinyData)
  self.actTinyData = actTinyData
  self:RefreshMGRAVGList()
end

function UINMiniGameReview:OnShow()
  base.OnShow(self)
  if self.actTinyData ~= nil then
    self:RefreshMGRAVGList()
  end
end

function UINMiniGameReview:RefreshMGRAVGList()
  local CPRData = self.actTinyData:GetHTGAVGReviewData()
  self.unlockedCharptPool:HideAll()
  self.lockedCharptPool:HideAll()
  for index, AvgGroupData in ipairs(CPRData:GetCPRAvgGroupList()) do
    local isUnlock = AvgGroupData:GetAvgGroupIsUnlock()
    if isUnlock then
      local item = self.unlockedCharptPool:GetOne()
      item:InitPlotReviewCharpt(AvgGroupData)
    else
      local item = self.lockedCharptPool:GetOne()
      item:InitLockedCPRCharpt(AvgGroupData)
    end
  end
  local totalCount, unLockCount = CPRData:GetCPRAvgGroupUnlockNum()
  self.ui.tex_IsUnlock:SetIndex(0, tostring(unLockCount), tostring(totalCount))
end

function UINMiniGameReview:OnDelete()
  base.OnDelete(self)
  MsgCenter:RemoveListener(eMsgEventId.AVGLogicPlayed, self.__AvgPlayedCallBack)
end

return UINMiniGameReview
