local UINSpring23StoryTeam = class("UINSpring23StoryTeam", UIBaseNode)
local base = UIBaseNode
local ActivitySpringStoryEnum = require("Game.ActivitySpring.Data.ActivitySpringStoryEnum")
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local UINSpring23StoryHeadItem = require("Game.ActivitySpring.UI.StoryReview.Team.UINSpring23StoryHeadItem")
local UINSpring23StoryTeamLiveSuccess = require("Game.ActivitySpring.UI.StoryReview.Team.UINSpring23StoryTeamLiveSuccess")
local CS_DOTween = CS.DG.Tweening.DOTween

function UINSpring23StoryTeam:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Review, self, self.OnClickBtnReview)
  UIUtil.AddButtonListener(self.ui.btn_FinalReward, self, self.OnClickShowRewardDetail)
  UIUtil.AddButtonListener(self.ui.btn_Overview, self, self.OnClickBtnOverView)
  UIUtil.AddButtonListener(self.ui.btn_Start, self, self.OnClickBtnStartLive)
  self._itemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived, false)
  self._headPool = UIItemPool.New(UINSpring23StoryHeadItem, self.ui.obj_headItem, false)
  self.liveSuccessNode = UINSpring23StoryTeamLiveSuccess.New()
  self.liveSuccessNode:Init(self.ui.obj_LiveSuccessedNode)
  self.__OnShowExtraCallback = BindCallback(self, self.OnSpring23StoryShowExtra)
end

function UINSpring23StoryTeam:InitSpring23StoryTeam(springStoryData, resloader, extraClickFunc, teamExtraClickFunc)
  local actId = springStoryData:GetStoryActId()
  self:__Init(actId, springStoryData, resloader, extraClickFunc, teamExtraClickFunc)
end

function UINSpring23StoryTeam:InitSpring23StoryTeamReview(actId, resloader, extraClickFunc, teamExtraClickFunc)
end

function UINSpring23StoryTeam:__Init(actId, springStoryData, resloader, extraClickFunc, teamExtraClickFunc)
  self.actFrameId = actId
  self.storyData = springStoryData
  self._extraClickFunc = extraClickFunc
  self._teamExtraClickFunc = teamExtraClickFunc
  local storyCfg = ConfigData.activity_interact[actId]
  self._heroStoryData = {}
  for k, v in pairs(storyCfg) do
    self:__AddheroTable(v)
  end
  self:__SortHeroTable()
  self:RefreshUITeam()
end

function UINSpring23StoryTeam:__AddheroTable(interactCfg)
  local heroId = interactCfg.interact_character
  if self._heroStoryData[heroId] == nil then
    self._heroStoryData[heroId] = {
      side = {},
      fixReward = {},
      ranReward = nil
    }
  end
  if interactCfg.stage_id == ActivitySpringStoryEnum.stageEnum.side then
    table.insert(self._heroStoryData[heroId].side, interactCfg)
  elseif interactCfg.stage_id == ActivitySpringStoryEnum.stageEnum.fixReward then
    table.insert(self._heroStoryData[heroId].fixReward, interactCfg)
  elseif interactCfg.stage_id == ActivitySpringStoryEnum.stageEnum.ranReward then
    self._heroStoryData[heroId].ranReward = interactCfg
  end
end

function UINSpring23StoryTeam:__SortHeroTable()
  for k, v in pairs(self._heroStoryData) do
    table.sort(v.side, function(a, b)
      return a.id < b.id
    end)
    table.sort(v.fixReward, function(a, b)
      return a.id < b.id
    end)
  end
end

