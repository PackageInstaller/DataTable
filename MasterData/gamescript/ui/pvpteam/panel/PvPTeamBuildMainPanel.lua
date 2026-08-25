local ItemType = CommonDefine.ItemType
local PvPTeamBuildMainPanel, Super = System.NewClass("PvPTeamBuildMainPanel", UIBasePanel)
PvPTeamBuildMainPanel.uiResCls = UI_Pvp_Team_MainResource

function PvPTeamBuildMainPanel:ctor()
  Super.ctor(self)
end

function PvPTeamBuildMainPanel:OnBind(binder)
  local model = binder:createModel(PvPTeamBuildMainPanelModel)
  self:_InitViewData(binder, model)
  self:OnBindClose()
  self:OnBindTeamToggle()
  self:OnBindTeamName()
  self:OnBindBottomBtn()
  self:OnBindAwakerGroup()
  self:OnBindWeaponGroup()
  self:OnBindKeeperSkillGroup()
  self:OnBindBattlePass()
  self:OnBindTeamCopyBtn()
  self:_InitDragSwap()
end

function PvPTeamBuildMainPanel:OnUnbind(binder)
  if self.dragCtrl then
    self.dragCtrl:UnInit()
    self.dragCtrl = nil
  end
  Super.OnUnbind(self, binder)
end

function PvPTeamBuildMainPanel:_InitViewData(binder, model)
  self.binder = binder
  self.model = model
  self.teamToggleGroup = {
    1,
    2,
    3,
    4,
    5
  }
  self.awakerCompGroup = {
    self.ui.UI_Pvp_Item_Information_5,
    self.ui.UI_Pvp_Item_Information_4,
    self.ui.UI_Pvp_Item_Information_3,
    self.ui.UI_Pvp_Item_Information_2
  }
  self.weaponCompGroup = {
    self.ui.UI_Pvp_Item_Information_10,
    self.ui.UI_Pvp_Item_Information_9,
    self.ui.UI_Pvp_Item_Information_8,
    self.ui.UI_Pvp_Item_Information_6
  }
  self.keeperSkillCompGroup = {
    self.ui.UI_Pvp_Item_Information_1,
    self.ui.UI_Pvp_Item_Information_7
  }
end

function PvPTeamBuildMainPanel:_OnClickMatchBtn()
  if self.model:CheckNeedUnlockBattlePass() then
    Alert.Show(100018, nil, function()
      BattlePassDataUtils.OpenBuyCore()
    end)
    return
  end
  if not self.model:CheckCanChallenge() then
    Alert.ShowStr(LT.Text("PvPTeamBuildChallengeNotFullTips"))
    return
  end
  local param = {
    pvpType = PvpMatchModel.Instance:GetPvpType(),
    onlyHuman = not PvpMatchModel.Instance:GetIsMatchMachine(),
    speedFirst = PvpMatchModel.Instance:GetIsSpeedFirst()
  }
  PvpController.Instance:ReqOnMatch(param)
end

function PvPTeamBuildMainPanel:OnBindClose()
  self.closeBtn = self.binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    self:OnClose()
  end))
  self.binder:BindEvent(EventMgr.Instance.PvPMatchEnded, System.fn(self, self.OnClose))
end

function PvPTeamBuildMainPanel:OnBindTeamToggle()
  local binder, model = self.binder, self.model
  for _, teamIdx in pairs(self.teamToggleGroup) do
    binder:BindToZ1Toggle(self.ui["Toggle_" .. teamIdx], nil, function(isOn)
      if isOn then
        model:SetCurTeamIdx(teamIdx)
      end
    end, function()
      return teamIdx == model.curTeamIdx
    end)
  end
end

function PvPTeamBuildMainPanel:OnBindTeamName()
  local binder, model = self.binder, self.model
  binder:BindToText(self.ui.Text_Team_Name, function()
    do return LT.Text, PvPTeamBuildDataUtils.GetTeamNameByIdx(model.curTeamIdx) end
    return LT.Text, PvPTeamBuildDataUtils.GetTeamNameByIdx(model.curTeamIdx)
  end)
  binder:BindButtonClick(self.ui.Btn_Rename, function()
    UIManager.Instance:Reopen(Urls.PvPTeamRenamePanel, model.curTeamIdx)
  end)
end

function PvPTeamBuildMainPanel:OnBindBottomBtn()
  local binder, model = self.binder, self.model
  binder:BindZ1Button(self.ui.Btn_Quick_Build, function()
    PvPTeamBuildDataUtils.OpenPvPTeamMultiBuildPanel(model)
  end, function()
    return CommonDefine.BtnType.High
  end)
  binder:BindZ1Button(self.ui.Btn_Challenge, System.fn(self, self._OnClickMatchBtn), function()
    if model:CheckNeedUnlockBattlePass() then
      return CommonDefine.BtnType.Unclickable
    end
    if not model:CheckCanChallenge() then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "PvPChallengeBtnText"
  end)
end

function PvPTeamBuildMainPanel:OnBindAwakerGroup()
  local binder, _ = self.binder, self.model
  for idx, ui in ipairs(self.awakerCompGroup) do
    binder:BindComponent(PvPTeamBuildAwakerItem(ui, self:_CreateAwakerItemData(idx)))
  end
end

function PvPTeamBuildMainPanel:OnBindWeaponGroup()
  local binder, _ = self.binder, self.model
  for idx, ui in ipairs(self.weaponCompGroup) do
    binder:BindComponent(PvPTeamBuildWeaponItem(ui, self:_CreateBaseItemData(idx, ItemType.Weapon)))
  end
end

