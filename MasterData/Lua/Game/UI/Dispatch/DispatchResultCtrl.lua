local BaseCtrl = require("GameCore.UI.BaseCtrl")
local DispatchResultCtrl = class("DispatchResultCtrl", BaseCtrl)
DispatchResultCtrl._mapNodeConfig = {
  btnCancel = {
    sNodeName = "btnCancel",
    sComponentName = "UIButton",
    callback = "OnBtnClick_ClosePanel"
  },
  btnAgain = {
    sNodeName = "btnConfirm1",
    sComponentName = "UIButton",
    callback = "OnBtnClick_OnDispatchAgain"
  },
  btnAgainGray = {
    sNodeName = "btnAgainGray",
    sComponentName = "UIButton",
    callback = "OnBtnClick_OnDispatchAgainGray"
  },
  btnClose = {
    sNodeName = "btnClose",
    sComponentName = "UIButton",
    callback = "OnBtnClick_ClosePanel"
  },
  loopsvRewardList = {
    sNodeName = "svRewardList",
    sComponentName = "LoopScrollView"
  }
}
DispatchResultCtrl._mapEventConfig = {
  StoryDialog_DialogEnd = "OnEvent_StoryDialog_DialogEnd"
}

function DispatchResultCtrl:Awake()
end

function DispatchResultCtrl:OnEnable()
  self.tbGrid = {}
end

function DispatchResultCtrl:OnDisable()
  for k, v in pairs(self.tbGrid) do
    for k1, v1 in pairs(v) do
      self:UnbindCtrlByNode(v1)
    end
  end
end

function DispatchResultCtrl:OpenPanel(data, performanceData)
  self.bClickAgainClose = false
  self.curReceiveData = data
  self._mapNode.loopsvRewardList:Init(#data, self, self.RefreshRewardItem)
  EventManager.Hit(EventId.TemporaryBlockInput, 2)
  if performanceData ~= nil and 0 < #performanceData then
    self.bHasPerformanceData = true
    self.curPerformanceData = performanceData
    self.curPlayIndex = 1
    EventManager.Hit(EventId.TemporaryBlockInput, 4)
    self:AddTimer(1, 2, function()
      self:OpenAvgPerformance()
    end, true, true, true)
  end
  local _mapAllBuild = {}
  
  local function GetDataCallback(tbBuildData, mapAllBuild)
    _mapAllBuild = mapAllBuild
    local canAdd = true
    for k, v in pairs(self.curReceiveData) do
      local mapData = {
        Id = v.Id,
        ProcessTime = v.Time,
        CharIds = v.CharIds,
        BuildId = v.BuildId
      }
      if mapData.BuildId ~= nil and mapData.BuildId > 0 then
        canAdd = _mapAllBuild[mapData.BuildId] ~= nil
      end
      canAdd = canAdd and not PlayerData.Dispatch.IsSpecialDispatch(v.Id)
      if canAdd then
        break
      end
    end
    self._mapNode.btnAgain.gameObject:SetActive(canAdd)
    self._mapNode.btnAgainGray.gameObject:SetActive(not canAdd)
  end
  
  PlayerData.Build:GetAllBuildBriefData(GetDataCallback)
end

function DispatchResultCtrl:RefreshRewardItem(goGrid, gridIndex)
  local index = gridIndex + 1
  local data = self.curReceiveData[index]
  local nInstanceId = goGrid:GetInstanceID()
  local tranRoot = goGrid.transform:Find("btnGrid/AnimRoot")
  local txtName = tranRoot:Find("txtName"):GetComponent("TMP_Text")
  local txtTime = tranRoot:Find("txtTime"):GetComponent("TMP_Text")
  local txtRewardTitle = tranRoot:Find("imgBg/txtRewardTitle"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtName, data.Name)
  NovaAPI.SetTMPText(txtRewardTitle, ConfigTable.GetUIText("Agent_Reward_Title"))
  local txtStr = ""
  if data.Time % 60 == 0 then
    txtStr = math.floor(data.Time / 60) .. ConfigTable.GetUIText("Depot_LeftTime_Hour")
  else
    txtStr = data.Time .. ConfigTable.GetUIText("Depot_LeftTime_Min")
  end
  NovaAPI.SetTMPText(txtTime, txtStr)
  for i = 1, 4 do
    local item = tranRoot:Find("item" .. i)
    if data.Item[i] ~= nil then
      if self.tbGrid[nInstanceId] ~= nil then
        if self.tbGrid[nInstanceId][i] == nil then
          self.tbGrid[nInstanceId][i] = self:BindCtrlByNode(item, "Game.UI.TemplateEx.TemplateItemCtrl")
        end
      else
        self.tbGrid[nInstanceId] = {}
        self.tbGrid[nInstanceId][i] = self:BindCtrlByNode(item, "Game.UI.TemplateEx.TemplateItemCtrl")
      end
      local itemData = ConfigTable.GetData_Item(data.Item[i].nId)
      self.tbGrid[nInstanceId][i]:SetItem(data.Item[i].nId, itemData.Rarity, data.Item[i].nCount)
      local btnItem = item:GetComponent("UIButton")
      btnItem.onClick:RemoveAllListeners()
      btnItem.onClick:AddListener(function()
        local mapData = {
          nTid = data.Item[i].nId,
          bShowDepot = true
        }
        EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, item, mapData)
      end)
    end
    item.gameObject:SetActive(data.Item[i] ~= nil)
  end
