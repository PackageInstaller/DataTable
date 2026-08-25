local UICompAbyssAwakerRecordItem, Super = NewViewComponent("UICompAbyssAwakerRecordItem")
local Weapon_Slot_Num = 2
local Max_Weapon_Star_Num = 3
local Trinket_Slot_Count = 6
local RefineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")

function UICompAbyssAwakerRecordItem:ctor(uiNode, view, data, onClick)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Team_Item_Awaker_ListResource(uiNode)
  self.awakerData = data.awakerData or {}
  self.items = data.items or {}
  self.onClick = onClick
end

function UICompAbyssAwakerRecordItem:RegisterNotifications()
end

function UICompAbyssAwakerRecordItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnClick))
  self:AddButtonClickListener(self.ui.Btn_Click_Trinket, System.fn(self, self._OnClickTrinkets))
end

function UICompAbyssAwakerRecordItem:OnEnterComponent()
  self.recordBinder = self.binder:createChild()
  self.itemDetailModel = self.recordBinder:createModel(CommonItemDetailTipsModel)
  self:_RefreshAwaker()
  self:_RefreshWeapons()
  self:_RefreshTrinkets()
  self:_RefreshPotency()
  self:_RefreshSkillLevel()
end

function UICompAbyssAwakerRecordItem:_RefreshAwaker()
  local isEmpty = not self.awakerData.tid or self.awakerData.tid <= 0
  self.ui.Image_Add:SetActive(isEmpty)
  self.ui.Group_Awaker:SetActive(not isEmpty)
  if isEmpty then
    return
  end
  local awakerConfig = AwakerDataUtils.GetAwakerConfig(self.awakerData.tid)
  self:SetImage(self.ui.Image_Career_Icon, AwakerDataUtils.GetSchoolIcon(awakerConfig.School))
  self:SetImage(self.ui.Image_Quality_1, AwakerDataUtils.GetAwakerQualityImage(self.awakerData.tid))
  self:SetImage(self.ui.Image_Quality_2, AwakerDataUtils.GetAwakerTeamFrame(self.awakerData.tid))
  self:SetText(self.ui.Text_Number_Dissolution, self.awakerData.level)
  self:SetText(self.ui.Text_Name_2, AwakerDataUtils.GetAwakerName(self.awakerData.tid))
  self.ui.Image_Help:SetActive(self.awakerData.assistPlayerId and 0 ~= self.awakerData.assistPlayerId)
  local portraitData = {
    awakerTid = self.awakerData.tid,
    portraitAlign = CommonDefine.PortraitAlign.Center
  }
  self:AddViewComponentOnce(self.ui.Container_Awaker, UICompAwakerPortrait, portraitData)
end

function UICompAbyssAwakerRecordItem:_RefreshWeapons()
  local weaponItemDataMap = {}
  if self.awakerData.weaponSlots and self.items then
    for _, weaponSlotData in ipairs(self.awakerData.weaponSlots) do
      local weaponUid = weaponSlotData and weaponSlotData.weaponUid
      local itemInfo = weaponUid and self.items[weaponUid]
      if itemInfo then
        weaponItemDataMap[weaponUid] = itemInfo
      end
    end
  end
  self.itemDetailModel:SetItemDataMap(weaponItemDataMap)
  for i = 1, Weapon_Slot_Num do
    local obj = self.ui["UI_Dungeons_Item_Weapon_" .. i]
    if not obj then
    else
      local weaponSlotData = self.awakerData.weaponSlots and self.awakerData.weaponSlots[i]
      local ui = UI_Dungeons_Item_WeaponResource(obj)
      self.recordBinder:CheckUpdatePanelResource(obj, DataCenter.gameData.CurrTextLanguage)
      ui.Image_Add:SetActive(false)
      local weaponUid = weaponSlotData and weaponSlotData.weaponUid
      local weaponEquipped = weaponUid and weaponUid > 0 and self.items[weaponUid]
      ui.Image_Weapon:SetActive(weaponEquipped)
      if not weaponEquipped then
      else
        local weaponItemInfo = self.items[weaponUid]
        
        local function _OnBtnWeaponClick()
          ItemDataUtils.ShowItemDetailTips(self.recordBinder, ui.Btn_Click, weaponUid, weaponItemInfo.tid, true, {
            assignModel = self.itemDetailModel
          })
        end
        
        self:SetImage(ui.Weapon_Icon_1, ItemDataUtils.GetSpIcon(weaponItemInfo.tid))
        local weaponLevel = weaponItemInfo.level or 0
        local showStar = math.min(weaponLevel, RefineStage1MaxLevel)
        for starIndex = 1, Max_Weapon_Star_Num do
          local starObj = ui["Star_" .. starIndex]
          if starObj then
            starObj:SetActive(starIndex <= showStar)
          end
        end
        local showTextLevel = weaponLevel > RefineStage1MaxLevel
        ui.Image_Max_1:SetActive(showTextLevel)
        if showTextLevel then
          self:SetText(ui.Text_Max_1, weaponLevel - RefineStage1MaxLevel)
        end
        self:AddButtonClickListener(ui.Btn_Click, _OnBtnWeaponClick)
      end
    end
  end
end

function UICompAbyssAwakerRecordItem:_RefreshTrinkets()
  self.ui.Trinket_Add:SetActive(false)
  local trinketUids = self.awakerData.trinkets
  self.trinketDatas = {}
  for index, uid in ipairs(trinketUids) do
    self.trinketDatas[index] = self.items[uid]
  end
  local isSuitGatherAll = AwakerTrinketDataUtils.IsSuitGatherAll(self.trinketDatas)
  self.ui.Trinket_Icon:SetActive(isSuitGatherAll)
  if isSuitGatherAll then
    local suitId = self.trinketDatas[1].suitId
    self:SetImage(self.ui.Trinket_Icon, AwakerTrinketDataUtils.GetSuitIcon(suitId))
  end
  for i = 1, Trinket_Slot_Count do
    local imageObj = self.ui["Team_Icon_0" .. i]
    if imageObj then
      local uid = trinketUids[i] or 0
      imageObj:SetActive(not isSuitGatherAll and uid and uid > 0)
    end
  end
end

function UICompAbyssAwakerRecordItem:_RefreshPotency()
  self:AddViewComponentOnce(self.ui.UI_Common_Item_Potency, CompAwakerPotencyItem, {
    awakerTid = self.awakerData.tid,
    potencyLevel = self.awakerData.potencyLevel
  })
end

function UICompAbyssAwakerRecordItem:_RefreshSkillLevel()
  local skillSlots = self.awakerData.slots
  local skillList, specialSkill = AwakerDataUtils.GetAwakerSkillsData({skills = skillSlots})
  self:SetText(self.ui.Text_Mad, specialSkill.level)
  for i = 1, #skillList do
    local ui = self.ui["Text_Skill_0" .. i]
    local skillData = skillList[i]
    if ui and skillData then
      self:SetText(ui, "/" .. skillData.level or 1)
    end
  end
end

function UICompAbyssAwakerRecordItem:_OnClick()
  if self.onClick then
    self.onClick()
  end
end

function UICompAbyssAwakerRecordItem:_OnClickTrinkets()
  UIManager.Instance:Reopen(Urls.TrinketGroupDetailTipsView, self.trinketDatas)
end

function UICompAbyssAwakerRecordItem:OnExitComponent()
  if self.recordBinder then
    self.recordBinder:teardown()
    self.recordBinder = nil
  end
  Super.OnExitComponent(self)
end

return UICompAbyssAwakerRecordItem
