local RefineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
local TYPEOF_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local MAX_STAR_NUM = 3
local DBGTeamFightWeaponItem, Super = System.NewComponent("DBGTeamFightWeaponItem")

function DBGTeamFightWeaponItem:ctor(res, data)
  Super.ctor(self)
  self.ui = UI_Dungeons_Item_WeaponResource(res)
  self.model = data.model
  self.uidFunc = data.uidFunc
  self.awakerTidFunc = data.awakerTidFunc
  self.selectedFunc = data.selectedFunc
  self.clickFunc = data.clickFunc
  self.weaponSlot = data.weaponSlot
  self.teamSlot = data.teamSlot
  self.banAddImage = data.banAddImage
  self.enableWeaponAnim = data.enableWeaponAnim
end

function DBGTeamFightWeaponItem:OnBind(binder)
  self.binder = binder
  self:_OnBindWeaponInfo(binder)
  self:_OnBindLockState(binder)
  self:_OnBindInvalidState(binder)
  self:_OnBindBanState(binder)
  self:_OnBindSelectedState(binder)
  self:_OnBindSwitchWeaponAnim(binder)
  binder:BindButtonClick(self.ui.Btn_Click, function()
    if not self.model then
      return
    end
    local weaponUid = self.uidFunc()
    local weaponData = ItemDataUtils.GetItemByUid(weaponUid)
    local weaponTid = weaponData and weaponData.tid or 0
    if self.model.teamMode == CommonDefine.TeamAssign.eStageTeamMode.Preview then
      if 0 ~= weaponUid then
        ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Btn_Click, weaponUid, weaponTid, true)
      end
      return
    end
    if self:_GetAssistAwakerWeaponSlotData() then
      if not self.assignModel then
        self.assignModel = binder:createModel(CommonItemDetailTipsModel)
      end
      local assitItems = self.model:GetAssistItem()
      local weaponSlotData = self:_GetAssistAwakerWeaponSlotData()
      local assistWeaponUid = weaponSlotData.weaponUid
      if not assistWeaponUid or 0 == assistWeaponUid then
        Alert.Show(10834)
        return
      end
      local assistWeaponItemData = assitItems[assistWeaponUid]
      local assistWeaponTid = assistWeaponItemData.tid
      self.assignModel:SetItemDataMap({assistWeaponItemData})
      ItemDataUtils.ShowItemDetailTips(binder, self.ui.Btn_Click, assistWeaponUid, assistWeaponTid, true, {
        assignModel = self.assignModel
      })
      return
    end
    if self:_CheckLock() then
      local tips
      if self.weaponSlot == CommonDefine.WeaponSlotType.Primary then
        tips = PlayerDataUtils.GetFeatureLogicUnlockTips(CommonDefine.FeatureId.MainWeapon, 0)
      elseif self.weaponSlot == CommonDefine.WeaponSlotType.Secondary then
        tips = PlayerDataUtils.GetFeatureLogicUnlockTips(CommonDefine.FeatureId.SecondaryWeapon, 0)
      end
      Alert.ShowStr(LT.Text(tips))
      return
    end
    if self.clickFunc then
      self.clickFunc()
    end
  end)
end

