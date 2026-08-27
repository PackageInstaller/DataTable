local UICommonActivityRepeatDungeon = class("UICommonActivityRepeatDungeon", UIBaseWindow)
local base = UIBaseWindow
local UINCommonActivityBG = require("Game.ActivityFrame.UI.UINCommonActivityBG")
local UINCommonActRepeatDunItem = require("Game.ActivityFrame.UI.UINCommonActRepeatDunItem")
local cs_ResLoader = CS.ResLoader

function UICommonActivityRepeatDungeon:OnInit()
  UIUtil.SetTopStatus(self, self.CloseRepeatDungeon)
  self._bgNode = UINCommonActivityBG.New()
  self._bgNode:Init(self.ui.uI_CommonActivityBG)
  self._resloader = cs_ResLoader.Create()
  self._itemPool = UIItemPool.New(UINCommonActRepeatDunItem, self.ui.item)
  self.ui.item:SetActive(false)
  self.ui.obj_OnSelect:SetActive(false)
  self.__OnSelectDungeon = BindCallback(self, self.OnSelectDungeon)
end

function UICommonActivityRepeatDungeon:InitActivityRepeatDungeon(actDungeonLevelCollect, callback)
  self._actDungeonLevelCollect = actDungeonLevelCollect
  self._callback = callback
  local actBase = self._actDungeonLevelCollect:GetActDungeonActBase()
  self._bgNode:InitActivityBG(actBase:GetActFrameId(), self._resloader)
  local cnName, enName = self._actDungeonLevelCollect:GetActDungeonTitle()
  self.ui.tex_CNTitleName.text = cnName
  self.ui.tex_ENTitleName.text = enName
  self:__CreateDungeonItemNode()
end

function UICommonActivityRepeatDungeon:__CreateDungeonItemNode()
  self._itemPool:HideAll()
  self.ui.obj_OnSelect:SetActive(false)
  local dungeonlist = self._actDungeonLevelCollect:GetActDungeonSortList()
  local posTrIndexDic = {}
  for i, posObj in ipairs(self.ui.posObjs) do
    local dungeonLevelData = dungeonlist[i]
    if dungeonLevelData == nil then
      posObj:SetActive(false)
    else
      posObj:SetActive(true)
      posTrIndexDic[posObj.transform] = i
      local item = self._itemPool:GetOne(true)
      item:InitActRepeatDunItem(dungeonLevelData, i, self.__OnSelectDungeon, self._resloader)
      item.transform:SetParent(posObj.transform)
      item.transform.anchoredPosition = Vector2.zero
    end
  end
  for _, img in ipairs(self.ui.lineImgArray) do
    local index = posTrIndexDic[img.transform.parent]
    if index ~= nil then
      local unlock = dungeonlist[index]:GetIsLevelUnlock()
      img.color = unlock and self.ui.color_unlock or self.ui.color_locked
    end
  end
end

function UICommonActivityRepeatDungeon:OnSelectDungeon(dungeonLevelData, item)
  if self._selectDungeon == dungeonLevelData then
    return
  end
  self._selectDungeon = dungeonLevelData
  self.ui.obj_OnSelect:SetActive(true)
  self.ui.obj_OnSelect.transform:SetParent(item.transform)
  self.ui.obj_OnSelect.transform.anchoredPosition = Vector2.zero
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonLevelDetail, function(window)
    window:SetDunLevelDetaiHideStartEvent(function()
      self:__PlayMoveLeftTween(false)
      self._selectDungeon = nil
      self.ui.obj_OnSelect:SetActive(false)
    end)
    local width, duration = window:GetDLevelDetailWidthAndDuration()
    self:__PlayMoveLeftTween(true, width, item.transform.parent.localPosition.x, duration)
    window:InitDungeonLevelDetail(self._selectDungeon, not self._selectDungeon:GetIsLevelUnlock())
    window:SetDungeonLevelBgClose(true)
  end)
end

local BgX = UIManager.BackgroundStretchSize.x
local n = BgX * (CS.UIManager.Instance.CurNotchValue / 100)

function UICommonActivityRepeatDungeon:__PlayMoveLeftTween(isLeft, offset, pointX, duration)
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

function UICommonActivityRepeatDungeon:CloseRepeatDungeon(toHome)
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

function UICommonActivityRepeatDungeon:OnDelete()
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  self.ui.moveTarget:DOKill()
  base.OnDelete(self)
end

return UICommonActivityRepeatDungeon
