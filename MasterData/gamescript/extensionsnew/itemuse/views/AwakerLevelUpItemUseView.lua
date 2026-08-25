local AWAKER_BREAKTHROUGH_SKILL_1_IDX = 7
local AWAKER_BREAKTHROUGH_SKILL_2_IDX = 8
local MAX_AWAKERSKILLITEM_NUM = 8
local AwakerLevelUpItemUseView, Super = System.NewClass("AwakerLevelUpItemUseView", BaseView)
AwakerLevelUpItemUseView.uiResCls = UI_Bag_Helicopter_TipsResource

function AwakerLevelUpItemUseView:ctor(uid)
  Super.ctor(self)
  self.uid = uid
end

function AwakerLevelUpItemUseView:OnBuildView()
  Super.OnBuildView(self)
  self.model = AwakerLevelUpItemUseModel.Instance
  self.model:SetItemUid(self.uid)
  self.awakerModel = AwakerLevelUpItemUseAwakerModel.Instance
  self:_InitCommonPopup()
  self:_InitAwakerList()
end

function AwakerLevelUpItemUseView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnItemUseAwakerLevelUpTidChanged, self._OnAwakerTidChanged, self)
end

function AwakerLevelUpItemUseView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._BtnConfirmClickFunc))
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
end

function AwakerLevelUpItemUseView:OnEnterView()
  Super.OnEnterView(self)
  self:_RefreshText()
  self:_RefreshVisible()
  local firstData = self.model:GetAwakerDataByIndex(1)
  if firstData then
    self:_OnSelectAwaker(firstData, 1)
  end
end

function AwakerLevelUpItemUseView:OnExitView()
  Super.OnExitView(self)
end

function AwakerLevelUpItemUseView:_InitCommonPopup()
  local commonPopupTipsData = {
    sizeType = CommonDefine.PopupTipsType.L,
    textTitleCN = nil,
    clickFunc = System.fn(self, self.Close)
  }
  self:AddViewComponent(self.ui.UI_Common_Popup_Tips_L, UICompCommonPopupTips, commonPopupTipsData)
end

function AwakerLevelUpItemUseView:_InitAwakerList()
  self.awakerModel:ClearDarkTid()
  self.awakerListView = self:CreateTableview(self.ui.ScrollView_Awaker_List, function()
    do return self.model.GetAwakerListCount end
    return self.model.GetAwakerListCount, self.model
  end, function(view, index)
    do return self._AwakerCellAtIndex, self, view end
    return self._AwakerCellAtIndex, self, view, index
  end)
  if self.awakerListView then
    self.awakerListView:ReloadData()
  end
end

function AwakerLevelUpItemUseView:_AwakerCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Awaker_Item_List)
  local data = self.model:GetAwakerDataByIndex(index)
  local awakerData = data.awakerData
  if not data.isCanUse then
    self.awakerModel:SetDarkTid(awakerData.tid)
  end
  
  local function callback()
    self:_OnSelectAwaker(data, index)
  end
  
  local itemData = {
    awakerData = awakerData,
    model = self.awakerModel,
    callback = callback
  }
  self:AddViewComponentOnce(cell.gameObject, CompAwakerFullListItem, itemData)
  return cell
end

function AwakerLevelUpItemUseView:_OnSelectAwaker(data, index)
  local awakerData = data.awakerData
  if not data.isCanUse then
    self.awakerModel:SetDarkTid(awakerData.tid)
  end
  if data.isCanUse or 1 == index then
    self.awakerModel:SetSelectAwakerId(awakerData.tid)
    self.model:SetAwakerTid(awakerData.tid)
  end
  if not data.isCanUse then
    local tipConfig = DT.TipsType[10551]
    local awakerCfg = DT.AwakerConfig[awakerData.tid]
    local desc = LT.Textf(tipConfig.Desc, awakerCfg.Name)
    Alert.Show(10551, nil, nil, nil, desc)
  end
end

function AwakerLevelUpItemUseView:_OnAwakerTidChanged(awakerTid)
  self:_RefreshAwakerInfo(awakerTid)
end

function AwakerLevelUpItemUseView:_RefreshText()
  self:SetButtonText(self.ui.Btn_Confirm, LT.Text("Shop_Confirm_Buy_Btn_Sure"))
  self:SetButtonText(self.ui.Btn_Cancel, LT.Text("Shop_Confirm_Buy_Btn_Back"))
end

function AwakerLevelUpItemUseView:_RefreshVisible()
  for i = 1, MAX_AWAKERSKILLITEM_NUM do
    self.ui["AwakerSkillItem" .. i]:SetActive(false)
  end
  self:SetButtonState(self.ui.Btn_Confirm, CommonDefine.BtnType.High)
  self:SetButtonState(self.ui.Btn_Cancel, CommonDefine.BtnType.High)
end

function AwakerLevelUpItemUseView:_BtnConfirmClickFunc()
  local item = ItemDataUtils.GetItemByUid(self.model:GetItemUid())
  local playerUseLevel = tonumber(ItemDataUtils.GetFastPromotionSpParamValByKey(DT.Item[item.tid].SpParam or {}, CommonDefine.FastPromotionSpParamKey.RequiredPlayerLevel))
  if playerUseLevel <= DataCenter.playerData.DRole.level then
    local function confirmFunc()
      ItemUseController.Instance:ReqFastPromotion(self.model:GetItemUid(), self.model:GetAwakerTid(), function()
        Alert.Show(10146)
        
        self:Close()
      end)
    end
    
    local tipConfig = DT.TipsType[20070]
    local itemName = ItemDataUtils.GetName(item.tid, true)
    local desc = LT.Textf(tipConfig.Desc, itemName)
    Alert.Show(20070, nil, confirmFunc, nil, desc)
  else
    local tipCfg = DT.TipsType[10619]
    Alert.ShowStr(LT.Textf(tipCfg.Desc, playerUseLevel))
  end
