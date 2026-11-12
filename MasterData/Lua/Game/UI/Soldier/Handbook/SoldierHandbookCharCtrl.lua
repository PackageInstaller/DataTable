local SoldierHandbookCharCtrl = class("SoldierHandbookCharCtrl", BaseCtrl)
local tabType = {
  All = 1,
  Gold = 2,
  Purple = 3,
  Blue = 4,
  Green = 5,
  White = 6
}
local tab2ChessRarity = {
  [tabType.All] = 1,
  [tabType.Gold] = GameEnum.ChessRarity.Gold,
  [tabType.Purple] = GameEnum.ChessRarity.Purple,
  [tabType.Blue] = GameEnum.ChessRarity.Blue,
  [tabType.Green] = GameEnum.ChessRarity.Green,
  [tabType.White] = GameEnum.ChessRarity.White
}
SoldierHandbookCharCtrl._mapNodeConfig = {
  btn_tab = {
    nCount = 6,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tab"
  },
  tab_On = {nCount = 6},
  tab_Off = {nCount = 6},
  sv_loop = {
    sComponentName = "LoopScrollView"
  },
  DetailCtrl = {
    sNodeName = "DetailRoot",
    sCtrlName = "Game.UI.Soldier.Handbook.SoldierHandbookCharDetailCtrl"
  }
}
SoldierHandbookCharCtrl._mapEventConfig = {}
SoldierHandbookCharCtrl._mapRedDotConfig = {}

function SoldierHandbookCharCtrl:OnDestroy()
  self:Clear()
end

function SoldierHandbookCharCtrl:Clear()
  if self.tbItemCtrl ~= nil then
    for _, v in ipairs(self.tbItemCtrl) do
      self:UnbindCtrlByNode(v)
    end
    self.tbItemCtrl = {}
  end
  self._mapNode.DetailCtrl:Clear()
end

function SoldierHandbookCharCtrl:Init()
  self.tbItemCtrl = {}
  self:InitCharList()
  self:SwitchToTab(tabType.All, true)
end

function SoldierHandbookCharCtrl:InitCharList()
  self.tbAllChar = {}
  self.mapCharByRarity = {}
  local nSeasonId = PlayerData.SoldierData:GetCurSelectSeasonId()
  local seasonConfig = ConfigTable.GetData("SoldierSeason", nSeasonId)
  if seasonConfig == nil then
    return
  end
  
  local function func_ForEach_Char(mapCharData)
    if mapCharData.BoardChess and seasonConfig.ChessGroupId == mapCharData.GroupId then
      table.insert(self.tbAllChar, mapCharData)
      if self.mapCharByRarity[mapCharData.Rarity] == nil then
        self.mapCharByRarity[mapCharData.Rarity] = {}
      end
      table.insert(self.mapCharByRarity[mapCharData.Rarity], mapCharData)
    end
  end
  
  ForEachTableLine(DataTable.SoldierCharacter, func_ForEach_Char)
  table.sort(self.tbAllChar, function(a, b)
    if a.Rarity == b.Rarity then
      return a.Id < b.Id
    end
    return a.Rarity > b.Rarity
  end)
  for nRarity, tbChar in pairs(self.mapCharByRarity) do
    table.sort(tbChar, function(a, b)
      return a.Id < b.Id
    end)
  end
end

function SoldierHandbookCharCtrl:RefreshCharList()
  if self.tbItemCtrl ~= nil then
    for _, v in ipairs(self.tbItemCtrl) do
      self:UnbindCtrlByNode(v)
    end
    self.tbItemCtrl = nil
  end
  self.tbItemCtrl = {}
  self.tbCurCharList = {}
  self.nSelectIndex = 1
  if self.nCurTab == tabType.All then
    self.tbCurCharList = self.tbAllChar
  else
    self.tbCurCharList = self.mapCharByRarity[tab2ChessRarity[self.nCurTab]]
  end
  self._mapNode.sv_loop:Init(#self.tbCurCharList, self, self.OnCharRefreshGrid, self.OnCharGridBtnClick, false)
  EventManager.Hit("SoldierHandbookChar_Selected", self.tbCurCharList[self.nSelectIndex].Id)
  self:RefreshDetail()
end

function SoldierHandbookCharCtrl:OnCharRefreshGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbItemCtrl[nInstanceId] then
    self.tbItemCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.Soldier.Handbook.SoldierHandbookCharItemCtrl")
  end
  self.tbItemCtrl[nInstanceId]:SetItemData(self.tbCurCharList[nIndex], self.nSelectIndex == nIndex)
end

function SoldierHandbookCharCtrl:OnCharGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  self.nSelectIndex = nIndex
  EventManager.Hit("SoldierHandbookChar_Selected", self.tbCurCharList[self.nSelectIndex].Id)
  self:RefreshDetail()
end

function SoldierHandbookCharCtrl:SwitchToTab(nTab, bForce)
  if self.nCurTab == nTab and not bForce then
    return
  end
  if self.nCurTab ~= nil then
    self._mapNode.tab_Off[self.nCurTab]:SetActive(true)
    self._mapNode.tab_On[self.nCurTab]:SetActive(false)
  else
    for i = 1, 6 do
      self._mapNode.tab_Off[i]:SetActive(true)
      self._mapNode.tab_On[i]:SetActive(false)
    end
  end
  self.nCurTab = nTab
  self._mapNode.tab_On[self.nCurTab]:SetActive(true)
  self._mapNode.tab_Off[self.nCurTab]:SetActive(false)
  self:RefreshCharList()
end

function SoldierHandbookCharCtrl:RefreshDetail()
  self._mapNode.DetailCtrl:RefreshDetail(self.tbCurCharList[self.nSelectIndex].Id)
end

function SoldierHandbookCharCtrl:OnBtnClick_Tab(btn, nIndex)
  if nIndex == self.nCurTab then
    return
  end
  self:SwitchToTab(nIndex)
end

return SoldierHandbookCharCtrl
