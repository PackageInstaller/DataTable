local ItemType = CommonDefine.ItemType
local PvPTeamBaseBuildPanel, Super = System.NewClass("PvPTeamBaseBuildPanel", UIBasePanel)
PvPTeamBaseBuildPanel.uiResCls = UI_Pvp_Panel_FormationResource

function PvPTeamBaseBuildPanel:ctor(mainModel)
  Super.ctor(self)
  self.mainModel = mainModel
end

function PvPTeamBaseBuildPanel:OnBind(binder)
  self:Init(binder)
  self:OnBindTitle()
  self:OnBindTagGroup()
  self:OnBindCircuListGroup()
  self:OnBindSelectAwakerView()
  self:OnBindSelectKeeperSkillWeaponView()
  self:OnBindTeamInfo()
  self:OnBindButton()
  self:OnBindAwakerImage()
  self:OnBattlePass()
end

function PvPTeamBaseBuildPanel:OnBattlePass()
  self.binder:BindToVisible(self.ui.TemporaryUnLock, function()
    return not PVPCollectionDataUtils.IsOwnedAll()
  end)
  self.binder:BindToText(self.ui.Txt_TemporaryUnLock, function()
    if BattlePassDataUtils.IsCore() then
      do return LT.Text end
      return LT.Text, "PVPBPUnLockTxt"
    else
      do return LT.Text end
      return LT.Text, "PVPBPLockTxt"
    end
  end)
  self.binder:BindButtonClick(self.ui.TemporaryUnLock, function()
    BattlePassDataUtils.OpenBuyCore()
  end)
end

function PvPTeamBaseBuildPanel:OnBindSelectAwakerView()
  local binder, model = self.binder, self.model
  binder:BindToVisible(self.ui.Image_Enlightenment, function()
    do return self.CheckCollcetType, self, model.curSelectTid end
    return self.CheckCollcetType, self, model.curSelectTid, {
      ItemType.AwakerItem
    }, ItemType.AwakerItem
  end)
  binder:BindButtonClick(self.ui.Btn_Detail, function()
    PvpCollectionModel.Instance:SetSelectCollectionTid(model.curSelectTid)
    local panelData = {
      targetIndex = 1,
      showList = {
        model.curSelectTid
      },
      targetTab = CommonDefine.PVPCollectionDetailTab.Detail
    }
    PvpCollectionController.Instance:OpenPvpCollectionMainView(panelData)
  end)
  binder:BindToImage(self.ui.Image_Positioning, function()
    local positionTid = PvpCollectCfgUtils.GetCollectAwakerPvpPosition(model.curSelectTid)
    local positionConfig = PVPPositionCfgUtils.GetCfg(positionTid)
    return positionConfig and positionConfig.CollectDetailsPositionIcon
  end)
  binder:BindToText(self.ui.Text_Awaker_Name, function()
    local awakerTid = self:GetAwakerId()
    return awakerTid and LT.Text(DT.AwakerConfig[awakerTid].Name) or nil
  end)
  binder:BindToVisible(self.ui.Group_Awaken, function()
    return false
  end)
end

function PvPTeamBaseBuildPanel:OnBindSelectKeeperSkillWeaponView()
  local binder, model = self.binder, self.model
  binder:BindButtonClick(self.ui.Btn_Card_Click, function()
    local itemCfg = PvpCollectCfgUtils.GetItemCfgByCollectTid(model.curSelectTid)
    local skillId = itemCfg.PVPSkill[1]
    local panelData = {cardUid = 0, cardTid = skillId}
    UIManager.Instance:Reopen(Urls.CardFeatureInfoPanel, panelData)
  end)
  binder:BindToVisible(self.ui.Item_Card_Base, function()
    do return self.CheckCollcetType, self, model.curSelectTid end
    return self.CheckCollcetType, self, model.curSelectTid, {
      ItemType.Weapon,
      ItemType.KeeperSkill
    }, ItemType.Weapon, ItemType.KeeperSkill
  end)
  binder:BindToRaw(function(cBinder, nVal, _)
    if self:CheckCollcetType(model.curSelectTid, {
      ItemType.Weapon,
      ItemType.KeeperSkill
    }) then
      local itemCfg = PvpCollectCfgUtils.GetItemCfgByCollectTid(nVal)
      local skillId = itemCfg.PVPSkill[1]
      cBinder:BindComponent(CardBaseComponent(self.ui.Item_Card_Base, 0, skillId))
    end
  end, function()
    return model.curSelectTid
  end)
end

function PvPTeamBaseBuildPanel:GetAwakerId()
  local model = self.model
  if not self:CheckCollcetType(model.curSelectTid, {
    ItemType.AwakerItem
  }) then
    return nil
  end
  local awakerTid = PvpCollectCfgUtils.GetAwakerTidByCollectTid(model.curSelectTid)
  if not awakerTid then
    return nil
  end
  return awakerTid
end

function PvPTeamBaseBuildPanel:GetAwakerResNum()
  local awakerTid = self:GetAwakerId()
  if not awakerTid then
    return nil
  end
  do return AwakerDataUtils.GetAwakerResNum, awakerTid end
  return AwakerDataUtils.GetAwakerResNum, awakerTid, false
end

function PvPTeamBaseBuildPanel:OnClose()
  self:Close()
end

function PvPTeamBaseBuildPanel:CheckCollcetType(collectId, typeGroup)
  local itemCfg = PvpCollectCfgUtils.GetItemCfgByCollectTid(collectId)
  return itemCfg and table.contains(typeGroup, itemCfg.Type)
end

return PvPTeamBaseBuildPanel
