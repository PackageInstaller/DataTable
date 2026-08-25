local MAX_WEAPONED_WEAPON_NUM = 2
local weaponSlotTypes = {
  CommonDefine.WeaponSlotType.Primary,
  CommonDefine.WeaponSlotType.Secondary
}
local TeamWeaponEquipView, Super = NewClass("TeamWeaponEquipView", BaseView)
TeamWeaponEquipView.uiResCls = UI_Team_Panel_Weapon_EquipResource

function TeamWeaponEquipView:ctor(data)
  Super.ctor(self)
  self.teamModel = data.dbgTeamBuildModel
  self.model = TeamWeaponModel.Instance
  self.model:InitDataByTeamWeaponEquipViewData(data)
  self.closeCallback = data.closeCallback
end

function TeamWeaponEquipView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnTeamWeaponSelectSlotChanged, self._RefreshWeaponSlot, self)
  self:RegisterLocalNotify(NotifyId.OnTeamWeaponSelectUidChanged, self._RefreshView, self)
  self:RegisterLocalNotify(NotifyId.OnTeamWeaponListSortTypeChanged, self._RefreshWeaponList, self)
  self:RegisterLocalNotify(NotifyId.OnTeamWeaponSlotChanged, self._RefreshExtraSSRWeaponDesc, self)
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Question, System.fn(self, self._OnClickRuleBtn))
  self:AddButtonClickListener(self.ui.Btn_Remove, System.fn(self, self._OnClickChangeBtn))
  self:AddButtonClickListener(self.ui.Btn_Strengthen, function()
    if self.model.curSelectWeaponUid and 0 ~= self.model.curSelectWeaponUid then
      UIManager.Instance:Reopen(Urls.AwakerWeaponStrengthPanel, self.model.curSelectWeaponUid)
    end
  end)
  self:AddButtonClickListener(self.ui.Btn_Tips_Mask, function()
    self.detailAnimCtr:StopPlayableGraph()
    self.detailAnimCtr:PlayState("UI_Common_Item_Detail_Close")
    self.ui.UI_Common_Item_Detail:SetActive(false)
    self.ui.Btn_Tips_Mask:SetActive(false)
  end)
end

function TeamWeaponEquipView:RegisterEvents()
  self:BindEvent(EventMgr.Instance.WeaponRefined, System.fn(self, self._RefreshWhenWeaponRefine))
  self:BindEvent(EventMgr.Instance.RemoveItemEvent, System.fn(self, self._RefreshWhenItemDelete))
  self:BindEvent(EventMgr.Instance.DecomposeLockStateEvent, function(_)
    self:_RefreshWeaponList()
  end)
end

function TeamWeaponEquipView:_RefreshWhenItemDelete(item)
  self:_RefreshWhenWeaponBacktrack(item.uid)
end

function TeamWeaponEquipView:_RefreshWhenWeaponBacktrack(uid)
  if self.model.curSelectWeaponUid == uid then
    self.model:SetCurSelectWeaponUid(0)
  end
  for slot, weaponUid in pairs(self.model.weaponedGroup) do
    if weaponUid == uid then
      local newWeapoedGroup = table.deepclone(self.model.weaponedGroup)
      newWeapoedGroup[slot] = 0
      if self.teamModel then
        self.teamModel:SetWeaponsGroupWithTeamSlot(newWeapoedGroup, self.model.teamSlot)
      end
      self:_PlayEquipAudio(newWeapoedGroup)
      self.model:SetWeaponedGroup(newWeapoedGroup)
      self.model:UpdateWeaponList()
      self:_RefreshView()
      return
    end
  end
end

function TeamWeaponEquipView:_RefreshWhenWeaponRefine()
  self.model:UpdateWeaponedGroup()
  self:_RefreshWeaponList()
  self:_RefreshView()
end

