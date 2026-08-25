local PvPBuildTagType = CommonDefine.PvPBuildTagType
local ItemType = CommonDefine.ItemType
local PvPTeamMultiBuildPanel, Super = System.NewClass("PvPTeamMultiBuildPanel", PvPTeamBaseBuildPanel)
PvPTeamMultiBuildPanel.uiResCls = UI_Pvp_Panel_FormationResource

function PvPTeamMultiBuildPanel:ctor(mainModel)
  Super.ctor(self, mainModel)
end

function PvPTeamMultiBuildPanel:Init(binder)
  local model = binder:createModel(PvPMultiBuildPanelModel, self.mainModel)
  self.binder = binder
  self.model = model
  self.tagToggleMap = {
    PvPBuildTagType.All,
    PvPBuildTagType.Chaos,
    PvPBuildTagType.Ocean,
    PvPBuildTagType.Blood,
    PvPBuildTagType.Dimension,
    PvPBuildTagType.KeeperSkill,
    PvPBuildTagType.Weapon
  }
  self.awakerCompGroup = {
    self.ui.Item_Team_4,
    self.ui.Item_Team_3,
    self.ui.Item_Team_2,
    self.ui.Item_Team_1
  }
  self.weaponCompGroup = {
    self.ui.Item_Weapon_4,
    self.ui.Item_Weapon_3,
    self.ui.Item_Weapon_2,
    self.ui.Item_Weapon_1
  }
  self.keeperSkillCompGroup = {
    self.ui.Item_Key_2,
    self.ui.Item_Key_1
  }
  self.teamLimitTipsTidMap = {
    [ItemType.AwakerItem] = 10526,
    [ItemType.Weapon] = 10716,
    [ItemType.KeeperSkill] = 10717
  }
end

function PvPTeamMultiBuildPanel:OnBindTitle()
  local binder, _ = self.binder, self.model
  binder:BindToVisible(self.ui.Text_Label, function()
    return false
  end)
  binder:BindToText(self.ui.Text_Title, function()
    do return LT.Text end
    return LT.Text, "PvPTeamMultiBuildTitle"
  end)
end

function PvPTeamMultiBuildPanel:OnBindTagGroup()
  local binder, model = self.binder, self.model
  binder:BindToVisible(self.ui.Image_list, function()
    return true
  end)
  local tagList = {
    PvPBuildTagType.All
  }
  local positionList = PVPCollectionDataUtils.GetPvpPositionList()
  table.mergeArray(tagList, positionList)
  table.mergeArray(tagList, {
    PvPBuildTagType.Weapon,
    PvPBuildTagType.KeeperSkill
  })
  for idx, tagType in pairs(tagList) do
    local obj = self.ui["Btn_" .. idx]
    binder:BindToZ1Toggle(obj, nil, function(isOn)
      if isOn then
        model:SetCurTag(tagType)
      end
    end, function()
      return model.curTag == tagType
    end)
  end
end

function PvPTeamMultiBuildPanel:OnBindCircuListGroup()
  local binder, model = self.binder, self.model
  binder:BindToVisible(self.ui.Group_Null_Black, function()
    return 0 == #model.contentGroup
  end)
  binder:BindToVisible(self.ui.Text_C_Detail, function()
    return not model.curSelectTid or 0 == model.curSelectTid
  end)
  local cellTemplate = self.ui.UI_Pvp_Item_Formation
  self._flatContentGroup = {}
  for _, group in ipairs(model.contentGroup) do
    for _, tid in ipairs(group) do
      table.insert(self._flatContentGroup, tid)
    end
  end
  local itemComps = {}
  self.goodsTableView = self:CreateTableview(self.ui.ScrollView_Goods, function()
    return #self._flatContentGroup
  end, function(view, idx)
    local tid = self._flatContentGroup[idx]
    if not tid then
      return nil
    end
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(cellTemplate)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local itemData = self:_BuildMultiSelectItemData(tid)
    itemComps[gameObj] = self.binder:BindComponent(PvPTeamSelectItem(gameObj, itemData))
    return cell
  end, nil, function()
    itemComps = nil
  end)
  local isFirstLoad = true
  binder:BindToRaw(function(_, _)
    self._flatContentGroup = {}
    for _, group in ipairs(model.contentGroup) do
      for _, tid in ipairs(group) do
        table.insert(self._flatContentGroup, tid)
      end
    end
    if self.goodsTableView then
      if isFirstLoad then
        isFirstLoad = false
        FrameWaiter.OnNextFrame(function()
          if self.goodsTableView then
            self.goodsTableView:ReloadData()
          end
        end)
      else
        self.goodsTableView:ReloadData()
      end
    end
  end, function()
    return model.contentGroup
  end, true)
