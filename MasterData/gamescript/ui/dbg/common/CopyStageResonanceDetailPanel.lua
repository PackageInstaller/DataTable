local CopyStageResonanceDetailPanel, Super = System.NewClass("CopyStageResonanceDetailPanel", UIBasePanel)
CopyStageResonanceDetailPanel.uiResCls = UI_Dbgcopy_Popup_Vibes_OriResource

function CopyStageResonanceDetailPanel:ctor(resonanceGroupName)
  Super.ctor(self)
  self.stageGroupId = WorldStageManager.Instance.curGroupId
  self.resonanceGroupName = resonanceGroupName
  self._activeResonanceListFromProtocol = nil
end

function CopyStageResonanceDetailPanel:OnBind(binder)
  self.binder = binder
  self:BindCommonPopupConfirmTips()
  ProtoManager.Instance:ReqServer("WorldRequest", "GetWorldResonanceGroup", function(protocolData, code)
    Logger.Proto("CopyStageResonanceDetailPanel:GetWorldResonanceGroup: protocolData =%s", table.tostring(protocolData), table.tostring(code))
    if table.next(protocolData.triggeredResonanceGroups) or table.next(protocolData.suppressedResonanceGroups) then
      self:BindResonancesWithProtocolData(protocolData)
    else
      self:TryBindResonancesFromUtils()
    end
  end, function()
    self:TryBindResonancesFromUtils()
  end)
  self.binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:Close()
  end)
end

function CopyStageResonanceDetailPanel:BindResonancesWithProtocolData(protocolData)
  self._activeResonanceListFromProtocol = self:_ParseActiveResonanceListFromProtocolData(protocolData)
  if self.resonanceGroupName and protocolData and protocolData.triggeredResonanceGroups then
    self:_CheckAndSetMaxLevelForTriggeredGroup(protocolData.triggeredResonanceGroups)
  end
  local activeResonanceList = self:_GetActiveResonanceListFromProtocolData()
  self:_BindResonanceList(activeResonanceList)
end

function CopyStageResonanceDetailPanel:_CheckAndSetMaxLevelForTriggeredGroup(triggeredResonanceGroups)
  if not self.resonanceGroupName then
    return
  end
  local isTriggered = false
  if type(triggeredResonanceGroups) == "table" then
    if triggeredResonanceGroups[self.resonanceGroupName] then
      isTriggered = true
    else
      for _, groupName in ipairs(triggeredResonanceGroups) do
        if groupName == self.resonanceGroupName then
          isTriggered = true
          break
        end
      end
    end
  end
  if not isTriggered then
    return
  end
  local resonanceConfigs = ResonanceDataUtils.GetResonanceConfigByGroupId(self.resonanceGroupName)
  if not resonanceConfigs or not table.next(resonanceConfigs) then
    Logger.Warn("CopyStageResonanceDetailPanel: 未找到共鸣组配置", self.resonanceGroupName)
    return
  end
  local list = {}
  for _, resonanceCfg in pairs(resonanceConfigs) do
    local resonanceId = resonanceCfg.ID
    if resonanceId then
      local maxLevel = ResonanceDataUtils.GetResonanceMaxLevel(resonanceId)
      if maxLevel > 0 then
        ResonanceDataUtils.SetResonanceLevel(resonanceId, maxLevel)
        list[#list + 1] = {resonanceId = resonanceId}
        Logger.Info("CopyStageResonanceDetailPanel: 设置共鸣等级 resonanceId:%s, maxLevel:%s", resonanceId, maxLevel)
      end
    end
  end
  self._activeResonanceListFromProtocol = list
  Logger.Info("CopyStageResonanceDetailPanel: 共鸣组 %s 共设置 %d 个共鸣为最大等级", self.resonanceGroupName, #list)
end

function CopyStageResonanceDetailPanel:_GetActiveResonanceListFromProtocolData()
  return self._activeResonanceListFromProtocol or {}
end

function CopyStageResonanceDetailPanel:_ParseActiveResonanceListFromProtocolData(protocolData)
  if not protocolData then
    return {}
  end
  local list = {}
  if protocolData.triggeredResonanceGroups then
    for _, g in ipairs(protocolData.triggeredResonanceGroups) do
      if g.resonanceId then
        list[#list + 1] = {
          resonanceId = g.resonanceId
        }
      end
    end
  end
  return list
end

function CopyStageResonanceDetailPanel:TryBindResonancesFromUtils()
  local resonanceGroupId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(self.stageGroupId)
  if ResonanceDataUtils.IsResonanceGroupDataInited(resonanceGroupId) then
    self:BindResonances()
  else
    ResonanceDataUtils.ReqResonanceData(resonanceGroupId, function()
      self:BindResonances()
    end)
  end
end

function CopyStageResonanceDetailPanel:BindCommonPopupConfirmTips()
  local commonPopupConfirmTipsData = {
    textTitleCN = LT.Text("ResonanceText"),
    sizeType = CommonDefine.PopupTipsType.S,
    clickFunc = System.fn(self, self.Close)
  }
  self.binder:BindComponent(CommonPopupTips(self.ui.UI_Common_Popup_Tips_S, commonPopupConfirmTipsData))
end

function CopyStageResonanceDetailPanel:BindResonances()
  local activeResonanceList = ResonanceDataUtils.GetActiveResonanceList(self.stageGroupId)
  self:_BindResonanceList(activeResonanceList)
end

function CopyStageResonanceDetailPanel:_BindResonanceList(activeResonanceList)
  self.binder:BindToVisible(self.ui.Text_Resonance_Empty, function()
    return 0 == #activeResonanceList
  end)
  self.binder:SetText(self.ui.Text_Resonance_Empty, LT.Text("ResonanceActiveNoneEffectsText"))
  self.binder:BindToVisible(self.ui.ScrollView_Effect, function()
    return #activeResonanceList > 0
  end)
  for index = 1, #activeResonanceList do
    local uiNode = CS.UnityEngine.GameObject.Instantiate(self.ui.Text_Introduce_1, self.ui.Content.transform)
    uiNode:SetActive(true)
    self.binder:onDestroy(function()
      CS.UnityEngine.GameObject.Destroy(uiNode)
    end)
    local resonanceName = ResonanceDataUtils.GetResonanceName(activeResonanceList[index].resonanceId)
    local resonanceLevel = ResonanceDataUtils.GetResonanceLevel(activeResonanceList[index].resonanceId)
    self.binder:SetText(uiNode, string.format(LT.Text("ResonanceEffectsText"), resonanceName, resonanceLevel, ResonanceDataUtils.GetResonanceDesc(activeResonanceList[index].resonanceId)))
  end
end

return CopyStageResonanceDetailPanel