function TeamWeaponEquipView:OnEnterView()
  Super.OnEnterView(self)
  self.detailAnimCtr = self.ui.UI_Common_Item_Detail:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, System.fn(self, self.Close))
  self:SetText(self.ui.Text_Extra_SSR_Desc, LT.Text("ExtraSSRWeaponUnlockTips"))
  self:_OnInitSortGroup()
  self:_OnInitWeaponGroup()
  self:_OnInitWeaponSlot()
  self:_RefreshView()
end

function TeamWeaponEquipView:_RefreshView(_)
  self.weaponsTableView:ReloadData()
  self:_RefreshSortGroup()
  self:_RefreshWeaponSlot()
  self:_RefreshBtn()
  self:_RefreshItemTips()
  self:_RefreshExtraSSRWeaponDesc()
  self.ui.Text_C_Null:SetActive(0 == #self.model.weaponList)
end

function TeamWeaponEquipView:_RefreshExtraSSRWeaponDesc()
  local isEquipMaxLvWeapon = self.model:CheckEquipMaxLvSSRWeapon()
  self.ui.Text_Extra_SSR_Desc:SetActive(isEquipMaxLvWeapon)
  self:SetText(self.ui.Text_Rule, isEquipMaxLvWeapon and LT.Text("CanEquipTwoSSRWeaonRuleDesc") or LT.Text("CanEquipOneSSRWeaonRuleDesc"))
end

function TeamWeaponEquipView:_RefreshItemTips()
  if not self.model.curSelectWeaponUid or 0 == self.model.curSelectWeaponUid then
    return
  end
  if not self.commonItemDetailTipItem then
    self.commonItemDetailTipItem = self:AddViewComponent(self.ui.UI_Common_Item_Detail, UICompTrinketDetailTipsItem)
  end
end

function TeamWeaponEquipView:_RefreshWeaponList()
  self.model:UpdateWeaponList()
  self.weaponsTableView:ReloadData()
  self:_RefreshSortGroup()
end

function TeamWeaponEquipView:_OnInitSortGroup()
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Trinket_Level, System.fn(self, self._OnClickSortType))
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Trinket_Litre, System.fn(self, self._OnClickSortOrder))
  self:AddButtonClickListener(self.ui.Btn_Mask, function()
    self:SetZ1Toggle(self.ui.Btn_Trinket_Level, not self.model.isShowSortTypePanel)
  end)
end

function TeamWeaponEquipView:_RefreshSortGroup()
  local showSortTypeText = AwakerTrinketDataUtils.GetWeaponSortTypeName(self.model.sortType)
  self:SetText(self.ui.Text_Trinket_SortType_1, showSortTypeText)
  self:SetText(self.ui.Text_Trinket_SortType_2, showSortTypeText)
end

function TeamWeaponEquipView:OnEnterViewFinished()
end

function TeamWeaponEquipView:_OnClickSortType()
  if self.model.isShowSortTypePanel == true then
    self.model:EnableSortTypePanel(false)
    self.ui.Btn_Mask:SetActive(false)
    UIManager.Instance:CloseByUrl(Urls.BagCommonFilterListView)
    self:SetZ1Toggle(self.ui.Btn_Trinket_Level, false)
  else
    self.model:EnableSortTypePanel(true)
    UIManager.Instance:Reopen(Urls.BagCommonFilterListView, self.ui.UI_Common_Filter_List_Filter.transform.position, self.model.sortType, self.model.sortTypeList, function(sortType)
      self.model:SetSortType(sortType)
      self:SetZ1Toggle(self.ui.Btn_Trinket_Level, false)
    end, function()
      self:SetZ1Toggle(self.ui.Btn_Trinket_Level, false)
    end)
    self.ui.UI_Common_Item_Detail:SetActive(false)
    self.ui.Btn_Mask:SetActive(true)
  end
end

function TeamWeaponEquipView:_OnClickSortOrder()
  if self.model.sortOrder == CommonDefine.SortOrder.Descend then
    self.model:SetSortOrder(CommonDefine.SortOrder.Ascend)
  else
    self.model:SetSortOrder(CommonDefine.SortOrder.Descend)
  end
end

