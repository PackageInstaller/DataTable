local UINSpring23StoryBaseItem = class("UINSpring23StoryBaseItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local Data_UIAvgDetail = require("Game.Sector.AvgDetail.Data_UIAvgDetail")

function UINSpring23StoryBaseItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickAvgDetail)
  self._item = UINBaseItemWithReceived.New()
  self._item:Init(self.ui.uINBaseItemWithReceived)
end

function UINSpring23StoryBaseItem:InitSpring23StoryItem(springStoryData, interactCfg, resloader, detailCallback)
  self._springStoryData = springStoryData
  self._interactCfg = interactCfg
  self._detailCallback = detailCallback
  self._interactInfoCfg = ConfigData.activity_interact_info[interactCfg.story]
  self._resloader = resloader
  self:__InitUI()
  self:RefreshSpring23StoryState()
end

function UINSpring23StoryBaseItem:InitSpring23StoryItemJustAvg(avgId, resloader, detailCallback)
  self._springStoryData = nil
  self._interactCfg = nil
  self._detailCallback = detailCallback
  self._interactInfoCfg = ConfigData.activity_interact_info[avgId]
  self._resloader = resloader
  self:__InitUI()
  self:RefreshSpring23StoryState()
end

function UINSpring23StoryBaseItem:InitSpring23StoryItemReview(interactCfg, resloader, detailCallback)
  self._hideReward = true
  self._forceLooked = false
  self:InitSpring23StoryItem(nil, interactCfg, resloader, detailCallback)
end

function UINSpring23StoryBaseItem:InitSpring23StoryItemJustAvgReview(avgId, resloader, detailCallback)
  self._hideReward = true
  self._forceLooked = true
  self:InitSpring23StoryItemJustAvg(avgId, resloader, detailCallback)
end

function UINSpring23StoryBaseItem:ResetSpring23StoryItemAniState()
  self.ui.ani_root:Stop()
  self.ui.detail.anchoredPosition = Vector2.zero
  self.ui.canvasGroup_root.alpha = 0
end

function UINSpring23StoryBaseItem:SetSpring23StoryItemTween(delayTime, sequeceTween)
  sequeceTween:InsertCallback(delayTime, function()
    self.ui.ani_root:Play()
  end)
  sequeceTween:Insert(delayTime, self.ui.detail:DOLocalMoveY(-20, 0.5):From():SetAutoKill(false))
end

function UINSpring23StoryBaseItem:__InitUI()
  if self._interactCfg ~= nil and not self._hideReward then
    local itemId = self._interactCfg.important_reward_ids[1]
    local itemCount = self._interactCfg.important_reward_nums[1]
    if itemId ~= nil then
      self._item.gameObject:SetActive(true)
      local itemCfg = ConfigData.item[itemId]
      self._item:InitItemWithCount(itemCfg, itemCount)
    else
      self._item.gameObject:SetActive(false)
    end
  else
    self._item.gameObject:SetActive(false)
  end
  local avgCfg = ConfigData.story_avg[self._interactInfoCfg.id]
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(avgCfg.name)
end

function UINSpring23StoryBaseItem:RefreshSpring23StoryState()
  self._played = false
  if self._interactCfg ~= nil and self._springStoryData ~= nil then
    self._played = self._springStoryData:GetThisTalkStateById(self._interactCfg.id) or false
  elseif self._forceLooked then
    self._played = true
  else
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    self._played = avgPlayCtrl:IsAvgPlayed(self._interactInfoCfg.id)
  end
  self._item:SetPickedUIActive(self._played)
  self.ui.obj_Checked:SetActive(self._played)
  self.ui.obj_Check:SetActive(not self._played)
end

function UINSpring23StoryBaseItem:__SetExtraCondition()
  if self._interactCfg == nil then
    return
  end
  local heroCfg = ConfigData.hero_data[self._interactCfg.interact_character]
  local heroName = LanguageUtil.GetLocaleText(heroCfg.name)
  local itemNum = tostring(self._interactCfg.needNum)
  local itemId = self._interactCfg.needItem
  local giftTip = ConfigData:GetTipContent(9107, heroName, itemNum, LanguageUtil.GetLocaleText(ConfigData.item[itemId].name))
  self._avgDetailData:SetAvgDetailExtraCondition(self._played, giftTip)
end

function UINSpring23StoryBaseItem:__CraetAvgDetailData()
  self._avgDetailData = Data_UIAvgDetail.New()
  self._avgDetailData:SetAvgDetailAvgId(self._interactInfoCfg.id)
  self._avgDetailData:SetAvgDetailBannerTexPath(self._interactInfoCfg.bg)
  self._avgDetailData:SetAvgDetailExTitle(self._interactInfoCfg.index)
  self._avgDetailData:SetAvgDetailExtraPlayedState(self._played)
  if self._hideReward then
    self._avgDetailData:SetAvgDetailRewardShowState(false)
  end
  if self._interactCfg ~= nil then
    local rewardDic = {}
    for i, itemid in ipairs(self._interactCfg.reward_ids) do
      rewardDic[itemid] = self._interactCfg.reward_nums[i]
    end
    self._avgDetailData:SetAvgDetailExtraReward(rewardDic)
  end
  self:__SetExtraCondition()
end

function UINSpring23StoryBaseItem:OnClickAvgDetail()
  if self._avgDetailData == nil then
    self:__CraetAvgDetailData()
  end
  if self._detailCallback ~= nil then
    self._detailCallback(self._avgDetailData, self)
  end
end

return UINSpring23StoryBaseItem
