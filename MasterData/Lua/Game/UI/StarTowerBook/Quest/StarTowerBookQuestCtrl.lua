local StarTowerBookQuestCtrl = class("StarTowerBookQuestCtrl", BaseCtrl)
StarTowerBookQuestCtrl._mapNodeConfig = {
  goWindowBlur = {},
  goQuestWindow = {},
  animRoot = {
    sNodeName = "goQuestWindow",
    sComponentName = "Animator"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Quest_Title"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  questLSV = {
    sComponentName = "LoopScrollView"
  },
  btnReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Receive"
  },
  txtReceiveBtn = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Quest_Quick_Receive"
  },
  btnReceiveGray = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ReceiveGray"
  },
  btnQuestBg = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  }
}
StarTowerBookQuestCtrl._mapEventConfig = {}
StarTowerBookQuestCtrl._mapRedDotConfig = {}

function StarTowerBookQuestCtrl:ShowWindow(nParam)
  self._mapNode.goQuestWindow.gameObject:SetActive(false)
  self._mapNode.goWindowBlur.gameObject:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goQuestWindow.gameObject:SetActive(true)
    self._mapNode.animRoot:Play("t_window_04_t_in")
    EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
    if self._panel.nPanelType == AllEnum.StarTowerBookPanelType.Potential then
      self:InitPotentialQuest(nParam)
    elseif self._panel.nPanelType == AllEnum.StarTowerBookPanelType.FateCard then
      self:InitFateCardQuest(nParam)
    end
  end
  
  cs_coroutine.start(wait)
end

function StarTowerBookQuestCtrl:InitPotentialQuest(nCharId)
  self.nCharId = nCharId
  self.mapQuest = {}
  local mapQuest = PlayerData.StarTowerBook:GetCharPotentialQuest(nCharId)
  self._mapNode.questLSV.gameObject:SetActive(mapQuest ~= nil)
  if mapQuest == nil then
    return
  end
  for nId, data in pairs(mapQuest) do
    data.Id = nId
    table.insert(self.mapQuest, data)
  end
  table.sort(self.mapQuest, function(a, b)
    if a.Status == b.Status then
      return a.Id < b.Id
    end
    return a.Status < b.Status
  end)
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self._mapNode.questLSV:Init(#self.mapQuest, self, self.OnPotentialGridRefresh, nil)
  local bCanReceive = false
  for _, v in ipairs(self.mapQuest) do
    if v.Status == AllEnum.BookQuestStatus.Complete then
      bCanReceive = true
      break
    end
  end
  self._mapNode.btnReceive.gameObject:SetActive(bCanReceive)
  self._mapNode.btnReceiveGray.gameObject:SetActive(not bCanReceive)
end

function StarTowerBookQuestCtrl:OnPotentialGridRefresh(goGrid, goIndex)
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.StarTowerBook.Quest.BookQuestItemCtrl")
  end
  local questData = self.mapQuest[goIndex + 1]
  self.tbGridCtrl[nInstanceID]:InitPotentialItem(questData)
end

function StarTowerBookQuestCtrl:InitFateCardQuest(nBundleId)
  self.nBundleId = nBundleId
  self.mapQuest = PlayerData.StarTowerBook:GetFateCardBundleQuest(nBundleId)
  table.sort(self.mapQuest, function(a, b)
    if a.Status == b.Status then
      return a.Id < b.Id
    end
    return a.Status < b.Status
  end)
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self._mapNode.questLSV:Init(#self.mapQuest, self, self.OnFateCardGridRefresh, nil)
  local bCanReceive = false
  for _, v in ipairs(self.mapQuest) do
    if v.Status == AllEnum.BookQuestStatus.Complete then
      bCanReceive = true
      break
    end
  end
  self._mapNode.btnReceive.gameObject:SetActive(bCanReceive)
  self._mapNode.btnReceiveGray.gameObject:SetActive(not bCanReceive)
end

function StarTowerBookQuestCtrl:OnFateCardGridRefresh(goGrid, goIndex)
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.StarTowerBook.Quest.BookQuestItemCtrl")
  end
  local questData = self.mapQuest[goIndex + 1]
  self.tbGridCtrl[nInstanceID]:InitFateCardItem(questData)
end

function StarTowerBookQuestCtrl:CloseWindow()
  self._mapNode.animRoot:Play("t_window_04_t_out")
  local nAnim = NovaAPI.GetAnimClipLength(self._mapNode.animRoot, {
    "t_window_04_t_out"
  })
  EventManager.Hit(EventId.TemporaryBlockInput, nAnim)
  self:AddTimer(1, nAnim, function()
    self._mapNode.goQuestWindow.gameObject:SetActive(false)
    self._mapNode.goWindowBlur.gameObject:SetActive(false)
    self.gameObject:SetActive(false)
  end, true, true, true, true)
end

function StarTowerBookQuestCtrl:Awake()
  self.tbGridCtrl = {}
end

function StarTowerBookQuestCtrl:FadeIn()
end

function StarTowerBookQuestCtrl:FadeOut()
end

function StarTowerBookQuestCtrl:OnEnable()
end

function StarTowerBookQuestCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
end

function StarTowerBookQuestCtrl:OnBtnClick_Close()
  self:CloseWindow()
end

function StarTowerBookQuestCtrl:OnBtnClick_Receive()
  local function callback()
    if self._panel.nPanelType == AllEnum.StarTowerBookPanelType.Potential then
      self:InitPotentialQuest(self.nCharId)
    elseif self._panel.nPanelType == AllEnum.StarTowerBookPanelType.FateCard then
      self:InitFateCardQuest(self.nBundleId)
    end
    self:CloseWindow()
  end
  
  if self._panel.nPanelType == AllEnum.StarTowerBookPanelType.Potential then
    PlayerData.StarTowerBook:SendReceivePotentialRewardMsg(self.nCharId, callback)
  elseif self._panel.nPanelType == AllEnum.StarTowerBookPanelType.FateCard then
    PlayerData.StarTowerBook:SendReceiveFateCardRewardMsg(self.nBundleId, 0, callback)
  end
end

function StarTowerBookQuestCtrl:OnBtnClick_ReceiveGray()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StarTower_Book_Quest_Reward"))
end

return StarTowerBookQuestCtrl