function TeamWeaponEquipView:_OnInitWeaponGroup()
  self.weaponsTableView = self:CreateTableview(self.ui.ScrollView_Parts, function()
    if not self.model.weaponList then
      return 0
    end
    return #self.model.weaponList
  end, function(view, index)
    do return self._WeaponItemCellAtIndex, self, view end
    return self._WeaponItemCellAtIndex, self, view, index
  end)
end

function TeamWeaponEquipView:_WeaponItemCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.IconEmpty)
  local list = self.model.weaponList
  local value = list[index]
  
  local function clickFrameShowFunc()
    return self.model.curSelectWeaponUid == value.uid
  end
  
  local function OnClick(tid, uid)
    if not tid or not uid then
      return
    end
    NewbieGuideManager.Instance:RegisterNewbieGo("GuideGo_EquipWeaponSave", self.ui.Btn_Remove, Urls.TeamWeaponEquipView)
    if self.model:_CheckSSRWeaponForbidden(value.tid, value.uid) then
      Alert.Show(10702)
      return
    end
    if self.model:_CheckMainAttrForbidden(value.tid, value.uid) then
      Alert.Show(10921)
      return
    end
    if self.model:_CheckSameWeaponForbidden(value.tid) then
      Alert.Show(10703)
      return
    end
    local haveFighted, weaponName, stageGroupName = self:_GetFightedWeaponInfo(value.tid)
    if haveFighted then
      local desc = DT.TipsType[10739].Desc
      Alert.ShowStr(LT.Textf(desc, weaponName, stageGroupName))
      return
    end
    self.model:SetCurSelectWeaponUid(uid)
    self.detailAnimCtr:StopPlayableGraph()
    self.detailAnimCtr:PlayState("UI_Common_Item_Detail_Open")
    self.ui.UI_Common_Item_Detail:SetActive(true)
    self.ui.Btn_Tips_Mask:SetActive(true)
    if self.commonItemDetailTipItem then
      self.commonItemDetailTipItem:SetItemUid(uid)
    end
  end
  
  local function longPressCallback()
  end
  
  local function noEquipFunc()
    do return self.model._CheckWeaponCanNotEquip, self.model, value.tid end
    return self.model._CheckWeaponCanNotEquip, self.model, value.tid, value.uid
  end
  
  local itemData = {
    tid = value.tid,
    uid = value.uid,
    onClick = OnClick,
    longPressCallback = longPressCallback,
    isChoosed = clickFrameShowFunc,
    noEquipFunc = noEquipFunc,
    getOwnerTid = function()
      local ownerTid = self.model:GetWeaponOwnedAwaker(value.uid)
      if ownerTid and ownerTid < 0 then
        return
      end
      return ownerTid
    end
  }
  self:SetIcon(MaterialIconType.CommonIcon, cell.gameObject, itemData)
  if 1 == index then
    self:BindTimer(0.3, 0, nil, function()
      NewbieGuideManager.Instance:RegisterNewbieGo("GuideGo_EquipWeapon1", cell.gameObject, Urls.TeamWeaponEquipView)
    end)
  end
  return cell
end

function TeamWeaponEquipView:_OnInitWeaponSlot()
  self:SetImage(self.ui.Icon_Awaker, AwakerDataUtils.GetLittleIcon(self.model.curSelectAwakerTid))
end

function TeamWeaponEquipView:_RefreshWeaponSlot()
  local haveWeapon = false
  for _, slotType in pairs(weaponSlotTypes) do
    if 0 ~= self.model.weaponedGroup[slotType] then
      haveWeapon = true
    end
  end
  self.ui.Btn_Uninstall:SetActive(haveWeapon)
  for weaponSlot = 1, MAX_WEAPONED_WEAPON_NUM do
    local uiNode = self.ui["UI_Team_Item_Weapon_Full_" .. weaponSlot]
    local weaponUid = self.model.weaponedGroup[weaponSlot]
    local itemData = {
      weaponUid = weaponUid,
      awakerTid = self.model.curSelectAwakerTid,
      slotType = weaponSlot
    }
    self:AddViewComponentOnce(uiNode, CompPublicWeaponSlotFull, itemData)
  end