function DBGTeamFightWeaponItem:_OnBindWeaponInfo(binder)
  binder:BindToVisible(self.ui.Image_Add, function()
    if self.model.teamMode == CommonDefine.TeamAssign.eStageTeamMode.Preview then
      return false
    end
    if self:_GetAssistAwakerWeaponSlotData() then
      return false
    end
    if self.banAddImage then
      return false
    end
    local haveNoWeapon = self.uidFunc() and 0 == self.uidFunc()
    local notLock = not self:_CheckLock()
    return haveNoWeapon and notLock
  end)
  binder:BindToVisible(self.ui.Image_Weapon, function()
    if self:_GetAssistAwakerWeaponSlotData() then
      local weaponSlotData = self:_GetAssistAwakerWeaponSlotData()
      local unlocked = self:_GetWeaponUnlockedBySlotData(weaponSlotData)
      local haveWeapon = 0 ~= weaponSlotData.weaponUid
      return unlocked and haveWeapon
    end
    local haveWeapon = self.uidFunc() and 0 ~= self.uidFunc()
    local notLock = not self:_CheckLock()
    return haveWeapon and notLock
  end)
  binder:BindToRaw(function(cBinder)
    local level = ItemDataUtils.GetWeaponRefineLevelByUid(self.uidFunc())
    if self.model and self:_GetAssistAwakerWeaponSlotData() then
      local assitItems = self.model:GetAssistItem()
      local weaponSlotData = self:_GetAssistAwakerWeaponSlotData()
      local weaponUid = weaponSlotData.weaponUid
      local weaponTid = assitItems[weaponUid] and assitItems[weaponUid].tid or 0
      level = assitItems[weaponUid] and assitItems[weaponUid].level or 0
      cBinder:SetImage(self.ui.Weapon_Icon_1, 0 ~= weaponTid and DT.Item[weaponTid].SpIcon or nil)
    else
      local itemData = ItemDataUtils.GetItemByUid(self.uidFunc())
      if itemData then
        cBinder:SetImage(self.ui.Weapon_Icon_1, DT.Item[itemData.tid].SpIcon)
      end
    end
    local showStars = math.min(level, RefineStage1MaxLevel)
    for i = 1, MAX_STAR_NUM do
      local obj = self.ui["Star_" .. i]
      if obj then
        cBinder:SetActive(obj, i <= showStars)
      end
    end
    if level > RefineStage1MaxLevel then
      self.ui.Image_Max_1:SetActive(true)
      cBinder:SetText(self.ui.Text_Max_1, level - RefineStage1MaxLevel)
    else
      self.ui.Image_Max_1:SetActive(false)
    end
  end, function()
    local refineLevel = ItemDataUtils.GetWeaponRefineLevelByUid(self.uidFunc())
    if self:_GetAssistAwakerWeaponSlotData() then
      return {
        self:_GetAssistAwakerWeaponSlotData().weaponUid,
        refineLevel
      }
    end
    return {
      self.uidFunc(),
      refineLevel
    }
  end)
end

function DBGTeamFightWeaponItem:_CheckLock()
  if self:_GetAssistAwakerWeaponSlotData() then
    return false
  end
  if not (self.awakerTidFunc and self.awakerTidFunc()) or 0 == self.awakerTidFunc() then
    return false
  end
  local awakerData = AwakerDataUtils.GetAwakerData(self.awakerTidFunc())
  local slotData = AwakerDataUtils.GetWeaponSlotDataWithType(awakerData, self.weaponSlot)
  local unlocked = self:_GetWeaponUnlockedBySlotData(slotData)
  return slotData and not unlocked or false
end

function DBGTeamFightWeaponItem:_GetCheckWeaponTid()
  if not self.model then
    return nil
  end
  local weaponSlotData = self:_GetAssistAwakerWeaponSlotData()
  if weaponSlotData then
    local assitItems = self.model:GetAssistItem()
    local weaponUid = weaponSlotData.weaponUid
    local weaponTid = assitItems[weaponUid] and assitItems[weaponUid].tid or 0
    return weaponTid
  end
  local uid = self.uidFunc()
  if 0 == uid then
    return nil
  end
  local checkweaponData = ItemDataUtils.GetItemByUid(uid)
  local checkweaponTid = checkweaponData and checkweaponData.tid or 0
  if 0 == checkweaponTid then
    return nil
  end
  return checkweaponTid
end