end

function AwakerLevelUpItemUseView:_RefreshAwakerInfo(awakerTid)
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awakerData then
    return
  end
  self:_RefreshAwakerText(awakerData, self.model)
  self:_RefreshAwakerVisible(awakerData, self.model)
  self:_RefreshAwakerComponent(awakerData, self.model)
end

function AwakerLevelUpItemUseView:_RefreshAwakerText(awakerData, model)
  self:SetText(self.ui.Text_Originally, "Lv." .. awakerData.level)
  local hoistText
  local toLevel = model:GetToLevel()
  local level = awakerData.level
  if toLevel > level then
    hoistText = string.format("<Blue:%s>", "Lv." .. toLevel)
  else
    hoistText = string.format("<WhiteQuality:%s>", "Lv." .. level)
  end
  self:SetText(self.ui.Text_Hoist, hoistText)
  local awakerName = self.awakerModel:GetAwakerName(awakerData.tid)
  self:SetText(self.ui.Text_Name, awakerName)
end

function AwakerLevelUpItemUseView:_RefreshAwakerVisible(awakerData, model)
  self.ui.Image_Level_Up:SetActive(awakerData.level < model:GetToLevel())
end

function AwakerLevelUpItemUseView:_RefreshAwakerComponent(awakerData, model)
  local toLevel = model:GetToLevel()
  local baseAwakerId = self.awakerModel:GetBaseTypeAwakerId()
  local baseAwakerLevel = self.awakerModel:GetAwakerLevel(baseAwakerId)
  local improveAttrList = AwakerDataUtils.GetAwakerLevelChangeAttrImprove(baseAwakerId, baseAwakerLevel, toLevel)
  for index, data in ipairs(improveAttrList) do
    local uiNode = self.ui["Inherent_" .. index]
    if uiNode then
      if not data.hasImproved then
        data.newValue = string.format("<WhiteQuality:%s>", data.oldValue)
      end
      self:AddViewComponentOnce(uiNode, UIBagAttributeCompareItem, data.iconPath, data.nameText, data.oldValue, data.newValue, data.hasImproved)
    end
  end
  for index, skillData in ipairs(awakerData.skills) do
    local uiNode = self.ui["AwakerSkillItem" .. index]
    if uiNode then
      uiNode:SetActive(false)
    end
    local skillTid = skillData.tid
    if skillTid then
      local skillCfg = DT.Skill[skillTid]
      local skillName = skillCfg.Name
      local extraLevel = skillData.level - (skillData.upNum + 1)
      local toSkillLevel = model:GetToSkillLevel()
      local isImprove = tonumber(skillData.level) < tonumber(toSkillLevel + extraLevel)
      local oldValue = "Lv." .. skillData.level
      local newValue = string.format("<Blue:%s>", "Lv." .. toSkillLevel + extraLevel)
      if not isImprove then
        newValue = string.format("<WhiteQuality:%s>", oldValue)
      end
      if uiNode then
        uiNode:SetActive(true)
        self:AddViewComponentOnce(uiNode, UIBagAttributeCompareItem, nil, skillName, oldValue, newValue, isImprove)
      end
    elseif skillData.isBreakthroughSkill then
      local unlockVal
      if skillData.slot == AWAKER_BREAKTHROUGH_SKILL_1_IDX then
        unlockVal = model:GetToBreakSkillUnlock1()
      elseif skillData.slot == AWAKER_BREAKTHROUGH_SKILL_2_IDX then
        unlockVal = model:GetToBreakSkillUnlock2()
      end
      if not unlockVal then
        if uiNode then
          uiNode:SetActive(false)
        end
        return
      end
      local skillName = skillData.name
      local isEffectStr = LT.Text("SkillActivated")
      local notEffectStr = LT.Text("SkillNotActivated")
      local oldValue = skillData.lock and notEffectStr or isEffectStr
      local oldLockVal = skillData.lock and 0 or 1
      local isImprove = unlockVal > oldLockVal
      local showVal = notEffectStr
      if isImprove or 1 == oldLockVal then
        showVal = isEffectStr
      end
      local newValue = isImprove and string.format("<Blue:%s>", showVal) or string.format("<WhiteQuality:%s>", showVal)
      if uiNode then
        uiNode:SetActive(true)
        self:AddViewComponentOnce(uiNode, UIBagAttributeCompareItem, nil, skillName, oldValue, newValue, isImprove)
      end
    end
  end
  local curBreakthroughStar = awakerData.currBreakthroughStar
  self:SetText(self.ui.Text_UpgradeFront, LT.Textf("BreakthroughTitleText", curBreakthroughStar))
  local toBreakthroughStar = math.max(model:GetToBreakLevel(), curBreakthroughStar)
  self:SetText(self.ui.Text_UpgradeLater, LT.Textf("BreakthroughTitleText", toBreakthroughStar))
end

return AwakerLevelUpItemUseView