end

function DispatchResultCtrl:OpenAvgPerformance()
  if #self.curPerformanceData >= self.curPlayIndex then
    local data = ConfigTable.GetData("AgentSpecialPerformance", self.curPerformanceData[self.curPlayIndex].performanceId)
    EventManager.Hit(EventId.TemporaryBlockInput, 2)
    CS.WwiseAudioManager.Instance:PlaySound("ui_dispatch_message")
    EventManager.Hit("StoryDialog_DialogStart", data.Avg, nil, nil, data.AVGGroupId)
  else
    EventManager.Hit("DispatchAvgEnd")
    self.bHasPerformance = false
  end
end

function DispatchResultCtrl:OnBtnClick_ClosePanel()
  if self.bHasPerformance == true then
    return
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  EventManager.Hit(EventId.DispatchCloseResultPanel, self.bClickAgainClose == true)
end

function DispatchResultCtrl:OnBtnClick_OnDispatchAgain()
  if self.bHasPerformance == true then
    return
  end
  local AgentList = {}
  local AgentData = {}
  local _mapAllBuild = {}
  
  local function GetDataCallback(tbBuildData, mapAllBuild)
    _mapAllBuild = mapAllBuild
    local canAdd = true
    for k, v in pairs(self.curReceiveData) do
      local mapData = {
        Id = v.Id,
        ProcessTime = v.Time,
        CharIds = v.CharIds,
        BuildId = v.BuildId
      }
      if mapData.BuildId ~= nil and mapData.BuildId > 0 then
        canAdd = _mapAllBuild[mapData.BuildId] ~= nil
      end
      canAdd = canAdd and not PlayerData.Dispatch.IsSpecialDispatch(v.Id)
      if canAdd then
        table.insert(AgentList, mapData)
        AgentData[v.Id] = mapData
      else
        break
      end
    end
    
    local function callback()
      self.bClickAgainClose = true
      self:OnBtnClick_ClosePanel()
    end
    
    if canAdd then
      CS.WwiseAudioManager.Instance:PlaySound("ui_dispatch_accept_successful")
      PlayerData.Dispatch.ReqApplyAgent(AgentList, AgentData, callback)
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Agent_Again_Fail"))
    end
  end
  
  PlayerData.Build:GetAllBuildBriefData(GetDataCallback)
end

function DispatchResultCtrl:OnBtnClick_OnDispatchAgainGray()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Agent_Again_Accept_Fail"))
end

function DispatchResultCtrl:OnEvent_StoryDialog_DialogEnd()
  local itemData = {}
  table.insert(itemData, {
    id = self.curPerformanceData[self.curPlayIndex].itemId,
    count = self.curPerformanceData[self.curPlayIndex].nCount
  })
  EventManager.Hit(EventId.TemporaryBlockInput, 1)
  self:AddTimer(1, 0.5, function()
    EventManager.Hit(EventId.OpenPanel, PanelId.ReceivePropsTips, itemData, function()
      self.curPlayIndex = self.curPlayIndex + 1
      self:OpenAvgPerformance()
    end)
  end, true, true, true)
end

return DispatchResultCtrl
