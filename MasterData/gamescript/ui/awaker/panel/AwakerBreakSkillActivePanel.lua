local AwakerBreakSkillActivePanel, Super = System.NewClass("AwakerBreakSkillActivePanel", UIBasePanel)
AwakerBreakSkillActivePanel.uiResCls = UI_Awaker_Popup_Skillup_Tip2Resource

function AwakerBreakSkillActivePanel:ctor(model, skill)
  Super.ctor(self)
  self.model = model
  self.skill = skill
end

function AwakerBreakSkillActivePanel:OnBind(binder)
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:Close()
  end)
  binder:SetText(self.ui.Text_Title, LT.Text("ActiveSkill"))
  binder:SetText(self.ui.Text_Info, self.skill.name)
  binder:SetText(self.ui.Text_Info2, self:_GetSkillDesc(self.skill))
  local goldCost = 0
  local goldEnough = true
  local currGoldCount = ItemDataUtils.GetItemNum(CommonDefine.CurrencyType.JuniorMoney)
  local mtrlsCost = {}
  local mtrlEnough = true
  for tid, count in pairs(self.skill.requiredMtrls) do
    if tid == CommonDefine.CurrencyType.JuniorMoney then
      goldCost = count
      goldEnough = currGoldCount >= goldCost
    else
      local mtrlItem = ItemDataUtils.GetItemByTid(tid)
      local currCount = mtrlItem and mtrlItem.num or 0
      if count > currCount then
        mtrlEnough = false
      end
      table.insert(mtrlsCost, {
        tid = tid,
        count = count,
        currCount = currCount
      })
    end
  end
  table.sort(mtrlsCost, function(a, b)
    local aCfg = DT.Item[a.tid]
    local bCfg = DT.Item[b.tid]
    return aCfg.BaseSortID < bCfg.BaseSortID
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Article, function()
    return mtrlsCost
  end, function(childBinder, obj, index)
    local mtrl = mtrlsCost[index]
    local itemInfo = {
      id = mtrl.tid,
      currCount = mtrl.currCount,
      requiredCount = mtrl.count
    }
    childBinder:BindComponent(AwakerBreakthroughMaterial(obj, itemInfo))
  end)
  if goldEnough then
    binder:SetText(self.ui.Text_Coin_Now, string.format("%s/%s", currGoldCount, goldCost))
  else
    local goldCount = string.format("<Color4:%d>", currGoldCount)
    binder:SetText(self.ui.Text_Coin_Now, string.format("%s/%s", goldCount, goldCost))
  end
  binder:BindZ1Button(self.ui.Btn_Cancel, function()
    self:Close()
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "UniversalCancelButton"
  end)
  binder:BindZ1Button(self.ui.Btn_Confirm, function()
    local isGoldEnough, isMtrlEnough = self:_CheckGoldAndMtrlEnough()
    if not isGoldEnough and not isMtrlEnough then
      Alert.Show(10606)
      return
    end
    if not isGoldEnough then
      Alert.Show(10462)
      return
    end
    if not isMtrlEnough then
      Alert.Show(10606)
      return
    end
    self.model:ReqAwakerBreakSkillActive(function()
      self:Close()
      UIManager.Instance:Reopen(Urls.ActiveSuccessPanel, LT.Text("BreakThrough_Skill_Active_Success"))
    end)
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "UniversalConfirmButton"
  end)
end

function AwakerBreakSkillActivePanel:_CheckGoldAndMtrlEnough()
  local goldEnough = true
  local currGoldCount = ItemDataUtils.GetItemNum(CommonDefine.CurrencyType.JuniorMoney)
  local mtrlEnough = true
  for tid, count in pairs(self.skill.requiredMtrls) do
    if tid == CommonDefine.CurrencyType.JuniorMoney then
      goldEnough = count <= currGoldCount
    else
      local mtrlItem = ItemDataUtils.GetItemByTid(tid)
      local currCount = mtrlItem and mtrlItem.num or 0
      if count > currCount then
        mtrlEnough = false
      end
    end
  end
  return goldEnough, mtrlEnough
end

function AwakerBreakSkillActivePanel:_GetSkillDesc(skill)
  if skill and skill.isSpecialSkill then
    return skill.desc
  end
  local slot = self.model.selectSlot
  if 0 == slot then
    return
  end
  local mode = self.model.mode
  local desc = self.model:GetSkillDesc(slot, mode)
  local stateDesc = self.model:GetSkillStateDesc(skill)
  do return string.format, "%s%s", desc end
  return string.format, "%s%s", desc, stateDesc
end

return AwakerBreakSkillActivePanel