end

function PvPTeamMultiBuildPanel:_BuildMultiSelectItemData(tid)
  local model = self.model
  local collectCfg = DT.PVPCollect[tid]
  local itemCfg = PvpCollectCfgUtils.GetItemCfgByCollectTid(tid)
  
  local function nameFunc()
    do return PvpCollectCfgUtils.GetCollectionName end
    return PvpCollectCfgUtils.GetCollectionName, tid
  end
  
  local function mainIconFunc()
    local isKeeperSkillCollection = itemCfg.Type == CommonDefine.ItemType.KeeperSkill
    local notOwnedCollection = not PVPCollectionDataUtils.IsRealOwnedCollection(tid)
    if isKeeperSkillCollection and notOwnedCollection then
      return collectCfg.UnknownDetailsImage
    end
    local awakerTid = PvpCollectCfgUtils.GetAwakerTidByCollectTid(tid)
    if awakerTid then
      do return AwakerDataUtils.GetAwakerBust end
      return AwakerDataUtils.GetAwakerBust, awakerTid
    end
    return collectCfg.CollectImage
  end
  
  local function isConflictFunc()
    if itemCfg.Type ~= CommonDefine.ItemType.AwakerItem then
      return false
    end
    if not PVPCollectionDataUtils.HasOwnedCollection(tid) then
      return false
    end
    if table.contains(model.curAwakerGroup, tid) then
      return false
    end
    do return PvPTeamBuildDataUtils.CheckPositionConflict, tid end
    return PvPTeamBuildDataUtils.CheckPositionConflict, tid, model.curSelectPosGroup
  end
  
  local function clickFunc()
    local isConflict = isConflictFunc()
    local notOwnedCollection = not PVPCollectionDataUtils.HasOwnedCollection(tid)
    if isConflict then
      local tipId = 20300
      local tipConfig = DT.TipsType[tipId]
      local posTid = PvpCollectCfgUtils.GetCollectAwakerPvpPosition(tid)
      local config = PVPPositionCfgUtils.GetCfg(posTid)
      local posName = config and LT.Text(config.Name)
      Alert.Show(tipId, nil, nil, nil, LT.Textf(tipConfig.Desc, posName))
    elseif notOwnedCollection then
      local collectionName = PvpCollectCfgUtils.GetCollectionName(tid)
      if not model:IsInTeam(tid) then
        Alert.Show(10903, nil, nil, nil, LT.Textf(DT.TipsType[10903].Desc, collectionName))
      end
    end
    if table.contains(model.type2GroupMap[itemCfg.Type], tid) then
      model:SetCurSelectTid(tid)
      model:RemoveGroupByType(tid, itemCfg.Type)
      return
    end
    model:SetCurSelectTid(tid)
    local isReachSelectLimitNum = self:CheckEffectNumLimit(itemCfg.Type)
    if isReachSelectLimitNum or notOwnedCollection or isConflict then
      return
    end
    if not table.contains(model.type2GroupMap[itemCfg.Type], tid) then
      model:AddGroupByType(tid, itemCfg.Type)
    end
  end
  
  local function isChooseFunc()
    return model.curSelectTid == tid
  end
  
  local function isMultiChooseFunc()
    do return table.contains, model.type2GroupMap[itemCfg.Type] end
    return table.contains, model.type2GroupMap[itemCfg.Type], tid
  end
  
  local function itemTypeFunc()
    return itemCfg.Type
  end
  
  local function nameFrameIconFunc()
    do return PVPCollectionDataUtils.GetCollectionNameFrameImage end
    return PVPCollectionDataUtils.GetCollectionNameFrameImage, tid
  end
  
  local function showNotOwnedIconFunc()
    return not PVPCollectionDataUtils.HasOwnedCollection(tid)
  end
  
  return {
    nameFunc = nameFunc,
    mainIconFunc = mainIconFunc,
    clickFunc = clickFunc,
    isChooseFunc = isChooseFunc,
    isMultiChooseFunc = isMultiChooseFunc,
    isConflictFunc = isConflictFunc,
    itemTypeFunc = itemTypeFunc,
    nameFrameIconFunc = nameFrameIconFunc,
    showNotOwnedIconFunc = showNotOwnedIconFunc,
    isUnlockByBattlePassFunc = function()
      do return PVPCollectionDataUtils.IsUnlockByBattlePass end
      return PVPCollectionDataUtils.IsUnlockByBattlePass, tid
    end
  }
