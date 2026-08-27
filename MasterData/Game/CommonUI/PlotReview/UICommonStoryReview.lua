local UICommonStoryReview = class("UICommonStoryReview", UIBaseWindow)
local base = UIBaseWindow
local UINCommonPlotReviewCharpt = require("Game.CommonUI.PlotReview.UINCommonPlotReviewCharpt")
local UINCommonPlotReviewLockCharpt = require("Game.CommonUI.PlotReview.UINCommonPlotReviewLockCharpt")

function UICommonStoryReview:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickCloseReview)
  self.unlockedCharptPool = UIItemPool.New(UINCommonPlotReviewCharpt, self.ui.plotGroup)
  self.ui.plotGroup:SetActive(false)
  self.lockedCharptPool = UIItemPool.New(UINCommonPlotReviewLockCharpt, self.ui.btn_DropDown)
  self.ui.btn_DropDown:SetActive(false)
end

function UICommonStoryReview:InitStoryReview(CPRData, callback)
  self._callback = callback
  self.CPRData = CPRData
  self:__RefreshTitleName()
  self:RefreshHeroPlotReview()
end

function UICommonStoryReview:SetStoryAvgJustClientPlay()
  for i, v in ipairs(self.unlockedCharptPool.listItem) do
    v:SetAvgJustClientPlay()
  end
end

function UICommonStoryReview:__RefreshTitleName()
  local titleName = self.CPRData:GetCPRTitleName()
  if titleName ~= nil then
    self.ui.tex_title:SetIndex(1, titleName)
  else
    self.ui.tex_title:SetIndex(0)
  end
end

function UICommonStoryReview:RefreshHeroPlotReview()
  self.unlockedCharptPool:HideAll()
  self.lockedCharptPool:HideAll()
  for index, AvgGroupData in ipairs(self.CPRData:GetCPRAvgGroupList()) do
    local isUnlock = AvgGroupData:GetAvgGroupIsUnlock()
    if isUnlock then
      local item = self.unlockedCharptPool:GetOne()
      item:InitPlotReviewCharpt(AvgGroupData)
    else
      local item = self.lockedCharptPool:GetOne()
      item:InitLockedCPRCharpt(AvgGroupData)
    end
  end
  local totalCount, unLockCount = self.CPRData:GetCPRAvgGroupUnlockNum()
  self.ui.tex_IsUnlock:SetIndex(0, tostring(unLockCount), tostring(totalCount))
end

function UICommonStoryReview:SetObjMaskActive(bValue)
  self.ui.obj_mask:SetActive(bValue)
end

function UICommonStoryReview:OnClickCloseReview()
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

return UICommonStoryReview