end

function TeamWeaponEquipView:_RefreshBtn()
  local curWeaponUid = self.model.curSelectWeaponUid
  self:SetButtonState(self.ui.Btn_Remove, self:_GetChangeStrengthenBtnState())
  self:SetButtonText(self.ui.Btn_Remove, self:_GetChangeBtnText())
  self:SetButtonState(self.ui.Btn_Strengthen, self:_GetChangeStrengthenBtnState())
  self:SetActive(self.ui.Btn_Strengthen, ItemDataUtils.IsShowRefineBtn(curWeaponUid))
  self:AddButtonClickListener(self.ui.Btn_Guide, System.fn(self, self._OnClickRecommend))
  self:AddButtonClickListener(self.ui.Btn_Uninstall, function()
    if self.teamModel then
      self.teamModel:SetWeaponsGroupWithTeamSlot({0, 0}, self.model.teamSlot)
      Logger.ReportApusInfo("DBGTeam SaveTeamToServer Uninstall All Weapon")
      self.teamModel:SaveTeamToServer(nil, true)
    end
    local newWeapoedGroup = {0, 0}
    self:_PlayEquipAudio(newWeapoedGroup)
    self.model:SetWeaponedGroup(newWeapoedGroup)
    self:_RefreshWeaponSlot()
    self:_RefreshWeaponList()
    self.model:SelectListFirstWeapon(false)
    Alert.Show(10472)
    self.ui.UI_Common_Item_Detail:SetActive(false)
    self.ui.Btn_Tips_Mask:SetActive(false)
  end)
end

function TeamWeaponEquipView:_OnClickRecommend()
  local primarySlotHasWeapon = 0 ~= self.model.weaponedGroup[CommonDefine.WeaponSlotType.Primary]
  local secondarySlotHasWeapon = 0 ~= self.model.weaponedGroup[CommonDefine.WeaponSlotType.Secondary]
  if not primarySlotHasWeapon or not secondarySlotHasWeapon then
    local awakerData = AwakerDataUtils.GetAwakerData(self.model.curSelectAwakerTid)
    local emptySlotTypes = {}
    local equipedWeaponCfgs = {}
    local equipedWeaponUids = {}
    for _, slotType in ipairs(weaponSlotTypes) do
      local weaponUid = self.model.weaponedGroup[slotType]
      local slot = AwakerDataUtils.GetWeaponSlotDataWithType(awakerData, slotType)
      if slot.unlocked then
        if 0 == weaponUid then
          table.insert(emptySlotTypes, slotType)
        else
          local weaponData = ItemDataUtils.GetItemByUid(weaponUid)
          table.insert(equipedWeaponCfgs, DT.Item[weaponData.tid])
          table.insert(equipedWeaponUids, weaponData.uid)
        end
      end
    end
    if #emptySlotTypes > 0 then
      local result = {hasWeaponEquiped = false}
      self:_EquipRecommendWeapon(emptySlotTypes, 1, equipedWeaponCfgs, equipedWeaponUids, result, function()
        if result.hasWeaponEquiped then
          Alert.Show(10471)
        else
          Alert.Show(10636)
        end
      end)
    end
    self:_RefreshWeaponList()
    self:_RefreshWeaponSlot()
    self.model:SelectListFirstWeapon(false)
    if self.teamModel then
      Logger.ReportApusInfo("DBGTeam SaveTeamToServer Recomend Weapon")
      self.teamModel:SaveTeamToServer(nil, true)
    end
  else
    Alert.Show(10701)
  end
  self.ui.UI_Common_Item_Detail:SetActive(false)
  self.ui.Btn_Tips_Mask:SetActive(false)
end

