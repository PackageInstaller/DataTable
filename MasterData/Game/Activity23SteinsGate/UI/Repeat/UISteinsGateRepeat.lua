local base = UIBaseWindow
local UISteinsGateRepeat = class("UISteinsGateRepeat", base)
local cs_Ease = CS.DG.Tweening.Ease
local cs_LoopType = CS.DG.Tweening.LoopType
local UINSteGtRepeatStory = require("Game.Activity23SteinsGate.UI.Repeat.Story.UINSteGtRepeatStory")
local UINSteGtRepeatItem = require("Game.Activity23SteinsGate.UI.Repeat.UINSteGtRepeatItem")
local DungeonCenterUtil = require("Game.DungeonCenter.Util.DungeonCenterUtil")

function UISteinsGateRepeat:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._CloseRepeatDungeon):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  self._stageItemPool = UIItemPool.New(UINSteGtRepeatItem, self.ui.item, false)
  self.__OnSelectDungeon = BindCallback(self, self._OnSelectDungeon)
  self.ui.obj_Selected:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_Story, self, self._OnClickStory)
  self.ui.storyNode:SetActive(false)
end

function UISteinsGateRepeat:InitSteinsGateRepeat(actDungeonLevelCollect, callback, battleReturnFunc)
  self._actDungeonLevelCollect = actDungeonLevelCollect
  self._callback = callback
  self._battleReturnFunc = battleReturnFunc
  local dungeonlist = self._actDungeonLevelCollect:GetActDungeonSortList()
  local posTrIndexDic = {}
  for i, posObj in ipairs(self.ui.pos_list) do
    local dungeonLevelData = dungeonlist[i]
    if dungeonLevelData == nil then
      posObj.gameObject:SetActive(false)
    else
      posObj.gameObject:SetActive(true)
      posTrIndexDic[posObj] = i
      local item = self._stageItemPool:GetOne(true)
      item:InitSteGtRepeatItem(dungeonLevelData, i, self.__OnSelectDungeon)
      item.transform:SetParent(posObj)
      item.transform.anchoredPosition = Vector2.zero
      item:PlaySteGtRepeatItemAnim()
    end
  end
  local actBase = actDungeonLevelCollect:GetActDungeonActBase()
  DungeonCenterUtil.TryPlayRepeatDungeonEnterAvg(actBase:GetActFrameId())
  self:PlaySteinsGateRepeatAnim()
end

local BgX = UIManager.BackgroundStretchSize.x

function UISteinsGateRepeat:__PlayMoveLeftTween(isLeft, offset, pointX, duration)
  self.ui.moveTarget:DOKill()
  if not isLeft then
    self.ui.moveTarget:DOLocalMoveX(0, self.duration)
    self.duration = 0
    return
  end
  local target = -(BgX - offset) / 2
  local move = target - pointX
  move = math.clamp(move, -offset, 0)
  self.ui.moveTarget:DOLocalMoveX(move, duration)
  self.duration = duration
end

function UISteinsGateRepeat:_OnSelectDungeon(dungeonLevelData, item)
  if self._selectDungeon == dungeonLevelData then
    return
  end
  self._selectDungeon = dungeonLevelData
  self.ui.obj_Selected:SetActive(true)
  self.ui.obj_Selected.transform:SetParent(item.transform)
  self.ui.obj_Selected.transform.anchoredPosition = Vector2.zero
  self:SteinsGateRepeatSelectAnim(0)
  dungeonLevelData:SetRepeatDgLvReturnFunc(self._battleReturnFunc)
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonLevelDetail, function(window)
    window:CloseDgLvDetailShowAudio()
    window:SetDunLevelDetaiHideStartEvent(function()
      self:__PlayMoveLeftTween(false)
      self._selectDungeon = nil
      self.ui.obj_Selected:SetActive(false)
      self:__StopSelectAnim()
    end)
    local width, duration = window:GetDLevelDetailWidthAndDuration()
    self:__PlayMoveLeftTween(true, width, item.transform.parent.localPosition.x, duration)
    window:InitDungeonLevelDetail(self._selectDungeon, not self._selectDungeon:GetIsLevelUnlock())
    window:SetDungeonLevelBgClose(true)
  end, UIWindowTypeID.DungeonLevelDetailSteinsGate)
end

function UISteinsGateRepeat:_OnClickStory()
  if self._storyNode == nil then
    self._storyNode = UINSteGtRepeatStory.New()
    self._storyNode:Init(self.ui.storyNode)
  end
  local actBase = self._actDungeonLevelCollect:GetActDungeonActBase()
  self._storyNode:Show()
  self._storyNode:InitSteGtRepeatStory(actBase:GetActFrameId())
end

function UISteinsGateRepeat:PlaySteinsGateRepeatAnim()
  if IsNull(self.ui.anim_paper) then
    return
  end
  self:__StopAnim()
  self.ui.anim_paper.gameObject.transform:DOScaleY(0.2, 0.25):From():SetEase(cs_Ease.OutQuart):SetLink(self.gameObject)
  self.ui.anim_paper:DOFade(0, 0.25):From():SetEase(cs_Ease.OutQuart):SetLink(self.gameObject)
end

function UISteinsGateRepeat:__StopAnim()
  if IsNull(self.ui.anim_paper) then
    return
  end
  self.ui.anim_paper.gameObject.transform:DOComplete()
  self.ui.anim_paper:DOComplete()
end

function UISteinsGateRepeat:SteinsGateRepeatSelectAnim(delayTime)
  self:__StopSelectAnim()
  if delayTime == nil then
    delayTime = 0
  end
  self.ui.anim_SelectedCircle:DOFade(0, 0.25):From():SetDelay(delayTime):SetLink(self.gameObject)
  self.ui.anim_SelectedCircle.transform:DOScale(1.3, 0.25):From():SetDelay(delayTime):SetLink(self.gameObject)
  self.ui.anim_SelectedArrow:DOFade(0, 0.25):From():SetDelay(delayTime + 0.2):SetLink(self.gameObject)
  self.__SelectedArrowAnim = self.ui.anim_SelectedArrow.transform:DOLocalMove(Vector3.New(-148, 129, 0), 0.4):SetDelay(delayTime + 0.2):SetLink(self.gameObject):SetLoops(-1, cs_LoopType.Yoyo):SetEase(cs_Ease.OutQuart)
end

function UISteinsGateRepeat:__StopSelectAnim()
  self.ui.anim_SelectedCircle:DOComplete()
  self.ui.anim_SelectedCircle.transform:DOComplete()
  self.ui.anim_SelectedArrow:DOComplete()
  if self.__SelectedArrowAnim ~= nil then
    self.__SelectedArrowAnim:Rewind()
    self.__SelectedArrowAnim:Kill()
    self.__SelectedArrowAnim = nil
  end
end

function UISteinsGateRepeat:_CloseRepeatDungeon(toHome)
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

function UISteinsGateRepeat:OnDelete()
  if self._storyNode ~= nil then
    self._storyNode:Delete()
  end
  self:__StopSelectAnim()
  self:__StopAnim()
  self._stageItemPool:DeleteAll()
  self.ui.moveTarget:DOKill()
  base.OnDelete(self)
end

return UISteinsGateRepeat
