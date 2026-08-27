local UINSpring23StoryMainLine = class("UINSpring23StoryMainLine", UIBaseNode)
local base = UIBaseNode
local UINSpring23StoryMainItem = require("Game.ActivitySpring.UI.StoryReview.UINSpring23StoryMainItem")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")

function UINSpring23StoryMainLine:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._itemPool = UIItemPool.New(UINSpring23StoryMainItem, self.ui.awardItem)
  self.ui.awardItem:SetActive(false)
end

function UINSpring23StoryMainLine:InitSpring23StoryMainLine(springStoryData, mainStoryCfg, resloader, detailCallback)
  if mainStoryCfg.id < 10 then
    self.ui.tex_Num.text = "0" .. tostring(mainStoryCfg.id)
  else
    self.ui.tex_Num.text = tostring(mainStoryCfg.id)
  end
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(mainStoryCfg.name)
  self._itemPool:HideAll()
  if mainStoryCfg.interact_id[1] ~= nil then
    for i, interactId in ipairs(mainStoryCfg.interact_id) do
      local interactCfg = ConfigData.activity_interact[mainStoryCfg.activity_id][interactId]
      local item = self._itemPool:GetOne()
      if springStoryData ~= nil then
        item:InitSpring23StoryItem(springStoryData, interactCfg, resloader, detailCallback)
      else
        item:InitSpring23StoryItemReview(interactCfg, resloader, detailCallback)
      end
    end
  else
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local actFrameId = mainStoryCfg.activity_id
    local lobbyCfg = ConfigData.activity_lobby[actFrameId]
    local item = self._itemPool:GetOne()
    if springStoryData ~= nil then
      item:InitSpring23StoryItemJustAvg(lobbyCfg.first_avg, resloader, detailCallback)
    else
      item:InitSpring23StoryItemJustAvgReview(lobbyCfg.first_avg, resloader, detailCallback)
    end
  end
end

function UINSpring23StoryMainLine:ResetSpring23StoryMainLineAniState()
  self.ui.ani_root:Stop()
  self.ui.canvasGroup_root.alpha = 0
  self.ui.detail.anchoredPosition = Vector2.zero
  for i, v in ipairs(self._itemPool.listItem) do
    v:ResetSpring23StoryItemAniState()
  end
end

function UINSpring23StoryMainLine:SetSpring23StoryMainLineTween(delayTime, sequeceTween)
  sequeceTween:InsertCallback(delayTime, function()
    self.ui.ani_root:Play()
  end)
  sequeceTween:Insert(delayTime, self.ui.detail:DOLocalMoveY(-50, 0.5):From():SetAutoKill(false))
  for i, v in ipairs(self._itemPool.listItem) do
    v:SetSpring23StoryItemTween(delayTime + (i - 1) * 0.1, sequeceTween)
  end
end

return UINSpring23StoryMainLine
