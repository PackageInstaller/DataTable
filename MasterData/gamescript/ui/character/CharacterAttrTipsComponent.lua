local CharacterAttrTipsComponent, Super = System.NewComponent("CharacterAttrTipsComponent")

function CharacterAttrTipsComponent:ctor(uiNode, tipsType, data)
  Super.ctor(self)
  self.ui = Func_Character_Attribute_Tips_1Resource(uiNode)
  self.tipsType = tipsType
  self.data = data
end

function CharacterAttrTipsComponent:OnBind(binder)
  self.binder = binder
  self.binder:BindButtonClick(self.ui.Btn_Mask, function()
    self.ui.uiNode:SetActive(false)
  end)
  self:FillText()
  local recttransform = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.RectTransform))
  local point = recttransform.localPosition
  recttransform.localPosition = CS.UnityEngine.Vector3(point.x, point.y, point.z * 0)
end

function CharacterAttrTipsComponent:SetActive(v)
  self.ui.uiNode:SetActive(v)
end

function CharacterAttrTipsComponent:SetLocalPosition(pos)
  self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.RectTransform)).anchoredPosition3D = pos
end

function CharacterAttrTipsComponent:FillText()
  local title, content
  if self.tipsType == TipsTypeUtils.TipsType.CharacterPanelLoveBtnTips then
    title = LT.Text("Like_Tips_1")
    content = LT.Text("Like_Tips_2")
    self.binder:SetText(self.ui.Text_1, title .. content)
    content = LT.Textf("Like_Tips_3", self.data)
    self.binder:SetText(self.ui.Text_2, content)
    self.ui.Text_3:SetActive(false)
  elseif self.tipsType == TipsTypeUtils.TipsType.TeamBaseCardGroupBtnWarmTips1 then
    title = LT.Text("Base_CardGroup_Tips_1")
    content = LT.Text("Base_CardGroup_Tips_2")
    self.binder:SetText(self.ui.Text_1, title .. content)
    self.ui.Text_2:SetActive(false)
    self.ui.Text_3:SetActive(false)
  elseif self.tipsType == TipsTypeUtils.TipsType.TeamBaseCardGroupBtnWarmTips2 then
    title = LT.Text("Base_CardGroup_Tips_1")
    content = LT.Text("Base_CardGroup_Tips_2")
    self.binder:SetText(self.ui.Text_1, title .. content)
    content = LT.Textf("Base_CardGroup_Tips_3", self.data)
    self.binder:SetText(self.ui.Text_2, content)
    title = LT.Text("Base_CardGroup_Tips_4")
    content = LT.Text("Base_CardGroup_Tips_5")
    self.binder:SetText(self.ui.Text_3, title .. content)
    self.ui.Text_4:SetActive(true)
    title = LT.Text("Base_CardGroup_Tips_6")
    content = LT.Text("Base_CardGroup_Tips_7")
    self.binder:SetText(self.ui.Text_4, title .. content)
  else
    title = LT.Text("Identity_Instruction_Title_1")
    content = LT.Text("Identity_Instruction_Tip_1")
    self.binder:SetText(self.ui.Text_1, title .. content)
    title = LT.Text("Identity_Instruction_Title_2")
    content = LT.Text("Identity_Instruction_Tip_2")
    self.binder:SetText(self.ui.Text_2, title .. content)
    title = LT.Text("Identity_Instruction_Title_3")
    content = LT.Text("Identity_Instruction_Tip_3")
    self.binder:SetText(self.ui.Text_3, title .. content)
  end
end

function CharacterAttrTipsComponent:UpdateData(data)
  self.data = data
  self:FillText()
end

return CharacterAttrTipsComponent
