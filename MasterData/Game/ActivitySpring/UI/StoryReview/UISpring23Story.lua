local UISpring23Story = class("UISpring23Story", UIBaseWindow)
local base = UIBaseWindow
local UINSpring23StoryMain = require("Game.ActivitySpring.UI.StoryReview.UINSpring23StoryMain")
local UINSpring23StoryChar = require("Game.ActivitySpring.UI.StoryReview.UINSpring23StoryChar")
local UINSpring23StoryTeam = require("Game.ActivitySpring.UI.StoryReview.Team.UINSpring23StoryTeam")
local UINSpring23StoryPage = require("Game.ActivitySpring.UI.StoryReview.UINSpring23StoryPage")
local UINSpring23StoryCharExtra = require("Game.ActivitySpring.UI.StoryReview.UINSpring23StoryCharExtra")
local UINSpring23StoryTeamExtra = require("Game.ActivitySpring.UI.StoryReview.Team.UINSpring23StoryLvRewardShow")
local UINCommonActivityBG = require("Game.ActivityFrame.UI.UINCommonActivityBG")
local ActivitySpringStoryEnum = require("Game.ActivitySpring.Data.ActivitySpringStoryEnum")
local cs_ResLoader = CS.ResLoader

function UISpring23Story:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseSpring23Story)
  self._pagePool = UIItemPool.New(UINSpring23StoryPage, self.ui.listItem)
  self.ui.listItem:SetActive(false)
  self._resloader = cs_ResLoader.Create()
  self._actBgNode = UINCommonActivityBG.New()
  self._actBgNode:Init(self.ui.UI_CommonActivityBG)
  self.__OpenExtraCallback = BindCallback(self, self.__OpenExtra)
  self.__OpenTeamExtraCallback = BindCallback(self, self.__OpenTeamExtra)
  self.__OnSelectPageCallback = BindCallback(self, self.__OnSelectPage)
  self.__OpenDetailCallback = BindCallback(self, self.__OpenDetail)
end

function UISpring23Story:_GetPageName(index)
  local pageName = ""
  if index == 1 then
    pageName = ConfigData.activity_interact_main[self._actId].main_story
  elseif self:__GetCanEnter(ConfigData.activity_interact_main[self._actId].side_story) then
    pageName = ConfigData.activity_interact_main[self._actId].side_story
  else
    pageName = ConfigData.activity_interact_main[self._actId].addup_mode
  end
  return pageName
end

function UISpring23Story:InitSpring23Story(springData, heroId, callback)
  self._springStoryData = springData:GetSpringStoryData()
  self._actId = self._springStoryData:GetStoryActId()
  self._callback = callback
  self._actBgNode:InitActivityBG(self._actId, self._resloader)
  self._pagePool:HideAll()
  for i = 1, 2 do
    local page = self._pagePool:GetOne()
    local flag = true
    if i == 2 then
      flag = self._springStoryData:IsSpringMaininteracterComplete()
    end
    page:InitSpring23StoryPage(i, flag, self.__OnSelectPageCallback, self:_GetPageName(i))
    if 1 < i then
      page:SetLockTip(self:_GetPageName(i - 1))
    end
  end
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.story)
  self:__jumpWhenEnter(heroId)
end

function UISpring23Story:__jumpWhenEnter(heroId)
  if not self._springStoryData:IsSpringMaininteracterComplete() then
    self:__OnSelectPage(1, self._pagePool.listItem[1])
    return
  end
  if self:__GetCanEnter(ConfigData.activity_interact_main[self._actId].side_story) then
    if (heroId or 0) == 0 then
      self:__OnSelectPage(1, self._pagePool.listItem[1])
      return
    end
    local sideFinish = true
    local interactCfgs = self._springStoryData:GetStoryInteractCfg()
    for id, cfg in pairs(interactCfgs) do
      if cfg.interact_character == heroId and cfg.stage_id == ActivitySpringStoryEnum.stageEnum.side and not self._springStoryData:GetThisTalkStateById(id) then
        sideFinish = false
        break
      end
    end
    self:__OnSelectPage(2, self._pagePool.listItem[2])
    if sideFinish and self._charWin then
      self._charWin:OnSpring23StoryShowExtra(heroId)
    end
  else
    self:__OnSelectPage(2, self._pagePool.listItem[2])
  end
end

function UISpring23Story:InitSpring23StoryReview(actId, callback)
  self._isReview = true
  self._actId = actId
  self._callback = callback
  self._pagePool:HideAll()
  for i = 1, 2 do
    local page = self._pagePool:GetOne()
    page:InitSpring23StoryPage(i, true, self.__OnSelectPageCallback, self:_GetPageName(i))
  end
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.story)
  self:__OnSelectPage(1, self._pagePool.listItem[1])
end

function UISpring23Story:__OnSelectPage(index, item)
  for i, v in ipairs(self._pagePool.listItem) do
    v:ActiveSpring23StoryPage(v == item)
  end
  self.ui.obj_Select:SetActive(true)
  local oldPos = self.ui.obj_Select.transform.position
  local parentPos = item.transform.position
  self.ui.obj_Select.transform.position = Vector3.New(oldPos.x, parentPos.y, oldPos.z)
  if index == 1 then
    self:__EnterMain()
  else
    if self:__GetCanEnter(ConfigData.activity_interact_main[self._actId].side_story) then
      self:__EnterChar()
    end
    if self:__GetCanEnter(ConfigData.activity_interact_main[self._actId].addup_mode) then
      self:__EnterSpecial()
    end
  end
end

function UISpring23Story:__GetCanEnter(modeStr)
  if type(modeStr) ~= "string" then
    return true
  end
  return not string.IsNullOrEmpty(modeStr)
end

