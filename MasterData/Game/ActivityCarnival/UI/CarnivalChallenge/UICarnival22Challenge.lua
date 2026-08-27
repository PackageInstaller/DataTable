local UICarnival22Challenge = class("UICarnival22Challenge", UIBaseWindow)
local base = UIBaseWindow
local CarnivalDungeonLevelData = require("Game.ActivityCarnival.CarnivalDungeonLevelData")
local UINCarnival22ChallengeItem = require("Game.ActivityCarnival.UI.CarnivalChallenge.UINCarnival22ChallengeItem")
local UINCarnival22ChallengeRank = require("Game.ActivityCarnival.UI.CarnivalChallenge.UINCarnival22ChallengeRank")
local CS_Resloader = CS.ResLoader

function UICarnival22Challenge:OnInit()
  UIUtil.SetTopStatus(self, self.OnChallengeClose)
  UIUtil.AddButtonListener(self.ui.btn_Rank, self, self.OnClickRank)
  UIUtil.AddButtonListener(self.ui.btn_Info, self, self.OnClickIntro)
  self._itemPool = UIItemPool.New(UINCarnival22ChallengeItem, self.ui.challengeItem)
  self.ui.challengeItem:SetActive(false)
  self._resloder = CS_Resloader.Create()
  self.__OnSelectItemCallback = BindCallback(self, self.__OnSelectItem)
  self.__BackFromeDetailCallback = BindCallback(self, self.__BackFromeDetail)
end

function UICarnival22Challenge:InitCarnivalChallenge(carnivalData)
  self._carnivalData = carnivalData
  local levelTypeCfg = self._carnivalData:GetCarnivalHardLevelCfg()
  local dungeonIdList = levelTypeCfg.dungeon_levels
  self._itemPool:HideAll()
  for index, dungeonId in ipairs(dungeonIdList) do
    local item = self._itemPool:GetOne()
    local parentTr = self.ui.itemPosList[index]
    item.transform:SetParent(parentTr)
    item.transform.anchoredPosition = Vector2.zero
    item:InitCarnivalChallegeItem(self._carnivalData, dungeonId, self.__OnSelectItemCallback)
    local bgName = "UI_Carnival22ChallengeBg" .. tostring(index)
    self._resloder:LoadABAssetAsync(PathConsts:GetCarnivalPic(bgName), function(texture)
      item:SetCarnivalChallengeBg(texture)
    end)
  end
  self._selectDungeonId = nil
end

function UICarnival22Challenge:__OnSelectItem(dungeonId)
  if self._selectDungeonId == dungeonId then
    return
  end
  self._selectDungeonId = dungeonId
  for i, item in ipairs(self._itemPool.listItem) do
    item:SetCarnivalChallengeSelect(dungeonId)
  end
  local window = UIManager:GetWindow(UIWindowTypeID.DungeonLevelDetail)
  if window == nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.DungeonLevelDetail, function(win)
      if win == nil then
        return
      end
      local dungeonLevel = CarnivalDungeonLevelData.New(self._selectDungeonId)
      dungeonLevel:SetCarnivalLevelPic(self._carnivalData:GetCarnivalHardLevelCfg().pic_small)
      win:InitDungeonLevelDetail(dungeonLevel, false)
      win:SetDungeonLevelBgClose(true)
      win:SetDunLevelDetaiHideEndEvent(self.__BackFromeDetailCallback)
    end)
  else
    window:Show()
    local dungeonLevel = CarnivalDungeonLevelData.New(self._selectDungeonId)
    dungeonLevel:SetCarnivalLevelPic(self._carnivalData:GetCarnivalHardLevelCfg().pic_small)
    window:InitDungeonLevelDetail(dungeonLevel, false)
  end
end

function UICarnival22Challenge:__BackFromeDetail()
  if IsNull(self.transform) then
    return
  end
  self._selectDungeonId = nil
  for i, item in ipairs(self._itemPool.listItem) do
    item:SetCarnivalChallengeSelect(self._selectDungeonId)
  end
end

function UICarnival22Challenge:OnClickRank()
  if self._rankNode == nil then
    self._rankNode = UINCarnival22ChallengeRank.New()
    self._rankNode:Init(self.ui.rankWindow)
    local rankId = self._carnivalData:GetCarnivalHardLevelCfg().ranklist_id
    self._rankNode:InitCarnivalChallengeRank(rankId, self._resloder)
  end
  self._rankNode:Show()
  self._rankNode:OpenCarnivalChallengeRank()
end

function UICarnival22Challenge:OnClickIntro()
  local carnivalCfg = self._carnivalData:GetCarnivalMainCfg()
  UIManager:ShowWindowAsync(UIWindowTypeID.Carnival22InfoWindow, function(win)
    if win == nil then
      return
    end
    win:InitCarnivalInfoWindow(carnivalCfg.hard_rule_id)
  end)
end

function UICarnival22Challenge:OnChallengeClose()
  UIManager:DeleteWindow(UIWindowTypeID.DungeonLevelDetail)
  self:Delete()
end

function UICarnival22Challenge:OnDelete()
  self._resloder:Put2Pool()
  self._resloder = nil
  base.OnDelete(self)
end

return UICarnival22Challenge
