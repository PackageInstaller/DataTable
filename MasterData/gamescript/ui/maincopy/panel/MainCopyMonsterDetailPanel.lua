local MainCopyMonsterDetailPanel, Super = System.NewClass("MainCopyMonsterDetailPanel", UIBasePanel)
MainCopyMonsterDetailPanel.uiResCls = UI_Chapter_Popup_Monster_DetailsResource

function MainCopyMonsterDetailPanel:ctor(stageId, monsters)
  Super.ctor(self)
  self.stageId = stageId
  self.monsters = table.clone(monsters)
  self.monsterTid = Vue.ref(monsters and monsters[1])
end

function MainCopyMonsterDetailPanel:OnBind(binder)
  local commonPopupTipsData = {
    sizeType = CommonDefine.PopupTipsType.S,
    textTitleCN = nil,
    clickFunc = System.fn(self, self.Close)
  }
  binder:BindComponent(CommonPopupTips(self.ui.UI_Common_Popup_Tips_S, commonPopupTipsData))
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  binder:BindToText(self.ui.Text_Quality, function()
    local monsterCfg = DT.MonsterConfig[self.monsterTid.value]
    if monsterCfg.MonsterClass == bc.EnemyType.Common then
      return "普通"
    elseif monsterCfg.MonsterClass == bc.EnemyType.Elite then
      return "精英"
    elseif monsterCfg.MonsterClass == bc.EnemyType.Boss then
      return "Boss"
    end
  end)
  binder:BindToText(self.ui.Text_Monster_Name, function()
    do return CopyDataUtils.GetMonsterName, self.monsterTid.value end
    return CopyDataUtils.GetMonsterName, self.monsterTid.value, self.stageId
  end)
  binder:BindToText(self.ui.Text_Details, function()
    local monsterCfg = CopyDataUtils.GetMonsterConfig(self.monsterTid.value) or {}
    return monsterCfg.Desc
  end)
  binder:BindToRaw(function(_, stateList)
    self:OnMonsterStateChange(stateList or {})
  end, function()
    do return CopyDataUtils.GetMonsterStateComputeList, self.stageId end
    return CopyDataUtils.GetMonsterStateComputeList, self.stageId, self.monsterTid.value
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Monster, function()
    return self.monsters
  end, function(itemBinder, item, index)
    local mainCopyMonsterItem = itemBinder:BindComponent(MainCopyMonsterItem(item, self.stageId, self.monsters[index], function()
      self.monsterTid.value = self.monsters[index]
    end))
    itemBinder:BindToVisible(mainCopyMonsterItem.ui.Image_Select, function()
      return self.monsterTid.value == self.monsters[index]
    end)
  end)
end

function MainCopyMonsterDetailPanel:OnMonsterStateChange(stateComputeList)
  self.ui.Group_State:SetActive(#stateComputeList > 0)
  local stateCompute = stateComputeList[1]
  if stateCompute then
    self.binder:SetText(self.ui.Text_State_Name, stateCompute:GetBuffName())
    self.binder:SetText(self.ui.Text_State_Desc, stateCompute:GetDesc())
  end
end

return MainCopyMonsterDetailPanel
