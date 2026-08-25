local ONE_PAGE_MAX_SHOW_NUM = 4
local itemTypeMap = {
  [CommonDefine.DropType.Relic] = CommonDefine.ItemType.Relic,
  [CommonDefine.DropType.Enchant] = CommonDefine.ItemType.Rune
}
local WorldStageGetAwardTip, Super = System.NewClass("WorldStageGetAwardTip", UIBasePanel)
WorldStageGetAwardTip.uiResCls = UI_Dbgcopy_Popup_Get_Article_NewResource

function WorldStageGetAwardTip:ctor(data, callBack)
  Super.ctor(self)
  self.awardGroup = data.items
  self.callBack = callBack
  self:PlaySound()
end

function WorldStageGetAwardTip:OnBind(binder)
  self:OnBindAwardGroup(binder)
  binder:BindToText(self.ui.Text_Title, function()
    do return LT.Text end
    return LT.Text, "AwardNodeGetItemTitle"
  end)
  binder:BindZ1Button(self.ui.Btn_Comfirm, System.fn(self, self.Close), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "AwardNodeGetItemButton"
  end)
  binder:SetActive(self.ui.Text_Alert, false)
  local stageData = WorldStageManager.Instance:GetCurStageData()
  if stageData and table.contains(DT.GetOriginalConstant("PrologueSettingButtonBlock", {}), stageData.stageId) and not stageData.isPrize then
    binder:BindTimer(0.03, 0, nil, function()
      binder:SetActive(self.ui.Text_Alert, true)
      binder:SetText(self.ui.Text_Alert, LT.Text("MainLines_DiamondMapNodeTips"))
    end)
  end
end

function WorldStageGetAwardTip:ChangeItemTid(inputTid)
  local specialItem = {
    PhiloStone = CommonDefine.CurrencyType.CopiesMoney
  }
  return specialItem[inputTid] or inputTid
end

function WorldStageGetAwardTip:Close()
  Super.Close(self)
  if self.callBack then
    self.callBack()
    self.callBack = nil
  end
end

function WorldStageGetAwardTip:OnBindAwardGroup(binder)
  local awardLen = #self.awardGroup
  self.ui.ScrollView:SetActive(awardLen > ONE_PAGE_MAX_SHOW_NUM)
  self.ui.Award_Group:SetActive(awardLen <= ONE_PAGE_MAX_SHOW_NUM)
  if awardLen > ONE_PAGE_MAX_SHOW_NUM then
    binder:BindToCircularListView(self.ui.ScrollView, function()
      return self.awardGroup
    end, function(itemBinder, item, index)
      local awardData = self.awardGroup[index]
      self:BindAwardItemComp(awardData, itemBinder, item)
    end)
  else
    for index = 1, ONE_PAGE_MAX_SHOW_NUM do
      local obj = self.ui["UI_Dbgcopy_Item_Select_Reward_" .. index]
      local awardData = self.awardGroup[index]
      obj:SetActive(awardData)
      if awardData then
        self:BindAwardItemComp(awardData, binder, obj)
      end
    end
  end
end

function WorldStageGetAwardTip:PlaySound()
  for _, awardData in pairs(self.awardGroup) do
    local dropType = awardData.type
    local itemType = itemTypeMap[dropType]
    local tid = self:ChangeItemTid(awardData.tid)
    if tid ~= CommonDefine.CurrencyType.CopiesMoney and itemType ~= CommonDefine.ItemType.Relic then
      AudioManager.Instance:PostSoundEvent("INGAME_GET_ITEM")
    end
    if tid ~= CommonDefine.CurrencyType.CopiesMoney and itemType ~= CommonDefine.ItemType.Relic and itemType ~= CommonDefine.ItemType.Rune then
      local isResonanceParticle = ItemDataUtils.IsResonanceParticle(tid)
      if isResonanceParticle then
        AudioManager.Instance:PostSoundEvent("EXPLORE_RESONANCEHEART_PLAYERGET")
      elseif tid == DT.GetConstant("DiamondItemTid") then
        AudioManager.Instance:PostSoundEvent("EXPLORE_SILVERCORE_PLAYERGET")
      end
    end
  end
end

function WorldStageGetAwardTip:GetTextTab(itemType, tid)
  local TextTab = {}
  if itemType == CommonDefine.ItemType.Relic then
    local cfg = DT.RelicConfig[tid]
    TextTab.Name = cfg.Name
    TextTab.Desc = RelicDataUtils.GetRelicDesc(tid)
  elseif itemType == CommonDefine.ItemType.Rune then
    local cfg = DT.EnchantConfig[tid]
    TextTab.Name = cfg.Name
    TextTab.Desc = SkillUtils.GetEnchantDesc(tid)
  else
    local cfg = DT.Item[tid]
    TextTab.Name = cfg.Name
    TextTab.Desc = cfg.Desc
  end
  return TextTab
end

function WorldStageGetAwardTip:BindAwardItemComp(awardData, binder, obj)
  local dropType = awardData.type
  local itemType = itemTypeMap[dropType] or nil
  local tid = self:ChangeItemTid(awardData.tid)
  local num = awardData.num
  
  local function textNameFunc()
    local rst
    if tid == CommonDefine.CurrencyType.CopiesMoney then
      rst = string.format("%s+%s", LT.Text("PhiloStone"), num)
      return rst
    end
    local TextTab = self:GetTextTab(itemType, tid)
    if num > 1 then
      rst = string.format("%s+%s", LT.Text(TextTab.Name), num)
    else
      rst = TextTab.Name
    end
    return rst
  end
  
  local function textDescFunc()
    local rst = LT.Text("PhiloStone_Desc")
    if tid ~= CommonDefine.CurrencyType.CopiesMoney then
      local TextTab = self:GetTextTab(itemType, tid)
      rst = TextTab.Desc
    end
    return rst
  end
  
  local itemData = {
    tid = tid,
    num = num,
    itemType = itemType,
    textNameFunc = textNameFunc,
    textDescFunc = textDescFunc
  }
  binder:BindComponent(WorldStageAwardItem(obj, itemData))
end

return WorldStageGetAwardTip