function TeamWeaponEquipView:_EquipRecommendWeapon(emptySlotTypes, index, equipedWeaponCfgs, equipedWeaponUids, result, finishCallback)
  local awakerCfg = DT.AwakerConfig[self.model.curSelectAwakerTid]
  local recommendWeaponTidList = {}
  for _, weaponTid in ipairs(awakerCfg.RecommendWeapon) do
    if not self.model:IsBanTid(weaponTid) then
      table.insert(recommendWeaponTidList, weaponTid)
    end
  end
  for _, tid in ipairs(recommendWeaponTidList) do
    local recommendWeapons = {}
    recommendWeapons = self.model:_RetrieveFreeWeapons(tid, recommendWeapons)
    if #recommendWeapons > 0 then
      table.sort(recommendWeapons, function(a, b)
        return a.level > b.level
      end)
      local weapon = recommendWeapons[1]
      local weaponCfg = DT.Item[weapon.tid]
      local uid
      if 0 == #equipedWeaponCfgs and not self:_IsFightedWeapon(weaponCfg) then
        uid = recommendWeapons[1].uid
      elseif self:_NotSameID(weaponCfg, equipedWeaponCfgs) and not self:_SameMainAttr(weapon.uid, equipedWeaponUids) then
        local ssrWeaponLimit = DT.GetConstant("SSRWeaponNumLimit")
        if ssrWeaponLimit > 1 or 1 == ssrWeaponLimit and self:_CheckSSRWeaponNumValid(weapon.uid, equipedWeaponUids, weaponCfg, equipedWeaponCfgs) and not self:_IsFightedWeapon(weaponCfg) then
          uid = weapon.uid
        end
      end
      if uid then
        local newWeapoedGroup = table.deepclone(self.model.weaponedGroup)
        newWeapoedGroup[emptySlotTypes[index]] = uid
        if self.teamModel then
          self.teamModel:SetWeaponsGroupWithTeamSlot(newWeapoedGroup, self.model.teamSlot)
        end
        if index == #emptySlotTypes then
          self:_PlayEquipAudio(newWeapoedGroup)
        end
        self.model:SetWeaponedGroup(newWeapoedGroup)
        result.hasWeaponEquiped = true
        if index == #emptySlotTypes then
          finishCallback()
        else
          local tmpWeapon = ItemDataUtils.GetItemByUid(uid)
          table.insert(equipedWeaponCfgs, DT.Item[tmpWeapon.tid])
          table.insert(equipedWeaponUids, tmpWeapon.uid)
          self:_EquipRecommendWeapon(emptySlotTypes, index + 1, equipedWeaponCfgs, equipedWeaponUids, result, finishCallback)
        end
        return
      end
    end
  end
  for _, weapon in ipairs(self.model.weaponList) do
    local weaponIsFree
    if self.teamModel then
      weaponIsFree = not table.contains(self.teamModel and self.teamModel.teamWeaponTids or {}, weapon.tid)
    else
      weaponIsFree = not table.contains(self.model.weaponedGroup, weapon.uid)
    end
    if weaponIsFree then
      local uid
      local weaponCfg = DT.Item[weapon.tid]
      if 0 == #equipedWeaponCfgs and not self:_IsFightedWeapon(weaponCfg) then
        uid = weapon.uid
      elseif self:_NotSameID(weaponCfg, equipedWeaponCfgs) and not self:_SameMainAttr(weapon.uid, equipedWeaponUids) then
        local ssrWeaponLimit = DT.GetConstant("SSRWeaponNumLimit")
        if ssrWeaponLimit > 1 or 1 == ssrWeaponLimit and self:_CheckSSRWeaponNumValid(weapon.uid, equipedWeaponUids, weaponCfg, equipedWeaponCfgs) and not self:_IsFightedWeapon(weaponCfg) then
          uid = weapon.uid
        end
      end
      if uid then
        local newWeapoedGroup = table.deepclone(self.model.weaponedGroup)
        newWeapoedGroup[emptySlotTypes[index]] = uid
        if self.teamModel then
          self.teamModel:SetWeaponsGroupWithTeamSlot(newWeapoedGroup, self.model.teamSlot)
        end
        if index == #emptySlotTypes then
          self:_PlayEquipAudio(newWeapoedGroup)
        end
        self.model:SetWeaponedGroup(newWeapoedGroup)
        result.hasWeaponEquiped = true
        if index == #emptySlotTypes then
          finishCallback()
        else
          local tmpWeapon = ItemDataUtils.GetItemByUid(uid)
          table.insert(equipedWeaponCfgs, DT.Item[tmpWeapon.tid])
          table.insert(equipedWeaponUids, tmpWeapon.uid)
          self:_EquipRecommendWeapon(emptySlotTypes, index + 1, equipedWeaponCfgs, equipedWeaponUids, result, finishCallback)
        end
        return
      end
    end
  end
  if index == #emptySlotTypes then
    finishCallback()
  else
    self:_EquipRecommendWeapon(emptySlotTypes, index + 1, equipedWeaponCfgs, equipedWeaponUids, result, finishCallback)
  end
