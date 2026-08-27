local UINSpring23StoryLvRewardShow = class("UINSpring23StoryLvRewardShow", UIBaseNode)
local base = UIBaseNode
local ActivitySpringStoryEnum = require("Game.ActivitySpring.Data.ActivitySpringStoryEnum")
local UINSpring23StoryLvRewardShowItem = require("Game.ActivitySpring.UI.StoryReview.Team.UINSpring23StoryLvRewardShowItem")

function UINSpring23StoryLvRewardShow:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickBtnBack)
  UIUtil.AddButtonListener(self.ui.btn_Box, self, self.OnClickShowRewardDetail)
  self._showItemPool = UIItemPool.New(UINSpring23StoryLvRewardShowItem, self.ui.obj_line, false)
end

function UINSpring23StoryLvRewardShow:InitUINSpring23StoryLvRewardShow(storyData)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Hide):PushTopStatusDataToBackStack()
  self.storyData = storyData
  self.actFrameId = self.storyData:GetStoryActId()
  self:RefreshLvRewardShowUI()
end

function UINSpring23StoryLvRewardShow:RefreshLvRewardShowUI()
  self._showItemPool:HideAll()
  local finalItemId
  for id, cfg in pairs(ConfigData.activity_interact_story_level[self.actFrameId]) do
    if cfg.level < ConfigData.activity_interact_story_level.maxLevelDic[self.actFrameId] then
      local item = self._showItemPool:GetOne()
      item:InitUINSpring23StoryTeamLiveSuccess(cfg, self.storyData.gotRewardLevel)
    else
      finalItemId = cfg.reward_ids[1]
    end
  end
  self.ui.obj_finalItem.transform:SetAsLastSibling()
  self._finalItemCfg = ConfigData.item[finalItemId]
  self.ui.img_Box.sprite = CRH:GetSpriteByItemId(finalItemId)
  self.ui.tex_Rule.text = ConfigData:GetTipContent(ConfigData.activity_interact_main[self.actFrameId].addup_final_des[2])
  self.ui.tex_Des.text = ConfigData:GetTipContent(ConfigData.activity_interact_main[self.actFrameId].addup_final_des[1])
end

function UINSpring23StoryLvRewardShow:OnClickShowRewardDetail()
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    if win ~= nil then
      win:InitCommonItemDetail(self._finalItemCfg)
    end
  end)
end

function UINSpring23StoryLvRewardShow:OnClickBtnBack()
  self._showItemPool:HideAll()
  UIUtil.OnClickBackByUiTab(self)
end

function UINSpring23StoryLvRewardShow:OnDelete()
  base.OnDelete(self)
end

return UINSpring23StoryLvRewardShow
