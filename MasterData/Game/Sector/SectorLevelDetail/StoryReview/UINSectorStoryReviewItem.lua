local base = UIBaseNode
local UINSectorStoryReviewItem = class("UINSectorStoryReviewItem", UIBaseNode)

function UINSectorStoryReviewItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Play, self, self.__OnClickPlay)
end

function UINSectorStoryReviewItem:InitSectorStoryReviewItem(storyId, subTitle, clickCallback)
  self.storyId = storyId
  self.clickCallback = clickCallback
  local avgCfg = ConfigData.story_avg[self.storyId]
  if avgCfg == nil then
    error("avgCfg not exist, storyId:" .. tostring(self.storyId))
    self.clickCallback = nil
    return
  end
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(avgCfg.name)
  self.ui.tex_Num.text = LanguageUtil.GetLocaleText(subTitle)
end

function UINSectorStoryReviewItem:__OnClickPlay()
  if self.clickCallback ~= nil then
    self.clickCallback(self.storyId)
  end
end

function UINSectorStoryReviewItem:OnDelete()
  base.OnDelete(self)
end

return UINSectorStoryReviewItem