end

function TeamWeaponEquipView:_OnClickChangeBtn()
  NewbieGuideManager.Instance:RegisterNewbieGo("GuideGo_EquipWeaponClose", self.ui.Image_Close, Urls.TeamWeaponEquipView)
  if 0 == self.model.curSelectWeaponUid then
    return
  end
  local oldWeaponUid = self.model.weaponedGroup[self.model.curSelectWeaponSlot]
  local newWeapoedGroup = table.deepclone(self.model.weaponedGroup)
  if oldWeaponUid == self.model.curSelectWeaponUid then
    newWeapoedGroup[self.model.curSelectWeaponSlot] = 0
    Alert.Show(10808)
    self:RefreshWhenEquip(newWeapoedGroup)
    return
  end
  local weaponTid = self.model:GetSelectWeaponTid()
  if self.model:IsBanTid(weaponTid) then
    local tipsKey = 10757
    local desc = LT.Textf(DT.TipsType[tipsKey].Desc, ItemCfgUtils.GetCfgField("Name", weaponTid))
    Alert.ShowStr(desc)
    return
  end
  if self:_CheckWeaponCanNotClick() then
    Alert.ShowStr(LT.Text("AbyssChallengeWeaponCanNotFight"))
    return
  end
  local beChangeedWeaponUid = newWeapoedGroup[self.model.curSelectWeaponSlot]
  newWeapoedGroup[self.model.curSelectWeaponSlot] = self.model.curSelectWeaponUid
  if self.teamModel then
    local ownedAwakerTid, teamSlot, beChangedWeaponSlot = self.model:GetWeaponOwnedAwaker(self.model.curSelectWeaponUid)
    if ownedAwakerTid and 0 ~= ownedAwakerTid then
      self:ShowTipsWhenEquip(20049, ownedAwakerTid, newWeapoedGroup, function()
        local notChangedWeaponSlot = beChangedWeaponSlot == CommonDefine.WeaponSlotType.Primary and CommonDefine.WeaponSlotType.Secondary or CommonDefine.WeaponSlotType.Primary
        local oriWeaponGroup = table.deepclone(self.teamModel:GetTeamWeaponGroupBySlot(teamSlot))
        local notchangedWeaponUid = oriWeaponGroup[notChangedWeaponSlot]
        if 0 ~= notchangedWeaponUid then
          local checkWeaponTid = ItemDataUtils.GetItemByUid(beChangeedWeaponUid) and ItemDataUtils.GetItemByUid(beChangeedWeaponUid).tid or 0
          if checkWeaponTid and 0 ~= checkWeaponTid and (AwakerDataUtils.CheckSSRWeaponForbidden(beChangeedWeaponUid, notchangedWeaponUid) or AwakerDataUtils.CheckSameWeaponForbidden(checkWeaponTid, notchangedWeaponUid)) then
            return
          end
        end
        oriWeaponGroup[beChangedWeaponSlot] = beChangeedWeaponUid
        self.teamModel:SetWeaponsGroupWithTeamSlot(oriWeaponGroup, teamSlot)
      end)
      return
    end
    local weaponEffectingTeamSlot = self.model:GetWeaponEffectingTeamSlot(self.model.teamSlot, self.model:GetSelectWeaponTid())
    if weaponEffectingTeamSlot then
      local showAwakerTid = self.teamModel.teamAwakerTids[weaponEffectingTeamSlot]
      self:ShowTipsWhenEquip(20203, showAwakerTid, newWeapoedGroup)
      return
    end
    Alert.Show(10471)
  end
  self:RefreshWhenEquip(newWeapoedGroup)
