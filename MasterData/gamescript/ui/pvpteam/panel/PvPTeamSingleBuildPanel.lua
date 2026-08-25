local ItemType = CommonDefine.ItemType
local PvPBuildTagType = CommonDefine.PvPBuildTagType
local TAG_TOGGLE_NUM = 8
local PvPTeamSingleBuildPanel, Super = System.NewClass("PvPTeamSingleBuildPanel", PvPTeamBaseBuildPanel)
PvPTeamSingleBuildPanel.uiResCls = UI_Pvp_Panel_FormationResource

function PvPTeamSingleBuildPanel:ctor(mainModel, type, buildIdx)
  Super.ctor(self, mainModel)
  self.type = type
  self.buildIdx = buildIdx
end

function PvPTeamSingleBuildPanel:Init(binder)
  local model = binder:createModel(PvPSingleBuildPanelModel, self.mainModel, self.type, self.buildIdx)
  self.binder = binder
  self.model = model
  self.tagToggleMap = {
    PvPBuildTagType.All,
    PvPBuildTagType.Chaos,
    PvPBuildTagType.Ocean,
    PvPBuildTagType.Blood,
    PvPBuildTagType.Dimension
  }
  self.type2TitleNameMap = {
    [ItemType.AwakerItem] = LT.Text("PvPTeamSingleBuildAwakerTitle"),
    [ItemType.Weapon] = LT.Text("PvPTeamSingleBuildWeaponTitle"),
    [ItemType.KeeperSkill] = LT.Text("PvPTeamSingleBuildKeyTitle")
  }
end

function PvPTeamSingleBuildPanel:OnBindTeamInfo()
  self.binder:BindToVisible(self.ui.Group_TeamInfo, function()
    return false
  end)
end

function PvPTeamSingleBuildPanel:OnBindTitle()
  local binder, model = self.binder, self.model
  binder:BindToVisible(self.ui.Text_Label, function()
    return false
  end)
  binder:BindToText(self.ui.Text_Title, function()
    return self.type2TitleNameMap[model.type]
  end)
end

function PvPTeamSingleBuildPanel:OnBindTagGroup()
  local binder, model = self.binder, self.model
  binder:BindToVisible(self.ui.Image_list, function()
    return model.type == ItemType.AwakerItem
  end)
  local tagList = {
    PvPBuildTagType.All
  }
  local positionList = PVPCollectionDataUtils.GetPvpPositionList()
  table.mergeArray(tagList, positionList)
  for idx = 1, TAG_TOGGLE_NUM do
    local obj = self.ui["Btn_" .. idx]
    local tag = tagList[idx]
    obj:SetActive(tag)
    if tag then
      binder:BindToZ1Toggle(obj, nil, function(isOn)
        if isOn then
          model:SetCurTag(tag)
        end
      end, function()
        return model.curTag == tag
      end)
    end
  end
end

function PvPTeamSingleBuildPanel:OnBindTagGroupWithPosition()
  local binder, model = self.binder, self.model
  binder:BindToVisible(self.ui.Image_list, function()
    return model.type == ItemType.AwakerItem
  end)
  local tagList = {
    PvPBuildTagType.All
  }
  local positionList = PVPCollectionDataUtils.GetPvpPositionList()
  table.mergeArray(tagList, positionList)
  for idx = 1, TAG_TOGGLE_NUM do
    local obj = self.ui["Btn_" .. idx]
    local tag = tagList[idx]
    if tag then
      binder:BindToZ1Toggle(obj, nil, function(isOn)
        if isOn then
          model:SetCurTag(tag)
        end
      end, function()
        return model.curTag == tag
      end)
    end
    obj:SetActive(tag)
  end
end

function PvPTeamSingleBuildPanel:OnBindCircuListGroup()
  local binder, model = self.binder, self.model
  binder:BindToVisible(self.ui.Group_Null_Black, function()
    return 0 == #model.contentGroup
  end)
  binder:BindToVisible(self.ui.Text_C_Empty, function()
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
    local itemData = self:_BuildSingleSelectItemData(tid)
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

function PvPTeamSingleBuildPanel:_BuildSingleSelectItemData(tid)
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
  
  local function isChooseFunc()
    return model.curSelectTid == tid
  end
  
  local function isMultiChooseFunc()
    do return table.contains, model.mainModel.type2GroupMap[itemCfg.Type] end
    return table.contains, model.mainModel.type2GroupMap[itemCfg.Type], tid
  end
  
  local function isConflictFunc()
    do return self._CheckConflict, self end
    return self._CheckConflict, self, tid
  end
  
  local function clickFunc()
    model:SetCurSelectTid(tid)
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
    isConflictFunc = isConflictFunc,
    itemTypeFunc = itemTypeFunc,
    nameFrameIconFunc = nameFrameIconFunc,
    showNotOwnedIconFunc = showNotOwnedIconFunc,
    isMultiChooseFunc = isMultiChooseFunc,
    isUnlockByBattlePassFunc = function()
      do return PVPCollectionDataUtils.IsUnlockByBattlePass end
      return PVPCollectionDataUtils.IsUnlockByBattlePass, tid
    end
  }
end

