local PVPCollectionDetailSkillItem, Super = System.NewComponent("PVPCollectionDetailSkillItem")

function PVPCollectionDetailSkillItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Pvp_Btn_CardResource(uiNode)
  self.data = data
end

function PVPCollectionDetailSkillItem:OnBind(binder)
  self.binder = binder
  binder:BindToText(self.ui.Text_Expenses, System.fn(self, self._GetSkillCost))
  binder:BindToText(self.ui.Text_Sheet, System.fn(self, self._GetSkillCardNumText))
  binder:BindToText(self.ui.Text_Name, System.fn(self, self._GetSkillName))
  local buttonComp = self.ui.Btn_Card:GetComponent(typeof(CS.Z1Client.Z1Button))
  buttonComp.onClick:RemoveAllListeners()
  binder:BindZ1Button(self.ui.Btn_Card, System.fn(self, self._OnClick))
  binder:BindToVisible(self.ui.Image_Selected, System.fn(self, self._OnSelect))
  binder:BindToVisible(self.ui.Group_Sheet, System.fn(self, self._IsNumVisible))
  local comp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Name)
  if comp then
    comp:SetBtn(self.ui.Btn_Card)
  end
end

function PVPCollectionDetailSkillItem:_GetSkillCost()
  local tid = self.data and self.data.skillTid
  if not tid then
    return
  end
  local skillConfig = DT.Skill[tid]
  if not skillConfig then
    return
  end
  return skillConfig.Cost
end

function PVPCollectionDetailSkillItem:_GetSkillName()
  local tid = self.data and self.data.skillTid
  if not tid then
    return
  end
  local skillConfig = DT.Skill[tid]
  if not skillConfig then
    return
  end
  do return BattleSkillUtils.GetSkillName, skillConfig, 0 end
  return BattleSkillUtils.GetSkillName, skillConfig, 0, 0
end

function PVPCollectionDetailSkillItem:_GetSkillCardNumText()
  local cardNum = self:_GetSkillCardNum()
  if not cardNum or cardNum <= 0 then
    return
  end
  do return ItemNumUtils.GetStr end
  return ItemNumUtils.GetStr, cardNum
end

function PVPCollectionDetailSkillItem:_GetSkillCardNum()
  return self.data and self.data.num or 0
end

function PVPCollectionDetailSkillItem:_IsNumVisible()
  local cardNum = self:_GetSkillCardNum()
  return cardNum and cardNum > 1
end

function PVPCollectionDetailSkillItem:_OnSelect()
  if self.data and self.data.isSelectFunc then
    do return end
    return self.data.isSelectFunc
  end
end

function PVPCollectionDetailSkillItem:_OnClick()
  if self.data and self.data.clickCallback then
    self.data.clickCallback()
  end
end

return PVPCollectionDetailSkillItem
