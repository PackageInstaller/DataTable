local base = UIBaseNode
local UINWarChessMain_PNSelectedTeamInfo = class("UINWarChessMain_PNSelectedTeamInfo", base)
local UINWCMain_HeroHeadItem = require("Game.WarChess.UI.Main.UINWCMain_HeroHeadItem")
local UINChipSmallItem = require("Game.CommonUI.Chip.UINChipSmallItem")
local UINFairyHeadItem = require("Game.Fairy.UI.Common.UINFairyHeadItem")

function UINWarChessMain_PNSelectedTeamInfo:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_ChipList, self, self._WCChipBagClick)
  self.__OnClickFairyBtn = BindCallback(self, self.OnClickFairyBtn)
  self.ui.obj_heroHeadItem:SetActive(false)
  self._wcHeroHeadPool = UIItemPool.New(UINWCMain_HeroHeadItem, self.ui.obj_heroHeadItem)
  self._smallChipPool = UIItemPool.New(UINChipSmallItem, self.ui.chipSmallItem, false)
  self.fairyHead = UINFairyHeadItem.New()
  self.fairyHead:Init(self.ui.obj_fariyHeadItem)
  self.fairyHead:Hide()
end

function UINWarChessMain_PNSelectedTeamInfo:BindSelectTeamEvent(openChipBagEvent)
  self._openChipBagEvent = openChipBagEvent
end

function UINWarChessMain_PNSelectedTeamInfo:RefreshWCTeamInfo(teamData, resloader)
  self._teamData = teamData
  self.resloader = resloader
  self:RefreshWCTeamInfoChip(true)
  self:RefreshWCTeamHeroList()
  self:RefreshWCTeamInfoHeroHp()
end

function UINWarChessMain_PNSelectedTeamInfo:RefreshWCTeamHeroList()
  self._wcHeroHeadPool:HideAll()
  local dynPlayer = self._teamData:GetTeamDynPlayer()
  for index, dynHero in pairs(dynPlayer.heroList) do
    local heroHeadItem = self._wcHeroHeadPool:GetOne()
    heroHeadItem:InitWCHeroHeadItem(dynHero, index == 1)
    heroHeadItem:Show()
  end
  local dynFairyData = dynPlayer:GetDynFairyData()
  if dynFairyData ~= nil then
    self.fairyHead:Show()
    self.fairyHead.transform:SetAsLastSibling()
    self.fairyHead:InitFairyHeadItem(dynFairyData, self.resloader, self.__OnClickFairyBtn)
  else
    self.fairyHead:Hide()
  end
end

function UINWarChessMain_PNSelectedTeamInfo:RefreshWCTeamInfoHeroHp()
  for _, heroItem in pairs(self._wcHeroHeadPool.listItem) do
    heroItem:RefreshWCHeroHp()
  end
end

function UINWarChessMain_PNSelectedTeamInfo:RefreshWCTeamInfoChip(refreshList)
  if self._teamData == nil then
    return
  end
  local wcDynPlayer = self._teamData:GetTeamDynPlayer()
  local num = wcDynPlayer.chipLimitInfo.count
  local limit = wcDynPlayer.chipLimitInfo.limit
  self.ui.tex_ChipInfo:SetIndex(0, tostring(num), tostring(limit))
  if refreshList then
    self._smallChipPool:HideAll()
    local chipList = wcDynPlayer.chipList
    for index, chipData in ipairs(chipList) do
      local chipItem = self._smallChipPool:GetOne()
      chipItem:InitChipSmallItem(chipData)
    end
  end
end

function UINWarChessMain_PNSelectedTeamInfo:GetWCSelectTeamData()
  return self._teamData
end

function UINWarChessMain_PNSelectedTeamInfo:_WCChipBagClick()
  if self._openChipBagEvent ~= nil then
    self._openChipBagEvent(self._teamData)
  end
end

function UINWarChessMain_PNSelectedTeamInfo:OnClickFairyBtn(fairyData, introHold)
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonFairyInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonFairyInfoWin(fairyData, introHold)
  end)
end

function UINWarChessMain_PNSelectedTeamInfo:OnDelete()
  self.resloader = nil
end

return UINWarChessMain_PNSelectedTeamInfo