end

function TeamWeaponEquipView:ShowTipsWhenEquip(tipsId, ownedAwakerTid, newWeapoedGroup, callback)
  local tipsCfg = DT.TipsType[tipsId]
  local weaponTid = self.model:GetSelectWeaponTid()
  ownedAwakerTid = math.abs(ownedAwakerTid)
  local desc = LT.Textf(tipsCfg.Desc, LT.Text(DT.Item[weaponTid].Name), LT.Text(DT.AwakerConfig[ownedAwakerTid].Name))
  Alert.Show(tipsId, nil, function()
    Alert.Show(10471)
    if callback then
      callback()
    end
    self:RefreshWhenEquip(newWeapoedGroup)
  end, nil, desc)
end

function TeamWeaponEquipView:RefreshWhenEquip(newWeapoedGroup)
  self:_PlayEquipAudio(newWeapoedGroup)
  if self.teamModel then
    self.teamModel:SetWeaponsGroupWithTeamSlot(newWeapoedGroup, self.model.teamSlot)
    self.teamModel:SetReactiveNum(self.teamModel.reactiveNum + 1)
    Logger.ReportApusInfo("DBGTeam SaveTeamToServer Equip Weapon")
    self.teamModel:SaveTeamToServer(nil, true)
  end
  self.model:SetWeaponedGroup(newWeapoedGroup)
  self:_RefreshWeaponSlot()
  self:_RefreshWeaponList()
  self:_RefreshBtn()
  self.ui.UI_Common_Item_Detail:SetActive(false)
  self.ui.Btn_Tips_Mask:SetActive(false)
end

function TeamWeaponEquipView:_PlayEquipAudio(newWeapoedGroup)
  local oldEquipNum = 0
  local newEquipNum = 0
  local oldWeaponGroup = self.model.weaponedGroup
  if oldWeaponGroup then
    for _, v in pairs(oldWeaponGroup) do
      if 0 ~= v then
        oldEquipNum = oldEquipNum + 1
      end
    end
  end
  if newWeapoedGroup then
    for _, v in pairs(newWeapoedGroup) do
      if 0 ~= v then
        newEquipNum = newEquipNum + 1
      end
    end
  end
  if 0 == newEquipNum or oldEquipNum > newEquipNum then
    return
  end
  if newEquipNum < 2 then
    AudioManager.Instance:PostSoundEvent("Play_UI_Ani_L_IngCard")
    return
  end
  local SSRNum = 0
  for _, uid in pairs(newWeapoedGroup) do
    local equipData = ItemDataUtils.GetItemByUid(uid)
    if equipData then
      local weaponCfg = DT.Item[equipData.tid]
      if weaponCfg.Quality == "Orange" then
        SSRNum = SSRNum + 1
      end
    end
  end
  if SSRNum == newEquipNum then
    AudioManager.Instance:PostSoundEvent("Play_UI_Ani_Super_L_IngCard")
    return
  end
  AudioManager.Instance:PostSoundEvent("Play_UI_Ani_L_IngCard")
end

function TeamWeaponEquipView:_GetChangeStrengthenBtnState()
  if 0 == self.model.curSelectWeaponUid or self:_CheckWeaponCanNotClick() then
    return CommonDefine.BtnType.Unclickable
  end
  return CommonDefine.BtnType.High
end

