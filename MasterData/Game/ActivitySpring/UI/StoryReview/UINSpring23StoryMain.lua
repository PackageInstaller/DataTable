local UINSpring23StoryMain = class("UINSpring23StoryMain", UIBaseNode)
local base = UIBaseNode
local UINSpring23StoryMainLine = require("Game.ActivitySpring.UI.StoryReview.UINSpring23StoryMainLine")
local CS_DOTween = CS.DG.Tweening.DOTween
local eDynConfigData = require("Game.ConfigData.eDynConfigData")

function UINSpring23StoryMain:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.activity_interact_main_story)
  ConfigData:LoadDynCfg(eDynConfigData.activity_interact)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_rect, self, self.OnCliCkRect)
  self._itemPool = UIItemPool.New(UINSpring23StoryMainLine, self.ui.mainStoryItem)
  self.ui.mainStoryItem:SetActive(false)
end

function UINSpring23StoryMain:InitSpring23StoryMain(springStoryData, resloader, detailCallback)
  local actId = springStoryData:GetStoryActId()
  self:__Init(actId, springStoryData, resloader, detailCallback)
end

function UINSpring23StoryMain:InitSpring23StoryMainReview(actId, resloader, detailCallback)
  self:__Init(actId, nil, resloader, detailCallback)
end

function UINSpring23StoryMain:__Init(actId, springStoryData, resloader, detailCallback)
  local cfgList = ConfigData.activity_interact_main_story[actId]
  self._itemPool:HideAll()
  for i, v in ipairs(cfgList) do
    local item = self._itemPool:GetOne()
    item:InitSpring23StoryMainLine(springStoryData, v, resloader, detailCallback)
  end
  self:__SetEnterTween()
end

function UINSpring23StoryMain:OnCliCkRect()
  if UIUtil.CheckTopIsWindow(UIWindowTypeID.AvgDetail) then
    UIUtil.OnClickBackByUiTab(self)
  end
end

function UINSpring23StoryMain:OnShow()
  base.OnShow(self)
  self.ui.btn_rect.transform.anchoredPosition = Vector2.zero
  if self._tween ~= nil then
    self:__SetEnterTween()
  end
end

function UINSpring23StoryMain:__SetEnterTween()
  if self._tween ~= nil then
    self._tween:Kill()
  end
  for i, v in ipairs(self._itemPool.listItem) do
    v:ResetSpring23StoryMainLineAniState()
  end
  self._tween = CS_DOTween.Sequence()
  for i, v in ipairs(self._itemPool.listItem) do
    v:SetSpring23StoryMainLineTween((i - 1) * 0.1, self._tween)
  end
  self._tween:PlayForward()
end

function UINSpring23StoryMain:__PlayEnterTween()
  for i, v in ipairs(self._itemPool.listItem) do
    v:ResetSpring23StoryMainLineAniState()
  end
  self._tween:Restart()
  self._tween:PlayForward()
end

function UINSpring23StoryMain:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_interact_main_story)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_interact)
  base.OnDelete(self)
  if self._tween ~= nil then
    self._tween:Kill()
    self._tween = nil
  end
end

return UINSpring23StoryMain
