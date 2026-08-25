local RefineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
local TYPEOF_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local MAX_STAR_NUM = 3
local DBGTeamFightFakeWeaponItem, Super = System.NewComponent("DBGTeamFightFakeWeaponItem")

function DBGTeamFightFakeWeaponItem:ctor(res, tid, potencyLv)
  Super.ctor(self)
  self.ui = UI_Dungeons_Item_WeaponResource(res)
  self.tid = tid
  self.potencyLv = potencyLv
end

function DBGTeamFightFakeWeaponItem:OnBind(binder)
  self.binder = binder
  self:_OnBindWeaponInfo(binder)
  self:_OnBindLockState(binder)
  self:_OnBindInvalidState(binder)
  self:_OnBindSelectedState(binder)
  binder:BindButtonClick(self.ui.Btn_Click, function()
    if 0 == self.tid then
      Alert.Show(10836)
      return
    end
    ItemDataUtils.ReqCalWeaponAttr(self.tid, self.potencyLv, function(weaponData)
      local assignModel = binder:createModel(CommonItemDetailTipsModel)
      weaponData.uid = 1
      assignModel:SetItemDataMap({weaponData})
      ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Btn_Click, weaponData.uid, self.tid, true, {assignModel = assignModel})
    end)
  end)
end

function DBGTeamFightFakeWeaponItem:_OnBindWeaponInfo(binder)
  binder:BindToVisible(self.ui.Image_Add, function()
    return false
  end)
  binder:BindToVisible(self.ui.Image_Weapon, function()
    return self.tid and 0 ~= self.tid
  end)
  if self.tid and 0 ~= self.tid then
    local level = self.potencyLv
    binder:SetImage(self.ui.Weapon_Icon_1, DT.Item[self.tid].SpIcon)
    local showStars = math.min(level, RefineStage1MaxLevel)
    for i = 1, MAX_STAR_NUM do
      local obj = self.ui["Star_" .. i]
      if obj then
        binder:SetActive(obj, i <= showStars)
      end
    end
    if level > RefineStage1MaxLevel then
      self.ui.Image_Max_1:SetActive(true)
      binder:SetText(self.ui.Text_Max_1, level - RefineStage1MaxLevel)
    else
      self.ui.Image_Max_1:SetActive(false)
    end
  end
end

function DBGTeamFightFakeWeaponItem:_OnBindLockState(binder)
  self.ui.Image_Lock_1:SetActive(false)
end

function DBGTeamFightFakeWeaponItem:_OnBindInvalidState(binder)
  self.ui.Image_Ban_1:SetActive(false)
end

function DBGTeamFightFakeWeaponItem:_OnBindSelectedState(binder)
  self.ui.Image_Selected:SetActive(false)
end

return DBGTeamFightFakeWeaponItem