function DBGTeamFightWeaponItem:_CheckNotEffect()
  local checkweaponTid = self:_GetCheckWeaponTid()
  local checkWeaponUid = self.uidFunc()
  if not checkweaponTid or self:_CheckIsBan() then
    return false
  end
  if self.teamSlot > 1 then
    for i = 1, self.teamSlot - 1 do
      local otherWeaponUids = self.model:GetTeamWeaponGroupBySlot(i)
      local otherAwakerTid = self.model:GetTeamAwakerTidBySlot(i)
      if otherAwakerTid and 0 ~= otherAwakerTid then
        for idx, weaponUid in pairs(otherWeaponUids) do
          if 0 == weaponUid then
          else
            local weaponData = ItemDataUtils.GetItemByUid(weaponUid)
            local weaponTid = weaponData and weaponData.tid or 0
            if 0 ~= weaponTid and checkWeaponUid ~= weaponUid and weaponTid == checkweaponTid then
              return true
            end
          end
        end
      end
    end
  end
  return false
end

function DBGTeamFightWeaponItem:_CheckIsBan()
  local checkweaponTid = self:_GetCheckWeaponTid()
  if not checkweaponTid or self.teamSlot == CommonDefine.TeamAssign.MaxBattleNum and self.model:GetAssistAwaker() then
    return false
  end
  do return self.model.CheckWeaponIsFighted, self.model end
  return self.model.CheckWeaponIsFighted, self.model, checkweaponTid
end

function DBGTeamFightWeaponItem:_OnBindLockState(binder)
  binder:BindToVisible(self.ui.Image_Lock_1, System.fn(self, self._CheckLock))
end

function DBGTeamFightWeaponItem:_OnBindInvalidState(binder)
  binder:BindToVisible(self.ui.Image_Disable, function()
    if self.model:IsAbyssChallenge() then
      return false
    end
    do return self._CheckNotEffect end
    return self._CheckNotEffect, self
  end)
end

function DBGTeamFightWeaponItem:_OnBindBanState(binder)
  binder:BindToVisible(self.ui.Image_Ban_1, function()
    if self.model:IsAbyssChallenge() then
      return self:_CheckIsBan() or self:_CheckNotEffect()
    end
    do return self._CheckIsBan end
    return self._CheckIsBan, self
  end)
end

function DBGTeamFightWeaponItem:_OnBindSelectedState(binder)
  binder:BindToVisible(self.ui.Image_Selected, self.selectedFunc)
end

function DBGTeamFightWeaponItem:_OnBindSwitchWeaponAnim(binder)
  if not self.enableWeaponAnim then
    return
  end
  if self.uidFunc and 0 ~= self.uidFunc() then
    local prefab = binder:LoadAsset("UI/UI_Dungeous/UI_Dungeous_Prefab/UI_Vx_Item_Weapon_Glow_01.prefab")
    self.weaponAnimGo = binder:Instantiate(prefab, self.ui.uiNode.transform)
    self.weaponAnimGo.transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
    local uiAnimationController = self.weaponAnimGo:GetComponent(TYPEOF_UIAnimationController)
    uiAnimationController:PlayState("UI_Vx_Item_Weapon_Glow_01")
  end
end

function DBGTeamFightWeaponItem:_GetAssistAwakerWeaponSlotData()
  if not self.model then
    return nil
  end
  if self.teamSlot == CommonDefine.TeamAssign.MaxBattleNum and self.model:GetAssistAwaker() then
    local assistAwakerData = self.model:GetAssistAwaker()
    do return AwakerDataUtils.GetWeaponSlotDataWithType, assistAwakerData end
    return AwakerDataUtils.GetWeaponSlotDataWithType, assistAwakerData, self.weaponSlot
  end
  return nil
end

function DBGTeamFightWeaponItem:_GetWeaponUnlockedBySlotData(weaponSlotData)
  if not weaponSlotData then
    return false
  end
  if self.model.teamMode == CommonDefine.TeamAssign.eStageTeamMode.Preview or self:_GetAssistAwakerWeaponSlotData() then
    return true
  end
  return weaponSlotData.unlocked
end

return DBGTeamFightWeaponItem
