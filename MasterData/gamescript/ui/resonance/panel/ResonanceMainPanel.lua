local LargeSubplotStageGroupTypeList = {
  CommonDefine.StageGroupType.LargeSubplotNormal,
  CommonDefine.StageGroupType.LargeSubplotHard,
  CommonDefine.StageGroupType.LargeSubplotCrazy
}
local ResonanceMainPanel, Super = System.NewClass("ResonanceMainPanel", UIBasePanel)
ResonanceMainPanel.uiResCls = UI_Chapter_ResonanceMain_PanelResource

function ResonanceMainPanel:ctor(params)
  Super.ctor(self)
  self.resonanceGroupId = params.resonanceGroupId
  self.stageGroupTid = params.stageGroupTid
  self.isActivity = params.isActivity
end

function ResonanceMainPanel:OnBind(binder)
  self.binder = binder
  self.resonanceModel = binder:createModel(ResonanceModel, self.resonanceGroupId)
  self:BindChapterGroupd()
  self:BindResonanceReset()
  self:BindResonanceDetailComp()
  self:BindCurrency()
  self.closeBtn = binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    self:OnClose()
  end))
  self.ui.Group_Toggle:SetActive(false)
  self.binder:SetText(self.ui.Text_Title, LT.Text("ResonanceText"))
  binder:BindButtonClick(self.ui.UI_Common_Btn_Question, function()
    local RailWayStageGroupTid = DT.GetOriginalConstant("RailWayStageGroupTid")
    local stageGroupId = self.stageGroupTid or ResonanceDataUtils.GetStageGroupIdByResonanceGroupId(self.resonanceGroupId)
    local stageGroupType = StageGroupCfgUtils.GetCfgField("Type", stageGroupId)
    if self.isActivity then
      PlayerDataUtils.OpenIllustrate(nil, LT.Text("ActivityResonanceRules"))
    elseif table.contains(LargeSubplotStageGroupTypeList, stageGroupType) then
      PlayerDataUtils.OpenIllustrate(nil, LT.Text("LargeSubplotResonanceRules"))
    elseif self.resonanceGroupId == ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(RailWayStageGroupTid) then
      PlayerDataUtils.OpenIllustrate(nil, LT.Text("RailWayResonanceRuleContent"))
    else
      PlayerDataUtils.OpenIllustrate(nil, LT.Text("ResonanceRules"))
    end
  end)
  PlayerDataUtils.OpenFirstTimeIllustrate(self.__name, nil, LT.Text("ResonanceRules"))
end

function ResonanceMainPanel:OnClose()
  self:Close()
  EventMgr.Instance.UpdateActivityDupInfo:Dispatch()
end

function ResonanceMainPanel:Close()
  if self.detailComp then
    self.detailComp:StopTween()
    self.detailComp.uiAnimController:PlayState("UI_Chapter_Popup_Vibes_List_Exit")
    self.detailComp = nil
  end
  Super.Close(self)
end

function ResonanceMainPanel:BindResonanceReset()
  self.binder:BindButtonClick(self.ui.Btn_Reset, function()
    local totalLevel = ResonanceDataUtils.GetResonanceGroupTotalLevel(self.resonanceGroupId)
    if 0 == totalLevel then
      Alert.Show(10560)
      return
    end
    UIManager.Instance:Reopen(Urls.ResonanceResetConfirmPanel, self.resonanceGroupId)
  end, function()
    local totalLevel = ResonanceDataUtils.GetResonanceGroupTotalLevel(self.resonanceGroupId)
    if 0 == totalLevel then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.Normal
  end)
  self.binder:BindToVisible(self.ui.Btn_Reset, function()
    return false
  end)
  self.binder:SetText(self.ui.Text_C_Reset, LT.Text("ResonanceReset"))
  self.binder:BindToTextColorOld(self.ui.Text_C_Reset, function()
    local totalLevel = ResonanceDataUtils.GetResonanceGroupTotalLevel(self.resonanceGroupId)
    if 0 == totalLevel then
      return DT.ColorConfig.ResonanceGray.Light
    end
    return DT.ColorConfig.TalentNumWhite.Light
  end)
end

function ResonanceMainPanel:BindResonanceDetailComp()
  self.ui.UI_Chapter_Popup_Vibes_List:SetActive(false)
  self.binder:BindToRaw(function(childBinder, nSelectId, _)
    if 0 == nSelectId then
      if self.detailComp then
        self.detailComp.uiAnimController:PlayState("UI_Chapter_Popup_Vibes_List_Exit")
        self.detailComp = nil
      end
      return
    end
    self.ui.UI_Chapter_Popup_Vibes_List:SetActive(true)
    self.detailComp = childBinder:BindComponent(ResonanceDetailComp(self.ui.UI_Chapter_Popup_Vibes_List, self.resonanceModel, self))
    self.detailComp.uiAnimController:PlayState("UI_Chapter_Popup_Vibes_List_Enter")
  end, function()
    do return self.resonanceModel.GetSelectResonanceID end
    return self.resonanceModel.GetSelectResonanceID, self.resonanceModel
  end)
end

function ResonanceMainPanel:BindChapterGroupd()
  print("PlayState BindChapterGroup")
  local prefabName = CommonDefine.ResonancePrefab[self.resonanceGroupId]
  local res = self.binder:LoadAsset(prefabName)
  local currGroupNode = self.binder:Instantiate(res, self.ui.Group_Content.transform)
  local uiResCls = require(CommonDefine.ResonanceRes[self.resonanceGroupId])
  ResonanceGroupItem.uiResCls = uiResCls
  if currGroupNode then
    self.binder:BindUIBehavior(currGroupNode, uiResCls, self.resonanceModel, self.ui.SelectResonancePos, self.ui.SelectResonanceScrollviewPos, self)
  end
end

function ResonanceMainPanel:BindCurrency()
  local coinList = ResonanceDataUtils.GetResonanceGroupAllConsumeMaterials(self.resonanceGroupId)
  self.binder:BindComponent(CommonCurrencyGroupItem(self.ui.UI_Common_Item_Coin_Group, coinList))
end

return ResonanceMainPanel