function PvPTeamBuildMainPanel:OnBindKeeperSkillGroup()
  local binder, _ = self.binder, self.model
  for idx, ui in ipairs(self.keeperSkillCompGroup) do
    binder:BindComponent(PvPTeamBuildKeeperSkillItem(ui, self:_CreateBaseItemData(idx, ItemType.KeeperSkill)))
  end
end

function PvPTeamBuildMainPanel:OnBindBattlePass()
  self.binder:BindToVisible(self.ui.TemporaryUnLock, function()
    return not PVPCollectionDataUtils.IsOwnedAll()
  end)
  self.binder:BindButtonClick(self.ui.TemporaryUnLock, function()
    BattlePassDataUtils.OpenBuyCore()
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
end

function PvPTeamBuildMainPanel:OnBindTeamCopyBtn()
  self.binder:SetActive(self.ui.Btn_Copy, true)
  self.binder:SetActive(self.ui.Btn_Paste, true)
  self.binder:BindButtonClick(self.ui.Btn_Copy, function()
    PvPTeamBuildDataUtils.GetTeamShareContentByTeamIdx(self.model.curTeamIdx)
    Alert.Show(10173)
  end)
  self.binder:BindButtonClick(self.ui.Btn_Paste, function()
    PvPTeamBuildDataUtils.PasteTeamFromClipboard()
  end)
end

function PvPTeamBuildMainPanel:OnClose()
  self:Close()
end

function PvPTeamBuildMainPanel:_CreateBaseItemData(idx, type)
  local model = self.model
  
  local function mainIconFunc()
    local tid = model.type2GroupMap[type][idx]
    if 0 == model.type2GroupMap[type][idx] then
      return nil
    end
    local collectCfg = DT.PVPCollect[model.type2GroupMap[type][idx]]
    if collectCfg.Type == cd.PVPCollectionType.KeeperSkill and not PVPCollectionDataUtils.IsRealOwnedCollection(tid) then
      return collectCfg.UnknownDetailsImage
    end
    local awakerTid = PvpCollectCfgUtils.GetAwakerTidByCollectTid(tid)
    if awakerTid then
      do return AwakerDataUtils.GetAwakerBust end
      return AwakerDataUtils.GetAwakerBust, awakerTid
    end
    return collectCfg.CollectImage
  end
  
  local function nameFunc()
    if 0 == model.type2GroupMap[type][idx] then
      return nil
    end
    do return LT.Text, PvpCollectCfgUtils.GetCollectionName(model.type2GroupMap[type][idx]) end
    return LT.Text, PvpCollectCfgUtils.GetCollectionName(model.type2GroupMap[type][idx])
  end
  
  local function clickFunc()
    PvPTeamBuildDataUtils.OpenPvPTeamSingleBuildPanel(self.model, type, idx)
  end
  
  local function isEmptyFunc()
    return 0 == model.type2GroupMap[type][idx]
  end
  
  local function nameFrameIconFunc()
    local collectTid = model.awakerGroup[idx]
    do return PVPCollectionDataUtils.GetCollectionNameFrameImage end
    return PVPCollectionDataUtils.GetCollectionNameFrameImage, collectTid
  end
  
  local data = {
    mainIconFunc = mainIconFunc,
    nameFunc = nameFunc,
    nameFrameIconFunc = nameFrameIconFunc,
    clickFunc = clickFunc,
    isEmptyFunc = isEmptyFunc,
    tidFunc = function()
      return model.type2GroupMap[type][idx]
    end
  }
  return data
end

function PvPTeamBuildMainPanel:_CreateAwakerItemData(idx)
  local data = self:_CreateBaseItemData(idx, ItemType.AwakerItem)
  
  local function awakenIconFunc()
    return nil
  end
  
  data.awakenIconFunc = awakenIconFunc
  return data
end

function PvPTeamBuildMainPanel:_InitDragSwap()
  self.dragCtrl = DragSwapController(self.ui.uiNode)
  self.dragCtrl:AddGroup(self.awakerCompGroup, {
    getTid = function(idx)
      return self.model.type2GroupMap[ItemType.AwakerItem][idx]
    end,
    onSwap = function(fromIdx, toIdx)
      self:_TrySwap(ItemType.AwakerItem, fromIdx, toIdx)
    end
  })
  self.dragCtrl:AddGroup(self.weaponCompGroup, {
    getTid = function(idx)
      return self.model.type2GroupMap[ItemType.Weapon][idx]
    end,
    onSwap = function(fromIdx, toIdx)
      self:_TrySwap(ItemType.Weapon, fromIdx, toIdx)
    end
  })
  self.dragCtrl:AddGroup(self.keeperSkillCompGroup, {
    getTid = function(idx)
      return self.model.type2GroupMap[ItemType.KeeperSkill][idx]
    end,
    onSwap = function(fromIdx, toIdx)
      self:_TrySwap(ItemType.KeeperSkill, fromIdx, toIdx)
    end
  })
  self.dragCtrl:Init()
end

function PvPTeamBuildMainPanel:_TrySwap(type, fromIdx, toIdx)
  local model = self.model
  local group = table.clone(model.type2GroupMap[type])
  group[fromIdx], group[toIdx] = group[toIdx], group[fromIdx]
  if type == ItemType.AwakerItem then
    model:SetAwakerGroup(group)
  elseif type == ItemType.Weapon then
    model:SetWeaponGroup(group)
  elseif type == ItemType.KeeperSkill then
    model:SetKeeperSkillGroup(group)
  end
  PvPTeamBuildDataUtils.ReqUpdateTeam(model.curTeamIdx, model.awakerGroup, model.weaponGroup, model.keeperSkillGroup)
end

return PvPTeamBuildMainPanel
