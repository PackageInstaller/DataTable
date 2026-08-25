local RefineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
local TYPEOF_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local MAX_STAR_NUM = 3
local startUICache = {
  [1] = "Star_1",
  [2] = "Star_2",
  [3] = "Star_3"
}
local CommonFightWeaponItem, Super = System.NewComponent("CommonFightWeaponItem")

function CommonFightWeaponItem:ctor(res, data)
  Super.ctor(self)
  self.ui = UI_Dungeons_Item_WeaponResource(res)
  self.uid = data.uid
  self.awakerTid = data.awakerTid
  self.clickFunc = data.clickFunc
  self.weaponSlot = data.weaponSlot
  self.isPreview = data.isPreview
  local itemData = ItemDataUtils.GetItemByUid(self.uid)
  self.tid = itemData and itemData.tid or 0
end

function CommonFightWeaponItem:OnBind(binder)
  self.binder = binder
  self:_OnBindWeaponInfo(binder)
  self:_OnBindLockState(binder)
  self:_OnBindInvalidState(binder)
  self:_OnBindSelectedState(binder)
  binder:BindButtonClick(self.ui.Btn_Click, function()
    if self.isPreview then
      if 0 ~= self.uid then
        ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Btn_Click, self.uid, self.tid, true)
      end
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

function CommonFightWeaponItem:_OnBindWeaponInfo(binder)
  binder:BindToVisible(self.ui.Image_Add, function()
    if self:_CheckLock() then
      return false
    end
    return not self.isPreview
  end)
  binder:BindToVisible(self.ui.Image_Weapon, function()
    return self.uid and 0 ~= self.uid
  end)
  binder:BindToRaw(function(cBinder)
    local level = ItemDataUtils.GetWeaponRefineLevelByUid(self.uid)
    local itemData = ItemDataUtils.GetItemByUid(self.uid)
    if itemData then
      cBinder:SetImage(self.ui.Weapon_Icon_1, DT.Item[itemData.tid].SpIcon)
    end
    local showStars = math.min(level, RefineStage1MaxLevel)
    for i = 1, MAX_STAR_NUM do
      local obj = self.ui[startUICache[i]]
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
    local refineLevel = ItemDataUtils.GetWeaponRefineLevelByUid(self.uid)
    return {
      self.uid,
      refineLevel
    }
  end)
end

function CommonFightWeaponItem:_OnBindLockState(binder)
  binder:BindToVisible(self.ui.Image_Lock_1, System.fn(self, self._CheckLock))
end

function CommonFightWeaponItem:_OnBindInvalidState(binder)
  self.ui.Image_Ban_1:SetActive(false)
end

function CommonFightWeaponItem:_OnBindSelectedState(binder)
  self.ui.Image_Selected:SetActive(false)
end

function CommonFightWeaponItem:_CheckLock()
  if not (not self.isPreview and self.awakerTid and self.awakerTid) or 0 == self.awakerTid then
    return false
  end
  local awakerData = AwakerDataUtils.GetAwakerData(self.awakerTid)
  local slotData = AwakerDataUtils.GetWeaponSlotDataWithType(awakerData, self.weaponSlot)
  return slotData and not slotData.unlocked or false
end

return CommonFightWeaponItem