end

function PvPTeamMultiBuildPanel:OnBindTeamInfo()
  local binder, model = self.binder, self.model
  binder:BindToVisible(self.ui.Group_TeamInfo, function()
    return true
  end)
  binder:BindToText(self.ui.Text_Team_Name, function()
    do return LT.Text, PvPTeamBuildDataUtils.GetTeamNameByIdx(self.mainModel.curTeamIdx) end
    return LT.Text, PvPTeamBuildDataUtils.GetTeamNameByIdx(self.mainModel.curTeamIdx)
  end)
  binder:BindButtonClick(self.ui.Btn_Rename, function()
    UIManager.Instance:Reopen(Urls.PvPTeamRenamePanel, self.mainModel.curTeamIdx)
  end)
  for idx, ui in pairs(self.awakerCompGroup) do
    local function textIdFunc()
      return idx
    end
    
    local function mainIconFunc()
      do return PvpCollectCfgUtils.GetCollectAwakerFormationImage end
      return PvpCollectCfgUtils.GetCollectAwakerFormationImage, model.curAwakerGroup[idx], idx
    end
    
    local function nameFrameFunc()
      local itemCfg = PvpCollectCfgUtils.GetItemCfgByCollectTid(model.curAwakerGroup[idx])
      if not itemCfg or itemCfg.Type ~= CommonDefine.ItemType.AwakerItem then
        return nil
      end
      local posTid = PvpCollectCfgUtils.GetCollectAwakerPvpPosition(model.curAwakerGroup[idx])
      local posConfig = PVPPositionCfgUtils.GetCfg(posTid)
      return posConfig and posConfig.CollectPositionColour
    end
    
    local function isEmptyFunc()
      return 0 == model.curAwakerGroup[idx]
    end
    
    local function clickFunc()
      if 0 ~= model.curAwakerGroup[idx] then
        model:RemoveGroupByType(model.curAwakerGroup[idx], ItemType.AwakerItem)
      end
    end
    
    local function tidFunc()
      return model.curAwakerGroup[idx]
    end
    
    local itemData = {
      isEmptyFunc = isEmptyFunc,
      textIdFunc = textIdFunc,
      mainIconFunc = mainIconFunc,
      clickFunc = clickFunc,
      nameFrameFunc = nameFrameFunc,
      tidFunc = tidFunc
    }
    binder:BindComponent(PvPTeamQuickBuildAwakerItem(ui, itemData))
  end
  self:BindWeaponKeeperSkillItem(self.keeperSkillCompGroup, ItemType.KeeperSkill)
  self:BindWeaponKeeperSkillItem(self.weaponCompGroup, ItemType.Weapon)
end

