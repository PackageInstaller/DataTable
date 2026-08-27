local UINCardSetLockedFmtTeamItem = class("UINCardSetLockedFmtTeamItem", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadWithStarItem = require("Game.CommonUI.Hero.UINHeroHeadWithStarItem")
local UINFairyHeadItem = require("Game.Fairy.UI.Common.UINFairyHeadItem")

function UINCardSetLockedFmtTeamItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.heroItemPool = UIItemPool.New(UINHeroHeadWithStarItem, self.ui.uINHeroHeadWithStar, false)
  self.fairyHead = UINFairyHeadItem.New()
  self.fairyHead:Init(self.ui.fairyHeadItem)
  self.fairyHead:SetFairyHeadItemLvShow(true)
end

function UINCardSetLockedFmtTeamItem:InitCardSetBannedTeamItem(heroIdList, fairyUid, roundNum, battleNum, resloader)
  self.ui.tex_Title:SetIndex(0, tostring(roundNum), tostring(battleNum))
  self.heroItemPool:HideAll()
  local idx = 0
  for k, heroId in ipairs(heroIdList) do
    local heroItem = self.heroItemPool:GetOne()
    local heroData = PlayerDataCenter:GetHeroData(heroId)
    heroItem:InitHead(heroData, true)
    heroItem.transform:SetSiblingIndex(idx)
    idx = idx + 1
  end
  if 0 < fairyUid then
    local fairyCtrl = ControllerManager:GetController(ControllerTypeId.Fairy, true)
    local fairyData = fairyCtrl:GetFairyDataByUID(fairyUid)
    if fairyData == nil then
      error("can't get new fairyData UID:" .. tostring(fairyUid))
      return
    else
      self.fairyHead:InitFairyHeadItem(fairyData, resloader)
      self.fairyHead:Show()
      self.fairyHead.transform:SetAsLastSibling()
    end
  else
    self.fairyHead:Hide()
  end
end

function UINCardSetLockedFmtTeamItem:InitCardSetRankBannedTeamItem(heroList, fairyData, roundNum, resloader)
  self.ui.tex_Title:SetIndex(1, tostring(roundNum))
  self.heroItemPool:HideAll()
  local idx = 0
  for k, heroData in ipairs(heroList) do
    local heroItem = self.heroItemPool:GetOne()
    heroItem:InitHead(heroData, true)
    heroItem.transform:SetSiblingIndex(idx)
    idx = idx + 1
  end
  if fairyData ~= nil then
    self.fairyHead:InitFairyHeadItem(fairyData, resloader)
    self.fairyHead:Show()
    self.fairyHead.transform:SetAsLastSibling()
  else
    self.fairyHead:Hide()
  end
end

function UINCardSetLockedFmtTeamItem:OnDelete()
  self.heroItemPool:DeleteAll()
  self.fairyHead:Delete()
  base.OnDelete(self)
end

return UINCardSetLockedFmtTeamItem
