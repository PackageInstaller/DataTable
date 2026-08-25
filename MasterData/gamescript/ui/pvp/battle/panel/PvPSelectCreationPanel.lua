local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local PvPSelectCreationPanel, Super = System.NewClass("PvPSelectCreationPanel", UIBasePanel)
PvPSelectCreationPanel.uiResCls = "UI/UI_Pvp/UI_Pvp_Prefab/UI_Pvp_Popup_SelectCreation.prefab"

function PvPSelectCreationPanel:ctor(callback)
  Super.ctor(self)
  self.callback = callback
  self.selectedRelicTid = Vue.ref(nil)
  self.relicList = nil
end

function PvPSelectCreationPanel:OnBind(binder)
  self.binder = binder
  self:InitRelicList()
  binder:BindEvent(EventMgr.Instance.OnEnterScene, System.fn(self, self.OnEnterScene))
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  binder:BindZ1Button(self.ui.Btn_Confirm, System.fn(self, self.OnConfirmClick), function()
    if self.selectedRelicTid.value then
      return CommonDefine.BtnType.High
    else
      return CommonDefine.BtnType.Unclickable
    end
  end, function()
    do return LT.Text end
    return LT.Text, "UniversalConfirmButton"
  end, nil, nil, nil)
  self:RefreshRelicTableView()
end

function PvPSelectCreationPanel:OnEnterScene(scene)
  self:Close()
end

function PvPSelectCreationPanel:RefreshRelicTableView()
  if not self.tableView then
    self:CreateRelicTableView()
  end
  self.tableView:ReloadData()
end

function PvPSelectCreationPanel:CreateRelicTableView()
  local itemPrefab = self.ui.UI_Pvp_Item_SelectCreation
  local cellRT = itemPrefab:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  local cbinderMap = {}
  self.tableView = self:CreateTableview(self.ui.CreationView, function()
    return #self.relicList
  end, function(view, index)
    local cell = self:DequeueCell(view, itemPrefab)
    local relicTid = self.relicList[index]
    local cbinder = cbinderMap[cell.gameObject]
    if cbinder then
      cbinder:teardown()
    end
    cbinder = self.binder:createChild(cell.gameObject)
    cbinderMap[cell.gameObject] = cbinder
    cbinder:BindComponent(PvPSelectCreationItem(cell.gameObject, relicTid, self.selectedRelicTid.value == relicTid, System.fn(self, self.OnRelicClick)))
    return cell
  end, function()
    return width, height
  end, function(view, cell)
    local cbinder = cbinderMap[cell.gameObject]
    if cbinder then
      cbinder:teardown()
      cbinderMap[cell.gameObject] = nil
    end
  end)
end

function PvPSelectCreationPanel:InitRelicList()
  self.relicList = DT.GetOriginalConstant("RotationModeRelicConfig") or {}
end

function PvPSelectCreationPanel:OnRelicClick(item, relicTid)
  self.selectedRelicTid.value = relicTid
  self:RefreshRelicTableView()
end

function PvPSelectCreationPanel:OnConfirmClick()
  if not self.selectedRelicTid.value then
    Alert.ShowStr(LT.Text("RelicAwardUncheck"))
    return
  end
  local selectCollectionTid = PvpCollectionModel.Instance:GetSelectCollectionTid()
  UIManager.Instance:CloseByUrl(Urls.PvPBattleTrainPanel)
  local awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(selectCollectionTid)
  BattleManager.Instance:DisposeCurrentBattle()
  local delayInitBattle = 0.05
  self.binder:BindTimer(delayInitBattle, 0, nil, function()
    local pvpTrainData = BattlePVPTrainMockDataUtil.MockDataToBattleData(awakerTid, self.selectedRelicTid.value)
    BattleManager.Instance:EnterBattle(pvpTrainData)
  end)
  if self.callback then
    self.callback(self.selectedRelicTid.value)
  end
  self.binder:BindTimer(delayInitBattle + 0.1, 0, nil, function()
    self:Close()
  end)
end

return PvPSelectCreationPanel