function UISpring23Story:__InitEnter()
  if self._charWin ~= nil then
    self._charWin:Hide()
  else
    self.ui.charStory:SetActive(false)
  end
  if self._mainWin ~= nil then
    self._mainWin:Hide()
  else
    self.ui.mainStory:SetActive(false)
  end
  if self._specialWin ~= nil then
    self._specialWin:Hide()
  else
    self.ui.SpHolder:SetActive(false)
  end
end

function UISpring23Story:__EnterMain()
  self:__InitEnter()
  if self._mainWin == nil then
    self._mainWin = UINSpring23StoryMain.New()
    self.ui.mainStory:SetActive(true)
    self._mainWin:Init(self.ui.mainStory)
    if self._isReview then
      self._mainWin:InitSpring23StoryMainReview(self._actId, self._resloader, self.__OpenDetailCallback)
    else
      self._mainWin:InitSpring23StoryMain(self._springStoryData, self._resloader, self.__OpenDetailCallback)
    end
  else
    self._mainWin:Show()
  end
end

function UISpring23Story:__EnterChar()
  self:__InitEnter()
  if self._charWin == nil then
    self._charWin = UINSpring23StoryChar.New()
    self.ui.charStory:SetActive(true)
    self._charWin:Init(self.ui.charStory)
    if self._isReview then
      self._charWin:InitSpring23StoryCharReview(self._actId, self._resloader, self.__OpenExtraCallback, self.__OpenDetailCallback)
    else
      self._charWin:InitSpring23StoryChar(self._springStoryData, self._resloader, self.__OpenExtraCallback, self.__OpenDetailCallback)
    end
  else
    self._charWin:Show()
  end
end

function UISpring23Story:__EnterSpecial()
  self:__InitEnter()
  if self._specialWin == nil then
    local prefabName = ConfigData.activity_interact_main[self._actId].addup_prefab
    if string.IsNullOrEmpty(prefabName) then
      return
    end
    local prefabPath = PathConsts:GetUIPrefabPath(prefabName)
    self._resloader:LoadABAssetAsync(prefabPath, BindCallback(self, self._OnLoadedUIPrefab))
  else
    self._specialWin:Show()
  end
end

function UISpring23Story:_OnLoadedUIPrefab(prefabGo)
  local go = prefabGo:Instantiate(self.ui.SpHolder.transform)
  go.transform.anchoredPosition = Vector2.zero
  self.ui.SpHolder:SetActive(true)
  self._specialWin = UINSpring23StoryTeam.New()
  self._specialWin:Init(go)
  self._specialWin:InitSpring23StoryTeam(self._springStoryData, self._resloader, self.__OpenExtraCallback, self.__OpenTeamExtraCallback)
end

function UISpring23Story:__OpenTeamExtra()
  if self._isReview then
    return
  end
  if self._teamExtraWin == nil then
    self._teamExtraWin = UINSpring23StoryTeamExtra.New()
    self.ui.awardOverviewWindow:SetActive(true)
    self._teamExtraWin:Init(self.ui.awardOverviewWindow)
  else
    self._teamExtraWin:Show()
  end
  self._teamExtraWin:InitUINSpring23StoryLvRewardShow(self._springStoryData)
end

function UISpring23Story:__OpenExtra(heroId, fixReward, ranReward)
  if self._isReview then
    return
  end
  if self._extraWin == nil then
    self._extraWin = UINSpring23StoryCharExtra.New()
    self.ui.extraAwardWindow:SetActive(true)
    self._extraWin:Init(self.ui.extraAwardWindow)
  else
    self._extraWin:Show()
  end
  self._extraWin:InitSpring23StoryCharExtra(self._springStoryData, heroId, fixReward, ranReward)
end

function UISpring23Story:__OpenDetail(avgDetailData, item)
  UIManager:ShowWindowAsync(UIWindowTypeID.AvgDetail, function(win)
    if win == nil then
      return
    end
    local moveX, moveTime = win:GetAvgDetailDetailMoveWidthAndTime()
    self:__SetForAvgDetailData(avgDetailData, item, moveX, moveTime)
    win:InitAvgDetail(avgDetailData)
  end)
end

function UISpring23Story:__SetForAvgDetailData(avgDetailData, item, moveX, moveTime)
  if avgDetailData:GetAvgDetailCloseCallback() ~= nil then
    return
  end
  local targetPointX = (self.transform.sizeDelta.x - moveX) / 2
  local oriPoint = self.transform:InverseTransformPoint(item.transform.position)
  moveX = math.clamp(oriPoint.x - targetPointX, 0, moveX)
  
  local function SetAvgDetailCloseCallback()
    self.ui.detail.anchoredPosition = Vector2.zero
  end
  
  local function SetAvgDetailOpenTweenBeginCallback()
    self.ui.detail:DOLocalMoveX(-moveX, moveTime)
  end
  
  local function SetAvgDetailCloseTweenBeginCallback()
    self.ui.detail:DOLocalMoveX(0, moveTime)
  end
  
  avgDetailData:SetAvgDetailCloseCallback(SetAvgDetailCloseCallback)
  avgDetailData:SetAvgDetailOpenTweenBeginCallback(SetAvgDetailOpenTweenBeginCallback)
  avgDetailData:SetAvgDetailCloseTweenBeginCallback(SetAvgDetailCloseTweenBeginCallback)
  avgDetailData:SetAvgDetailCloseBgOpen(true)
end

function UISpring23Story:OnCloseSpring23Story()
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

function UISpring23Story:OnDelete()
  self._resloader:Put2Pool()
  if self._charWin ~= nil then
    self._charWin:Delete()
  end
  if self._mainWin ~= nil then
    self._mainWin:Delete()
  end
  base.OnDelete(self)
end

return UISpring23Story
