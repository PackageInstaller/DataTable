local InfinityTowerPlot = class("InfinityTowerPlot", BaseCtrl)
InfinityTowerPlot._mapNodeConfig = {
  goPlot = {},
  tex_plot_Title = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Plot_Review"
  },
  plotList = {
    sComponentName = "LoopScrollView"
  },
  goPlotRoot = {},
  rtWindowAni = {sNodeName = "rtWindow", sComponentName = "Animator"},
  txtGoPlotTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Plot_Review"
  },
  cancelPlotAvgBtnTex = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Cancel"
  },
  goPlotAvgBtnTex = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldMap_MainLine_Avg_Btn"
  },
  txtGoPlotReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "STRanking_Reward_Btn"
  },
  goPlotRootMask = {
    sComponentName = "Button",
    callback = "OnBtn_ClickCloseGoPlotPanel"
  },
  btnGoPlotClose = {
    sComponentName = "UIButton",
    callback = "OnBtn_ClickCloseGoPlotPanel"
  },
  btnCancelGoPlot = {
    sComponentName = "UIButton",
    callback = "OnBtn_ClickCloseGoPlotPanel"
  },
  btnSureGoPlot = {
    sComponentName = "UIButton",
    callback = "OnBtn_ClickPlayPlot"
  },
  goRewardInfo = {},
  goPlotLvNum = {sComponentName = "TMP_Text"},
  goPlotLvName = {sComponentName = "TMP_Text"},
  goPlotLvDes = {sComponentName = "TMP_Text"},
  imgGoPlotReward = {sComponentName = "Image"},
  txtGoPlotRewardCount = {sComponentName = "TMP_Text"}
}
InfinityTowerPlot._mapEventConfig = {
  Refresh_Infinity_PlotList = "OnEvent_RefreshInfinityPlotList"
}

function InfinityTowerPlot:OpenPlotView()
  self.AniRoot = self.gameObject:GetComponent("Animator")
  self._mapNode.goPlot.gameObject:SetActive(false)
  
  local function wait()
    self:InitPlotMsg()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self.AniRoot.enabled = true
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goPlot.gameObject:SetActive(true)
  end
  
  cs_coroutine.start(wait)
  self.gameObject:SetActive(true)
end

function InfinityTowerPlot:InitPlotMsg()
  local count = 0
  self.tabPlot = {}
  
  local function foreach_Base(baseData)
    count = count + 1
    self.tabPlot[count] = baseData
  end
  
  ForEachTableLine(DataTable.InfinityTowerPlot, foreach_Base)
  self._mapNode.plotList:Init(count, self, self.InitPlotList)
  local tmpCount = 1
  for i = 1, count do
    if PlayerData.InfinityTower:GetPlotUnLock(self.tabPlot[i].Id) and not PlayerData.InfinityTower:GetPlotGetReward(self.tabPlot[i].Id) then
      tmpCount = i
      break
    end
  end
  if 0 < count then
    self._mapNode.plotList:SetScrollGridPos(tmpCount, 0.1, 0)
  end
end

function InfinityTowerPlot:OnEvent_RefreshInfinityPlotList()
  self:InitPlotMsg()
end

