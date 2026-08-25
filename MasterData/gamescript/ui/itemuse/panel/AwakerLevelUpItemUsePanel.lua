local AWAKER_BREAKTHROUGH_SKILL_1_IDX = 7
local AWAKER_BREAKTHROUGH_SKILL_2_IDX = 8
local MAX_AWAKERSKILLITEM_NUM = 8
local AwakerLevelUpItemUsePanel, Super = System.NewClass("AwakerLevelUpItemUsePanel", UIBasePanel)
AwakerLevelUpItemUsePanel.uiResCls = UI_Bag_Helicopter_TipsResource

function AwakerLevelUpItemUsePanel:ctor(uid)
  Super.ctor(self)
  self.uid = uid
end

function AwakerLevelUpItemUsePanel:OnBind(binder)
  local model = binder:createModel(AwakerLevelUpItemUsePanelModel, self.uid)
  local awakerModel = binder:createModel(AwakerModel)
  for i = 1, MAX_AWAKERSKILLITEM_NUM do
    self.ui["AwakerSkillItem" .. i]:SetActive(false)
  end
  self.model = model
  local commonPopupTipsData = {
    sizeType = CommonDefine.PopupTipsType.L,
    textTitleCN = nil,
    clickFunc = System.fn(self, self.Close)
  }
  binder:BindComponent(CommonPopupTips(self.ui.UI_Common_Popup_Tips_L, commonPopupTipsData))
  binder:BindToCircularListView(self.ui.ScrollView_Awaker_List, function()
    return model.awakerList
  end, function(itemBinder, item, index)
    local data = model.awakerList[index]
    local awakerData = data.awakerData
    if not data.isCanUse then
      awakerModel:SetDarkTid(awakerData.tid)
    end
    
    local function callback()
      if data.isCanUse or 1 == index then
        model:SetAwakerTid(awakerData.tid)
        awakerModel:SetSelectAwakerId(awakerData.tid)
      end
      if not data.isCanUse then
        local tipConfig = DT.TipsType[10551]
        local awakerCfg = DT.AwakerConfig[awakerData.tid]
        local desc = LT.Textf(tipConfig.Desc, awakerCfg.Name)
        Alert.Show(10551, nil, nil, nil, desc)
      end
    end
    
    if 1 == index then
      callback()
    end
    local itemData = {
      awakerData = awakerData,
      model = awakerModel,
      callback = callback
    }
    itemBinder:BindComponent(AwakerFullListItem(item, itemData))
  end, nil, nil, nil)
  binder:BindToRaw(function(childBinder, awakerTid, _)
    local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
    childBinder:BindToText(self.ui.Text_Originally, function()
      return "Lv." .. awakerData.level
    end, nil)
    childBinder:BindToText(self.ui.Text_Hoist, function()
      if model.toLevel > awakerData.level then
        do return string.format, "<Blue:%s>" end
        return string.format, "<Blue:%s>", "Lv." .. model.toLevel, model.toLevel
      else
        do return string.format, "<WhiteQuality:%s>" end
        return string.format, "<WhiteQuality:%s>", "Lv." .. awakerData.level, awakerData.level
      end
    end, nil)
    childBinder:BindToVisible(self.ui.Image_Level_Up, function()
      return awakerData.level < model.toLevel
    end)
    childBinder:BindToText(self.ui.Text_Name, function()
      do return awakerModel.GetAwakerName, awakerModel end
      return awakerModel.GetAwakerName, awakerModel, awakerTid
    end, nil)
    local awakerLevelUpModel = childBinder:createModel(AwakerLevelUpModel, awakerModel)
    awakerLevelUpModel:SetTargetLevel(model.toLevel)
    local improveAttrList = awakerLevelUpModel:GetImproveAttrList()
    for index, data in ipairs(improveAttrList) do
      local uiNode = self.ui["Inherent_" .. index]
      if uiNode then
        if not data.hasImproved then
          data.newValue = string.format("<WhiteQuality:%s>", data.oldValue)
        end
        childBinder:BindComponent(UIBagAttributeCompareItem(uiNode, data.iconPath, data.nameText, data.oldValue, data.newValue, data.hasImproved))
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
        local isImprove = tonumber(skillData.level) < tonumber(model.toSkillLevel + extraLevel)
        local oldValue = "Lv." .. skillData.level
        local newValue = string.format("<Blue:%s>", "Lv." .. model.toSkillLevel + extraLevel)
        if not isImprove then
          newValue = string.format("<WhiteQuality:%s>", oldValue)
        end
        if uiNode then
          uiNode:SetActive(true)
          childBinder:BindComponent(UIBagAttributeCompareItem(uiNode, nil, skillName, oldValue, newValue, isImprove))
        end
      elseif skillData.isBreakthroughSkill then
        local unlockVal
        if skillData.slot == AWAKER_BREAKTHROUGH_SKILL_1_IDX then
          unlockVal = model.toBreakSkillUnlock1
        elseif skillData.slot == AWAKER_BREAKTHROUGH_SKILL_2_IDX then
          unlockVal = model.toBreakSkillUnlock2
        end
        if not unlockVal then
          uiNode:SetActive(false)
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
          childBinder:BindComponent(UIBagAttributeCompareItem(uiNode, nil, skillName, oldValue, newValue, isImprove))
        end
      end
    end
    local curBreakthroughStar = awakerData.currBreakthroughStar
    childBinder:SetText(self.ui.Text_UpgradeFront, LT.Textf("BreakthroughTitleText", curBreakthroughStar))
    local toBreakthroughStar = math.max(model.toBreakLevel, curBreakthroughStar)
    childBinder:SetText(self.ui.Text_UpgradeLater, LT.Textf("BreakthroughTitleText", toBreakthroughStar))
  end, function()
    return model.awakerTid
  end, nil)
  binder:BindZ1Button(self.ui.Btn_Confirm, function()
    local item = ItemDataUtils.GetItemByUid(model.itemUid)
    local playerUseLevel = tonumber(ItemDataUtils.GetFastPromotionSpParamValByKey(DT.Item[item.tid].SpParam or {}, CommonDefine.FastPromotionSpParamKey.RequiredPlayerLevel))
    if playerUseLevel <= DataCenter.playerData.DRole.level then
      local function confirmFunc()
        Logger.Debug("GameRequest OnFastPromotion", model.itemUid, model.awakerTid)
        
        ProtoManager.Instance:ReqServer("GameRequest", "OnFastPromotion", function()
          Alert.Show(10146)
          self:Close()
        end, function()
        end, model.itemUid, model.awakerTid)
      end
      
      local tipConfig = DT.TipsType[20070]
      local itemName = ItemDataUtils.GetName(item.tid, true)
      local desc = LT.Textf(tipConfig.Desc, itemName)
      Alert.Show(20070, nil, confirmFunc, nil, desc)
    else
      local tipCfg = DT.TipsType[10619]
      Alert.ShowStr(LT.Textf(tipCfg.Desc, playerUseLevel))
    end
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "Shop_Confirm_Buy_Btn_Sure"
  end, nil, nil, nil)
  binder:BindZ1Button(self.ui.Btn_Cancel, function()
    self:Close()
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "Shop_Confirm_Buy_Btn_Back"
  end, nil, nil, nil)
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
end

function AwakerLevelUpItemUsePanel:OnTodoFunc()
end

return AwakerLevelUpItemUsePanel
