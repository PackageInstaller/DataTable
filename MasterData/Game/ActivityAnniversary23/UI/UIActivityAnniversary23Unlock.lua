local base = UIBaseWindow
local UIActivityAnniversary23Unlock = class("UIActivityAnniversary23Unlock", base)
local UIActivityAnniversary23ChapterItem = require("Game.ActivityAnniversary23.UI.UIActivityAnniversary23ChapterItem")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local cs_Ease = CS.DG.Tweening.Ease

function UIActivityAnniversary23Unlock:OnInit()
  UIUtil.SetTopStatus(self, self.CloseFunc, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_BG, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_checkBG, self, self.OnClickJump)
  self.__chapterList = UIItemPool.New(UIActivityAnniversary23ChapterItem, self.ui.obj_chapterItem, false)
  self.__chapterList:HideAll()
  self._isSequence = false
end

function UIActivityAnniversary23Unlock:InitCommonUnlock(dataList, index, cancelFunc, jumpFunc, titleIndex)
  self.cancelFunc = cancelFunc
  self.jumpFunc = jumpFunc
  self.ui.tex_UnlockTitle:SetIndex(titleIndex or 1)
  self.ui.btn_checkBG.gameObject:SetActive(self.jumpFunc ~= nil)
  for i, name in ipairs(dataList) do
    local chapterItem = self.__chapterList:GetOne()
    if i == #dataList then
      chapterItem:InitCommonChapterItem(name, i, true)
      break
    end
    chapterItem:InitCommonChapterItem(name, i, false)
  end
  UIUtil.AddOneCover("storyBp")
  local layoutObj = self.ui.LayoutGroup.gameObject.transform
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(layoutObj)
  local oneObjSpace = -(self.ui.LayoutGroup.spacing + self.ui.obj_chapterItem.transform.sizeDelta.x)
  local offset = (index - 2) * oneObjSpace
  layoutObj.anchoredPosition = Vector2.New(offset, 0)
  layoutObj:DOLocalMoveX(offset + oneObjSpace, 1.5):SetEase(cs_Ease.OutExpo):SetLink(self.gameObject):SetDelay(1)
  if self.coverTimer ~= nil then
    TimerManager:StopTimer(self.coverTimer)
  end
  self.coverTimer = TimerManager:StartTimer(2, function()
    UIUtil.CloseOneCover("storyBp")
  end, nil, false)
end

function UIActivityAnniversary23Unlock:InitAnniversary23Unlock(storyList, index, storyId, cancelFunc, jumpFunc)
  self.cancelFunc = cancelFunc
  self.jumpFunc = jumpFunc
  self.ui.tex_UnlockTitle:SetIndex(0)
  for i, storyId in ipairs(storyList) do
    local avgCfg = ConfigData.story_avg[storyId]
    if avgCfg ~= nil then
      local chapterItem = self.__chapterList:GetOne()
      if i == #storyList then
        chapterItem:InitChapterItem(avgCfg, i, true)
        break
      end
      chapterItem:InitChapterItem(avgCfg, i, false)
    end
  end
  local layoutObj = self.ui.LayoutGroup.gameObject.transform
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(layoutObj)
  local oneObjSpace = -(self.ui.LayoutGroup.spacing + self.ui.obj_chapterItem.transform.sizeDelta.x)
  local offset = (index - 2) * oneObjSpace
  layoutObj.anchoredPosition = Vector2.New(offset, 0)
  layoutObj:DOLocalMoveX(offset + oneObjSpace, 1.5):SetEase(cs_Ease.OutExpo):SetLink(self.gameObject):SetDelay(1)
end

function UIActivityAnniversary23Unlock:CalculateStoryListData(storyList)
  self.storyIndex = nil
  self.realNeedNum = 0
  local nowNum = 0
  local targetNum = 0
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  for i, storyId in ipairs(storyList) do
    local avgCfg = ConfigData.story_avg[storyId]
    if avgCfg ~= nil then
      local chapterItem = self.__chapterList:GetOne()
      if i == #storyList then
        chapterItem:InitChapterItem(avgCfg, i, true)
        break
      end
      chapterItem:InitChapterItem(avgCfg, i, false)
      if avgCfg.pre_condition[1] == CheckerTypeId.ActivityGeneralNormal then
        targetNum = targetNum + 1
        local taskId = avgCfg.pre_para1[1]
        if actFrameCtrl:isCompleteActivityTask(taskId) then
          nowNum = nowNum + 1
        end
      end
    end
  end
  self.storyIndex = nowNum + 1
end

function UIActivityAnniversary23Unlock:PlayStoryUnLockSequence(storyList, jumpFunc)
  UIUtil.AddOneCover("storyBp")
  self:CalculateStoryListData(storyList)
  local anniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
  local sequence = anniversary23Ctrl:GetStoryChangeSequence()
  self._isSequence = true
  sequence:AppendCallback(function()
    anniversary23Ctrl:TryPlayStarChapterTimeLine()
    anniversary23Ctrl:ChangeTimeLineState(true)
  end)
  sequence:AppendInterval(0.5)
  sequence:AppendCallback(function()
    UIUtil.CloseOneCover("storyBp")
  end)
  self.ui.tex_UnlockTitle:SetIndex(0)
  local layoutObj = self.ui.LayoutGroup.gameObject.transform
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(layoutObj)
  local oneObjSpace = -(self.ui.LayoutGroup.spacing + self.ui.obj_chapterItem.transform.sizeDelta.x)
  local offset = (self.storyIndex - 2) * oneObjSpace
  layoutObj.anchoredPosition = Vector2.New(offset, 0)
  self._layoutTweener = layoutObj:DOLocalMoveX(offset + oneObjSpace, 1.5):SetEase(cs_Ease.OutExpo):SetLink(self.gameObject):SetDelay(1)
  
  function self.cancelFunc()
    if self._layoutTweener == nil or not self._layoutTweener:IsActive() then
      anniversary23Ctrl:ChangeTimeLineState(false, 2)
      self._layoutTweener = nil
      self._isSequence = false
      UIUtil.OnClickBackByUiTab(self)
    else
      self._layoutTweener:Complete(true)
      self._layoutTweener:Kill()
      self._layoutTweener = nil
      self._isSequence = false
    end
  end
  
  function self.jumpFunc()
    anniversary23Ctrl:ClearStoryChangeSequence()
    anniversary23Ctrl:ChangeTimeLineState(false, 2)
    if jumpFunc then
      jumpFunc()
    end
  end
end

function UIActivityAnniversary23Unlock:OnClickClose()
  if self._isSequence then
    if self.cancelFunc and not self.isJump then
      self.cancelFunc()
    end
  else
    UIUtil.OnClickBackByUiTab(self)
  end
end

function UIActivityAnniversary23Unlock:CloseFunc()
  if self.cancelFunc and not self.isJump then
    self.cancelFunc()
  end
  self:Delete()
end

function UIActivityAnniversary23Unlock:OnClickJump()
  if self.jumpFunc then
    self.jumpFunc()
  end
  self.isJump = true
  UIUtil.OnClickBackByUiTab(self)
end

function UIActivityAnniversary23Unlock:OnDelete()
  if self._layoutTweener ~= nil then
    self._layoutTweener = nil
  end
  if self.coverTimer ~= nil then
    TimerManager:StopTimer(self.coverTimer)
    self.coverTimer = nil
  end
  UIUtil.CloseOneCover("storyBp")
  base.OnDelete(self)
end

return UIActivityAnniversary23Unlock