function TeamWeaponEquipView:_GetChangeBtnText()
  local oldWeaponUid = self.model.weaponedGroup[self.model.curSelectWeaponSlot]
  if oldWeaponUid == self.model.curSelectWeaponUid then
    do return LT.Text end
    return LT.Text, "RoleDetailsEquipDetails_Btn_Remove", nil
  end
  if 0 ~= self.model:GetWeaponOwnedAwaker(self.model.curSelectWeaponUid) then
    do return LT.Text end
    return LT.Text, "RoleDetailsEquipDetails_Btn_Change", self.model.curSelectWeaponUid
  end
  if 0 == oldWeaponUid then
    do return LT.Text end
    return LT.Text, "RoleDetailsEquipDetails_Btn_PutOn", self.model.curSelectWeaponUid
  end
  do return LT.Text end
  return LT.Text, "RoleDetailsEquipDetails_Btn_Change", self.model.curSelectWeaponUid
end

function TeamWeaponEquipView:_GetFightedWeaponInfo(checkWeaponTid)
  if not self.teamModel then
    return false, "", ""
  end
  local fightedTeamData = self.teamModel:GetFightedStageGroupData()
  for _, fightData in pairs(fightedTeamData) do
    for _, weaponTid in pairs(fightData.weaponTids) do
      if 0 ~= weaponTid and checkWeaponTid == weaponTid then
        local weaponName = LT.Text(DT.Item[weaponTid].Name)
        local stageGroupName = LT.Text(DT.StageGroup[fightData.stageGroupId].Name)
        return true, weaponName, stageGroupName
      end
    end
  end
  return false, "", ""
end

function TeamWeaponEquipView:_CheckWeaponCanNotClick()
  local oldWeaponUid = self.model.weaponedGroup[self.model.curSelectWeaponSlot]
  local unloadWeapon = oldWeaponUid == self.model.curSelectWeaponUid
  return not unloadWeapon and self.model:_CheckWeaponCanNotEquip(self.model:GetSelectWeaponTid(), self.model.curSelectWeaponUid)
end

function TeamWeaponEquipView:OnExitView()
  if self.closeCallback then
    self.closeCallback(self.model.weaponedGroup)
  end
  Super.OnExitView(self)
end

function TeamWeaponEquipView:_NotSameID(weaponCfg, equipedWeaponCfgs)
  for _, cfg in ipairs(equipedWeaponCfgs) do
    if cfg.ID == weaponCfg.ID then
      return false
    end
  end
  return true
end

function TeamWeaponEquipView:_SameMainAttr(weaponUid, equipedWeaponUids)
  local isCheckForbid = DT.GetConstant("WeaponMainAttrTypeLimit", cd.NumberFalse) == cd.NumberTrue
  if not isCheckForbid then
    return false
  end
  local mainAttr = ItemDataUtils.GetWeaponSecondaryAttr(weaponUid)
  for _, uid in ipairs(equipedWeaponUids) do
    local checkAttr = ItemDataUtils.GetWeaponSecondaryAttr(uid)
    if checkAttr and checkAttr.id == mainAttr.id then
      return true
    end
  end
  return false
end

function TeamWeaponEquipView:_OnClickRuleBtn()
  UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("ExtraSSRWeaponRuleTitle"), LT.Text("ExtraSSRWeaponRuleContent"))
end

function TeamWeaponEquipView:_CheckSSRWeaponNumValid(weaponUid, equipedWeaponUids, weaponCfg, equipedWeaponCfgs)
  local hasMaxLvSSR = false
  local checkGroup = table.clone(equipedWeaponUids)
  table.insert(checkGroup, weaponUid)
  for _, uid in pairs(checkGroup) do
    if ItemDataUtils.CheckIsMaxLvSSRWeapon(uid) then
      hasMaxLvSSR = true
      break
    end
  end
  local hasEquipedSSR = false
  for _, cfg in ipairs(equipedWeaponCfgs) do
    if cfg.Quality == "Orange" then
      hasEquipedSSR = true
      break
    end
  end
  if hasEquipedSSR and not hasMaxLvSSR and weaponCfg.Quality == "Orange" then
    return false
  end
  return true
end

function TeamWeaponEquipView:_IsFightedWeapon(weaponCfg)
  do return self.model._GetFightedWeaponInfo, self.model end
  return self.model._GetFightedWeaponInfo, self.model, weaponCfg.ID
end

return TeamWeaponEquipView
