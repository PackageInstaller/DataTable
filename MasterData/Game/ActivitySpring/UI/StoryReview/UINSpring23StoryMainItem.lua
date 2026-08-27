local base = require("Game.ActivitySpring.UI.StoryReview.UINSpring23StoryBaseItem")
local UINSpring23StoryMainItem = class("UINSpring23StoryMainItem", base)
local CS_Image = CS.UnityEngine.UI.Image

function UINSpring23StoryMainItem:__InitUI()
  base.__InitUI(self)
  if self._tagList == nil then
    self._tagList = {}
    table.insert(self._tagList, self.ui.picItem)
  end
  local tags = self._interactInfoCfg.tags
  if tags[1] == nil then
    return
  end
  local count = 0
  for _, iconName in ipairs(tags) do
    count = count + 1
    local item = self._tagList[count]
    if item == nil then
      local go = self.ui.picItem:Instantiate(self.ui.picItem.transform.parent)
      item = go:GetComponentInParent(typeof(CS_Image))
      table.insert(self._tagList, item)
    end
    item.gameObject:SetActive(true)
    item.sprite = AtlasUtil.GetSpriteFromAtlas("UI_Spring23Story", iconName, self._resloader)
  end
  for i = count + 1, #self._tagList do
    self._tagList[i].gameObject:SetActive(false)
  end
end

function UINSpring23StoryMainItem:__SetExtraCondition()
  base.__SetExtraCondition(self)
  if self._interactCfg == nil or self._interactCfg.pre_interact[1] == nil then
    return
  end
  local isPreFinish = true
  if self._springStoryData ~= nil then
    for i, preId in ipairs(self._interactCfg.pre_interact) do
      if not self._springStoryData:GetThisTalkStateById(preId) then
        isPreFinish = false
        break
      end
    end
  else
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    for i, preId in ipairs(self._interactCfg.pre_interact) do
      local preCfg = ConfigData.activity_interact[self._interactCfg.activity_id][preId]
      if not avgPlayCtrl:IsAvgPlayed(preCfg.story) then
        isPreFinish = false
        break
      end
    end
  end
  local preFirstId = self._interactCfg.pre_interact[1]
  local preFinishTip = ""
  local mapping = ConfigData.activity_interact_main_story.stageMapping[self._interactCfg.activity_id]
  local mainStoryId = mapping ~= nil and mapping[preFirstId] or nil
  if mainStoryId ~= nil then
    local mainStoryCfg = ConfigData.activity_interact_main_story[self._interactCfg.activity_id][mainStoryId]
    preFinishTip = ConfigData:GetTipContent(9106, LanguageUtil.GetLocaleText(mainStoryCfg.name))
  end
  self._avgDetailData:SetAvgDetailExtraCondition(isPreFinish, preFinishTip)
end

return UINSpring23StoryMainItem
