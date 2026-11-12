local BaseCtrl = require("GameCore.UI.BaseCtrl")
local CharacterPlotCtrl = class("CharacterPlotCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
CharacterPlotCtrl._mapNodeConfig = {
  loopsv = {
    sNodeName = "sv",
    sComponentName = "LoopScrollView"
  }
}
CharacterPlotCtrl._mapEventConfig = {
  [EventId.CharRelatePanelAdvance] = "OnEvent_PanelAdvance",
  Enter_CharPlot = "OnEvent_Enter_CharPlot",
  [EventId.TransAnimOutClear] = "OnEvent_TransAnimOutClear",
  RefreshCharPlotContent = "OnEvent_RefreshCharPlotContent"
}
local PlotGridSize = {Title = 52, Plot = 208}

function CharacterPlotCtrl:Awake()
end

function CharacterPlotCtrl:OnEnable()
end

function CharacterPlotCtrl:OnDisable()
end

function CharacterPlotCtrl:OnDestroy()
end

function CharacterPlotCtrl:RegisterRedDot(plotId, redDot, bRebind)
  RedDotManager.RegisterNode(RedDotDefine.Role_AffinityPlotItem, {
    self.characterId,
    plotId
  }, redDot, nil, nil, bRebind)
end

function CharacterPlotCtrl:RefreshContent(nCharId)
  self.tbReward = {}
  self:RefreshPlotList(nCharId)
  PlayerData.Phone:TrySendAddressListReq()
end

function CharacterPlotCtrl:RefreshPlotList(nCharId)
  self.characterId = nCharId
  local tbPlot = PlayerData.Char:GetCharPlotDataById(self.characterId)
  table.sort(tbPlot, function(a, b)
    if a.PlotType == b.PlotType then
      return a.Id < b.Id
    end
    return a.PlotType < b.PlotType
  end)
  local tbTempPlot = {}
  self.tbPlotData = {}
  local tbGirdHeight = {}
  local nLastType = 0
  local nLastSkinId = 0
  local nPlotTypeCount = 0
  local nIndex = 0
  for _, v in ipairs(tbPlot) do
    local bAdd = true
    if v.PlotType == GameEnum.CharPlotType.SkinPlot then
      local bSkinUnlock = PlayerData.CharSkin:CheckSkinUnlock(v.UnlockSkinId)
      bAdd = bAdd and bSkinUnlock
    end
    if bAdd then
      if nLastType == 0 or nLastType ~= v.PlotType then
        nLastType = v.PlotType
        nPlotTypeCount = nPlotTypeCount + 1
        nIndex = 0
        table.insert(tbTempPlot, {
          bTitle = true,
          nType = v.PlotType
        })
      end
      if nLastSkinId ~= v.UnlockSkinId then
        nLastSkinId = v.UnlockSkinId
        nIndex = 0
      end
      nIndex = nIndex + 1
      table.insert(tbTempPlot, {
        bTitle = false,
        mapData = v,
        nIndex = nIndex
      })
    end
  end
  for _, v in ipairs(tbTempPlot) do
    if v.bTitle then
      if 1 < nPlotTypeCount then
        table.insert(self.tbPlotData, v)
        table.insert(tbGirdHeight, PlotGridSize.Title)
      end
    else
      table.insert(self.tbPlotData, v)
      table.insert(tbGirdHeight, PlotGridSize.Plot)
    end
  end
  if self._mapNode ~= nil then
    self._mapNode.loopsv:InitEx(tbGirdHeight, self, self.RefreshPlotItem)
  end
end

function CharacterPlotCtrl:RefreshPlotItem(go)
  local index = tonumber(go.name) + 1
  local trans = go.transform
  local plotData = self.tbPlotData[index]
  if plotData == nil then
    go:SetActive(false)
    return
  end
  local titleRoot = trans:Find("DescRoot")
  local plotRoot = trans:Find("btnGrid")
  if plotData.bTitle == true then
    titleRoot.gameObject:SetActive(true)
    plotRoot.gameObject:SetActive(false)
    local plotTitle = titleRoot:Find("t_common_04/imgBg/txtTitle"):GetComponent("TMP_Text")
    if plotData.nType == GameEnum.CharPlotType.CharPlot then
      NovaAPI.SetTMPText(plotTitle, ConfigTable.GetUIText("Plot_Title_Normal"))
    elseif plotData.nType == GameEnum.CharPlotType.SkinPlot then
      NovaAPI.SetTMPText(plotTitle, ConfigTable.GetUIText("Plot_Title_Skin"))
    end
  else
    local data = plotData.mapData
    local nPlotIndex = plotData.nIndex
    titleRoot.gameObject:SetActive(false)
    plotRoot.gameObject:SetActive(true)
    local txtLockStr = ""
    local bLock = false
    local favourLevel = 0
    local favourData = PlayerData.Char:GetAdvanceLevelTable(self.curCharId)
    favourLevel = favourData ~= nil and favourData.Level or 0
    bLock, txtLockStr = PlayerData.Char:IsPlotUnlock(data.Id, self.characterId)
    local goLock = go.transform:Find("btnGrid/Lock")
    local root = go.transform:Find("btnGrid/AnimRoot")
    goLock.gameObject:SetActive(bLock)
    root.gameObject:SetActive(not bLock)
    local rewardData = decodeJson(data.Rewards)
    local itemId, itemCount
    for id, count in pairs(rewardData) do
      itemId = tonumber(id)
      itemCount = tonumber(count)
    end
    if bLock then
      local txtLock = goLock.transform:Find("txtLock"):GetComponent("TMP_Text")
      NovaAPI.SetTMPText(txtLock, txtLockStr)
      local txtLockReward = goLock:Find("txtLockReward"):GetComponent("TMP_Text")
      NovaAPI.SetTMPText(txtLockReward, ConfigTable.GetUIText("CharacterRelation_Plot_Reward"))
      local goReward = goLock:Find("txtLockReward/goJade")
      if itemId ~= nil then
        local imgReward = goReward:Find("goJadeImg/imgJade"):GetComponent("Image")
        self:SetPngSprite(imgReward, ConfigTable.GetData_Item(itemId).Icon)
      end
      if itemCount ~= nil then
        local txtRewardCount = goReward:Find("txtCount"):GetComponent("TMP_Text")
        NovaAPI.SetTMPText(txtRewardCount, "×" .. itemCount)
        LayoutRebuilder:ForceRebuildLayoutImmediate(txtRewardCount.transform)
        LayoutRebuilder:ForceRebuildLayoutImmediate(goReward)
      end
      local hasCG = nil ~= CacheTable.GetData("_CharacterCG", data.Id)
      local goFavorCg = goReward:Find("goFavorCg")
      goFavorCg.gameObject:SetActive(hasCG)
      local txtFavorCg = goFavorCg:Find("txtFavorCg"):GetComponent("TMP_Text")
      NovaAPI.SetTMPText(txtFavorCg, ConfigTable.GetUIText("CharacterRelation_CG_Reward"))
      return
    end
    local txtLevelIndex = root:Find("txtLevelIndex"):GetComponent("TMP_Text")
    local txtLevelName = root:Find("txtLevelName"):GetComponent("TMP_Text")
    local btnSelect = root:Find("btnSelect"):GetComponent("UIButton")
    local imgLevel = root:Find("goAvg/imgLevel"):GetComponent("Image")
    local goReward = root:Find("goJade")
    local redDot = root:Find("RedDot")
    if data.PlotType == GameEnum.CharPlotType.CharPlot then
      NovaAPI.SetTMPText(txtLevelIndex, orderedFormat(ConfigTable.GetUIText("Plot_Index"), nPlotIndex))
    elseif data.PlotType == GameEnum.CharPlotType.SkinPlot then
      local nSkinId = data.UnlockSkinId
      local mapSkinCfg = ConfigTable.GetData("CharacterSkin", nSkinId)
      if mapSkinCfg ~= nil then
        NovaAPI.SetTMPText(txtLevelIndex, orderedFormat(ConfigTable.GetUIText("Skin_Plot_Index"), mapSkinCfg.Name, nPlotIndex))
      else
        NovaAPI.SetTMPText(txtLevelIndex, orderedFormat(ConfigTable.GetUIText("Plot_Index"), nPlotIndex))
      end
    end
    NovaAPI.SetTMPText(txtLevelName, data.Name)
    if data.PicSource ~= "" then
      self:SetPngSprite(imgLevel, data.PicSource)
    end
    btnSelect.onClick:RemoveAllListeners()
    btnSelect.onClick:AddListener(function()
      self.curSelectIndex = index
      self:OnBtnClick_Select()
    end)
    local bGetReward = PlayerData.Char:IsCharPlotFinish(self.characterId, data.Id)
    local hasCG = nil ~= CacheTable.GetData("_CharacterCG", data.Id)
    goReward.gameObject:SetActive(not bGetReward or hasCG)
    self.tbReward[index] = {nId = itemId, bReceive = bGetReward}
    if itemId ~= nil then
      local imgReward = goReward:Find("goJadeImg/imgJade"):GetComponent("Image")
      self:SetPngSprite(imgReward, ConfigTable.GetData_Item(itemId).Icon)
      imgReward.gameObject:SetActive(not bGetReward)
    end
    if itemCount ~= nil then
      local txtRewardCount = goReward:Find("txtCount"):GetComponent("TMP_Text")
      NovaAPI.SetTMPText(txtRewardCount, "×" .. itemCount)
      txtRewardCount.gameObject:SetActive(not bGetReward)
      LayoutRebuilder:ForceRebuildLayoutImmediate(txtRewardCount.transform)
      LayoutRebuilder:ForceRebuildLayoutImmediate(goReward)
    end
    local goFavorCg = goReward:Find("goFavorCg")
    goFavorCg.gameObject:SetActive(hasCG)
    self:RegisterRedDot(data.Id, redDot, true)
  end
end

function CharacterPlotCtrl:ShowReward()
  local data = self.tbPlotData[self.curSelectIndex]
  if data.mapData == nil then
    return
  end
  local mapPlot = data.mapData
  local mapMsgData = self.PlotRewardData
  
  local function rewardFunc()
    local bHasReward = mapMsgData and mapMsgData.Props and #mapMsgData.Props > 0
    local tbItem = {}
    if bHasReward then
      local sRewardDisplay = mapPlot.Rewards
      local tbRewardDisplay = decodeJson(sRewardDisplay)
      for k, v in pairs(tbRewardDisplay) do
        table.insert(tbItem, {
          Tid = tonumber(k),
          Qty = v,
          rewardType = AllEnum.RewardType.First
        })
      end
      UTILS.OpenReceiveByDisplayItem(tbItem, mapMsgData)
    end
  end
  
  if nil ~= CacheTable.GetData("_CharacterCG", mapPlot.Id) then
    local tbRewardList = {}
    table.insert(tbRewardList, {
      nId = CacheTable.GetData("_CharacterCG", mapPlot.Id),
      nCharId = self.characterId,
      bNew = true,
      tbItemList = {},
      bCG = true,
      callBack = rewardFunc
    })
    EventManager.Hit(EventId.OpenPanel, PanelId.ReceiveSpecialReward, tbRewardList)
  else
    rewardFunc()
  end
  self.PlotRewardData = nil
end

function CharacterPlotCtrl:OnBtnClick_Select()
  local data = self.tbPlotData[self.curSelectIndex]
  if data ~= nil and data.mapData ~= nil then
    EventManager.Hit(EventId.OpenPanel, PanelId.CharPlot, data.mapData, self.tbReward, self.curSelectIndex, data.nIndex)
  end
end

function CharacterPlotCtrl:OnBtnClick_EnterPlot()
  if self.tbPlotData == nil then
    return
  end
  local data = self.tbPlotData[self.curSelectIndex]
  if data ~= nil and data.mapData ~= nil then
    local mapPlot = data.mapData
    if mapPlot.ConnectChatId ~= 0 and not PlayerData.Phone:CheckChatComplete(mapPlot.ConnectChatId) then
      EventManager.Hit(EventId.OpenPanel, PanelId.PhonePopUp, mapPlot.ConnectChatId, true)
      return
    end
    local bGetReward = PlayerData.Char:IsCharPlotFinish(self.characterId, mapPlot.Id)
    
    local function finishCallback(nCharId)
      if not bGetReward then
        EventManager.Hit("RefreshCharPlotContent", nCharId)
      else
        EventManager.Hit(EventId.ClosePanel, PanelId.PureAvgStory)
      end
    end
    
    PlayerData.Char:EnterCharPlotAvg(self.characterId, mapPlot.Id, finishCallback, true)
  end
end

function CharacterPlotCtrl:OnBtnClick_Reward(btn)
  if self.tbReward ~= nil then
    local nTid = self.tbReward.nId
    UTILS.ClickItemGridWithTips(nTid, btn.transform, false, true, false)
  end
end

function CharacterPlotCtrl:OnEvent_Enter_CharPlot(...)
  EventManager.Hit(EventId.ClosePanel, PanelId.CharPlot)
  self:OnBtnClick_EnterPlot()
end

function CharacterPlotCtrl:OnEvent_TransAnimOutClear(...)
end

function CharacterPlotCtrl:OnEvent_RefreshCharPlotContent(nCharId)
  self:RefreshContent(nCharId)
end

return CharacterPlotCtrl
