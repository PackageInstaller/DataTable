local UINSpring23StoryChar = class("UINSpring23StoryChar", UIBaseNode)
local base = UIBaseNode
local UINSpring23StoryCharLine = require("Game.ActivitySpring.UI.StoryReview.UINSpring23StoryCharLine")
local ActivitySpringStoryEnum = require("Game.ActivitySpring.Data.ActivitySpringStoryEnum")
local CS_DOTween = CS.DG.Tweening.DOTween

function UINSpring23StoryChar:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_rect, self, self.OnCliCkRect)
  self._itemPool = UIItemPool.New(UINSpring23StoryCharLine, self.ui.charStoryItem)
  self.ui.charStoryItem:SetActive(false)
  self.__OnShowExtraCallback = BindCallback(self, self.OnSpring23StoryShowExtra)
end

function UINSpring23StoryChar:InitSpring23StoryChar(springStoryData, resloader, extraClickFunc, avgDetailCallback)
  local actId = springStoryData:GetStoryActId()
  self:__Init(actId, springStoryData, resloader, extraClickFunc, avgDetailCallback)
end

function UINSpring23StoryChar:InitSpring23StoryCharReview(actId, resloader, extraClickFunc, avgDetailCallback)
  self:__Init(actId, nil, resloader, extraClickFunc, avgDetailCallback)
end

function UINSpring23StoryChar:__Init(actId, springStoryData, resloader, extraClickFunc, avgDetailCallback)
  self._extraClickFunc = extraClickFunc
  local storyCfg = ConfigData.activity_interact[actId]
  self._heroStoryData = {}
  self._heroSort = {}
  for k, v in pairs(storyCfg) do
    self:__AddheroTable(v)
  end
  self:__SortHeroTable()
  self._itemPool:HideAll()
  for i, heroId in ipairs(self._heroSort) do
    local item = self._itemPool:GetOne()
    item:InitSpring23StoryCharLine(springStoryData, heroId, self._heroStoryData[heroId].side, resloader, self.__OnShowExtraCallback, avgDetailCallback)
  end
  self:__SetEnterTween()
end

function UINSpring23StoryChar:__AddheroTable(interactCfg)
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

function UINSpring23StoryChar:__SortHeroTable()
  local heroWeight = {}
  for k, v in pairs(self._heroStoryData) do
    table.sort(v.side, function(a, b)
      return a.id < b.id
    end)
    table.sort(v.fixReward, function(a, b)
      return a.id < b.id
    end)
    table.insert(self._heroSort, k)
    heroWeight[k] = v.side[1].id
  end
  table.sort(self._heroSort, function(a, b)
    return heroWeight[a] < heroWeight[b]
  end)
end

function UINSpring23StoryChar:OnShow()
  base.OnShow(self)
  self.ui.btn_rect.transform.anchoredPosition = Vector2.zero
  if self._tween ~= nil then
    self:__SetEnterTween()
  end
end

function UINSpring23StoryChar:__SetEnterTween()
  if self._tween ~= nil then
    self._tween:Kill()
  end
  for i, v in ipairs(self._itemPool.listItem) do
    v:ResetSpring23StoryCharLineAniState()
  end
  self._tween = CS_DOTween.Sequence()
  for i, v in ipairs(self._itemPool.listItem) do
    v:SetSpring23StoryCharLineTween((i - 1) * 0.1, self._tween)
  end
  self._tween:PlayForward()
end

function UINSpring23StoryChar:__PlayEnterTween()
  for i, v in ipairs(self._itemPool.listItem) do
    v:ResetSpring23StoryCharLineAniState()
  end
  self._tween:Restart()
  self._tween:PlayForward()
end

function UINSpring23StoryChar:OnSpring23StoryShowExtra(heroId)
  if self._extraClickFunc ~= nil then
    local heroStory = self._heroStoryData[heroId]
    self._extraClickFunc(heroId, heroStory.fixReward, heroStory.ranReward)
  end
end

function UINSpring23StoryChar:OnCliCkRect()
  if UIUtil.CheckTopIsWindow(UIWindowTypeID.AvgDetail) then
    UIUtil.OnClickBackByUiTab(self)
  end
end

function UINSpring23StoryChar:OnDelete()
  base.OnDelete(self)
  if self._tween ~= nil then
    self._tween:Kill()
    self._tween = nil
  end
end

return UINSpring23StoryChar