function UINSpring23StoryTeam:RefreshUITeam()
  self._headPool:HideAll()
  for heroId, _ in pairs(ConfigData.activity_interact.heroActDic[self.actFrameId]) do
    local headItem = self._headPool:GetOne()
    headItem:InitUINSpring23StoryTeamLiveSuccess(heroId, self.storyData:GetHeroStoryLevel(heroId), ConfigData.activity_interact_main[self.actFrameId].heroHeadDic[heroId], self.__OnShowExtraCallback)
  end
  local nowLevel, targetLevel = self.storyData:GetNextCanGetRewardLevel()
  self.nowLevel = nowLevel
  self.targetLevel = targetLevel
  self.ui.tex_NowLvl.text = tostring(nowLevel)
  self.ui.tex_TargetLvl.text = tostring(targetLevel)
  if targetLevel <= nowLevel then
    self.ui.obj_NotReach:SetActive(false)
    self.ui.btn_Start.gameObject:SetActive(true)
  else
    self.ui.obj_NotReach:SetActive(true)
    self.ui.btn_Start.gameObject:SetActive(false)
  end
  local interactId = ConfigData.activity_interact_story_level.storyLevelDic[self.actFrameId]
  local isShow = ConfigData.activity_interact_story_level[self.actFrameId][interactId].level <= self.storyData.gotRewardLevel
  self.ui.btn_Review.gameObject:SetActive(isShow)
  local isLongTail, rewardIds, rewardNums = self.storyData:GetStoryLevelRewards(targetLevel)
  if isLongTail then
    self.ui.obj_RewardList:SetActive(false)
    self.ui.obj_FinalReward:SetActive(true)
    local finalItemId = rewardIds[1]
    self._finalItemCfg = ConfigData.item[finalItemId]
    self.ui.img_FinalReward.sprite = CRH:GetSpriteByItemId(finalItemId)
    self.ui.tex_RuleDes.text = ConfigData:GetTipContent(ConfigData.activity_interact_main[self.actFrameId].addup_final_des[1])
  else
    self.ui.obj_RewardList:SetActive(true)
    self.ui.obj_FinalReward:SetActive(false)
    self._itemPool:HideAll()
    for i, itemId in ipairs(rewardIds) do
      local itemCfg = ConfigData.item[itemId]
      local itemCount = rewardNums[i]
      local item = self._itemPool:GetOne()
      item:InitItemWithCount(itemCfg, itemCount, nil, false)
    end
  end
end

function UINSpring23StoryTeam:OnClickBtnReview()
  local interactId = ConfigData.activity_interact_story_level.storyLevelDic[self.actFrameId]
  local storyId = ConfigData.activity_interact_story_level[self.actFrameId][interactId].avg_1
  local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
  avgCtrl:StartAvg(nil, storyId)
end

function UINSpring23StoryTeam:OnClickBtnStartLive()
  if self.nowLevel and self.targetLevel and self.nowLevel >= self.targetLevel then
    self.storyData:FinishTeamStory(self.targetLevel, function(rewardIds, rewardNums)
      self:RefreshUITeam()
      self:ShowLiveSuccess(rewardIds, rewardNums)
    end)
  end
end

function UINSpring23StoryTeam:OnClickBtnOverView()
  if self._teamExtraClickFunc then
    self._teamExtraClickFunc()
  end
end

function UINSpring23StoryTeam:ShowLiveSuccess(rewardIds, rewardNums)
  self.liveSuccessNode:Show()
  self.liveSuccessNode:InitUINSpring23StoryTeamLiveSuccess(rewardIds, rewardNums)
end

function UINSpring23StoryTeam:OnClickShowRewardDetail()
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    if win ~= nil then
      win:InitCommonItemDetail(self._finalItemCfg)
    end
  end)
end

function UINSpring23StoryTeam:OnSpring23StoryShowExtra(heroId)
  if self._extraClickFunc ~= nil then
    local heroStory = self._heroStoryData[heroId]
    self._extraClickFunc(heroId, heroStory.fixReward, heroStory.ranReward)
  end
end

function UINSpring23StoryTeam:OnDelete()
  base.OnDelete(self)
end

return UINSpring23StoryTeam