function PvPTeamMultiBuildPanel:BindWeaponKeeperSkillItem(compGroup, type)
  local binder, model = self.binder, self.model
  for idx, ui in pairs(compGroup) do
    local function mainIconFunc()
      local tid = model.type2GroupMap[type][idx]
      
      local collectCfg = DT.PVPCollect[model.type2GroupMap[type][idx]]
      if not collectCfg then
        return
      end
      if collectCfg.Type == cd.PVPCollectionType.KeeperSkill and not PVPCollectionDataUtils.IsRealOwnedCollection(tid) then
        return collectCfg.UnknownDetailsImage
      end
      local awakerTid = PvpCollectCfgUtils.GetAwakerTidByCollectTid(tid)
      if awakerTid then
        do return AwakerDataUtils.GetAwakerBust end
        return AwakerDataUtils.GetAwakerBust, awakerTid
      end
      return collectCfg and collectCfg.CollectImage
    end
    
    local function clickFunc()
      if 0 ~= model.type2GroupMap[type][idx] then
        model:RemoveGroupByType(model.type2GroupMap[type][idx], type)
      end
    end
    
    local function isEmptyFunc()
      return 0 == model.type2GroupMap[type][idx]
    end
    
    local function itemTypeFunc()
      local itemCfg = PvpCollectCfgUtils.GetItemCfgByCollectTid(model.type2GroupMap[type][idx])
      return itemCfg and itemCfg.Type
    end
    
    local function tidFunc()
      return model.type2GroupMap[type][idx]
    end
    
    local itemData = {
      mainIconFunc = mainIconFunc,
      clickFunc = clickFunc,
      isEmptyFunc = isEmptyFunc,
      itemTypeFunc = itemTypeFunc,
      tidFunc = tidFunc
    }
    binder:BindComponent(PvPTeamQuickBuildWeaponKeeperSkillItem(ui, itemData))
  end
end

function PvPTeamMultiBuildPanel:OnBindAwakerImage()
  local binder = self.binder
  binder:BindToVisible(self.ui.Image_Mask, function()
    return false
  end)
  binder:BindToVisible(self.ui.Awaker_Half, function()
    return true
  end)
  binder:BindToVisible(self.ui.Awaker_Body, function()
    return false
  end)
  local portraitAlign = CommonDefine.PortraitAlign.Center
  binder:BindToRaw(function(childBinder, awakerTid)
    if awakerTid then
      local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
      local skinRes = AwakerSkinUtils.GetSkinResNum(awakerData.curSkin)
      childBinder:BindComponent(AwakerPortraitComp(self.ui.Container_Awaker_Half, awakerTid, skinRes, nil, portraitAlign))
    end
  end, function()
    do return self.GetAwakerId end
    return self.GetAwakerId, self
  end)
end

function PvPTeamMultiBuildPanel:OnBindButton()
  local binder, _ = self.binder, self.model
  self.closeBtn = binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, System.fn(self, self.OnClose)))
  binder:BindZ1Button(self.ui.UI_Common_Btn_Level1, System.fn(self, self.SaveTeamBuilding), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "Formation_SelectRole_Sure_Btn2"
  end)
end

function PvPTeamMultiBuildPanel:SaveTeamBuilding()
  local mainModel, model = self.mainModel, self.model
  local awakerGroup = table.clone(model.curAwakerGroup)
  local weaponGroup = table.clone(model.curWeaponGroup)
  local keeperSkillGroup = table.clone(model.curKeeperSkillGroup)
  mainModel:SetAwakerGroup(awakerGroup)
  mainModel:SetWeaponGroup(weaponGroup)
  mainModel:SetKeeperSkillGroup(keeperSkillGroup)
  PvPTeamBuildDataUtils.ReqUpdateTeam(mainModel.curTeamIdx, mainModel.awakerGroup, mainModel.weaponGroup, mainModel.keeperSkillGroup)
  self:OnClose()
end

function PvPTeamMultiBuildPanel:CheckEffectNumLimit(type)
  local group = self.model.type2GroupMap[type]
  local limitNum = #group
  local effectNum = 0
  for _, tid in pairs(group) do
    if 0 ~= tid then
      effectNum = effectNum + 1
    end
  end
  return limitNum <= effectNum
end

return PvPTeamMultiBuildPanel