function InfinityTowerPlot:InitPlotList(goGrid, gridIndex)
  local index = gridIndex + 1
  local plotData = self.tabPlot[index]
  local isUnLock = PlayerData.InfinityTower:GetPlotUnLock(plotData.Id)
  local plot_item_bg = goGrid.transform:Find("gridRt/plot_item_bg"):GetComponent("Image")
  local unlock = goGrid.transform:Find("gridRt/unlock").gameObject
  local lock = goGrid.transform:Find("gridRt/lock").gameObject
  if isUnLock then
    NovaAPI.SetImageColor(plot_item_bg, Color(1, 1, 1, 1))
    unlock:SetActive(true)
    lock:SetActive(false)
    local plot_item_Index = unlock.transform:Find("plot_item_Index"):GetComponent("TMP_Text")
    local plot_item_Name = unlock.transform:Find("plot_item_Name"):GetComponent("TMP_Text")
    local plot_item_Reward = unlock.transform:Find("plot_item_Reward").gameObject
    local plot_item_RewardReview = unlock.transform:Find("plot_item_RewardReview"):GetComponent("UIButton")
    local redDot = unlock.transform:Find("redDot").gameObject
    local isGet = PlayerData.InfinityTower:GetPlotGetReward(plotData.Id)
    if isGet then
      plot_item_Reward:SetActive(false)
      redDot:SetActive(false)
    else
      local plot_item_RewardIcon = unlock.transform:Find("plot_item_Reward/plot_item_RewardIcon"):GetComponent("Image")
      local plot_item_RewardCount = unlock.transform:Find("plot_item_Reward/plot_item_RewardCount"):GetComponent("TMP_Text")
      self:SetPngSprite(plot_item_RewardIcon, ConfigTable.GetData_Item(plotData.RewardItemId).Icon2)
      NovaAPI.SetTMPText(plot_item_RewardCount, "×" .. plotData.RewardItemQty)
      plot_item_Reward:SetActive(true)
      redDot:SetActive(true)
    end
    NovaAPI.SetTMPText(plot_item_Index, plotData.Name)
    NovaAPI.SetTMPText(plot_item_Name, plotData.Desc)
    plot_item_RewardReview.onClick:RemoveAllListeners()
    
    local function clickCb()
      self:ShowGoPlotPanel(plotData)
    end
    
    plot_item_RewardReview.onClick:AddListener(clickCb)
  else
    NovaAPI.SetImageColor(plot_item_bg, Color(1, 1, 1, 0.6))
    unlock:SetActive(false)
    lock:SetActive(true)
    local plot_item_LockMsg = lock.transform:Find("plot_item_LockMsg"):GetComponent("TMP_Text")
    local _cond = plotData.UnlockCond
    if _cond ~= 0 then
      if _cond == GameEnum.InfinityTowerCond.LevelClearWithSpecificId then
        local lvId = plotData.CondParam[1]
        local lvData = ConfigTable.GetData("InfinityTowerLevel", lvId)
        NovaAPI.SetTMPText(plot_item_LockMsg, orderedFormat(ConfigTable.GetUIText("InfinityTower_Cond_WithSpecificId"), lvData.Name))
      elseif _cond == GameEnum.InfinityTowerCond.InfinityTowerWithSpecificLevelTotal then
        NovaAPI.SetTMPText(plot_item_LockMsg, orderedFormat(ConfigTable.GetUIText("InfinityTower_Cond_WithSpecificLevelTotal"), plotData.CondParam[1]))
      elseif _cond == GameEnum.InfinityTowerCond.AnyTowerWithSpecificTotalLevel then
        NovaAPI.SetTMPText(plot_item_LockMsg, orderedFormat(ConfigTable.GetUIText("InfinityTower_Cond_TotalLevel"), plotData.CondParam[1], plotData.CondParam[2]))
      elseif _cond == GameEnum.InfinityTowerCond.BountyLevelSpecific then
        NovaAPI.SetTMPText(plot_item_LockMsg, orderedFormat(ConfigTable.GetUIText("InfinityTower_Cond_LevelSpecific"), plotData.CondParam[1]))
      end
    end
  end
end

function InfinityTowerPlot:OnBtnClick_Close()
  local function ClosePanel()
    self._mapNode.goPlot.gameObject:SetActive(false)
    
    self.gameObject:SetActive(false)
    self.AniRoot.enabled = false
  end
  
  self:AddTimer(1, 0.12, ClosePanel, true, true)
  self.AniRoot:Play("MatList_out")
end

function InfinityTowerPlot:ShowGoPlotPanel(plotData)
  self.SelectPlotData = plotData
  local isGet = PlayerData.InfinityTower:GetPlotGetReward(plotData.Id)
  if isGet then
    self._mapNode.goRewardInfo:SetActive(false)
  else
    self:SetPngSprite(self._mapNode.imgGoPlotReward, ConfigTable.GetData_Item(plotData.RewardItemId).Icon2)
    NovaAPI.SetTMPText(self._mapNode.txtGoPlotRewardCount, "×" .. plotData.RewardItemQty)
    self._mapNode.goRewardInfo:SetActive(true)
  end
  NovaAPI.SetTMPText(self._mapNode.goPlotLvNum, plotData.Name)
  NovaAPI.SetTMPText(self._mapNode.goPlotLvName, plotData.Desc)
  NovaAPI.SetTMPText(self._mapNode.goPlotLvDes, plotData.PlotSum)
  self._mapNode.goPlotRoot.gameObject:SetActive(true)
  self._mapNode.goPlotRootMask.gameObject:SetActive(true)
  self._mapNode.rtWindowAni:Play("t_window_04_t_in")
end

function InfinityTowerPlot:OnBtn_ClickPlayPlot()
  PlayerData.InfinityTower:PlayPlot(self.SelectPlotData.Id)
  self:OnBtn_ClickCloseGoPlotPanel()
end

function InfinityTowerPlot:OnBtn_ClickCloseGoPlotPanel()
  self._mapNode.goPlotRootMask.gameObject:SetActive(false)
  self._mapNode.rtWindowAni:Play("t_window_04_t_out")
  self:AddTimer(1, 0.3, function()
    self._mapNode.goPlotRoot:SetActive(false)
  end, true, true, true)
end

return InfinityTowerPlot
