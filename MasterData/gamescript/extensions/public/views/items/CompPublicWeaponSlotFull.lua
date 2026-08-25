local AWAKER_WEAPON_SCALE = 0.8
local RefineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
local MAX_STAR_NUM = 3
local CompPublicWeaponSlotFull, Super = NewViewComponent("CompPublicWeaponSlotFull")

function CompPublicWeaponSlotFull:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Team_Item_Weapon_FullResource(uiNode)
  self.onCompleted = data.onCompleted
  self.weaponUid = data.weaponUid
  self.awakerTid = data.awakerTid
  self.slotType = data.slotType
  local weaponData = ItemDataUtils.GetItemByUid(self.weaponUid)
  self.weaponTid = weaponData and weaponData.tid or 0
  self.model = TeamWeaponModel.Instance
end

function CompPublicWeaponSlotFull:OnEnterComponent()
  CameraManager:SetUICameraModel(true)
  self:_InitWeaponPrefab()
  local awakerData = AwakerDataUtils.GetAwakerData(self.awakerTid)
  local slotData = AwakerDataUtils.GetWeaponSlotDataWithType(awakerData, self.slotType)
  local isUnlock = slotData and slotData.unlocked
  local hasWeapon = self.weaponUid and 0 ~= self.weaponUid
  local weaponData = ItemDataUtils.GetItemByUid(self.weaponUid)
  self.ui.Group_Lock:SetActive(not isUnlock)
  self.ui.Group_Empty:SetActive(isUnlock and not hasWeapon)
  self.ui.Group_Weapon_Info:SetActive(hasWeapon)
  self.ui.Image_Selected:SetActive(self.slotType == self.model.curSelectWeaponSlot)
  self.ui.Image_Prohibit:SetActive(self.model:GetWeaponEffectingTeamSlot(self.model.teamSlot, self.weaponTid))
  if hasWeapon then
    local qualityFrame = ItemDataUtils.GetWeaponQualityLarge(self.weaponUid)
    if qualityFrame and "" ~= qualityFrame then
      self.ui.Image_Weapon_Quality:SetActive(true)
      self:SetImage(self.ui.Image_Weapon_Quality, qualityFrame)
    else
      self.ui.Image_Weapon_Quality:SetActive(false)
    end
    self:SetText(self.ui.Text_WeaponName, ItemDataUtils.GetName(self.weaponTid))
    if weaponData then
      self:SetText(self.ui.Text_WeaponInfo, SkillUtils.GetWeaponStateDesc(weaponData.tid, weaponData.level))
      local comp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_WeaponInfo, 0, 0, 0, nil, true, true)
      comp:SetBtn(self.ui.Btn_Click)
    end
    local level = ItemDataUtils.GetWeaponRefineLevelByUid(self.weaponUid)
    local showStars = math.min(level, RefineStage1MaxLevel)
    for i = 1, MAX_STAR_NUM do
      local starBreathe = UIRootMgr.FindChild(self.ui["Star_" .. i].transform, "Image_Breathe")
      local effectStar = UIRootMgr.FindChild(self.ui["Star_" .. i].transform, "Effect_Star_1")
      if starBreathe then
        starBreathe:SetActive(i <= showStars)
      end
      if effectStar then
        effectStar:SetActive(i <= showStars)
      end
    end
    if level > RefineStage1MaxLevel then
      self.ui.RootLevel:SetActive(true)
      self:SetText(self.ui.Text_Level, level - RefineStage1MaxLevel)
    else
      self.ui.RootLevel:SetActive(false)
    end
    local attr = ItemDataUtils.GetWeaponSecondaryAttr(self.weaponUid)
    if attr then
      local attrCfg = DT.ActorAttrType[attr.id]
      if attrCfg then
        local name = LT.Text(attrCfg.Text)
        local value = attr.value
        value = attrCfg.Percentage and value .. "%" or value
        self:SetImage(self.ui.Attr_Icon, attrCfg.Icon)
        self:SetText(self.ui.Attr_Name, name)
        self:SetText(self.ui.Attr_Num, value)
      end
    end
  end
  self:AddButtonClickListener(self.ui.Btn_Click, function()
    if not isUnlock then
      local tips = ItemDataUtils.GetLockTips(self.slotType)
      Alert.ShowStr(tips)
      return
    end
    TeamWeaponModel.Instance:SetSelectWeaponSlot(self.slotType)
    TeamWeaponModel.Instance:SetCurSelectWeaponUid(self.weaponUid)
  end)
end

function CompPublicWeaponSlotFull:_InitWeaponPrefab()
  local itemCfg = DT.Item[self.weaponTid]
  self.ui.Image_Weapon_Large:SetActive(itemCfg)
  if itemCfg then
    local imagePath = itemCfg and itemCfg.SpIcon or ""
    local viewData = {
      path = imagePath,
      scale = AWAKER_WEAPON_SCALE,
      gyroSpeed = self.slotType == CommonDefine.WeaponSlotType.Secondary and 10 or nil
    }
    local compAwakerWeapon = self:AddViewComponentOnce(self.ui.Image_Weapon_Large, CompPublicAwakerWeapon, viewData)
    compAwakerWeapon:FrozenGyroscopedCtrl()
    self:BindTimer(1, 0, nil, function()
      compAwakerWeapon:UnfrozenGyroscopedCtrl()
    end)
  end
end

function CompPublicWeaponSlotFull:OnExitComponent()
  CameraManager:SetUICameraModel(false)
  Super.OnExitComponent(self)
end

return CompPublicWeaponSlotFull
