local SoldierHandbookStrategyCardCtrl = class("SoldierHandbookStrategyCardCtrl", BaseCtrl)
local tabType = {
  All = 1,
  R = 2,
  M = 3,
  N = 4
}
local tab2ItemRarity = {
  [tabType.All] = 1,
  [tabType.R] = GameEnum.itemRarity.R,
  [tabType.M] = GameEnum.itemRarity.M,
  [tabType.N] = GameEnum.itemRarity.N
}
SoldierHandbookStrategyCardCtrl._mapNodeConfig = {
  btn_tab = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tab"
  },
  tab_On = {nCount = 4},
  tab_Off = {nCount = 4},
  sv_loop = {
    sComponentName = "LoopScrollView"
  },
  CardDetailCtrl = {
    sNodeName = "DetailRoot",
    sCtrlName = "Game.UI.Soldier.Handbook.SoldierHandbookCardDetailCtrl"
  }
}
SoldierHandbookStrategyCardCtrl._mapEventConfig = {}
SoldierHandbookStrategyCardCtrl._mapRedDotConfig = {}

function SoldierHandbookStrategyCardCtrl:Awake()
end

function SoldierHandbookStrategyCardCtrl:OnEnable()
end

function SoldierHandbookStrategyCardCtrl:OnDisable()
end

function SoldierHandbookStrategyCardCtrl:OnDestroy()
  self:Clear()
end

function SoldierHandbookStrategyCardCtrl:Clear()
  if self.tbCardItemCtrl ~= nil then
    for _, v in ipairs(self.tbCardItemCtrl) do
      self:UnbindCtrlByNode(v)
    end
    self.tbCardItemCtrl = {}
  end
  self._mapNode.CardDetailCtrl:Clear()
end

function SoldierHandbookStrategyCardCtrl:Init()
  self.tbCardItemCtrl = {}
  self:InitCardList()
  self:SwitchToTab(tabType.All, true)
end

function SoldierHandbookStrategyCardCtrl:InitCardList()
  self.tbAllCard = {}
  self.mapCardByRarity = {}
  
  local function func_ForEach_Card(mapCardData)
    table.insert(self.tbAllCard, mapCardData)
    if self.mapCardByRarity[mapCardData.Rarity] == nil then
      self.mapCardByRarity[mapCardData.Rarity] = {}
    end
    table.insert(self.mapCardByRarity[mapCardData.Rarity], mapCardData)
  end
  
  ForEachTableLine(DataTable.SoldierStrategyCard, func_ForEach_Card)
  table.sort(self.tbAllCard, function(a, b)
    if a.Rarity == b.Rarity then
      return a.Id < b.Id
    end
    return a.Rarity < b.Rarity
  end)
  for nRarity, tbCard in pairs(self.mapCardByRarity) do
    table.sort(tbCard, function(a, b)
      return a.Id < b.Id
    end)
  end
end

function SoldierHandbookStrategyCardCtrl:SwitchToTab(nTab, bForce)
  if self.nCurTab == nTab and not bForce then
    return
  end
  if self.nCurTab ~= nil then
    self._mapNode.tab_Off[self.nCurTab]:SetActive(true)
    self._mapNode.tab_On[self.nCurTab]:SetActive(false)
  else
    for i = 1, 4 do
      self._mapNode.tab_Off[i]:SetActive(true)
      self._mapNode.tab_On[i]:SetActive(false)
    end
  end
  self.nCurTab = nTab
  self._mapNode.tab_On[self.nCurTab]:SetActive(true)
  self._mapNode.tab_Off[self.nCurTab]:SetActive(false)
  self:RefreshCardList()
end

function SoldierHandbookStrategyCardCtrl:RefreshCardList()
  self.tbCardItemCtrl = {}
  self.tbCurCardList = {}
  self.nSelectIndex = 1
  if self.nCurTab == tabType.All then
    self.tbCurCardList = self.tbAllCard
  else
    self.tbCurCardList = self.mapCardByRarity[tab2ItemRarity[self.nCurTab]]
  end
  self._mapNode.sv_loop:Init(#self.tbCurCardList, self, self.OnCardRefreshGrid, self.OnCardGridBtnClick, false)
  EventManager.Hit("SoldierHandbookStrategyCard_Selected", self.tbCurCardList[self.nSelectIndex].Id)
  self:RefreshDetail()
end

function SoldierHandbookStrategyCardCtrl:RefreshDetail()
  self._mapNode.CardDetailCtrl:RefreshStrategyCardDetail(self.tbCurCardList[self.nSelectIndex].Id)
end

function SoldierHandbookStrategyCardCtrl:OnCardRefreshGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbCardItemCtrl[nInstanceId] then
    self.tbCardItemCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.Soldier.Template.SoldierStrategyCardItemCtrl")
  end
  self.tbCardItemCtrl[nInstanceId]:SetItemData(self.tbCurCardList[nIndex], self.nSelectIndex == nIndex)
end

function SoldierHandbookStrategyCardCtrl:OnCardGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  self.nSelectIndex = nIndex
  EventManager.Hit("SoldierHandbookStrategyCard_Selected", self.tbCurCardList[self.nSelectIndex].Id)
  self:RefreshDetail()
end

function SoldierHandbookStrategyCardCtrl:OnBtnClick_Tab(btn, nIndex)
  if nIndex == self.nCurTab then
    return
  end
  self:SwitchToTab(nIndex)
end

return SoldierHandbookStrategyCardCtrl
