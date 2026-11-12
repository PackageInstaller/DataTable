local StarTowerBookCtrl = class("StarTowerBookCtrl", BaseCtrl)
StarTowerBookCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  MainRoot = {
    sNodeName = "---Main---",
    sCtrlName = "Game.UI.StarTowerBook.StarTowerBookMainCtrl"
  },
  PotentialRoot = {
    sNodeName = "---Potential---",
    sCtrlName = "Game.UI.StarTowerBook.Potential.StarTowerPotentialBookCtrl"
  },
  FateCardRoot = {
    sNodeName = "---FateCard---",
    sCtrlName = "Game.UI.StarTowerBook.FateCard.StarTowerFateCardBookCtrl"
  },
  EventRoot = {
    sNodeName = "---Event---",
    sCtrlName = "Game.UI.StarTowerBook.Event.StarTowerEventBookCtrl"
  },
  QuestRoot = {
    sNodeName = "---Quest---",
    sCtrlName = "Game.UI.StarTowerBook.Quest.StarTowerBookQuestCtrl"
  },
  AffinityRoot = {
    sNodeName = "---Affinity---",
    sCtrlName = "Game.UI.StarTowerBook.Affinity.StarTowerNpcAffinityCtrl"
  },
  goBg = {},
  animBg = {sNodeName = "goBg", sComponentName = "Animator"}
}
StarTowerBookCtrl._mapEventConfig = {
  ChangeStarTowerBookPanel = "OnEvent_ChangeStarTowerBookPanel",
  OpenStarTowerBookQuest = "OnEvent_OpenStarTowerBookQuest",
  [EventId.UIBackConfirm] = "OnEvent_Back",
  [EventId.UIHomeConfirm] = "OnEvent_Home"
}
StarTowerBookCtrl._mapRedDotConfig = {}

function StarTowerBookCtrl:RefreshPanel()
  self._mapNode.MainRoot.gameObject:SetActive(self._panel.nPanelType == AllEnum.StarTowerBookPanelType.Main)
  self._mapNode.PotentialRoot.gameObject:SetActive(self._panel.nPanelType == AllEnum.StarTowerBookPanelType.Potential)
  self._mapNode.FateCardRoot.gameObject:SetActive(self._panel.nPanelType == AllEnum.StarTowerBookPanelType.FateCard)
  self._mapNode.EventRoot.gameObject:SetActive(self._panel.nPanelType == AllEnum.StarTowerBookPanelType.Event)
  self._mapNode.AffinityRoot.gameObject:SetActive(self._panel.nPanelType == AllEnum.StarTowerBookPanelType.Affinity)
  self._mapNode.goBg.gameObject:SetActive(true)
  if self.nLastPanelType ~= nil and (self.nLastPanelType == AllEnum.StarTowerBookPanelType.Event or self.nLastPanelType == AllEnum.StarTowerBookPanelType.Affinity) or self._panel.nPanelType == AllEnum.StarTowerBookPanelType.Event or self._panel.nPanelType == AllEnum.StarTowerBookPanelType.Affinity then
    self._mapNode.goBg.gameObject:SetActive(false)
    return
  end
  if self._panel.nPanelType == AllEnum.StarTowerBookPanelType.Potential or self._panel.nPanelType == AllEnum.StarTowerBookPanelType.FateCard then
    self._mapNode.animBg:Play("StarTowerBookgoBg_in", 0, 0)
  else
    self._mapNode.animBg:Play("StarTowerBookgoBg_out", 0, 0)
  end
end

function StarTowerBookCtrl:Awake()
  self.nLastPanelType = nil
  if self._panel.nPanelType == 0 then
    self._panel.nPanelType = AllEnum.StarTowerBookPanelType.Main
  end
  self._mapNode.QuestRoot.gameObject:SetActive(false)
  self:RefreshPanel()
  self._mapNode.goBg.gameObject:SetActive(false)
end

function StarTowerBookCtrl:FadeIn()
end

function StarTowerBookCtrl:FadeOut()
end

function StarTowerBookCtrl:OnEnable()
  self._mapNode.MainRoot.gameObject:SetActive(true)
  self._mapNode.MainRoot:Init()
  local tbParam = self:GetPanelParam()
  if tbParam[1] ~= nil then
    self._panel.nPanelType = tbParam[1]
    tbParam = {}
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if self._panel.nPanelType ~= AllEnum.StarTowerBookPanelType.Main then
      self:OnEvent_ChangeStarTowerBookPanel(self._panel.nPanelType)
    end
  end
  
  cs_coroutine.start(wait)
end

function StarTowerBookCtrl:OnDisable()
end

function StarTowerBookCtrl:OnDestroy()
end

function StarTowerBookCtrl:OnRelease()
end

function StarTowerBookCtrl:OnEvent_ChangeStarTowerBookPanel(nPanelType)
  self.nLastPanelType = self._panel.nPanelType
  self._panel.nPanelType = nPanelType
  if self._panel.nPanelType == AllEnum.StarTowerBookPanelType.Potential then
    self:RefreshPanel()
    self._mapNode.PotentialRoot:Init()
    self._mapNode.TopBar:SetTitleTxt(ConfigTable.GetUIText("StarTower_Book_Potential_TopBar_Title"))
  elseif self._panel.nPanelType == AllEnum.StarTowerBookPanelType.Event then
    self:RefreshPanel()
    self._mapNode.EventRoot:Init()
    self._mapNode.TopBar:SetTitleTxt(ConfigTable.GetUIText("StarTower_Book_Event_TopBar_Title"))
  elseif self._panel.nPanelType == AllEnum.StarTowerBookPanelType.FateCard then
    self:RefreshPanel()
    self._mapNode.FateCardRoot:Init()
    self._mapNode.TopBar:SetTitleTxt(ConfigTable.GetUIText("StarTower_Book_FateCard_TopBar_Title"))
  elseif self._panel.nPanelType == AllEnum.StarTowerBookPanelType.Affinity then
    local function callback()
      self:RefreshPanel()
      
      self._mapNode.AffinityRoot:Init()
      self._mapNode.TopBar:SetTitleTxt(ConfigTable.GetUIText("StartowerBook_NPCAffinityTitle"))
    end
    
    PlayerData.StarTower:GetAffinity(callback)
  elseif self._panel.nPanelType == AllEnum.StarTowerBookPanelType.Main then
    self:RefreshPanel()
    self._mapNode.MainRoot:BackToMain()
    self._mapNode.TopBar:SetTitleTxt(ConfigTable.GetUIText("StarTower_Book_Main_TopBar_Title"))
  end
end

function StarTowerBookCtrl:OnEvent_OpenStarTowerBookQuest(nParam)
  self._mapNode.QuestRoot.gameObject:SetActive(true)
  self._mapNode.QuestRoot:ShowWindow(nParam)
end

function StarTowerBookCtrl:OnEvent_Back()
  if self._panel.nPanelType == AllEnum.StarTowerBookPanelType.Potential then
    self._mapNode.PotentialRoot:Back()
  elseif self._panel.nPanelType == AllEnum.StarTowerBookPanelType.Event then
    self._mapNode.EventRoot:Back()
  elseif self._panel.nPanelType == AllEnum.StarTowerBookPanelType.FateCard then
    self._mapNode.FateCardRoot:Back()
  elseif self._panel.nPanelType == AllEnum.StarTowerBookPanelType.Affinity then
    self._mapNode.AffinityRoot:Back()
  else
    EventManager.Hit(EventId.ClosePanel, PanelId.StarTowerBook)
  end
end

function StarTowerBookCtrl:OnEvent_Home()
  PanelManager.Home()
end

return StarTowerBookCtrl
