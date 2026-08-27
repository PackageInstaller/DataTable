local base = UIBaseWindow
local UISectorStoryReview = class("UISectorStoryReview", UIBaseWindow)
local UINSectorStoryReviewItem = require("Game.Sector.SectorLevelDetail.StoryReview.UINSectorStoryReviewItem")

function UISectorStoryReview:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Delete):PushTopStatusDataToBackStack(true)
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
  self.__playAvg = BindCallback(self, self.__PlayAvg)
  self.__itemPool = UIItemPool.New(UINSectorStoryReviewItem, self.ui.item, false)
end

function UISectorStoryReview:InitSectorStoryReview(storyIdList, subTitleList)
  self.__itemPool:HideAll()
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  for i, storyId in ipairs(storyIdList) do
    if avgPlayCtrl:IsAvgPlayed(storyId) then
      local subTitle = subTitleList[i]
      local item = self.__itemPool:GetOne()
      item:InitSectorStoryReviewItem(storyId, subTitle, self.__playAvg)
    end
  end
end

function UISectorStoryReview:__PlayAvg(storyId)
  local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
  avgCtrl:StartAvg(nil, storyId)
end

function UISectorStoryReview:OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UISectorStoryReview:OnDelete()
  self.__itemPool:DeleteAll()
  base.OnDelete(self)
end

return UISectorStoryReview
