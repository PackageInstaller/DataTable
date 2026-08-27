local base = UIBaseNode
local UINSteGtRepeatStory = class("UINSteGtRepeatStory", base)
local CS_DOTween = CS.DG.Tweening.DOTween
local UINSteGtRepeatStoryItem = require("Game.Activity23SteinsGate.UI.Repeat.Story.UINSteGtRepeatStoryItem")

function UINSteGtRepeatStory:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Bg, self, self._OnClickClose)
  self._storyItemPool = UIItemPool.New(UINSteGtRepeatStoryItem, self.ui.item, false)
  self._OnPlayAvgFunc = BindCallback(self, self._OnPlayAvg)
end

function UINSteGtRepeatStory:InitSteGtRepeatStory(actFrameId)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(BindCallback(self, self.Hide)):PushTopStatusDataToBackStack()
  local cfgList = ConfigData.act_general_repeat_dg_story[actFrameId]
  if cfgList == nil then
    error("cant get act_general_repeat_dg_story, actFrameId:" .. tostring(actFrameId))
    return
  end
  self._storyItemPool:HideAll()
  for k, cfg in ipairs(cfgList) do
    local item = self._storyItemPool:GetOne()
    item:InitSteGtRepeatStoryItem(k, cfg, self._OnPlayAvgFunc)
  end
  self:_PlayShowTween()
end

function UINSteGtRepeatStory:_PlayShowTween()
  if self.sequence ~= nil then
    self.sequence:Complete(true)
    self.sequence = nil
  end
  self.sequence = CS_DOTween.Sequence():Append(self.ui.canvasGroup:DOFade(0, 0.1):From()):AppendInterval(0.3):Append(self.ui.cg_holder:DOFade(0, 0.35):From()):Join(self.ui.list:DOAnchorPosY(-85, 0.5):From()):Join(self.ui.desBg:DOAnchorPosY(-73, 0.5):From()):Join(self.ui.title:DOAnchorPosY(60, 0.5):From()):SetLink(self.gameObject)
end

function UINSteGtRepeatStory:_OnPlayAvg(avgId)
  ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, avgId)
end

function UINSteGtRepeatStory:_OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UINSteGtRepeatStory:OnDelete()
  self._storyItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINSteGtRepeatStory
