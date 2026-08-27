local LevelDetailExtrData = class("LevelDetailExtrData")

function LevelDetailExtrData:ctor()
  self._additionalFirstClearRewardList = nil
end

function LevelDetailExtrData:Set_AdditionalFirstClearRewardList(list)
  self._additionalFirstClearRewardList = list
  return self
end

function LevelDetailExtrData:Get_AdditionalFirstClearRewardList()
  return self._additionalFirstClearRewardList
end

function LevelDetailExtrData:Set_AdditionalReviewStoryList(storyIdList, storySubTitleList)
  self.storyIdList = storyIdList
  self.storySubTitleList = storySubTitleList
  return self
end

function LevelDetailExtrData:Get_AdditionalReviewStoryList(storyIdList, storySubTitleList)
  return self.storyIdList, self.storySubTitleList
end

function LevelDetailExtrData:Set_SpecialLevelIdName(specialLevelIdName)
  self.specialLevelIdName = specialLevelIdName
  return self
end

function LevelDetailExtrData:Get_SpecialLevelIdName()
  return self.specialLevelIdName
end

return LevelDetailExtrData