function PvPTeamSingleBuildPanel:OnBindButton()
  local binder, model, mainModel = self.binder, self.model, self.mainModel
  self.closeBtn = binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, System.fn(self, self.OnClose)))
  binder:BindZ1Button(self.ui.UI_Common_Btn_Level1, System.fn(self, self.SaveTeamBuilding), function()
    local oriTid = mainModel.type2GroupMap[model.type][model.buildIdx]
    local notOwnedCollection = not PVPCollectionDataUtils.HasOwnedCollection(model.curSelectTid)
    local isConflict = 0 ~= model.curSelectTid and self:_CheckConflict(model.curSelectTid)
    if 0 ~= oriTid and oriTid == model.curSelectTid then
      return CommonDefine.BtnType.High
    end
    if 0 == oriTid and 0 == model.curSelectTid or notOwnedCollection or isConflict then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.High
  end, function()
    local oriTid = mainModel.type2GroupMap[model.type][model.buildIdx]
    if 0 == oriTid then
      do return LT.Text end
      return LT.Text, "Formation_SelectRole_Sure_Btn2"
    elseif oriTid == model.curSelectTid then
      do return LT.Text end
      return LT.Text, "Formation_SelectRole_Sure_Btn1"
    end
    do return LT.Text end
    return LT.Text, "Formation_SelectRole_Sure_Btn3"
  end)
end

function PvPTeamSingleBuildPanel:OnBindAwakerImage()
  local binder = self.binder
  binder:BindToVisible(self.ui.Image_Mask, function()
    return false
  end)
  binder:BindToVisible(self.ui.Awaker_Half, function()
    return false
  end)
  binder:BindToVisible(self.ui.Awaker_Body, function()
    return true
  end)
  local portraitAlign = CommonDefine.PortraitAlign.Center
  binder:BindToRaw(function(childBinder, resNum)
    if resNum then
      childBinder:BindComponent(AwakerPortraitComp(self.ui.Container_Awaker_Body, nil, resNum, nil, portraitAlign))
    end
  end, function()
    do return self.GetAwakerResNum end
    return self.GetAwakerResNum, self
  end)
end

function PvPTeamSingleBuildPanel:_CheckConflict(collectionTid)
  local itemCfg = PvpCollectCfgUtils.GetItemCfgByCollectTid(collectionTid)
  if itemCfg.Type ~= CommonDefine.ItemType.AwakerItem then
    return false
  end
  if not PVPCollectionDataUtils.HasOwnedCollection(collectionTid) then
    return false
  end
  if table.contains(self.model.mainModel.awakerGroup, collectionTid) then
    return false
  end
  do return PvPTeamBuildDataUtils.CheckPositionConflict, collectionTid end
  return PvPTeamBuildDataUtils.CheckPositionConflict, collectionTid, self.model.curChosenPosTids
end

function PvPTeamSingleBuildPanel:SaveTeamBuilding()
  local mainModel, model = self.mainModel, self.model
  if 0 == model.curSelectTid and 0 == model:GetOriTid() then
    Alert.Show(10525)
    return
  end
  if not PVPCollectionDataUtils.HasOwnedCollection(model.curSelectTid) then
    local oriTid = mainModel.type2GroupMap[model.type][model.buildIdx]
    local isOffLoad = 0 ~= oriTid and oriTid == model.curSelectTid
    if not isOffLoad then
      local collectionName = PvpCollectCfgUtils.GetCollectionName(model.curSelectTid)
      Alert.Show(10903, nil, nil, nil, LT.Textf(DT.TipsType[10903].Desc, collectionName))
      return
    end
  end
  if self:_CheckConflict(model.curSelectTid) then
    local tipId = 20300
    local tipConfig = DT.TipsType[tipId]
    local posTid = PvpCollectCfgUtils.GetCollectAwakerPvpPosition(model.curSelectTid)
    local config = PVPPositionCfgUtils.GetCfg(posTid)
    local posName = config and LT.Text(config.Name)
    Alert.Show(tipId, nil, nil, nil, LT.Textf(tipConfig.Desc, posName))
    return
  end
  local finalGroup = table.clone(mainModel.type2GroupMap[model.type])
  local oriTid = model:GetOriTid()
  if model.curSelectTid == oriTid then
    finalGroup[model.buildIdx] = 0
  else
    local replaceIdx
    for idx, tid in pairs(finalGroup) do
      if tid == model.curSelectTid then
        replaceIdx = idx
        break
      end
    end
    if replaceIdx and finalGroup[replaceIdx] then
      finalGroup[replaceIdx] = oriTid
    end
    finalGroup[model.buildIdx] = model.curSelectTid
  end
  if model.type == ItemType.AwakerItem then
    mainModel:SetAwakerGroup(finalGroup)
  elseif model.type == ItemType.Weapon then
    mainModel:SetWeaponGroup(finalGroup)
  elseif model.type == ItemType.KeeperSkill then
    mainModel:SetKeeperSkillGroup(finalGroup)
  end
  PvPTeamBuildDataUtils.ReqUpdateTeam(mainModel.curTeamIdx, mainModel.awakerGroup, mainModel.weaponGroup, mainModel.keeperSkillGroup)
  self:OnClose()
end

return PvPTeamSingleBuildPanel
