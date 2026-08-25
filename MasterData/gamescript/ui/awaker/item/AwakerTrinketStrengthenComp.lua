local AwakerTrinketStrengthenComp, Super = System.NewComponent("AwakerTrinketStrengthenComp")

function AwakerTrinketStrengthenComp:ctor(uiNode, model)
  Super.ctor(self)
  self.ui = UI_Awaker_Popup_Trinket_Intensify_DetailResource(uiNode)
  self.model = model
end

function AwakerTrinketStrengthenComp:OnBind(binder)
  local model = self.model
  local trinketModel = model.trinketModel
  
  local function CheckIdValid(id)
    return id and 0 ~= id
  end
  
  binder:BindZ1Button(self.ui.Btn_Confirm, function()
    local function OnReqSuccess(svrData)
      local multiple = svrData and svrData.multiple
      
      UIManager.Instance:Reopen(Urls.AwakerTrinketStrengthenResultPanel, svrData.extraOrigin, multiple)
    end
    
    model:ReqStrengthenTrinket(OnReqSuccess)
  end, function()
    local state = CommonDefine.BtnType.High
    if not model:CanStrengthen() then
      state = CommonDefine.BtnType.Unclickable
    end
    return state
  end, function()
    do return LT.Text end
    return LT.Text, "AwakerTrinketStrengthenBtnText"
  end, nil, nil, nil)
  binder:BindToText(self.ui.Text_Name, function()
    if not CheckIdValid(model.strengthenTid) then
      return ""
    end
    local name = trinketModel:GetTrinketName(model.strengthenTid)
    return name
  end)
  binder:BindToVisible(self.ui.Text_Upper_Limit, function()
    if not CheckIdValid(model.strengthenTid) then
      return false
    end
    local currLevel = model.currTrinketLevel
    local maxLevel = model:GetTrinketMaxLevel(model.strengthenTid)
    return currLevel >= maxLevel
  end)
  binder:BindToText(self.ui.Text_Now, function()
    if not CheckIdValid(model.strengthenUid) then
      return ""
    end
    local level = trinketModel:GetLevel(model.strengthenUid)
    do return string.format, "+%s" end
    return string.format, "+%s", level
  end)
  binder:BindToText(self.ui.Text_Next, function()
    local afterLevelData = model.afterLevelData
    local level = afterLevelData.level - model.currTrinketLevel
    if not level or 0 == level then
      return ""
    end
    do return string.format, "+%s" end
    return string.format, "+%s", afterLevelData.level
  end)
  binder:BindToText(self.ui.Text_Total, function()
    if not CheckIdValid(model.strengthenTid) then
      return ""
    end
    local itemData = model:GetItemData(model.strengthenUid)
    if not itemData then
      return ""
    end
    local afterLevelData = model.afterLevelData
    local maxLevel = model:GetTrinketMaxLevel(model.strengthenTid)
    if maxLevel <= afterLevelData.level then
      do return LT.Text end
      return LT.Text, "Max", nil, nil, nil, nil, nil
    end
    local quality = model:GetItemQuality(model.strengthenTid)
    local needExp = model:GetLevelUpExp(afterLevelData.level, quality)
    local currExp = itemData.exp
    if afterLevelData.exp > 0 then
      currExp = afterLevelData.exp
    end
    do return string.format, "%s/%s", currExp end
    return string.format, "%s/%s", currExp, needExp
  end)
  binder:BindToText(self.ui.Text_Base_Prop, function()
    if not CheckIdValid(model.strengthenUid) then
      return ""
    end
    local mainAttr = trinketModel:GetMainAttr(model.strengthenUid)
    return mainAttr.name
  end)
  binder:BindToText(self.ui.Text_Prop_Now, function()
    if not CheckIdValid(model.strengthenUid) then
      return ""
    end
    local mainAttr = trinketModel:GetMainAttr(model.strengthenUid)
    local value = mainAttr.count
    if mainAttr.isPercent then
      value = value .. "%"
    end
    return value
  end)
  binder:BindToVisible(self.ui.Image_Arrow_1, function()
    if not CheckIdValid(model.strengthenTid) or not CheckIdValid(model.strengthenUid) then
      return false
    end
    local afterLevelData = model.afterLevelData
    return afterLevelData.level > model.currTrinketLevel
  end)
  binder:BindToVisible(self.ui.Image_Arrow_2, function()
    if not CheckIdValid(model.strengthenTid) or not CheckIdValid(model.strengthenUid) then
      return false
    end
    local afterLevelData = model.afterLevelData
    return afterLevelData.level > model.currTrinketLevel
  end)
  binder:BindToText(self.ui.Text_Prop_Next, function()
    if not CheckIdValid(model.strengthenTid) or not CheckIdValid(model.strengthenUid) then
      return ""
    end
    local afterLevelData = model.afterLevelData
    if afterLevelData.level <= model.currTrinketLevel then
      return ""
    end
    local mainAttr = trinketModel:GetMainAttr(model.strengthenUid)
    local quality = model:GetItemQuality(model.strengthenTid)
    local value = model:GetTrinketMainAttrValue(afterLevelData.level, mainAttr.tid, quality)
    if mainAttr.isPercent then
      value = value .. "%"
    end
    return value
  end)
  binder:BindToText(self.ui.Text_Coin_Need, function()
    local ownNum = ItemDataUtils.GetItemNum(CommonDefine.CurrencyType.JuniorMoney)
    local needNum = model.needMoney
    if ownNum < needNum then
      needNum = string.format("<Color4:%s>", needNum)
    end
    return needNum
  end)
  binder:BindToImage(self.ui.Image_Coin_Icon, function()
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, CommonDefine.CurrencyType.JuniorMoney
  end)
  binder:BindToImageFillAmount(self.ui.Image_Progress, function()
    if not CheckIdValid(model.strengthenTid) then
      return 0
    end
    local afterLevelData = model.afterLevelData
    local maxLevel = model:GetTrinketMaxLevel(model.strengthenTid)
    if maxLevel <= afterLevelData.level then
      return 1
    end
    local itemData = model:GetItemData(model.strengthenUid)
    if not itemData then
      return 0
    end
    local currExp = itemData.exp
    if afterLevelData.exp > 0 then
      currExp = afterLevelData.exp
    end
    local quality = model:GetItemQuality(model.strengthenTid)
    local needExp = model:GetLevelUpExp(afterLevelData.level, quality)
    return currExp / needExp
  end)
  binder:BindToVisible(self.ui.Btn_Shortcut, function()
    return false
  end)
  binder:BindToVisible(self.ui.Btn_Filtrate, function()
    return false
  end)
  for i = 1, 5 do
    local obj = self.ui["Prop_" .. i]
    if obj then
      binder:BindToVisible(obj, function()
        if not CheckIdValid(model.strengthenUid) then
          return false
        end
        local subAttr = trinketModel:GetSubAttrs(model.strengthenUid)
        return subAttr and #subAttr >= i
      end)
    end
  end
  local list = {}
  binder:BindToCircularListView(self.ui.ScrollView_Entry_List, function()
    if not CheckIdValid(model.strengthenUid) then
      return {}
    end
    list = trinketModel:GetSubAttrs(model.strengthenUid)
    local showNewAttrNum = model.showNewAttrNum or 0
    if showNewAttrNum > 0 then
      local newAttrTip = "TrinketLevelUpTips_1"
      local upgraddeAttrValueTip = "TrinketLevelUpTips_2"
      if #list >= model.maxSubAttrNum then
        local tipStr = string.format("<Blue:%s>", LT.Textf(upgraddeAttrValueTip, showNewAttrNum))
        table.insert(list, tipStr)
      else
        local emptyNewNum = model.maxSubAttrNum - #list
        local newAttrNum = math.min(emptyNewNum, showNewAttrNum)
        local tipStr = string.format("<Blue:%s>", LT.Textf(newAttrTip, newAttrNum))
        table.insert(list, tipStr)
        if showNewAttrNum > emptyNewNum then
          local upgradeAttrValueNum = showNewAttrNum - emptyNewNum
          tipStr = string.format("<Blue:%s>", LT.Textf(upgraddeAttrValueTip, upgradeAttrValueNum))
          table.insert(list, tipStr)
        end
      end
    end
    return list
  end, function(childBinder, obj, index)
    local data = list[index]
    local specialShowText
    if type(data) == "string" then
      specialShowText = data
    end
    local itemData = {
      clientAttr = data,
      resourceCls = UI_Awaker_Item_EntryResource,
      useDefaultIcon = true,
      specialShowText = specialShowText,
      useOriginDemical = true
    }
    childBinder:BindComponent(AwakerAttrItem(obj, itemData))
  end)
  binder:BindComponent(AwakerSpecialSkillAdditionItem(self.ui.UI_Awaker_Button_Addition, CommonDefine.AwakerSpecialSkillType.MultiplierXP))
end

function AwakerTrinketStrengthenComp:OnUnbind()
  Super.OnUnbind(self)
end

return AwakerTrinketStrengthenComp
